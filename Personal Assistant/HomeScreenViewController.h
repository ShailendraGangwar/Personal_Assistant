//
//  HomeScreenViewController.h
//  Personal Assistant
//
//  Created by Aricent Group on 15/10/13.
//  Copyright (c) 2013 Aricent Group. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeScreenViewController : UIViewController{
    
    
}
@property (weak, nonatomic) IBOutlet UILabel        *mNotSharedLabel;
@property (weak, nonatomic) IBOutlet UILabel        *mSexTitle;
@property (weak, nonatomic) IBOutlet UILabel        *mpartitionLine;
@property (weak, nonatomic) IBOutlet UIView        *mBackgroundView;
@property (weak, nonatomic) IBOutlet UILabel        *mPersonalLabel;
@property (weak, nonatomic) IBOutlet UILabel        *mAssistantLabel;
@property (weak, nonatomic) IBOutlet UILabel        *mDigitalAssistantLabel;
@property (weak, nonatomic) IBOutlet UILabel        *mTaskLabel;
@property (weak, nonatomic) IBOutlet UILabel        *mTaskDescLabel;
@property (weak, nonatomic) IBOutlet UILabel        *mContactsLabel;
@property (weak, nonatomic) IBOutlet UILabel        *mContactsDescLabel;
@property (weak, nonatomic) IBOutlet UILabel        *mExpenseLabel;
@property (weak, nonatomic) IBOutlet UILabel        *mExpenseDescLabel;
@property (weak, nonatomic) IBOutlet UIImageView        *mPAImage;
@property (weak, nonatomic) IBOutlet UIView        *mBoundaryView;


@end
