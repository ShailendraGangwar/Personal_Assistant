//
//  TaskViewCell.m
//  Personal Assistant
//
//  Created by Aricent Group on 24/10/13.
//  Copyright (c) 2013 Aricent Group. All rights reserved.
//

#import "TaskViewCell.h"
#import "Constants.h"
@implementation TaskViewCell

@synthesize taskNameLabel,backgroundView,timeLabel,statusStateLabel,priorityView,mCheckMark,mAlarmImageView;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)layoutSubviews{
    
    [super layoutSubviews];

    [taskNameLabel setFont: [UIFont fontWithName:@UNIVERS_57_CONDENSED_LATIN size:15]];
    taskNameLabel.textColor = [UIColor grayColor];
    [statusStateLabel setFont: [UIFont fontWithName:@UNIVERS_57_CONDENSED_LATIN size:15]];
    [timeLabel setFont: [UIFont fontWithName:@UNIVERS_57_CONDENSED_LATIN size:15]];
    timeLabel.textColor = [UIColor grayColor];

    statusStateLabel.shadowColor = [UIColor grayColor];
    statusStateLabel.shadowOffset = CGSizeMake(0, 1);
    statusStateLabel.alpha = 0.5;    [self setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = backgroundView.bounds;
    gradient.colors = [NSArray arrayWithObjects:
                       (id)[[RGB(200, 200, 200) colorWithAlphaComponent:1.0] CGColor],
                       (id)[[RGB(238, 238, 238) colorWithAlphaComponent:0.1] CGColor],
                       nil];
    [backgroundView.layer insertSublayer:gradient atIndex:0];
    backgroundView.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    backgroundView.layer.borderWidth = 1;
    backgroundView.layer.cornerRadius = 4;

   
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
