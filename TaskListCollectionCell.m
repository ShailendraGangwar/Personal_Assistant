//
//  TaskListCollectionCell.m
//  Personal Assistant
//
//  Created by Aricent Group on 23/10/13.
//  Copyright (c) 2013 Aricent Group. All rights reserved.
//

#import "TaskListCollectionCell.h"
#import "Constants.h"
@implementation TaskListCollectionCell

@synthesize backgroundView,cellLabel;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void)layoutSubviews{
    backgroundView.layer.borderColor = [[UIColor lightGrayColor]CGColor];
    backgroundView.layer.borderWidth = 2;
    backgroundView.layer.cornerRadius = 8;
    backgroundView.alpha = 0.85;
    [cellLabel setFont: [UIFont fontWithName:@UNIVERS_67_CONDENSED_BOLD_LATIN size:16]];
    [cellLabel setTextColor:RGB(240,240,240)];


}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
