//
//  TaskViewCell.h
//  Personal Assistant
//
//  Created by Aricent Group on 24/10/13.
//  Copyright (c) 2013 Aricent Group. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TaskViewCell : UITableViewCell
{
    
}
@property (strong, nonatomic) IBOutlet UIView        *backgroundView;
@property (weak, nonatomic) IBOutlet UILabel        *taskNameLabel;
@property (weak, nonatomic) IBOutlet UILabel        *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel        *statusStateLabel;
@property (strong, nonatomic) IBOutlet UIView        *priorityView;
@property (weak, nonatomic) IBOutlet UIImageView        *mAlarmImageView;
@property (weak, nonatomic) IBOutlet UIImageView        *mCheckMark;





@end
