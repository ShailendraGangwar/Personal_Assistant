//
//  HomeScreenViewController.m
//  Personal Assistant
//
//  Created by Aricent Group on 15/10/13.
//  Copyright (c) 2013 Aricent Group. All rights reserved.
//

#import "HomeScreenViewController.h"
#import "Constants.h"
#import "TabbarViewController.h"
#import "TaskListViewController.h"
#import "ContactsViewController.h"
#import "ExpenseViewController.h"
#import "ContactManager.h"
@interface HomeScreenViewController ()

@end

@implementation HomeScreenViewController
@synthesize mNotSharedLabel,mBackgroundView,mPersonalLabel,mAssistantLabel,mDigitalAssistantLabel,mTaskDescLabel,mTaskLabel,mContactsDescLabel,mBoundaryView,mContactsLabel,mExpenseDescLabel,mExpenseLabel;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setCustomFontsAndColors];
    [[ContactManager getInstance] fetchContactsFromDevice];
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void) setCustomFontsAndColors
{
    [mNotSharedLabel setFont: [UIFont fontWithName:@UNIVERS_65_BOLD_LATIN size:20]];
    [mPersonalLabel setFont: [UIFont fontWithName:@UNIVERS_67_CONDENSED_BOLD_LATIN size:24]];
    mPersonalLabel.shadowColor = [UIColor grayColor];
    mPersonalLabel.shadowOffset = CGSizeMake(0, 1);
    mPersonalLabel.textColor = RGB(255,165,34);
    mPersonalLabel.alpha = 0.85;
    [mAssistantLabel setFont: [UIFont fontWithName:@UNIVERS_67_CONDENSED_BOLD_LATIN size:24]];
    mAssistantLabel.shadowColor = [UIColor lightGrayColor];
    mAssistantLabel.shadowOffset = CGSizeMake(0, 1);
    [mDigitalAssistantLabel setTextColor:UIColorFromHexRGB(0x323232)];
    [mDigitalAssistantLabel setFont: [UIFont fontWithName:@UNIVERS_67_CONDENSED_BOLD_LATIN size:16]];
    [mContactsLabel setFont: [UIFont fontWithName:@UNIVERS_67_CONDENSED_BOLD_LATIN size:17]];
    [mTaskLabel setFont: [UIFont fontWithName:@UNIVERS_67_CONDENSED_BOLD_LATIN size:17]];
    [mExpenseLabel setFont: [UIFont fontWithName:@UNIVERS_67_CONDENSED_BOLD_LATIN size:17]];
    [mContactsDescLabel setFont: [UIFont fontWithName:@UNIVERS_55_ROMAN_LATIN size:13]];
    [mTaskDescLabel setFont: [UIFont fontWithName:@UNIVERS_55_ROMAN_LATIN size:13]];
    [mExpenseDescLabel setFont: [UIFont fontWithName:@UNIVERS_55_ROMAN_LATIN size:13]];
    mBoundaryView.layer.borderColor = [UIColorFromHexRGB(0x004f7d) CGColor];
    mBoundaryView.layer.borderWidth = 3;
    mBoundaryView.layer.cornerRadius = 8;
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = mBackgroundView.bounds;
    gradient.colors = [NSArray arrayWithObjects:(id)[[RGB(219, 221, 222) colorWithAlphaComponent:1.0] CGColor], (id)[[RGB(238, 238, 238) colorWithAlphaComponent:0.5] CGColor], nil];
    [mBackgroundView.layer insertSublayer:gradient atIndex:0];
}



-(IBAction)pushView:(id)sender
{
    NSInteger buttonTag = [sender tag];

    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"mainStoryboard" bundle:[NSBundle mainBundle]];
    TabbarViewController *myViewController = [storyboard instantiateViewControllerWithIdentifier:@"TabbarViewController"];
    if(buttonTag == 234)
        [myViewController setSelectedIndex:0];
    else if(buttonTag == 235)
        [myViewController setSelectedIndex:1];
    else
        [myViewController setSelectedIndex:2];

    [self.navigationController pushViewController:myViewController animated:YES];

}



@end
