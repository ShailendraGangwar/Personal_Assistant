//
//  ReportViewController.h
//  HeyZooka
//
//  Created by Apple on 20/01/14.
//  Copyright (c) 2014 Aricent Group. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PAAppDelegate.h"
@interface ReportViewController : UIViewController<UIScrollViewDelegate>
{
    NSFetchedResultsController          *mFetchedResultsController;
    NSManagedObjectContext              *mManagedObjectContext;


}
@property (nonatomic, weak) IBOutlet UILabel *titleLabelIncome;
@property (nonatomic, weak) IBOutlet UILabel *titleLabelExpense;
@property (nonatomic, weak) NSMutableArray *mArray;
@property (nonatomic, weak) IBOutlet UIView *backgroundView;
@property (nonatomic, weak) IBOutlet UIView *backgroundViewIncome;
@property (weak,nonatomic) IBOutlet UIScrollView *mScrollView;
@property (weak,nonatomic) IBOutlet UIScrollView *mainScrollView;
@property (nonatomic, weak) IBOutlet UIView *viewIncome;
@property (nonatomic, weak) IBOutlet UIView *viewExpense;
@property (nonatomic, strong)            NSManagedObjectContext     *mManagedObjectContext;

- (NSFetchedResultsController *)fetchedResultsController;
@end
