//
//  ExpenseViewController.h
//  Personal Assistant
//
//  Created by Aricent Group on 18/10/13.
//  Copyright (c) 2013 Aricent Group. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NIDropDown.h"
@interface ExpenseViewController : UIViewController<NSFetchedResultsControllerDelegate,NIDropDownDelegate>
{
    NSFetchedResultsController          *mFetchedResultsController;
    NSManagedObjectContext              *mManagedObjectContext;
    NIDropDown *dropDown;
}
@property (weak,nonatomic)      IBOutlet UITableView                *recordTableView;
@property (nonatomic, strong)            NSManagedObjectContext     *mManagedObjectContext;
@property (weak,nonatomic)      IBOutlet UILabel                *mNetBalance;
@property (weak,nonatomic)      IBOutlet UILabel                *mNetBalanceAmount;
@property (weak,nonatomic)      IBOutlet UIButton               *mNewButton;
@property (weak,nonatomic)      NSString *sorting;
@property (weak,nonatomic)      NSString *type;
@property (strong,nonatomic)    NSMutableArray                  *mTempExpenseData;
@property (strong,nonatomic)    NSMutableArray                  *mTempPlotArray;
@property (strong,nonatomic) IBOutlet UIView  *mTopView;
-(IBAction)addExpenseOrIncome:(id)sender;
-(NSMutableArray *)getFetchedObjects;
@end
