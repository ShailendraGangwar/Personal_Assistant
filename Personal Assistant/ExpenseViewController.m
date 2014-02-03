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
#import "LocationDemoViewController.h"
@interface ExpenseViewController ()

@end

@implementation ExpenseViewController
@synthesize mManagedObjectContext,recordTableView,type,sorting;
@synthesize mNetBalance,mNetBalanceAmount,mTempPlotArray;
@synthesize mCellBalance,mCellCategory,mCellDate,mCellDesc,mCellType;
@synthesize mTempExpenseData,mSpendingButton,mEarningButton;
@synthesize mCellPayment,mNewButton,mTopView,mBottomView,mSortingButton;
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
    
    [self customizeLabel:mCellBalance];
    [self customizeLabel:mCellCategory];
    [self customizeLabel:mCellDate];
    [self customizeLabel:mCellDesc];
    [self customizeLabel:mCellPayment];
    [self customizeLabel:mCellType];
    [self customizeHeaderLabels:mNetBalanceAmount];
    [self customizeHeaderLabels:mNetBalance];
    mTempExpenseData = [[NSMutableArray alloc] init];
    [self customizeButton:mNewButton];
    [self customizeButtonEarningSpendings:mEarningButton];
    [self customizeButtonEarningSpendings:mSpendingButton];
    [self customizeButton:mSortingButton];
    [mSortingButton setTitle:@"Daily" forState:UIControlStateNormal];
    [mSortingButton setTitle:@"Daily" forState:UIControlStateSelected];
    sorting = @"Daily";
    type = @"All";
    mTopView.backgroundColor=RGB(220,220,220);
    mTopView.alpha=0.85;
    mTopView.layer.borderColor = [[UIColor blackColor] CGColor];
    mTopView.layer.borderWidth = 1;
    mBottomView.backgroundColor=[UIColor groupTableViewBackgroundColor];
    mBottomView.alpha=0.85;
    mTempPlotArray = [[NSMutableArray alloc] init];
    //mBottomView.layer.borderColor = [[UIColor blackColor] CGColor];
    //mBottomView.layer.borderWidth = 1;
    
	// Do any additional setup after loading the view.
}
-(void) viewWillAppear:(BOOL)animated
{
    [recordTableView reloadData];
    [self calculateNetBalance];
    type = @"All";
    [recordTableView reloadData];

    mEarningButton.layer.borderColor = [[UIColor whiteColor] CGColor];
    mSpendingButton.layer.borderColor = [[UIColor whiteColor] CGColor];

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
    [btn setBackgroundColor:RGB(255,134,34)];
    [btn setAlpha:0.7];
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
    UIView * headerView;
    
    headerView=[[UIView alloc]init];
    headerView.frame = CGRectMake(0,0,320,40);
    headerView.backgroundColor=[UIColor orangeColor];
    
    UIImageView *imgview=[[UIImageView alloc]init];
    imgview.frame=CGRectMake(0,1,320,38);
    imgview.backgroundColor = [UIColor groupTableViewBackgroundColor];
    UILabel *statuslabel=[[UILabel alloc]initWithFrame:CGRectMake(5,10,320,20)];
    
    statuslabel.font = [UIFont boldSystemFontOfSize:14];
    statuslabel.backgroundColor=[UIColor clearColor];
    
    id <NSFetchedResultsSectionInfo> sectionInfo =[[mFetchedResultsController sections] objectAtIndex:section];
    Expense *exp = [sectionInfo objects][0];
    statuslabel.text = exp.transactionDate;
    
    [imgview addSubview:statuslabel];
    [headerView addSubview:imgview];
    return headerView;
}
-(float)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40.0;
}



@end
