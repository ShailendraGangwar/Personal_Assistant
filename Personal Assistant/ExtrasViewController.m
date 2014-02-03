//
//  ExtrasViewController.m
//  HeyZooka
//
//  Created by Apple on 22/01/14.
//  Copyright (c) 2014 Aricent Group. All rights reserved.
//

#import "ExtrasViewController.h"

@interface ExtrasViewController ()

@end

@implementation ExtrasViewController

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
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(IBAction)locationDemo:(id)sender
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"mainStoryboard" bundle:[NSBundle mainBundle]];
    
    LocationDemoViewController *myViewController = [storyboard instantiateViewControllerWithIdentifier:@"LocationDemoViewController"];
    [self.navigationController pushViewController:myViewController animated:YES];
    
}

-(IBAction)createExpensePieChart:(id)sender
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"mainStoryboard" bundle:[NSBundle mainBundle]];
    ReportViewController *myViewController = [storyboard instantiateViewControllerWithIdentifier:@"ReportViewController"];
    ExpenseViewController *expenseViewcontroller = [[ExpenseViewController alloc] init];
    //myViewController.mFetchedResultsController = [expenseViewcontroller getFetchedObjects];
    [self.navigationController pushViewController:myViewController animated:YES];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
-(IBAction)testConnection:(id)sender

{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"mainStoryboard" bundle:[NSBundle mainBundle]];
    URLViewController *myViewController = [storyboard instantiateViewControllerWithIdentifier:@"URLViewController"];
    //ExpenseViewController *expenseViewcontroller = [[ExpenseViewController alloc] init];
    //myViewController.mFetchedResultsController = [expenseViewcontroller getFetchedObjects];
    [self.navigationController pushViewController:myViewController animated:YES];
}

@end
