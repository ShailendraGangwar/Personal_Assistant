//
//  TaskViewController.m
//  Personal Assistant
//
//  Created by Aricent Group on 24/10/13.
//  Copyright (c) 2013 Aricent Group. All rights reserved.
//

#import "TaskViewController.h"
#import "TaskViewCell.h"
#import "PAAppDelegate.h"
#import "Constants.h"
#import "TaskDetailViewController.h"
#import "TaskList.h"
#import "TabbarViewController.h"
@interface TaskViewController ()

@end

@implementation TaskViewController
@synthesize TaskListName,taskListNameLabel,mtableView,mManagedObjectContext,mActivateButton,mTopView,mDeleteButton;
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
    [self customizeHeaderLabels:taskListNameLabel];
    [self customizeButton:mActivateButton];
    mTopView.backgroundColor=RGB(220,220,220);
    mTopView.alpha=0.85;
    mTopView.layer.borderColor = [[UIColor blackColor] CGColor];
    mTopView.layer.borderWidth = 1;
	// Do any additional setup after loading the view.
    if(IS_IPHONE_5)
    {
        CGRect frame;
        frame = self.mDeleteButton.frame;
        frame.origin.y = frame.origin.y + 70;
        self.mDeleteButton.frame = frame;
    }
}

-(void)viewWillAppear:(BOOL)animated{
    taskListNameLabel.text = TaskListName;
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

-(void) customizeHeaderLabels: (UILabel *)lbl
{
    [lbl setFont: [UIFont fontWithName:@UNIVERS_67_CONDENSED_BOLD_LATIN size:17]];
    lbl.shadowColor = [UIColor grayColor];
    lbl.shadowOffset = CGSizeMake(0, 1);
    lbl.textColor = RGB(255,134,34);
    lbl.alpha = 0.7;
}

-(void) customizeButton: (UIButton *)btn
{
    [btn.titleLabel setFont:[UIFont fontWithName:@UNIVERS_67_CONDENSED_BOLD_LATIN size:15]];
    [btn setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
    [btn setAlpha:0.7];
    btn.titleLabel.shadowColor = [UIColor blackColor];
    btn.titleLabel.shadowOffset = CGSizeMake(1, 1);
    btn.titleLabel.textColor = UIColorFromHexRGB(0x323272);
    btn.layer.borderColor = [RGB(255,134,34) CGColor];
    btn.layer.borderWidth = 2;
    btn.layer.cornerRadius = 1;
    
    
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    mFetchedResultsController =  [self fetchedResultsController];
    NSInteger i = [[mFetchedResultsController fetchedObjects] count];
    return [[mFetchedResultsController fetchedObjects] count];
}


-(IBAction)addTask:(id)sender
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"mainStoryboard" bundle:[NSBundle mainBundle]];
    TaskDetailViewController *myViewController = [storyboard instantiateViewControllerWithIdentifier:@"TaskDetailViewController"];
    myViewController.TaskListName = TaskListName;
    [self.navigationController pushViewController:myViewController animated:YES];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"TaskCell";
    TaskViewCell *cell = (TaskViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    TaskList *info = nil;
    info = [mFetchedResultsController objectAtIndexPath:indexPath];
    cell.taskNameLabel.text =[NSString stringWithFormat:@"%@",info.taskName];
    cell.timeLabel.text =[NSString stringWithFormat:@"%@",info.taskEndtime];
    cell.statusStateLabel.text =[NSString stringWithFormat:@"%@",info.taskStatus];

    if([info.taskStatus isEqualToString:@"Completed"])
    {
        cell.statusStateLabel.textColor = [UIColor greenColor];
    }
    else
    {
        cell.statusStateLabel.textColor = [UIColor redColor];
    }
    if([info.taskPriority isEqualToString:@"High"])
    {
        cell.priorityView.backgroundColor = ([UIColor redColor]);
    }
    else if([info.taskPriority isEqualToString:@"Med"])
    {
        cell.priorityView.backgroundColor = ([UIColor orangeColor]);

    }
    else
    {
        cell.priorityView.backgroundColor = ([UIColor yellowColor]);

    }
    if([info.isTaskListActive isEqual:@1])
    {
        cell.mCheckMark.hidden = NO;
    }
    else
    {
        cell.mCheckMark.hidden = YES;
    }
    if([info.taskAlarmstatus isEqual:@1])
    {
        cell.mAlarmImageView.hidden = NO;
    }
    else
    {
        cell.mAlarmImageView.hidden = YES;
    }

    return cell;

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"mainStoryboard" bundle:[NSBundle mainBundle]];
     TaskDetailViewController *myViewController = [storyboard instantiateViewControllerWithIdentifier:@"TaskDetailViewController"];
    TaskList *info = [mFetchedResultsController objectAtIndexPath:indexPath];
    myViewController.mTempTaskData = info;
    [self.navigationController pushViewController:myViewController animated:YES];
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
   return  67;
}



/*!
 @method fetchedResultsController
 @abstract This methods initialize the fetchResultController with the Core Data.
 @result a NSFetchedResultsController.
 */
- (NSFetchedResultsController *)fetchedResultsController
{
    //if (mFetchedResultsController != nil)
    {
    //   return mFetchedResultsController;
    }
    
    if (self.mManagedObjectContext == nil)
    {
        PAAppDelegate* appDelegate = (PAAppDelegate*)[[UIApplication sharedApplication] delegate];
        self.mManagedObjectContext = [appDelegate managedObjectContext];
    }
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"TaskList" inManagedObjectContext:self.mManagedObjectContext];
    [fetchRequest setEntity:entity];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"taskListName == %@",TaskListName];
    [fetchRequest setPredicate: predicate];
   //sortDescriptors = nil;
    NSSortDescriptor *sortDescriptor1 =[[NSSortDescriptor alloc] initWithKey:  @"taskListName" ascending: YES selector: nil];
    NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor1, nil];
    [fetchRequest setSortDescriptors:  sortDescriptors];
    [fetchRequest setFetchBatchSize:20];
    [fetchRequest setReturnsObjectsAsFaults:NO];
    NSError* error;
    NSFetchedResultsController *theFetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:self.mManagedObjectContext sectionNameKeyPath:nil cacheName:nil];
    if (![theFetchedResultsController performFetch:&error])
    {
        //Unresolved Error
    }
    mFetchedResultsController = theFetchedResultsController;
    mFetchedResultsController.delegate = self;
    return mFetchedResultsController;
    
    
}
- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller
{
    [mtableView reloadData];
}



@end
