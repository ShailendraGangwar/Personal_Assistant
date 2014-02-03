//
//  TaskDetailViewController.m
//  Personal Assistant
//
//  Created by Aricent Group on 31/10/13.
//  Copyright (c) 2013 Aricent Group. All rights reserved.
//

#import "TaskDetailViewController.h"
#import "Constants.h"
#import "DBManager.h"
@interface TaskDetailViewController ()

@end

@implementation TaskDetailViewController
@synthesize taskDescription,taskEndTimeLabel,taskLabel,taskNameTextField,taskStartTimeLabel,startTimeLabel,statusLabel,descriptionLabel,mScrollView,deleteButton,saveButton,endTimeLabel,alarmLabel,alarmControl,statusControl,priorityControl,priorityLabel,mTempTaskData,TaskListName,activateControl,activateLabel;

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
    [self setNavigationBar];
    [self setCustomFontsAndColors];
    mScrollView.contentSize = CGSizeMake(320, 450);
    [taskDescription setText:@""];
    endTimeLabel.delegate = self;
    startTimeLabel.delegate = self;
    mScrollView.delegate = self;
    date = [[NSMutableString alloc] init];
    [self setDataToControls];
    [mScrollView setScrollEnabled:YES];

    
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = self.mScrollView.bounds;
    gradient.colors = [NSArray arrayWithObjects:
                       (id)[[RGB(200, 200, 200) colorWithAlphaComponent:1.0] CGColor],
                       (id)[[RGB(238, 238, 238) colorWithAlphaComponent:0.1] CGColor],
                       nil];
    [self.mScrollView.layer insertSublayer:gradient atIndex:0];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];


}
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
#pragma mark - Notification Handlers

- (void)keyboardWillShow:(NSNotification *)notification
{
    mScrollView.contentSize = CGSizeMake(320, 650);
    
}


- (void)keyboardWillHide:(NSNotification *)notification
{
    mScrollView.contentSize = CGSizeMake(320, 450);
    
}
-(void)setDataToControls
{
    if (mTempTaskData != nil)
    {
        if([mTempTaskData.taskAlarmstatus isEqual:@1])
        {
            [alarmControl setSelectedSegmentIndex:0];
        }
        else
        {
            [alarmControl setSelectedSegmentIndex:1];
        }
        taskDescription.text = [NSString stringWithFormat:@"%@",mTempTaskData.taskDesc];
        startTimeLabel.text = [NSString stringWithFormat:@"%@",mTempTaskData.
                               taskStartTime];
        endTimeLabel.text = [NSString stringWithFormat:@"%@",mTempTaskData.taskEndtime];
        taskNameTextField.text = [NSString stringWithFormat:@"%@",mTempTaskData.taskName];
        if([mTempTaskData.taskPriority isEqualToString:@"High"])
        {
            [alarmControl setSelectedSegmentIndex:0];
        }
        else if([mTempTaskData.taskPriority isEqualToString:@"Med"])
        {
            [priorityControl setSelectedSegmentIndex:1];

        }
        else
        {
            [priorityControl setSelectedSegmentIndex:2];

        }
        if([mTempTaskData.taskStatus isEqualToString:@"Completed"])
        {
            [statusControl setSelectedSegmentIndex:0];
        }
        else
        {
            [statusControl setSelectedSegmentIndex:1];

        }
        
        if([mTempTaskData.isTaskListActive isEqual:@1])
        {
            [activateControl setSelectedSegmentIndex:0];
        }
        else
        {
            [activateControl setSelectedSegmentIndex:1];
            
        }


        
        
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) setCustomFontsAndColors
{
    [mScrollView setBackgroundColor:UIColorFromHexRGB(0xe6e7e8)];
    [self customizeLabel:taskLabel];
    [self customizeLabel:taskStartTimeLabel];
    [self customizeLabel:taskEndTimeLabel];
    [self customizeLabel:statusLabel];
    [self customizeLabel:priorityLabel];
    [self customizeLabel:descriptionLabel];
    [self customizeButton:saveButton];
    [self customizeButton:deleteButton];
    [self customizeLabel:alarmLabel];
    [self customizeLabel:activateLabel];

    [startTimeLabel setFont: [UIFont fontWithName:@UNIVERS_57_CONDENSED_LATIN size:15]];
    [endTimeLabel setFont: [UIFont fontWithName:@UNIVERS_57_CONDENSED_LATIN size:15]];
    [statusLabel setFont: [UIFont fontWithName:@UNIVERS_57_CONDENSED_LATIN size:15]];
    [priorityLabel setFont: [UIFont fontWithName:@UNIVERS_57_CONDENSED_LATIN size:15]];
    activateControl.tintColor =[UIColor blueColor];
    activateControl.alpha = 0.5;
    alarmControl.tintColor =[UIColor blueColor];
    alarmControl.alpha = 0.5;
    statusControl.tintColor =[UIColor blueColor];
    statusControl.alpha = 0.5;
    priorityControl.tintColor =[UIColor blueColor];
    priorityControl.alpha = 0.5;

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
    btn.titleLabel.textColor = [UIColor blueColor];
    btn.layer.borderColor = [[UIColor blackColor] CGColor];
    btn.layer.borderWidth = 1;
    
}


-(IBAction)saveButtonPressed:(id)sender
{
    
    NSInteger retval;
    
    NSMutableDictionary *temp = [[NSMutableDictionary alloc] init];
    [temp setValue:[taskNameTextField text] forKey:@"taskName"];
    [temp setValue:[taskDescription text] forKey:@"taskDesc"];
    [temp setValue:[startTimeLabel text] forKey:@"taskStartTime"];
    [temp setValue:[endTimeLabel text] forKey:@"taskEndtime"];
    
    if([statusControl selectedSegmentIndex] == 0)
    {
        [temp setValue:@"Completed"forKey:@"taskStatus"];
    }
    else
    {
        [temp setValue:@"Pending"forKey:@"taskStatus"];
    }
    
    if([priorityControl selectedSegmentIndex] == 0)
    {
        [temp setValue:@"High"forKey:@"taskPriority"];
    }
    else if ([priorityControl selectedSegmentIndex] == 1)
    {
        [temp setValue:@"Med"forKey:@"taskPriority"];
    }
    else
    {
        [temp setValue:@"Low"forKey:@"taskPriority"];
    }
    
    if([alarmControl selectedSegmentIndex] == 0)
    {
        [temp setValue:@1 forKey:@"taskAlarmstatus"];
    }
    else
    {
        [temp setValue:@0 forKey:@"taskAlarmstatus"];
    }
    if([activateControl selectedSegmentIndex] == 0)
    {
        [temp setValue:@1 forKey:@"isTaskListActive"];
    }
    else
    {
        [temp setValue:@0 forKey:@"isTaskListActive"];
    }
    if(mTempTaskData != nil)
    {
        [temp setValue:mTempTaskData.taskListName forKey:@"taskListName"];
    }
    else
    {
        [temp setValue:TaskListName forKey:@"taskListName"];
    }
    if(mTempTaskData != nil)
    {
        [temp setValue:mTempTaskData.taskid forKey:@"taskid"];
    }
    
    retval = [[DBManager getInstance] addOrUpdateTaskinDb:temp];
    if(retval == 1)
    {
        if (alarmControl.selectedSegmentIndex == 0 && activateControl.selectedSegmentIndex == 0)
        {
            UILocalNotification *localNotif = [[UILocalNotification alloc] init];
            [localNotif setFireDate:timePick.date];
            [localNotif setAlertBody:[NSString stringWithFormat:@"%@ end.",[taskNameTextField text]]];
            [localNotif setAlertBody:[NSString stringWithFormat:@"%@ started.",[taskNameTextField text]]];
            [[UIApplication sharedApplication] scheduleLocalNotification:localNotif];
        }
        [self.navigationController popViewControllerAnimated:YES];

    }
}

-(IBAction)editButtonPressed:(id)sender{
    
}

-(IBAction)deleteButtonPressed:(id)sender{
    
}


/*
 @method setNavigationBar
 @abstract This method customize the navigation bar
 @param none
 @result a void value
 */
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

- (void) datePickerValueChanged:(UIDatePicker*) datePicker
{
    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
    [outputFormatter setDateFormat:@"hh:mm a"];
    NSString* date = [outputFormatter stringFromDate: timePick.date];
    NSArray *arrayWithNumberValue = [date componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@": "]];
    NSInteger hours = [arrayWithNumberValue[0] intValue];
    NSInteger mins = [arrayWithNumberValue[1] intValue];
    NSString *amPm = arrayWithNumberValue[2];
    NSInteger secsInHours = hours * 3600;
    NSInteger minInHours = mins * 60;
    NSInteger proximoAlarme = secsInHours + minInHours;
    if([amPm isEqualToString:@"PM"])
        proximoAlarme =proximoAlarme+(12*60*60);
    NSLog(@"%ld", (long)proximoAlarme);
    NSDateFormatter* oldDateCalFormatter = [[NSDateFormatter alloc] init];
	[oldDateCalFormatter setDateFormat:@"MM/dd/yyyy"];
    //NSDate *currentDate = [NSDate date] ;
    //NSString* todayDateString = [oldDateCalFormatter stringFromDate:currentDate];
    /////////////////////////////////////////////////////////////////
    NSDateFormatter* monthFormatter = [[NSDateFormatter alloc] init];
	[monthFormatter setDateFormat:@"MM"];
    NSString* todayMonthString = [monthFormatter stringFromDate:[NSDate date]];
    
    NSDateFormatter* todaydateFormatter = [[NSDateFormatter alloc] init];
	[oldDateCalFormatter setDateFormat:@"dd"];
    NSString* todaydateString = [todaydateFormatter stringFromDate:[NSDate date]];
    
    NSDateFormatter* todayYearFormatter = [[NSDateFormatter alloc] init];
	[todayYearFormatter setDateFormat:@"yyyy"];
    NSString* todayYearString = [todayYearFormatter stringFromDate:[NSDate date]];
    
    
    
    
    
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [[NSDateComponents alloc] init];
    [components setDay: [todaydateString integerValue]];
    [components setMonth: [todayMonthString integerValue]];
    [components setYear: [todayYearString integerValue]];
    [components setHour: 17];
    [components setMinute: 44];
    [components setSecond: 0];
    [calendar setTimeZone: [NSTimeZone defaultTimeZone]];
    NSDate *dateToFire = [calendar dateFromComponents:components];
    UILocalNotification *localNotification = [[UILocalNotification alloc] init];
    [localNotification setFireDate:dateToFire];
    //[localNotification setAlertAction:@"Launch"]; //The button's text that launches the application and is shown in the alert
    [localNotification setAlertBody:@"shiva 123"]; //Set the message in the notification from the textField's text
    //[localNotification setHasAction: YES]; //Set that pushing the button will launch the application
    //[localNotification setApplicationIconBadgeNumber:[[UIApplication sharedApplication] applicationIconBadgeNumber]+1]; //Set the Application Icon Badge Number of the application's icon to the current Application Icon Badge Number plus 1
    [[UIApplication sharedApplication] scheduleLocalNotification:localNotification]; //Schedule the notification with the system
    
    //    UILocalNotification *localNotif = [[UILocalNotification alloc] init];
    //    if (localNotif == nil) return;
    //    NSDate *fireTime = [[NSDate date] addTimeInterval:60]; // adds 10 secs
    //    localNotif.fireDate = fireTime;
    //    localNotif.alertBody = @"Alert!";
    //    [[UIApplication sharedApplication] scheduleLocalNotification:localNotif];
    
    
    
}
-(void) setTimeValuesToEndText: (UITextField *)textfield
{
    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
    [outputFormatter setDateFormat:@"hh:mm a"];
    date = [outputFormatter stringFromDate: timePick.date];
    endTimeLabel.text = date;
    endDate = timePick.date;
}
-(void) setTimeValuesToStartText: (UITextField *)textfield
{
    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
    [outputFormatter setDateFormat:@"hh:mm a"];
    date = [outputFormatter stringFromDate: timePick.date];
    startTimeLabel.text = date;
    startDate = timePick.date;
    
}
-(void)createDatePicker:(UITextField *)textfield
{
    if(timePick != nil)
    {
        [timePick removeFromSuperview];
        timePick = nil;
    }
    if(IS_IPHONE_4)
    {
        timePick = [[UIDatePicker alloc]initWithFrame:CGRectMake(0, 270, 320, 200)];
    }
    else
    {
        timePick = [[UIDatePicker alloc]initWithFrame:CGRectMake(0, 320, 320, 200)];
    }
    
    timePick.backgroundColor = [UIColor grayColor];
    timePick.datePickerMode =UIDatePickerModeDateAndTime;
    if(textfield == startTimeLabel)
    {
        [timePick addTarget:self action:@selector(setTimeValuesToStartText:) forControlEvents:UIControlEventValueChanged];
    }
    else if (textfield == endTimeLabel)
    {
        [timePick addTarget:self action:@selector(setTimeValuesToEndText:) forControlEvents:UIControlEventValueChanged];
    }
    [self.view addSubview:timePick];
}
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (textField == startTimeLabel )
    {
        [self.view endEditing:YES];
        [self createDatePicker:textField];
        return NO;
    }
    if( textField == endTimeLabel)
    {
        [self.view endEditing:YES];
        [self createDatePicker:textField];
        return NO;
    }
    if(textField == taskNameTextField)
    {
        if(timePick != nil)
        {
            [timePick removeFromSuperview];
            timePick = nil;
        }
    }
    return YES;
}
- (void)textViewDidBeginEditing:(UITextView *)textView {
}
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    if (textView == taskDescription)
    {
        if(timePick != nil)
        {
            [timePick removeFromSuperview];
            timePick = nil;
        }
        //[self focusControlsOnKeyboardAppear: textView];
        
        return YES;
    }
    return NO;
}

//-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
//{
//}
//-(void)scrollViewDidScroll:(UIScrollView *)scrollView
//{
//}
//-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView
//                 willDecelerate:(BOOL)decelerate
//{
//}
//-(void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView
//{
//}
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    if(timePick != nil)
    {
        [timePick removeFromSuperview];
        timePick = nil;
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
                //[self deleteCurrentRecord];
                break;
        }
    }
    
}

@end
