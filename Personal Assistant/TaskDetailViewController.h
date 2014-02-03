//
//  TaskDetailViewController.h
//  Personal Assistant
//
//  Created by Aricent Group on 31/10/13.
//  Copyright (c) 2013 Aricent Group. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TaskList.h"
@interface TaskDetailViewController : UIViewController<UITextFieldDelegate,UIScrollViewDelegate,UIPickerViewDelegate>
{
    UIDatePicker                        *timePick;
    NSMutableString* date;
    NSMutableString* startDate;
    NSMutableString* endDate;

}
@property (weak,nonatomic) IBOutlet UIScrollView *mScrollView;
@property (weak,nonatomic) IBOutlet UILabel *taskLabel;
@property (weak,nonatomic) IBOutlet UITextView *taskDescription;
@property (weak,nonatomic) IBOutlet UITextField *taskNameTextField;
@property (weak,nonatomic) IBOutlet UILabel *taskStartTimeLabel;
@property (weak,nonatomic) IBOutlet UILabel *taskEndTimeLabel;
@property (weak,nonatomic) IBOutlet UITextField *startTimeLabel;
@property (weak,nonatomic) IBOutlet UITextField *endTimeLabel;
@property (weak,nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak,nonatomic) IBOutlet UILabel *statusLabel;
@property (weak,nonatomic) IBOutlet UILabel *priorityLabel;
@property (weak,nonatomic) IBOutlet UILabel *alarmLabel;
@property (weak,nonatomic) IBOutlet UILabel *activateLabel;
@property (weak,nonatomic) IBOutlet UIButton *saveButton;
@property (weak,nonatomic) IBOutlet UIButton *deleteButton;
@property (strong,nonatomic) IBOutlet UISegmentedControl *statusControl;
@property (strong,nonatomic) IBOutlet UISegmentedControl *alarmControl;
@property (strong,nonatomic) IBOutlet UISegmentedControl *priorityControl;
@property (strong,nonatomic) IBOutlet UISegmentedControl *activateControl;

@property(nonatomic)                TaskList *mTempTaskData;
@property(weak, nonatomic) NSString *TaskListName;


@end
