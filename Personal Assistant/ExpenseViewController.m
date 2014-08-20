//
//  ExpenseViewController.m
//  Personal Assistant
//
//  Created by Aricent Group on 18/10/13.
//  Copyright (c) 2013 Aricent Group. All rights reserved.
//

#import "ExpenseViewController.h"
#import"RecordCell.h"
#import "Constants.h"
#import "PAAppDelegate.h"
#import "ExpenseDetailViewController.h"
#import "Expense.h"
#import "ReportViewController.h"
#import "CustomHeader.h"
#import "LocationDemoViewController.h"
#import "Common.h"
@interface ExpenseViewController ()
@property (nonatomic, assign) CGRect coloredBoxRect;
@property (nonatomic, assign) CGRect paperRect;

@property (nonatomic, strong) UILabel * titleLabel;
@property (nonatomic, strong) UIColor * lightColor;
@property (nonatomic, strong) UIColor * darkColor;
@end

@implementation ExpenseViewController
@synthesize mManagedObjectContext,recordTableView,type,sorting;
@synthesize mNetBalance,mNetBalanceAmount,mTempPlotArray;
@synthesize mTempExpenseData;
@synthesize mNewButton,mTopView;
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
    [self customizeHeaderLabels:mNetBalanceAmount];
    [self customizeHeaderLabels:mNetBalance];
    [self customizeButton:mNewButton];
    mTempExpenseData = [[NSMutableArray alloc] init];
    sorting = @"Daily";
    type = @"All";
    mTopView.backgroundColor = [UIColor colorWithRed:170/255.0 green:201/255.0 blue:226/255.0 alpha:1.0];
    mTempPlotArray = [[NSMutableArray alloc] init];
    [recordTableView setBackgroundColor:[UIColor darkGrayColor]];
}
-(void) viewWillAppear:(BOOL)animated
{
    [recordTableView reloadData];
    [self calculateNetBalance];
    type = @"All";
    [recordTableView reloadData];

}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(NSMutableArray *)getFetchedObjects
{
    mFetchedResultsController =  [self fetchedResultsController];//: sorting :type];
    mTempPlotArray = [mFetchedResultsController fetchedObjects];
    return self.mTempPlotArray;
}
-(void) calculateNetBalance
{
    sorting = @"Daily";
    type = @"All";
    mFetchedResultsController =  [self fetchedResultsController];//: sorting :type];
    NSArray *temp =[mFetchedResultsController fetchedObjects];
    mTempPlotArray = [mFetchedResultsController fetchedObjects];
    int balance = 0;
    for(int i = 0;i < temp.count;i++)
    {
        Expense *info = [temp objectAtIndex:i];
        if([info.transactionType isEqualToString:@"Expense"])
        {
            balance = balance - info.transactionAmount.integerValue;
        }
        else
        {
            balance = balance + info.transactionAmount.integerValue;
        }
    }
    [mNetBalanceAmount setText:[NSString stringWithFormat:@"%d",balance]];
}

-(void) customizeButton: (UIButton *)btn
{
    [btn.titleLabel setFont:[UIFont fontWithName:@UNIVERS_57_CONDENSED_LATIN size:15]];
    [btn setBackgroundColor:[UIColor colorWithRed:208/255.0 green:208/255.0 blue:208/255.0 alpha:1.0]];
    [btn setAlpha:1.0];
    btn.titleLabel.shadowColor = [UIColor groupTableViewBackgroundColor];
    btn.titleLabel.shadowOffset = CGSizeMake(1, 1);
    btn.titleLabel.textColor = UIColorFromHexRGB(0x329232);
    btn.titleLabel.textColor = [UIColor blackColor];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];

    btn.layer.borderColor = [RGB(255,134,134) CGColor];
    btn.layer.borderWidth = 1;
    btn.layer.cornerRadius = 1;
    
}
-(void) customizeButtonEarningSpendings: (UIButton *)btn
{
    [btn.titleLabel setFont:[UIFont fontWithName:@UNIVERS_45_STD_LIGHT size:15]];
    [btn setBackgroundColor:RGB(223,222,222)];
    [btn setAlpha:0.7];
    btn.titleLabel.shadowColor = [UIColor groupTableViewBackgroundColor];
    btn.titleLabel.shadowOffset = CGSizeMake(1, 1);
    btn.titleLabel.textColor = UIColorFromHexRGB(0x329212);
    btn.titleLabel.textColor = [UIColor blackColor];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];

    btn.layer.borderColor = [RGB(255,255,255) CGColor];
    btn.layer.borderWidth = 1;
    btn.layer.cornerRadius = 1;
    
}
-(void) customizeHeaderLabels: (UILabel *)lbl
{
    [lbl setFont: [UIFont fontWithName:@UNIVERS_55_ROMAN_LATIN size:17]];
    lbl.shadowColor = [UIColor grayColor];
    lbl.shadowOffset = CGSizeMake(0, 1);
    lbl.textColor = RGB(255,134,34);
    lbl.alpha = 0.7;
}
-(void) customizeLabel: (UILabel *)lbl
{
    [lbl setFont: [UIFont fontWithName:@UNIVERS_57_CONDENSED_LATIN size:15]];
    lbl.shadowColor = [UIColor grayColor];
    lbl.shadowOffset = CGSizeMake(0, 1);
    lbl.textColor = UIColorFromHexRGB(0x323272);
    lbl.alpha = 0.85;
    
}
-(IBAction)locationDemo:(id)sender
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"mainStoryboard" bundle:[NSBundle mainBundle]];
    
    LocationDemoViewController *myViewController = [storyboard instantiateViewControllerWithIdentifier:@"LocationDemoViewController"];
    [self.navigationController pushViewController:myViewController animated:YES];

}

-(IBAction)addExpenseOrIncome:(id)sender
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"mainStoryboard" bundle:[NSBundle mainBundle]];
    
    ExpenseDetailViewController *myViewController = [storyboard instantiateViewControllerWithIdentifier:@"ExpenseDetailViewController"];
    [self.navigationController pushViewController:myViewController animated:YES];
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
    
}
//-(NSInteger) calculateSectionCount
//{
//    mFetchedResultsController =  [self fetchedResultsController: sorting :type];
//    NSMutableArray *headerDate = [[NSMutableArray alloc] init];
//    for (int i = 0; i < [[mFetchedResultsController fetchedObjects] count]; i++)
//    {
//        //Expense *info = [mFetchedResultsController objectAtIndexPath:0];
//        {
//            [headerDate addObject:[mFetchedResultsController objectAtIndexPath:[]];
//        }
//
//    }
//    return [headerDate count];
//}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    //NSInteger i = [self calculateSectionCount];
    return [[mFetchedResultsController sections] count];
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //mFetchedResultsController =  [self fetchedResultsController: sorting :type];
    NSInteger i = [[mFetchedResultsController fetchedObjects] count];
    NSLog(@"Number of rows: %ld",(long)i);
    //return [[mFetchedResultsController fetchedObjects] count];
    
    id <NSFetchedResultsSectionInfo> sectionInfo =[[mFetchedResultsController sections] objectAtIndex:section];
    //
    //[[[ mFetchedResultsController sections] objectAtIndex:section];
    
    return [sectionInfo numberOfObjects];
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"RecordCell";
    RecordCell *cell = (RecordCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];

    Expense *info = [mFetchedResultsController objectAtIndexPath:indexPath];
    //[mTempExpenseData addObject:info];
    cell.amountLabel.text = [NSString stringWithFormat:@"%@",info.transactionAmount];
    cell.dateLabel.text =[NSString stringWithFormat:@"%@",info.transactionDate];
    cell.categoryLabel.text = [NSString stringWithFormat:@"%@",info.category];
    cell.typeLabel.text = [NSString stringWithFormat:@"%@",info.transactionMode];
    cell.expenseLabel.text = [NSString stringWithFormat:@"%@",info.transactionType];
    cell.descLabel.text = [NSString stringWithFormat:@"%@",info.transactionNote];
    if([info.transactionType isEqualToString:@"Expense"])
    {
        cell.expenseLabel.textColor = [UIColor redColor];
    }
    else
    {
        cell.expenseLabel.textColor = [UIColor greenColor];
    }
    cell.backgroundColor = [UIColor groupTableViewBackgroundColor];
    cell.alpha = 0.5;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return  80;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"mainStoryboard" bundle:[NSBundle mainBundle]];
    ExpenseDetailViewController *myViewController = [storyboard instantiateViewControllerWithIdentifier:@"ExpenseDetailViewController"];
    Expense *info = [mFetchedResultsController objectAtIndexPath:indexPath];
    myViewController.mTempExpenseData = info;
    [self.navigationController pushViewController:myViewController animated:YES];
    
}

/*!
 @method fetchedResultsController
 @abstract This methods initialize the fetchResultController with the Core Data.
 @result a NSFetchedResultsController.
 */


//- (void)first:(NSString *)fname second:(NSString *)mname third:(NSString *)lname;
- (NSFetchedResultsController *)fetchedResultsController//: (NSString *)sortingType :(NSString *)typeEarningOrSpending
{
//    if (mFetchedResultsController != nil)
//    {
//        return mFetchedResultsController;
//    }
    
    if (self.mManagedObjectContext == nil)
    {
        PAAppDelegate* appDelegate = (PAAppDelegate*)[[UIApplication sharedApplication] delegate];
        self.mManagedObjectContext = [appDelegate managedObjectContext];
    }
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Expense" inManagedObjectContext:self.mManagedObjectContext];
    [fetchRequest setEntity:entity];
    NSSortDescriptor *dateSort;
    NSArray *sortDescriptors;
    //if([sortingType isEqualToString:@"Daily"])
    {
         dateSort = [[NSSortDescriptor alloc] initWithKey:@"transactionDate" ascending:NO selector:nil];
        sortDescriptors = [[NSArray alloc] initWithObjects:dateSort, nil];
    }
    //else if ([sortingType isEqualToString:@"Monthly"])
    {
        
    }
   // else
    {
        
    }
   // NSPredicate *predicate;
   // if([typeEarningOrSpending isEqualToString:@"Earnings"])
    {
    //    predicate = [NSPredicate predicateWithFormat:@"transactionType == %@",@"Income"];
    //    [fetchRequest setPredicate: predicate];
    }
   // else if ([typeEarningOrSpending isEqualToString:@"Spendings"])
    {
   //     predicate = [NSPredicate predicateWithFormat:@"transactionType == %@",@"Expense"];
   //     [fetchRequest setPredicate: predicate];
    }
    [fetchRequest setSortDescriptors:sortDescriptors];
    [fetchRequest setFetchBatchSize:20];
    [fetchRequest setReturnsObjectsAsFaults:NO];
    NSError* error;
    NSFetchedResultsController *theFetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:self.mManagedObjectContext sectionNameKeyPath:@"transactionDate" cacheName:@"Root"];
    
        if (![theFetchedResultsController performFetch:&error])
    {
        //Unresolved Error
    }
    mFetchedResultsController = theFetchedResultsController;
    mFetchedResultsController.delegate = self;   
    return mFetchedResultsController;
    
    
}
- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller {
    [recordTableView reloadData];
}

- (IBAction)selectClicked:(id)sender {
    NSArray * arr = [[NSArray alloc] init];
    arr = [NSArray arrayWithObjects:@"Daily",@"Weekly", @"Monthly",nil];
    if(dropDown == nil) {
        CGFloat f = 120;
        dropDown = [[NIDropDown alloc]showDropDown:sender :&f :arr :@"down"];
        dropDown.delegate = self;
    }
    else {
        [dropDown hideDropDown:sender];
        [self rel];
    }
}

- (void) niDropDownDelegateMethod: (NIDropDown *) sender {
    [self rel];
   // if([sorting isEqualToString:@"Monthly"])
    {
//        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"mainStoryboard" bundle:[NSBundle mainBundle]];
//        ReportViewController *myViewController = [storyboard instantiateViewControllerWithIdentifier:@"ReportViewController"];
//        myViewController.mFetchedResultsController = mTempPlotArray;
//        [self.navigationController pushViewController:myViewController animated:YES];
    }
    //mFetchedResultsController =  [self fetchedResultsController: sorting :type];
    //[recordTableView reloadData];
}

-(void)rel{
    dropDown = nil;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    CustomHeader * headerView = [[CustomHeader alloc] init];
    headerView.frame = CGRectMake(0,0,320,40);

    UILabel *statuslabel=[[UILabel alloc]initWithFrame:CGRectMake(130,15,60,20)];
    
    statuslabel.font = [UIFont boldSystemFontOfSize:14];
    statuslabel.backgroundColor=[UIColor clearColor];
    
    id <NSFetchedResultsSectionInfo> sectionInfo =[[mFetchedResultsController sections] objectAtIndex:section];
    Expense *exp = [sectionInfo objects][0];
    statuslabel.text = exp.transactionDate;
    
    [headerView addSubview:statuslabel];
    return headerView;
}
-(float)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 50.0;
}
-(void) drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    UIColor * whiteColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0];
    UIColor * shadowColor = [UIColor colorWithRed:0.2 green:0.2 blue:0.2 alpha:0.5];
    
    CGContextSetFillColorWithColor(context, whiteColor.CGColor);
    CGContextFillRect(context, _paperRect);
    
    CGContextSaveGState(context);
    CGContextSetShadowWithColor(context, CGSizeMake(0, 2), 3.0, shadowColor.CGColor);
    CGContextSetFillColorWithColor(context, self.lightColor.CGColor);
    CGContextFillRect(context, self.coloredBoxRect);
    CGContextRestoreGState(context);
    drawGlossAndGradient(context, self.coloredBoxRect, self.lightColor.CGColor, self.darkColor.CGColor);
    
    CGContextSetStrokeColorWithColor(context, self.darkColor.CGColor);
    CGContextSetLineWidth(context, 1.0);
    CGContextStrokeRect(context, rectFor1PxStroke(self.coloredBoxRect));
}

@end
