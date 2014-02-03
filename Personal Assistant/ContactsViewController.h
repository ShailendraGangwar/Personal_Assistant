//
//  ContactsViewController.h
//  Personal Assistant
//
//  Created by Aricent Group on 18/10/13.
//  Copyright (c) 2013 Aricent Group. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ContactsViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>
{
    NSMutableArray *contactArray;
    NSInteger currentIndex;
    NSMutableArray *deletedcontactArray;
    
    
}
@property (weak, nonatomic) IBOutlet UILabel        *mSyncLabel;
@property (weak, nonatomic) IBOutlet UILabel        *mSyncHelpTextLabel;
@property (weak,nonatomic) IBOutlet UITableView  *contactTableView;
@property (weak,nonatomic) IBOutlet UIView  *mTopView;
@property (weak,nonatomic) IBOutlet UIImageView  *mSyncView;

- (IBAction)syncContacts:(id)sender;

@end
