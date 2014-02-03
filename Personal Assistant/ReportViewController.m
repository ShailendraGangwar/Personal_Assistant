//
//  ReportViewController.m
//  HeyZooka
//
//  Created by Apple on 20/01/14.
//  Copyright (c) 2014 Aricent Group. All rights reserved.
//

#import "ReportViewController.h"
#import "PCPieChart.h"
#import "Expense.h"
#import "Constants.h"
@interface ReportViewController ()

@end

@implementation ReportViewController
@synthesize titleLabelIncome,backgroundView,backgroundViewIncome,mScrollView,mainScrollView,viewExpense,viewIncome,titleLabelExpense,mManagedObjectContext;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setNavigationBar];

    mScrollView.contentSize =CGSizeMake(610, 235);
	mScrollView.delegate = self;
    [mScrollView setBackgroundColor:UIColorFromHexRGB(0xF7D138)];
    mScrollView.layer.borderColor = [[UIColor blackColor] CGColor];
    mScrollView.layer.borderWidth = 1;
    
    mainScrollView.contentSize =CGSizeMake(320, 450);
	mainScrollView.delegate = self;
    [mainScrollView setBackgroundColor:[UIColor whiteColor]];
    
    [self.view setBackgroundColor:[UIColor grayColor]];

    [viewIncome setBackgroundColor:UIColorFromHexRGB(0xF7D138)];
    viewIncome.backgroundColor=RGB(220,220,220);
    viewIncome.alpha=0.85;
    viewIncome.layer.borderColor = [[UIColor blackColor] CGColor];
    viewIncome.layer.borderWidth = 1;
    
    [viewExpense setBackgroundColor:UIColorFromHexRGB(0xF7D138)];
    viewExpense.backgroundColor=RGB(220,220,220);
    viewExpense.alpha=0.85;
    viewExpense.layer.borderColor = [[UIColor blackColor] CGColor];
    viewExpense.layer.borderWidth = 1;
    
    int height = [self.backgroundView bounds].size.width/3*2.; // 220;
    int width = [self.backgroundView bounds].size.width; //320;
    PCPieChart *pieChart = [[PCPieChart alloc] initWithFrame:CGRectMake(([self.backgroundView bounds].size.width-width)/2,([self.backgroundView bounds].size.height-height)/2,width,height)];
    [pieChart setAutoresizingMask:UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleBottomMargin];
    [pieChart setDiameter:width/2];
    [pieChart setSameColorLabel:YES];
    [self.backgroundView addSubview:pieChart];
    NSMutableArray *components = [NSMutableArray array];
    NSMutableArray *temp = [NSMutableArray array];
    for (int i=0; i<[[[self fetchedResultsController] fetchedObjects] count]; i++)
    {
        
         Expense *item = [[[self fetchedResultsController] fetchedObjects] objectAtIndex:i];
         if([item.transactionType isEqualToString:@"Expense"])
         {
             [temp addObject:item];
         }

    }
    NSMutableArray *sortedArray = [NSMutableArray array];
    sortedArray = [self sortArray:temp];
    NSInteger totalExpense = 0;
    for (int i=0; i<[sortedArray count]; i++)
    {
        PCPieComponent *component;
        if (i==0)
        {
            component = nil;
            component = [PCPieComponent pieComponentWithTitle:@"Automobile" value:[[sortedArray objectAtIndex:i] floatValue]];
            [component setColour:PCColorBlue];

            if([[sortedArray objectAtIndex:i] floatValue] > 0)
            {
                [components addObject:component];
                totalExpense = totalExpense + [[sortedArray objectAtIndex:i] integerValue];

            }
        }
        else if (i==1)
        {
            component = nil;

            component = [PCPieComponent pieComponentWithTitle:@"Clothing" value:[[sortedArray objectAtIndex:i] floatValue]];
            [component setColour:PCColorGreen];

            if([[sortedArray objectAtIndex:i] floatValue] > 0)
            {
                [components addObject:component];
                totalExpense = totalExpense + [[sortedArray objectAtIndex:i] integerValue];

            }

        }
        else if (i==2)
        {
            component = nil;

            component = [PCPieComponent pieComponentWithTitle:@"Entertainment" value:[[sortedArray objectAtIndex:i] floatValue]];
            [component setColour:PCColorOrange];

            if([[sortedArray objectAtIndex:i] floatValue] > 0)
            {
                [components addObject:component];
                totalExpense = totalExpense + [[sortedArray objectAtIndex:i] integerValue];

            }

        }
        else if (i==3)
        {
            component = nil;

            component = [PCPieComponent pieComponentWithTitle:@"Groceries" value:[[sortedArray objectAtIndex:i] floatValue]];
            [component setColour:PCColorRed];

            if([[sortedArray objectAtIndex:i] floatValue] > 0)
            {
                [components addObject:component];
                totalExpense = totalExpense + [[sortedArray objectAtIndex:i] integerValue];

            }

        }
        else if (i == 4)
        {
            component = nil;

            component = [PCPieComponent pieComponentWithTitle:@"Gifts" value:[[sortedArray objectAtIndex:i] floatValue]];
            [component setColour:PCColorBlue];

            if([[sortedArray objectAtIndex:i] floatValue] > 0)
            {
                [components addObject:component];
                totalExpense = totalExpense + [[sortedArray objectAtIndex:i] integerValue];

            }

        }
        else if (i == 5)
        {
            component = nil;

            component = [PCPieComponent pieComponentWithTitle:@"Household" value:[[sortedArray objectAtIndex:i] floatValue]];
            [component setColour:PCColorYellow];

            if([[sortedArray objectAtIndex:i] floatValue] > 0)
            {
                [components addObject:component];
                totalExpense = totalExpense + [[sortedArray objectAtIndex:i] integerValue];

            }
            
        }
        else if (i == 6)
        {
            component = nil;

            component = [PCPieComponent pieComponentWithTitle:@"Homecare" value:[[sortedArray objectAtIndex:i] floatValue]];
            [component setColour:PCColorDefault];

            if([[sortedArray objectAtIndex:i] floatValue] > 0)
            {
                [components addObject:component];
                totalExpense = totalExpense + [[sortedArray objectAtIndex:i] integerValue];

            }
            
        }
        else if (i == 7)
        {
            component = nil;

            component = [PCPieComponent pieComponentWithTitle:@"Insurance" value:[[sortedArray objectAtIndex:i] floatValue]];
            [component setColour:PCColorBlue];

            if([[sortedArray objectAtIndex:i] floatValue] > 0)
            {
                [components addObject:component];
                totalExpense = totalExpense + [[sortedArray objectAtIndex:i] integerValue];

            }
            
        }
        else if (i == 8)
        {
            component = nil;

            component = [PCPieComponent pieComponentWithTitle:@"Loans" value:[[sortedArray objectAtIndex:i] floatValue]];
            [component setColour:PCColorGreen];

            if([[sortedArray objectAtIndex:i] floatValue] > 0)
            {
                [components addObject:component];
                totalExpense = totalExpense + [[sortedArray objectAtIndex:i] integerValue];

            }
            
        }
        else if (i == 9)
        {
            component = nil;

            component = [PCPieComponent pieComponentWithTitle:@"Medical" value:[[sortedArray objectAtIndex:i] floatValue]];
            [component setColour:PCColorOrange];

            if([[sortedArray objectAtIndex:i] floatValue] > 0)
            {
                [components addObject:component];
                totalExpense = totalExpense + [[sortedArray objectAtIndex:i] integerValue];

            }
            
        }
        else if (i == 10)
        {
            component = nil;

            component = [PCPieComponent pieComponentWithTitle:@"Transfers" value:[[sortedArray objectAtIndex:i] floatValue]];
            [component setColour:PCColorRed];

            if([[sortedArray objectAtIndex:i] floatValue] > 0)
            {
                [components addObject:component];
                totalExpense = totalExpense + [[sortedArray objectAtIndex:i] integerValue];

            }
            
        }
        else if (i == 11)
        {
            component = nil;

            component = [PCPieComponent pieComponentWithTitle:@"Phone" value:[[sortedArray objectAtIndex:i] floatValue]];
            [component setColour:PCColorYellow];

            if([[sortedArray objectAtIndex:i] floatValue] > 0)
            {
                [components addObject:component];
                totalExpense = totalExpense + [[sortedArray objectAtIndex:i] integerValue];

            }
            
        }
        else if (i == 12)
        {
            component = nil;

            component = [PCPieComponent pieComponentWithTitle:@"Rent" value:[[sortedArray objectAtIndex:i] floatValue]];
            [component setColour:PCColorDefault];

            if([[sortedArray objectAtIndex:i] floatValue] > 0)
            {
                [components addObject:component];
                totalExpense = totalExpense + [[sortedArray objectAtIndex:i] integerValue];

            }
            
        }
        else if (i == 13)
        {
            component = nil;

            component = [PCPieComponent pieComponentWithTitle:@"Utilities" value:[[sortedArray objectAtIndex:i] floatValue]];
            [component setColour:PCColorBlue];

            if([[sortedArray objectAtIndex:i] floatValue] > 0)
            {
                [components addObject:component];
                totalExpense = totalExpense + [[sortedArray objectAtIndex:i] integerValue];

            }
            
        }
        else if (i == 14)
        {
            component = nil;

            component = [PCPieComponent pieComponentWithTitle:@"Others" value:[[sortedArray objectAtIndex:i] floatValue]];
            [component setColour:PCColorGreen];

            if([[sortedArray objectAtIndex:i] floatValue] > 0)
            {
                [components addObject:component];
                totalExpense = totalExpense + [[sortedArray objectAtIndex:i] integerValue];

            }
            
        }

    }
    [pieChart setComponents:components];

    titleLabelExpense.text = [NSString stringWithFormat:@"%d",totalExpense];
    PCPieChart *pieChartIncome = [[PCPieChart alloc] initWithFrame:CGRectMake(([self.backgroundViewIncome bounds].size.width-width)/2,([self.backgroundViewIncome bounds].size.height-height)/2,width,height)];
    [pieChartIncome setAutoresizingMask:UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleBottomMargin];
    [pieChartIncome setDiameter:width/2];
    [pieChartIncome setSameColorLabel:YES];
    
    [self.backgroundViewIncome addSubview:pieChartIncome];
    
    NSMutableArray *componentsIncome = [NSMutableArray array];

    NSMutableArray *tempIncome = [NSMutableArray array];
    for (int i=0; i<[[[self fetchedResultsController] fetchedObjects] count]; i++)
    {
        
        Expense *item = [[[self fetchedResultsController] fetchedObjects] objectAtIndex:i];
        if([item.transactionType isEqualToString:@"Income"])
        {
            [tempIncome addObject:item];
        }
        
    }
    sortedArray = nil;
    sortedArray = [self sortArray:tempIncome];
    NSInteger totalIncome = 0;
    for (int i=0; i<[sortedArray count]; i++)
    {
        PCPieComponent *component;
        if (i==0)
        {
            component = nil;
            component = [PCPieComponent pieComponentWithTitle:@"Automobile" value:[[sortedArray objectAtIndex:i] floatValue]];
            [component setColour:PCColorBlue];
            
            if([[sortedArray objectAtIndex:i] floatValue] > 0)
            {
                [componentsIncome addObject:component];
                totalIncome = totalIncome + [[sortedArray objectAtIndex:i] integerValue];
            }
        }
        else if (i==1)
        {
            component = nil;
            
            component = [PCPieComponent pieComponentWithTitle:@"Clothing" value:[[sortedArray objectAtIndex:i] floatValue]];
            [component setColour:PCColorGreen];
            
            if([[sortedArray objectAtIndex:i] floatValue] > 0)
            {
                [componentsIncome addObject:component];
                totalIncome = totalIncome + [[sortedArray objectAtIndex:i] integerValue];

            }
            
        }
        else if (i==2)
        {
            component = nil;
            
            component = [PCPieComponent pieComponentWithTitle:@"Entertainment" value:[[sortedArray objectAtIndex:i] floatValue]];
            [component setColour:PCColorOrange];
            
            if([[sortedArray objectAtIndex:i] floatValue] > 0)
            {
                [componentsIncome addObject:component];
                totalIncome = totalIncome + [[sortedArray objectAtIndex:i] integerValue];

            }
            
        }
        else if (i==3)
        {
            component = nil;
            
            component = [PCPieComponent pieComponentWithTitle:@"Groceries" value:[[sortedArray objectAtIndex:i] floatValue]];
            [component setColour:PCColorRed];
            
            if([[sortedArray objectAtIndex:i] floatValue] > 0)
            {
                [componentsIncome addObject:component];
                totalIncome = totalIncome + [[sortedArray objectAtIndex:i] integerValue];

            }
            
        }
        else if (i == 4)
        {
            component = nil;
            
            component = [PCPieComponent pieComponentWithTitle:@"Gifts" value:[[sortedArray objectAtIndex:i] floatValue]];
            [component setColour:PCColorBlue];
            
            if([[sortedArray objectAtIndex:i] floatValue] > 0)
            {
                [componentsIncome addObject:component];
                totalIncome = totalIncome + [[sortedArray objectAtIndex:i] integerValue];

            }
            
        }
        else if (i == 5)
        {
            component = nil;
            
            component = [PCPieComponent pieComponentWithTitle:@"Household" value:[[sortedArray objectAtIndex:i] floatValue]];
            [component setColour:PCColorYellow];
            
            if([[sortedArray objectAtIndex:i] floatValue] > 0)
            {
                [componentsIncome addObject:component];
                totalIncome = totalIncome + [[sortedArray objectAtIndex:i] integerValue];

            }
            
        }
        else if (i == 6)
        {
            component = nil;
            
            component = [PCPieComponent pieComponentWithTitle:@"Homecare" value:[[sortedArray objectAtIndex:i] floatValue]];
            [component setColour:PCColorDefault];
            
            if([[sortedArray objectAtIndex:i] floatValue] > 0)
            {
                [componentsIncome addObject:component];
                totalIncome = totalIncome + [[sortedArray objectAtIndex:i] integerValue];

            }
            
        }
        else if (i == 7)
        {
            component = nil;
            
            component = [PCPieComponent pieComponentWithTitle:@"Insurance" value:[[sortedArray objectAtIndex:i] floatValue]];
            [component setColour:PCColorBlue];
            
            if([[sortedArray objectAtIndex:i] floatValue] > 0)
            {
                [componentsIncome addObject:component];
                totalIncome = totalIncome + [[sortedArray objectAtIndex:i] integerValue];

            }
            
        }
        else if (i == 8)
        {
            component = nil;
            
            component = [PCPieComponent pieComponentWithTitle:@"Loans" value:[[sortedArray objectAtIndex:i] floatValue]];
            [component setColour:PCColorGreen];
            
            if([[sortedArray objectAtIndex:i] floatValue] > 0)
            {
                [componentsIncome addObject:component];
                totalIncome = totalIncome + [[sortedArray objectAtIndex:i] integerValue];

            }
            
        }
        else if (i == 9)
        {
            component = nil;
            
            component = [PCPieComponent pieComponentWithTitle:@"Medical" value:[[sortedArray objectAtIndex:i] floatValue]];
            [component setColour:PCColorOrange];
            
            if([[sortedArray objectAtIndex:i] floatValue] > 0)
            {
                [componentsIncome addObject:component];
                totalIncome = totalIncome + [[sortedArray objectAtIndex:i] integerValue];

            }
            
        }
        else if (i == 10)
        {
            component = nil;
            
            component = [PCPieComponent pieComponentWithTitle:@"Transfers" value:[[sortedArray objectAtIndex:i] floatValue]];
            [component setColour:PCColorRed];
            
            if([[sortedArray objectAtIndex:i] floatValue] > 0)
            {
                [componentsIncome addObject:component];
                totalIncome = totalIncome + [[sortedArray objectAtIndex:i] integerValue];

            }
            
        }
        else if (i == 11)
        {
            component = nil;
            
            component = [PCPieComponent pieComponentWithTitle:@"Phone" value:[[sortedArray objectAtIndex:i] floatValue]];
            [component setColour:PCColorYellow];
            
            if([[sortedArray objectAtIndex:i] floatValue] > 0)
            {
                [componentsIncome addObject:component];
                totalIncome = totalIncome + [[sortedArray objectAtIndex:i] integerValue];

            }
            
        }
        else if (i == 12)
        {
            component = nil;
            
            component = [PCPieComponent pieComponentWithTitle:@"Rent" value:[[sortedArray objectAtIndex:i] floatValue]];
            [component setColour:PCColorDefault];
            
            if([[sortedArray objectAtIndex:i] floatValue] > 0)
            {
                [componentsIncome addObject:component];
                totalIncome = totalIncome + [[sortedArray objectAtIndex:i] integerValue];

            }
            
        }
        else if (i == 13)
        {
            component = nil;
            
            component = [PCPieComponent pieComponentWithTitle:@"Utilities" value:[[sortedArray objectAtIndex:i] floatValue]];
            [component setColour:PCColorBlue];
            
            if([[sortedArray objectAtIndex:i] floatValue] > 0)
            {
                [componentsIncome addObject:component];
                totalIncome = totalIncome + [[sortedArray objectAtIndex:i] integerValue];

            }
            
        }
        else if (i == 14)
        {
            component = nil;
            
            component = [PCPieComponent pieComponentWithTitle:@"Others" value:[[sortedArray objectAtIndex:i] floatValue]];
            [component setColour:PCColorGreen];
            
            if([[sortedArray objectAtIndex:i] floatValue] > 0)
            {
                [componentsIncome addObject:component];
                totalIncome = totalIncome + [[sortedArray objectAtIndex:i] integerValue];

            }
            
        }
        
    }
    [pieChartIncome setComponents:componentsIncome];
    
    titleLabelIncome.text = [NSString stringWithFormat:@"%d",totalIncome];
    
    
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


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(NSMutableArray *)sortArray: (NSMutableArray *)array
{

    NSInteger Automobile = 0,Clothing = 0,Entertainment = 0,Groceries = 0,Gifts = 0,Household = 0,Homecare = 0,
    Insurance = 0,Loans = 0,Medical = 0,Transfers = 0,Phone = 0,Rent = 0,Utilities = 0,Others = 0;
    
    for (int i=0; i<[array count]; i++)
    {
        Expense *item = [array objectAtIndex:i];
        if([item.category isEqualToString:@"Automobile"])
        {
            Automobile = Automobile + [item.transactionAmount intValue];
        }
        else if([item.category isEqualToString:@"Clothing"])
        {
            Clothing = Clothing + [item.transactionAmount intValue];
        }
        else if([item.category isEqualToString:@"Entertainment"])
        {
            Entertainment = Entertainment + [item.transactionAmount intValue];
        }
        else if([item.category isEqualToString:@"Groceries"])
        {
            Groceries = Groceries + [item.transactionAmount intValue];
        }
        else if([item.category isEqualToString:@"Gifts"])
        {
            Gifts = Gifts + [item.transactionAmount intValue];
        }
        else if([item.category isEqualToString:@"Household"])
        {
            Household = Household + [item.transactionAmount intValue];
        }
        else if([item.category isEqualToString:@"Homecare"])
        {
            Homecare = Homecare + [item.transactionAmount intValue];
        }
        else if([item.category isEqualToString:@"Insurance"])
        {
            Insurance = Insurance + [item.transactionAmount intValue];
        }
        else if([item.category isEqualToString:@"Loans"])
        {
            Loans = Loans + [item.transactionAmount intValue];
        }
        else if([item.category isEqualToString:@"Medical"])
        {
            Medical = Medical + [item.transactionAmount intValue];
        }
        else if([item.category isEqualToString:@"Transfers"])
        {
            Transfers = Transfers + [item.transactionAmount intValue];
        }
        else if([item.category isEqualToString:@"Phone"])
        {
            Phone = Phone + [item.transactionAmount intValue];
        }
        else if([item.category isEqualToString:@"Rent"])
        {
            Rent = Rent + [item.transactionAmount intValue];
        }
        else if([item.category isEqualToString:@"Utilities"])
        {
            Utilities = Utilities + [item.transactionAmount intValue];
        }
        else if([item.category isEqualToString:@"Others"])
        {
            Others = Others + [item.transactionAmount intValue];
        }
        
    }
    NSMutableArray *sortedArrray = [[NSMutableArray alloc] initWithObjects:[NSNumber numberWithInteger:Automobile],[NSNumber numberWithInteger:Clothing],[NSNumber numberWithInteger:Entertainment],[NSNumber numberWithInteger:Groceries],[NSNumber numberWithInteger:Gifts],[NSNumber numberWithInteger:Household],[NSNumber numberWithInteger:Homecare],[NSNumber numberWithInteger:Insurance],[NSNumber numberWithInteger:Loans],[NSNumber numberWithInteger:Medical],[NSNumber numberWithInteger:Transfers],[NSNumber numberWithInteger:Phone],[NSNumber numberWithInteger:Rent],[NSNumber numberWithInteger:Utilities],[NSNumber numberWithInteger:Others], nil];
    return sortedArrray;
}
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

@end
