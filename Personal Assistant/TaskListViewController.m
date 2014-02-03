//
//  TaskListViewController.m
//  Personal Assistant
//
//  Created by Aricent Group on 15/10/13.
//  Copyright (c) 2013 Aricent Group. All rights reserved.
//
#import "Constants.h"
#import "TaskListViewController.h"
#import "DBManager.h"
#import "TaskListCollectionCell.h"
#import "PAAppDelegate.h"
#import "TaskList.h"
#import "Task.h"
#import "TaskViewController.h"
@interface TaskListViewController ()

@end

@implementation TaskListViewController
@synthesize createTaskListView,collectionView,taskListNameTextField;
@synthesize mManagedObjectContext,createLabel,listNameLabel;
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
    [self customizeLabel:createLabel];
    [self customizeLabel:listNameLabel];
    createTaskListView.backgroundColor = RGB(220,220,220);
    createTaskListView.layer.borderColor = [UIColorFromHexRGB(0x323272) CGColor];
    createTaskListView.layer.borderWidth = 3;
    createTaskListView.layer.cornerRadius = 8;
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = createTaskListView.bounds;
    gradient.colors = [NSArray arrayWithObjects:(id)[[RGB(219, 221, 222) colorWithAlphaComponent:1.0] CGColor], (id)[[RGB(238, 238, 238) colorWithAlphaComponent:0.5] CGColor], nil];
    [createTaskListView.layer insertSublayer:gradient atIndex:0];

	// Do any additional setup after loading the view.
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    mFetchedResultsController =  [self fetchedResultsController];
    return [[mFetchedResultsController fetchedObjects] count];
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView1 cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"Cell";
    
    TaskListCollectionCell *cell = (TaskListCollectionCell *)[collectionView1 dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];

    Task *info = [mFetchedResultsController objectAtIndexPath:indexPath];
    cell.cellLabel.text = info.tasklistname;
    return cell;
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
    UIImageView *addTaskImageView = [[UIImageView alloc] init];
    addTaskImageView.frame = CGRectMake(-8,12,10,10);
    UIButton *backButton =  [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setFrame:CGRectMake(0, 10, 70, 33)];
    [backButton addSubview:addTaskImageView];
    UILabel *backLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,6,90,20)];
    backLabel.text = @"Add Lists";
    [backLabel setFont: [UIFont fontWithName:@UNIVERS_55_ROMAN_LATIN size:14]];
    [backLabel setTextColor:UIColorFromHexRGB(0x323232)];
    [backButton addSubview:backLabel];
    [backButton addTarget:self action:@selector(CreateTaskList:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    

    
}

- (IBAction)EnterData:(id)sender
{
   
}

- (IBAction)ShowData:(id)sender{
    [[DBManager getInstance] printOnConsole];
    NSMutableArray *fetchedObjects = [[NSMutableArray alloc] initWithObjects:(NSMutableArray*)[mFetchedResultsController fetchedObjects], nil];
    for(int i = 0; i < [fetchedObjects count]; i++)
    {
        NSLog(@" data %d %@",i,[fetchedObjects objectAtIndex:i]);
    }
    
}


- (IBAction)CreateTaskList:(id)sender
{
    createTaskListView.frame = CGRectMake(10, -65, 300, 126);
    createTaskListView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    createTaskListView.alpha = 0.8;
    [UIView animateWithDuration:0.7 delay:0.0 options:UIViewAnimationCurveEaseOut|UIViewAnimationOptionAllowUserInteraction
                     animations:^{
                         self.createTaskListView.frame = CGRectMake( 10, 65, 300, 126);
                         
                     }
                     completion:^ (BOOL finished)
                    {
                        [taskListNameTextField becomeFirstResponder];
     }];
}



- (IBAction)SaveButtonPressed:(id)sender{
    [taskListNameTextField resignFirstResponder];
    NSInteger retval;
    retval = [[DBManager getInstance] addTaskListinDb: taskListNameTextField.text];
    if(retval == 0)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle: nil message:@"This name is already used. Try other List name" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil,nil];
        [alert show];
        return;

    }
    self.createTaskListView.frame = CGRectMake( 10, -65, 300, 126);

}

- (IBAction)cancelButtonPressed:(id)sender{
    [taskListNameTextField resignFirstResponder];
    self.createTaskListView.frame = CGRectMake( 10, -65, 300, 126);
}


#pragma mark – UICollectionViewDelegateFlowLayout


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {

    // 2
    CGSize retval = CGSizeMake(50, 50);
    retval.height += 40;
    retval.width += 30;
    return retval;
}


- (UIEdgeInsets)collectionView:
(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(-40, 20, 50, 20);
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath;
{
    [self cancelButtonPressed:nil];
    Task *info = [mFetchedResultsController objectAtIndexPath:indexPath];
    NSString *taskListName = info.tasklistname;

    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"mainStoryboard" bundle:[NSBundle mainBundle]];
    TaskViewController *myViewController = [storyboard instantiateViewControllerWithIdentifier:@"TaskViewController"];
    myViewController.TaskListName = taskListName;
    [self.navigationController pushViewController:myViewController animated:YES];
}


/*!
 @method fetchedResultsController
 @abstract This methods initialize the fetchResultController with the Core Data.
 @result a NSFetchedResultsController.
 */
- (NSFetchedResultsController *)fetchedResultsController
{
    if (mFetchedResultsController != nil)
    {
        return mFetchedResultsController;
    }
    
    if (self.mManagedObjectContext == nil)
    {
        PAAppDelegate* appDelegate = (PAAppDelegate*)[[UIApplication sharedApplication] delegate];
        self.mManagedObjectContext = [appDelegate managedObjectContext];
    }
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Task" inManagedObjectContext:self.mManagedObjectContext];
    [fetchRequest setEntity:entity];
    NSArray *sortDescriptors = nil;
    NSSortDescriptor *sortDescriptor1 =[[NSSortDescriptor alloc] initWithKey:  @"tasklistname" ascending: YES selector: @selector(caseInsensitiveCompare:)];
    sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor1, nil];
    [fetchRequest setSortDescriptors:  sortDescriptors];
    [fetchRequest setFetchBatchSize:20];
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
- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller {
    // The fetch controller is about to start sending change notifications, so prepare the table view for updates.
    [collectionView reloadData];
}

-(void) customizeLabel: (UILabel *)lbl
{
    [lbl setFont: [UIFont fontWithName:@UNIVERS_57_CONDENSED_LATIN size:15]];
    lbl.shadowColor = [UIColor grayColor];
    lbl.shadowOffset = CGSizeMake(0, 1);
    lbl.textColor = UIColorFromHexRGB(0x323272);
    lbl.alpha = 0.7;
    
}


@end

