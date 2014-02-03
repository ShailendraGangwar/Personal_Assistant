//
//  ContactsViewController.m
//  Personal Assistant
//
//  Created by Aricent Group on 18/10/13.
//  Copyright (c) 2013 Aricent Group. All rights reserved.
//
#import "Constants.h"
#import "ContactsViewController.h"
#import "ContactManager.h"
#import "ContatTableViewCell.h"
#import <AddressBook/AddressBook.h>
#define PHONETYPE_HOME                              @"_$!<Home>!$_"
#define PHONETYPE_MOBILE                            @"_$!<Mobile>!$_"
#define PHONETYPE_WORK                              @"_$!<Work>!$_"
#define BOTTTOMPADDING                              5
@interface ContactsViewController ()
@end

@implementation ContactsViewController

@synthesize mTopView,contactTableView;
@synthesize mSyncLabel;
@synthesize mSyncView;
@synthesize mSyncHelpTextLabel;

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setNavigationBar];
    contactArray = [[NSMutableArray alloc]init];
    deletedcontactArray = [[NSMutableArray alloc]init];
    [mTopView setBackgroundColor:UIColorFromHexRGB(0xF7D138)];
    
    mTopView.backgroundColor=RGB(220,220,220);
    mTopView.alpha=0.85;
    mTopView.layer.borderColor = [[UIColor blackColor] CGColor];
    mTopView.layer.borderWidth = 1;
    [mSyncLabel setFont: [UIFont fontWithName:@UNIVERS_55_ROMAN_LATIN size:17]];
    mSyncLabel.shadowColor = [UIColor grayColor];
    mSyncLabel.shadowOffset = CGSizeMake(0, 1);
    [mSyncHelpTextLabel setFont: [UIFont fontWithName:@UNIVERS_55_ROMAN_LATIN size:12]];
    mSyncLabel.textColor = RGB(255,134,34);
    mSyncLabel.alpha = 0.85;
    
}

- (void)addORDeleteRows
{
    [self.navigationItem.rightBarButtonItem setStyle:UIBarButtonItemStyleBordered];
    if(contactTableView.editing)
    {
        [self setEditing:NO animated:YES];
        [contactTableView reloadData];
        UIImageView *addTaskImageView = [[UIImageView alloc] init];
        addTaskImageView.frame = CGRectMake(-8,12,10,10);
        UIButton *backButton =  [UIButton buttonWithType:UIButtonTypeCustom];
        [backButton setFrame:CGRectMake(0, 10, 40, 33)];
        [backButton addSubview:addTaskImageView];
        UILabel *backLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,6,40,20)];
        backLabel.text = @"Edit";
        [backLabel setFont: [UIFont fontWithName:@UNIVERS_55_ROMAN_LATIN size:14]];
        [backLabel setTextColor:UIColorFromHexRGB(0x323232)];
        [backButton addSubview:backLabel];
        [backButton addTarget:self action:@selector(addORDeleteRows) forControlEvents:UIControlEventTouchUpInside];
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
        
    }
    else
    {
        [self setEditing:YES animated:YES];
        [contactTableView reloadData];
        [self.navigationItem.rightBarButtonItem setTitle:@"Done"];
        
        UIImageView *addTaskImageView = [[UIImageView alloc] init];
        addTaskImageView.frame = CGRectMake(-8,12,10,10);
        UIButton *backButton =  [UIButton buttonWithType:UIButtonTypeCustom];
        [backButton setFrame:CGRectMake(0, 10, 40, 33)];
        [backButton addSubview:addTaskImageView];
        UILabel *backLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,6,40,20)];
        backLabel.text = @"Done";
        [backLabel setFont: [UIFont fontWithName:@UNIVERS_55_ROMAN_LATIN size:14]];
        [backLabel setTextColor:UIColorFromHexRGB(0x323232)];
        [backButton addSubview:backLabel];
        [backButton addTarget:self action:@selector(addORDeleteRows) forControlEvents:UIControlEventTouchUpInside];
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];

    }
    
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



-(void)viewWillAppear:(BOOL)animated{
    contactArray = [[ContactManager getInstance] contactList];
    currentIndex=0;
}




#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [contactArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"ContatTableViewCell";
    ContatTableViewCell *cell = (ContatTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];

    ABRecordRef ref = CFBridgingRetain([contactArray objectAtIndex:indexPath.row]);
    CFStringRef firstName, lastName;
    firstName = ABRecordCopyValue(ref, kABPersonFirstNameProperty);
    lastName  = ABRecordCopyValue(ref, kABPersonLastNameProperty);
    ABMultiValueRef phones = ABRecordCopyValue( ref, kABPersonPhoneProperty );
    CFIndex phoneNumbersCount = ABMultiValueGetCount(phones);
    [cell hideAllLabels];
    cell.alpha = 0.3;
    for (int index = 0; index < phoneNumbersCount; index++)
    {
        {
            NSString* mobileLabel = (NSString*)CFBridgingRelease(ABMultiValueCopyLabelAtIndex(phones, index));
            mobileLabel = [mobileLabel stringByReplacingOccurrencesOfString:@"_$!<" withString:@""];
            mobileLabel = [mobileLabel stringByReplacingOccurrencesOfString:@">!$_" withString:@""];
            
            if(index == 0)
            {
                cell.mMobileNumber1.text = (NSString*)CFBridgingRelease(ABMultiValueCopyValueAtIndex(phones, index));
                cell.mTypeofPhoneLabel1.text = mobileLabel;
                cell.mTypeofPhoneLabel1.hidden = NO;
                cell.mMobileNumber1.hidden = NO;
                
            }
            else if (index == 1)
            {
                cell.mMobileNumber2.text = (NSString*)CFBridgingRelease(ABMultiValueCopyValueAtIndex(phones, index)) ;
                cell.mTypeofPhoneLabel2.text = mobileLabel;
                cell.mMobileNumber2.hidden = NO;
                cell.mTypeofPhoneLabel2.hidden = NO;
                
                
            }
            else if (index == 2)
            {   cell.mMobileNumber3.text = (NSString*)CFBridgingRelease(ABMultiValueCopyValueAtIndex(phones, index)) ;
                cell.mTypeofPhoneLabel3.text = mobileLabel;
                cell.mMobileNumber3.hidden = NO;
                cell.mTypeofPhoneLabel3.hidden = NO;
                
            }
            else
            {
                cell.mOthersLabel.hidden = NO;
                cell.mOthersLabel.text = @"&Others";
                break;
            }
        }
    }
 
    if((NSString *)CFBridgingRelease(lastName) == nil)
        cell.mNameLabel.text =[NSString stringWithFormat:@"  %@",firstName];
    else
        cell.mNameLabel.text =[NSString stringWithFormat:@"  %@ %@",firstName,lastName];
    CGRect frame;
    frame = cell.backgroundView.frame;
    frame.size.height = cell.frame.size.height - 3;
    cell.backgroundView.frame = frame;
    [cell setBackgroundColor: [UIColor groupTableViewBackgroundColor]];
    cell.alpha = 0.8;
  
    return cell;
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ABRecordRef ref = CFBridgingRetain([contactArray objectAtIndex:indexPath.row]);
    ABMultiValueRef phones = ABRecordCopyValue( ref, kABPersonPhoneProperty );
    CFIndex phoneNumbersCount = ABMultiValueGetCount(phones);
    
    float mincellHeight = 40;
    return (20 * phoneNumbersCount) + mincellHeight + BOTTTOMPADDING;
}
/*
 @method setNavigationBar
 @abstract This method customize the navigation bar
 @param none
 @result a void value
 */
-(void)setNavigationBar
{
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 123, 55)];
    headerView.backgroundColor = [UIColor clearColor];
    UIImageView *parentImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pa_logo.png"]];
    parentImageView.frame = CGRectMake(30, 10, 55, 45);
    [headerView addSubview: parentImageView];
    self.navigationItem.titleView = headerView;
//    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithTitle:@"Edit" style: UIBarButtonItemStyleBordered target:self action:@selector(addORDeleteRows)];
//    addButton.tintColor = RGB(255,134,34);
//    [self.navigationItem setRightBarButtonItem:addButton];
    
    UIImageView *addTaskImageView = [[UIImageView alloc] init];
    addTaskImageView.frame = CGRectMake(-8,12,10,10);
    UIButton *backButton =  [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setFrame:CGRectMake(0, 10, 40, 33)];
    [backButton addSubview:addTaskImageView];
    UILabel *backLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,6,40,20)];
    backLabel.text = @"Edit";
    [backLabel setFont: [UIFont fontWithName:@UNIVERS_55_ROMAN_LATIN size:14]];
    [backLabel setTextColor:UIColorFromHexRGB(0x323232)];
    [backButton addSubview:backLabel];
    [backButton addTarget:self action:@selector(addORDeleteRows) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    
    
    
}


/*!
 @method tableView:viewForHeaderInSection:
 @abstract delegate for the editing style of a row at a particular location in a table view.
 @param tableView,indexPath
 @result return the editing style.
 */
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
    
}


/*!
 @method setEditing:animated
 @abstract Sets whether the view controller shows an editable view.
 @param editing,animated
 @result a void value
 */
//- (void) setEditing:(BOOL)editing animated:(BOOL)animated
//{
//    [self.contactTableView setEditing:editing animated:animated];
//}
-(void)setEditing:(BOOL)editing animated:(BOOL) animated {
    [super setEditing:editing animated:animated];
    [contactTableView setEditing:editing animated:animated];
    [contactTableView reloadData];
}

/*!
 @method tableView:commitEditingStyle:forRowAtIndexPath:
 @abstract data source to commit the insertion or deletion of a specified row in the receiver.
 @param tableView,editingStyle,indexPath
 @result return a void value
 */
- (void) tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    [deletedcontactArray addObject:[contactArray objectAtIndex:indexPath.row]];
    [contactArray removeObjectAtIndex:indexPath.row];
    [contactTableView reloadData];
}

- (IBAction)syncContacts:(id)sender{
    [[ContactManager getInstance] updateDeviceContacts:deletedcontactArray];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"Contacts Synched." message:@"Contact synching has been completed." delegate:nil cancelButtonTitle:NSLocalizedString(@"OK", @"OK") otherButtonTitles:nil, nil];
    [alert show];
    [deletedcontactArray removeAllObjects];
}


@end
