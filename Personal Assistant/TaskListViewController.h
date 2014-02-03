//
//  TaskListViewController.h
//  Personal Assistant
//
//  Created by Aricent Group on 15/10/13.
//  Copyright (c) 2013 Aricent Group. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
@interface TaskListViewController : UIViewController< UICollectionViewDataSource, UICollectionViewDelegateFlowLayout,NSFetchedResultsControllerDelegate,UIPickerViewDataSource,UIPickerViewDelegate>
{
    NSFetchedResultsController          *mFetchedResultsController;
    NSManagedObjectContext              *mManagedObjectContext;


}
@property (weak,nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak,nonatomic) IBOutlet UIView *createTaskListView;
@property (weak,nonatomic) IBOutlet UITextField *taskListNameTextField;
@property (weak,nonatomic) IBOutlet UILabel *createLabel;
@property (weak,nonatomic) IBOutlet UILabel *listNameLabel;

@property (nonatomic, strong) NSManagedObjectContext     *mManagedObjectContext;
- (IBAction)ShowData:(id)sender;
- (IBAction)EnterData:(id)sender;
- (IBAction)CreateTaskList:(id)sender;
- (IBAction)SaveButtonPressed:(id)sender;
- (IBAction)cancelButtonPressed:(id)sender;
- (NSFetchedResultsController *)fetchedResultsController;

@end
