//
//  ContactManager.h
//  Personal Assistant
//
//  Created by Aricent Group on 21/10/13.
//  Copyright (c) 2013 Aricent Group. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AddressBook/AddressBook.h>

@interface ContactManager : NSObject{
    ABAddressBookRef addressBook;
}
@property(nonatomic,strong)NSMutableArray *contactList;
@property(assign, nonatomic)ABAddressBookRef addressBook;
@property(assign, nonatomic)BOOL phonebookNotaccessible;


+ (id)getInstance;
-(void)fetchContactsFromDevice;
-(void)updateDeviceContacts: (NSMutableArray *)deletedContacts;

@end
