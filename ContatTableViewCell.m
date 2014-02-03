//
//  ContatTableViewCell.m
//  Personal Assistant
//
//  Created by Aricent Group on 21/10/13.
//  Copyright (c) 2013 Aricent Group. All rights reserved.
//

#import "ContatTableViewCell.h"
#import "Constants.h"
@implementation ContatTableViewCell
@synthesize backgroundView;
@synthesize mMobileNumber1,mMobileNumber2,mMobileNumber3,mMobileNumber4,mOthersLabel,mTypeofPhoneLabel1,mTypeofPhoneLabel2,mTypeofPhoneLabel3,mNameLabel;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        // Initialization code
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    [mMobileNumber1 setFont: [UIFont fontWithName:@UNIVERS_57_CONDENSED_LATIN size:15]];
    [mMobileNumber2 setFont: [UIFont fontWithName:@UNIVERS_57_CONDENSED_LATIN size:15]];
    [mMobileNumber3 setFont: [UIFont fontWithName:@UNIVERS_57_CONDENSED_LATIN size:15]];
    [mMobileNumber4 setFont: [UIFont fontWithName:@UNIVERS_57_CONDENSED_LATIN size:15]];
    [mOthersLabel setFont: [UIFont fontWithName:@UNIVERS_57_CONDENSED_LATIN size:15]];
    [mTypeofPhoneLabel1 setFont: [UIFont fontWithName:@UNIVERS_57_CONDENSED_LATIN size:15]];
    [mTypeofPhoneLabel2 setFont: [UIFont fontWithName:@UNIVERS_57_CONDENSED_LATIN size:15]];
    [mTypeofPhoneLabel3 setFont: [UIFont fontWithName:@UNIVERS_57_CONDENSED_LATIN size:15]];
    [mTypeofPhoneLabel1 setTextColor:UIColorFromHexRGB(0x323232)];
    [mTypeofPhoneLabel2 setTextColor:UIColorFromHexRGB(0x323232)];
    [mTypeofPhoneLabel3 setTextColor:UIColorFromHexRGB(0x323232)];
    [mOthersLabel setTextColor:UIColorFromHexRGB(0x323232)];
    mNameLabel.shadowColor = [UIColor grayColor];
    mNameLabel.shadowOffset = CGSizeMake(0, 1);
    mNameLabel.textColor = RGB(255,134,34);
    mNameLabel.layer.borderColor = [RGB(255,134,34) CGColor];
    mNameLabel.layer.borderWidth = 1;
    mNameLabel.layer.cornerRadius = 4;
    
    mMobileNumber1.textColor = [UIColor blackColor];
    mMobileNumber2.textColor = [UIColor blackColor];
    mMobileNumber3.textColor = [UIColor blackColor];
    mMobileNumber4.textColor = [UIColor blackColor];
    mTypeofPhoneLabel1.textColor = UIColorFromHexRGB(0x323232);
    mTypeofPhoneLabel2.textColor = UIColorFromHexRGB(0x323232);
    mTypeofPhoneLabel3.textColor = UIColorFromHexRGB(0x323232);
    mOthersLabel.textColor = UIColorFromHexRGB(0x323232);
    [mNameLabel setFont: [UIFont fontWithName:@UNIVERS_57_CONDENSED_LATIN size:18]];
    mNameLabel.alpha = 1;
    backgroundView.backgroundColor = RGB(200, 200, 200);
    backgroundView.alpha = 0.8;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

-(void)hideAllLabels{
    mMobileNumber1.hidden = YES;
    mMobileNumber2.hidden = YES;
    mMobileNumber3.hidden = YES;
    mMobileNumber4.hidden = YES;
    mOthersLabel.hidden = YES;
    mTypeofPhoneLabel1.hidden = YES;
    mTypeofPhoneLabel2.hidden = YES;
    mTypeofPhoneLabel3.hidden = YES;
}


@end
