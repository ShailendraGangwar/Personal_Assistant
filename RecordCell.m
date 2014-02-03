//
//  RecordCell.m
//  Personal Assistant
//
//  Created by Aricent Group on 24/10/13.
//  Copyright (c) 2013 Aricent Group. All rights reserved.
//

#import "RecordCell.h"
@implementation RecordCell
@synthesize backgroundView,amountLabel,dateLabel,categoryLabel,descLabel,typeLabel;
@synthesize expenseLabel;
@synthesize upperView,lowerView;

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
    
    [self customizeLabel:typeLabel];
    [self customizeLabel:descLabel];
    [self customizeLabel:amountLabel];
    [self customizeLabel:dateLabel];
    [self customizeLabel:categoryLabel];
    backgroundView.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    backgroundView.layer.borderWidth = 1;
    backgroundView.layer.cornerRadius = 4;
    [expenseLabel setFont: [UIFont fontWithName:@UNIVERS_57_CONDENSED_LATIN size:15]];
    expenseLabel.shadowColor = [UIColor grayColor];
    expenseLabel.shadowOffset = CGSizeMake(0, 1);
    expenseLabel.alpha = 0.5;
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = backgroundView.bounds;
    gradient.colors = [NSArray arrayWithObjects:
                       (id)[[RGB(200, 200, 200) colorWithAlphaComponent:1.0] CGColor],
                       (id)[[RGB(238, 238, 238) colorWithAlphaComponent:0.1] CGColor],
                       nil];
    [backgroundView.layer insertSublayer:gradient atIndex:0];

    upperView.backgroundColor = [UIColor lightGrayColor];
    lowerView.backgroundColor = [UIColor lightGrayColor];
}
-(void) customizeLabel: (UILabel *)lbl
{
    [lbl setFont: [UIFont fontWithName:@UNIVERS_57_CONDENSED_LATIN size:15]];
    lbl.shadowColor = [UIColor grayColor];
    lbl.shadowOffset = CGSizeMake(0, 1);
    lbl.textColor = [UIColor blackColor];
    lbl.alpha = 0.7;
    
}

@end
