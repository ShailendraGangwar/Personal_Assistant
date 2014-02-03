//
//  ExpenseDetailViewController.m
//  Personal Assistant
//
//  Created by Aricent Group on 24/10/13.
//  Copyright (c) 2013 Aricent Group. All rights reserved.
//

#import "ExpenseDetailViewController.h"
#import "DBManager.h"
#import "Constants.h"
#import <QuartzCore/QuartzCore.h>
#define CATEGORY_PICKER_TAG 9876
#define EXPENSE_PICKER_TAG 9877
#define MODE_PICKER_TAG 9878
#define AGE_LIMIT_IN_SEC   -3629124000
#define kOFFSET_FOR_KEYBOARD 80.0

/*
 Setting:
 
 Currency
 Clear Data
 Sorting: date,alphabetical,amount,income/expense
 Security
 
 */
@interface ExpenseDetailViewController ()

@end

@implementation ExpenseDetailViewController
@synthesize transactionAmount,transactionCategory,transactionDate,transactionMode;
@synthesize transactionAmountLabel,transactionCategoryLabel,transactionDateLabel,transactionModeLabel,transactionNoteLabel,transactionCurrency,saveButton,expenceIncomeButton,mPickerView,datePickerView,mScrollView,transactionNote;
@synthesize mTempExpenseData,cancelButton,deleteRecordButton,mExpenseView,segmentControl;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setCustomFontsAndColors];
    [transactionDate setDelegate:self];
    transactionCategory.delegate = self;
    transactionMode.delegate = self;
    transactionNote.delegate = self;
    mScrollView.contentSize =CGSizeMake(320, 550);
	mScrollView.delegate = self;
    [mScrollView setBackgroundColor:[UIColor whiteColor]];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = self.mExpenseView.bounds;
    gradient.colors = [NSArray arrayWithObjects:
                       (id)[[RGB(200, 200, 200) colorWithAlphaComponent:1.0] CGColor],
                       (id)[[RGB(238, 238, 238) colorWithAlphaComponent:0.1] CGColor],
                       nil];
    [self.mExpenseView.layer insertSublayer:gradient atIndex:0];
    [self.view addGestureRecognizer:tap];
    [self setNavigationBar];
    [self setDataToControls];
    [mScrollView setDelegate:self];
    [mScrollView setScrollEnabled:YES];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
    
    
}
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
#pragma mark - Notification Handlers

- (void)keyboardWillShow:(NSNotification *)notification
{
    mScrollView.contentSize = CGSizeMake(320, 700);

}


- (void)keyboardWillHide:(NSNotification *)notification
{
    mScrollView.contentSize = CGSizeMake(320, 550);

}

- (void) focusControlsOnKeyboardAppear : (UIView*) control
{
    CGRect aRect = CGRectMake(0, 0, 320, 200);
    float superViewOrigin = control.superview.frame.origin.y;
    float currentFieldOrigin = control.frame.origin.y + superViewOrigin;
    CGPoint scrollPoint = CGPointMake(0, currentFieldOrigin+95);
    if (!CGRectContainsPoint(aRect, scrollPoint))
    {
        CGPoint scrollPoint = CGPointMake(0.0, (currentFieldOrigin - 10));
        [mScrollView setContentOffset:scrollPoint animated:YES];
    }
}
-(void)setNavigationBar
{
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 123, 55)];
    headerView.backgroundColor = [UIColor clearColor];
    UIImageView *parentImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pa_logo.png"]];
    parentImageView.frame = CGRectMake(30, 10, 55, 45);
    [headerView addSubview: parentImageView];
    self.navigationItem.titleView = headerView;
    
    UIImageView *backParentImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"backArrow.png"]];
    backParentImageView.frame = CGRectMake(-8,10,12,12);
    UIButton* backButton =  [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setFrame:CGRectMake(0, 10, 46, 33)];
    [backButton addSubview:backParentImageView];
    UILabel *backLabel = [[UILabel alloc] initWithFrame:CGRectMake(6,6,40,20)];
    backLabel.text = @"Back";
    [backLabel setFont: [UIFont fontWithName:@UNIVERS_55_ROMAN_LATIN size:14]];
    [backLabel setTextColor:UIColorFromHexRGB(0x323232)];
    [backButton addSubview:backLabel];
    [backButton addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];

    

    
}
-(void)back:(id) sender
{
    
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(void)dismissKeyboard {
    [transactionAmount resignFirstResponder];
    [transactionDate resignFirstResponder];
    [transactionNote resignFirstResponder];
    if(mPickerView != nil)
    {
        [mPickerView removeFromSuperview];
        mPickerView = nil;
    }
    if(datePickerView != nil)
    {
        [datePickerView removeFromSuperview];
        datePickerView = nil;
    }
}
-(void) setCustomFontsAndColors
{
    [self customizeLabel:transactionAmountLabel];
    [self customizeLabel:transactionCategoryLabel];
    [self customizeLabel:transactionDateLabel];
    [self customizeLabel:transactionModeLabel];
    [self customizeLabel:transactionNoteLabel];
    [self customizeLabel:transactionCurrency];
    
    [transactionAmount setFont: [UIFont fontWithName:@UNIVERS_57_CONDENSED_LATIN size:15]];
    [transactionDate setFont: [UIFont fontWithName:@UNIVERS_57_CONDENSED_LATIN size:15]];
    [transactionMode setFont: [UIFont fontWithName:@UNIVERS_57_CONDENSED_LATIN size:15]];
    [transactionCategory setFont: [UIFont fontWithName:@UNIVERS_57_CONDENSED_LATIN size:15]];
    
    [self customizeButton:saveButton];
    [self customizeButton:cancelButton];
    [self customizeButton:deleteRecordButton];
    
}
-(void) customizeLabel: (UILabel *)lbl
{
    [lbl setFont: [UIFont fontWithName:@UNIVERS_57_CONDENSED_LATIN size:15]];
    lbl.shadowColor = [UIColor grayColor];
    lbl.shadowOffset = CGSizeMake(0, 1);
    lbl.textColor = [UIColor blueColor];
    lbl.alpha = 0.5;
    
}
-(void) customizeButton: (UIButton *)btn
{
    [btn.titleLabel setFont:[UIFont fontWithName:@UNIVERS_57_CONDENSED_LATIN size:15]];
    [btn setBackgroundColor:[UIColor grayColor]];
    [btn setAlpha:0.5];
    btn.titleLabel.shadowColor = [UIColor blackColor];
    btn.titleLabel.shadowOffset = CGSizeMake(0, 1);
    btn.layer.borderColor = [[UIColor blackColor] CGColor];
    btn.layer.borderWidth = 1;
    btn.titleLabel.textColor = UIColorFromHexRGB(0x323272);
    btn.tintColor =RGB(255,134,34);
    btn.backgroundColor=RGB(220,220,220);
    btn.alpha=0.85;
}

-(void) setDataToControls
{
    segmentControl = [[UISegmentedControl alloc]initWithItems:[NSArray arrayWithObjects:@"Expense",@"Income", nil]];
    segmentControl.frame = CGRectMake(20, 158, 280, 30);
    [segmentControl setSelectedSegmentIndex:0];
    segmentControl.tintColor =[UIColor blueColor];
    segmentControl.alpha = 0.5;

    if(mTempExpenseData != nil)
    {
        transactionAmount.text = [NSString stringWithFormat:@"%@", mTempExpenseData.transactionAmount];
        transactionDate.text = [NSString stringWithFormat:@"%@", mTempExpenseData.transactionDate];
        transactionCategory.text = [NSString stringWithFormat:@"%@", mTempExpenseData.category];
        transactionMode.text = [NSString stringWithFormat:@"%@", mTempExpenseData.transactionMode];
        transactionNote.text = [NSString stringWithFormat:@"%@",mTempExpenseData.transactionNote];
        [expenceIncomeButton setTitle:[NSString stringWithFormat:@"%@",mTempExpenseData.transactionType] forState:UIControlStateNormal];
        if([mTempExpenseData.transactionType isEqualToString:@"Expense"])
        {
            [segmentControl setSelectedSegmentIndex:0];
        }
        else
        {
            [segmentControl setSelectedSegmentIndex:1];
        }
    }
    [self.mExpenseView addSubview:segmentControl];

}
-(IBAction)save:(id)sender
{
    [transactionDate resignFirstResponder];
    [transactionAmount resignFirstResponder];
    NSInteger retval;
    retval = [self validateData];
    if(retval == 0)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"Missing Information" message:@"You have missed entering some information." delegate:nil cancelButtonTitle:NSLocalizedString(@"OK", @"OK") otherButtonTitles:nil, nil];
        [alert show];
        return;
    }
    NSMutableDictionary *temp = [[NSMutableDictionary alloc] init];
    [temp setValue:[NSNumber numberWithInt:[[transactionAmount text] intValue]] forKey:@"amount"];
    [temp setValue:transactionCategory.text forKey:@"category"];
    [temp setValue:[transactionDate text]forKey:@"date"];
    [temp setValue:transactionMode.text forKey:@"mode"];
    //[temp setValue:expenceIncomeButton.titleLabel.text forKey:@"type"];
    if([segmentControl selectedSegmentIndex] == 0)
    {
        [temp setValue:@"Expense" forKey:@"type"];
    }
    else
    {
        [temp setValue:@"Income" forKey:@"type"];

    }
    [temp setValue:transactionNote.text forKey:@"note"];
    if(mTempExpenseData != nil)
    {
        [temp setValue:mTempExpenseData.transactionId forKey:@"id"];
    }
    retval = [[DBManager getInstance] addRecordinDb:temp];
    if(retval == 1)
    {
        [self.navigationController popViewControllerAnimated:YES];
        
    }
}

-(NSInteger)validateData
{
    
    if([transactionAmount.text isEqualToString:@"" ]|| [transactionCategory.text isEqualToString:@""] ||[transactionDate.text isEqualToString:@""] || [transactionMode.text isEqualToString:@""] || [expenceIncomeButton.titleLabel.text isEqualToString:@"Expense/Income"])
    {
        return 0;
    }
    
    return 1;
}

-(IBAction)deleteRecord:(id)sender
{
    if(mTempExpenseData.transactionId == nil)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"Errr" message:@"Sorry! Nothing to delete." delegate:nil cancelButtonTitle:NSLocalizedString(@"OK", @"OK") otherButtonTitles:nil, nil];
        [alert show];
        return;
    }
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"Delete Record" message:@"Are you sure you want to delete this record?" delegate:self cancelButtonTitle:@"Yes" otherButtonTitles:@"No", nil];
    alert.tag = 1267;
    [alert show];
}

-(void)deleteCurrentRecord
{
    NSInteger retval;
    retval = [[DBManager getInstance] deleteRecordinDb:mTempExpenseData.transactionId];
    if(retval == 1)
    {
        [self.navigationController popViewControllerAnimated:YES];
    }

}

-(IBAction)cancel:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)addPickerView:(UITextField *)textfield
{
    if(mPickerView != nil)
    {
        [mPickerView removeFromSuperview];
        mPickerView = nil;
    }
    if(datePickerView != nil)
    {
        [datePickerView removeFromSuperview];
        datePickerView = nil;
    }
    if(currentTextField == transactionAmount)
    {
        [currentTextField resignFirstResponder];
        [self dismissKeyboard];
        [self.view endEditing:YES];
    }
    if([transactionAmount isFirstResponder])
    {
        [transactionAmount resignFirstResponder];
    }
    if([transactionDate isFirstResponder])
    {
        [transactionDate resignFirstResponder];
    }
    if(IS_IPHONE_4)
    {
        mPickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 270, 320, 200)];

    }
    else
    {
        mPickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 320, 320, 200)];

    }
    mPickerView.dataSource = self;
    mPickerView.delegate = self;
    mPickerView.backgroundColor =[UIColor lightGrayColor];

    if(textfield == transactionCategory)
    {
        mainArray = [[NSMutableArray alloc]initWithObjects:@"Automobile",@"Clothing",@"Entertainment",@"Groceries",@"Gifts",@"Household",@"Homecare",@"Insurance",@"Loans",@"Medical",@"Transfers",@"Phone",@"Rent",@"Utilities",@"Others", nil];
        transactionCategory.delegate = self;
        [transactionCategory setText:[NSString stringWithFormat:@"%@",[mainArray objectAtIndex:0]]];
        mPickerView.tag = CATEGORY_PICKER_TAG;
    }
    if(textfield == transactionMode)
    {
        mainArray = [[NSMutableArray alloc]initWithObjects:@"Credit",
                     @"Debit",@"Cash",@"Cheque", nil];
        transactionMode.delegate = self;
        [transactionMode setText:[NSString stringWithFormat:@"%@",[mainArray objectAtIndex:0]]];
        mPickerView.tag = MODE_PICKER_TAG;
    }
    mPickerView.showsSelectionIndicator = YES;
    [self.view addSubview:mPickerView];
}



- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return mainArray.count;
}
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return  80;
}
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if(mPickerView.tag == EXPENSE_PICKER_TAG)
    {
        [expenceIncomeButton setTitle:[NSString stringWithFormat:@"%@",[mainArray objectAtIndex:[pickerView selectedRowInComponent:0]]] forState:UIControlStateNormal];
    }
    if(mPickerView.tag == MODE_PICKER_TAG)
    {
        [transactionMode setText:[NSString stringWithFormat:@"%@",[mainArray objectAtIndex:[pickerView selectedRowInComponent:0]]]];    }
    if(mPickerView.tag == CATEGORY_PICKER_TAG)
    {
        [transactionCategory setText:[NSString stringWithFormat:@"%@",[mainArray objectAtIndex:[pickerView selectedRowInComponent:0]]]];
    }
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [mainArray objectAtIndex:row];
}
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
    CGFloat componentWidth = 0.0;
    componentWidth = 320.0;
    if(pickerView.tag == EXPENSE_PICKER_TAG)
    {
        componentWidth = 50.0;

    }
    return componentWidth;
}
- (UIView *)pickerView:(UIPickerView *)picker viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{

    UILabel *label;
    if(picker.tag == EXPENSE_PICKER_TAG)
    {
        CGRect rect = CGRectMake(0, 0,100, 100);
        label = [[UILabel alloc] initWithFrame:rect];
        label.transform = CGAffineTransformRotate(label.transform, M_PI/2);
    }
    else
    {
        CGRect rect = CGRectMake(0, 0,200, 200);
        label = [[UILabel alloc] initWithFrame:rect];
    }
    [label setFont:[UIFont fontWithName:@UNIVERS_57_CONDENSED_LATIN size:22]];
    [label setText:[NSString stringWithFormat: @"%@",[mainArray objectAtIndex:row]]];
    [label setBackgroundColor:UIColorFromHexRGB(0x323232)];
    [label setTextAlignment:NSTextAlignmentCenter];
    label.shadowColor = [UIColor grayColor];
    label.shadowOffset = CGSizeMake(0, 1);
    label.textColor = RGB(255,134,34);
    label.clipsToBounds = YES;
    return label;
}


- (void)createDatePicker
{
    if(mPickerView != nil)
    {
        [mPickerView removeFromSuperview];
        mPickerView = nil;
    }
    if(datePickerView != nil)
    {
        [datePickerView removeFromSuperview];
        datePickerView = nil;
    }
    [transactionDate resignFirstResponder];
    datePickerView = [[UIDatePicker alloc] initWithFrame:CGRectZero];
    datePickerView.backgroundColor =[UIColor lightGrayColor];
	datePickerView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
	datePickerView.datePickerMode = UIDatePickerModeDate;
    [datePickerView addTarget:self action:@selector(datePickerValueChanged:) forControlEvents:UIControlEventValueChanged];
    if(IS_IPHONE_4)
    {
        datePickerView.frame=CGRectMake(0, 270, 320, 200);
    }
    else
    {
        datePickerView.frame=CGRectMake(0, 320, 320, 200);
    }
    
    
	datePickerView.hidden = NO;
    NSDateFormatter* oldDateCalFormatter = [[NSDateFormatter alloc] init];
	[oldDateCalFormatter setDateFormat:@"MM/dd/yyyy"];
    NSDate *currentDate = [NSDate date];
    NSString* todayDateString = [oldDateCalFormatter stringFromDate:currentDate];
    NSRange range = NSMakeRange(todayDateString.length - 4, 4);
    NSString* todayYearValue = [todayDateString substringWithRange:range];
    int requiredYearValue = [todayYearValue intValue];
    NSString* newYearValue =[NSString stringWithFormat:@"%d",requiredYearValue];
    todayDateString = [todayDateString stringByReplacingOccurrencesOfString:todayYearValue withString:newYearValue];
    NSDate* newDate = [oldDateCalFormatter dateFromString:todayDateString];
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
	[dateFormatter setDateStyle:NSDateFormatterShortStyle];
    NSString* date = [dateFormatter stringFromDate:newDate];
    NSDateFormatter* dateFmt = [[NSDateFormatter alloc] init];
	[dateFmt setDateStyle:NSDateFormatterShortStyle];
    NSDate* pickerDate = [dateFormatter dateFromString:date];
    [datePickerView setDate:pickerDate];
    [datePickerView setMaximumDate: currentDate];
    NSDate *maxdate = nil;
    maxdate = [[NSDate date] dateByAddingTimeInterval:(AGE_LIMIT_IN_SEC)];
    [datePickerView setMinimumDate:maxdate];
    [self.view addSubview:datePickerView];
    transactionDate.text = [dateFormatter stringFromDate:datePickerView.date];
}
- (void) datePickerValueChanged:(UIDatePicker*) datePicker
{
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterShortStyle];
    NSString* date = [dateFormatter stringFromDate:datePickerView.date];
    transactionDate.text = date;
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (textField==transactionCategory || textField == transactionMode )
    {
        [self.view endEditing:YES];
        [self addPickerView:textField];
        return NO;
    }
    if( textField == transactionDate)
    {
        [self.view endEditing:YES];
        [self createDatePicker];
        return NO;
    }
    if(textField == transactionAmount)
    {
        if(mPickerView != nil)
        {
            [mPickerView removeFromSuperview];
            mPickerView = nil;
        }
        if(datePickerView != nil)
        {
            [datePickerView removeFromSuperview];
            datePickerView = nil;
        }
        
    }
    return YES;
}
- (void)textViewDidBeginEditing:(UITextView *)textView {
}
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    if (textView == transactionNote)
    {
        if(mPickerView != nil)
        {
            [mPickerView removeFromSuperview];
            mPickerView = nil;
        }
        if(datePickerView != nil)
        {
            [datePickerView removeFromSuperview];
            datePickerView = nil;
        }
        [self focusControlsOnKeyboardAppear: textView];
        
        return YES;
    }
    return NO;
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
}
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView
                 willDecelerate:(BOOL)decelerate
{
}
-(void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView
{
}
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    //mScrollView.contentSize = CGSizeMake(320, 700);
    if(mPickerView != nil)
    {
        [mPickerView removeFromSuperview];
        mPickerView = nil;
    }
    if(datePickerView != nil)
    {
        [datePickerView removeFromSuperview];
        datePickerView = nil;
    }

}


/*!
 @method alertView:clickedButtonAtIndex:
 @abstract This method handles the action sheet button action.
 @param alertView an UIAlertView
 @param buttonIndex a NSInteger indicates the index of the clicked button.
 @result a void value
 */
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 1267)
    {
        switch(buttonIndex)
        {
            case 0:
                [self deleteCurrentRecord];
                break;
        }
    }
   
}


@end
