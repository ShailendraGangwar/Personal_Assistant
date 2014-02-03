//
//  TaskViewController.h
//  Personal Assistant
//
//  Created by Aricent Group on 24/10/13.
//  Copyright (c) 2013 Aricent Group. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TaskViewController : UIViewController<NSFetchedResultsControllerDelegate>
{
    NSFetchedResultsController          *mFetchedResultsController;
    NSManagedObjectContext              *mManagedObjectContext;

}
@property(weak, nonatomic) NSString *TaskListName;
@property (weak,nonatomic) IBOutlet UILabel *taskListNameLabel;
@property (weak,nonatomic) IBOutlet UITableView *mtableView;
@property (nonatomic, strong)NSManagedObjectContext     *mManagedObjectContext;
@property (weak,nonatomic) IBOutlet UIButton *mActivateButton;
@property (weak,nonatomic) IBOutlet UIView  *mTopView;
@property (weak,nonatomic) IBOutlet UIButton *mDeleteButton;

-(IBAction)addTask:(id)sender;

@end
