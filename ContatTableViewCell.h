//
//  ContatTableViewCell.h
//  Personal Assistant
//
//  Created by Aricent Group on 21/10/13.
//  Copyright (c) 2013 Aricent Group. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ContatTableViewCell : UITableViewCell
{
    
}

@property (weak, nonatomic) IBOutlet UILabel        *mNameLabel;
@property (weak, nonatomic) IBOutlet UILabel        *mMobileNumber1;
@property (weak, nonatomic) IBOutlet UILabel        *mMobileNumber2;
@property (weak, nonatomic) IBOutlet UILabel        *mMobileNumber3;
@property (weak, nonatomic) IBOutlet UILabel        *mMobileNumber4;
@property (weak, nonatomic) IBOutlet UILabel        *mTypeofPhoneLabel1;
@property (weak, nonatomic) IBOutlet UILabel        *mTypeofPhoneLabel2;
@property (weak, nonatomic) IBOutlet UILabel        *mTypeofPhoneLabel3;
@property (weak, nonatomic) IBOutlet UILabel        *mOthersLabel;
@property (strong,nonatomic) IBOutlet UIView          *backgroundView;

-(void)hideAllLabels;



@end
