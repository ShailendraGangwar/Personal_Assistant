//
//  ContactManager.m
//  Personal Assistant
//
//  Created by Aricent Group on 21/10/13.
//  Copyright (c) 2013 Aricent Group. All rights reserved.
//
#import "ContactManager.h"
#import <AddressBook/AddressBook.h>

static ContactManager *CManager = nil;
@implementation ContactManager
@synthesize contactList,addressBook,phonebookNotaccessible;
+ (id)getInstance {
    @synchronized(self) {
        if (CManager == nil){
            CManager = [[self alloc] init];
        }
    }
    return CManager;
}

-(void)fetchContactsFromDevice
{
    contactList=[[NSMutableArray alloc] init];
    CFArrayRef allPeople;
    CFErrorRef errorRef = NULL;
    addressBook = ABAddressBookCreateWithOptions(NULL, &errorRef);
    if (errorRef && CFErrorGetCode(errorRef) == kABOperationNotPermittedByUserError)
    {
    }

    {
        __block BOOL accessGranted = NO;
        
#ifdef __IPHONE_6_0
        if (ABAddressBookRequestAccessWithCompletion != NULL) { // we're on iOS 6
            dispatch_semaphore_t sema = dispatch_semaphore_create(0);
            
            ABAddressBookRequestAccessWithCompletion(addressBook, ^(bool granted, CFErrorRef error) {
                accessGranted = granted;
                dispatch_semaphore_signal(sema);
                
            });
            
            dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
        }
        else
        {
            accessGranted = YES;
        }
        phonebookNotaccessible = !accessGranted;
        if (accessGranted) {
            allPeople = ABAddressBookCopyArrayOfAllPeople(addressBook);
        }
        else
        {
            if(addressBook)
                CFRelease(addressBook);
            return;
        }
        
#endif
    }
    CFIndex nPeople = CFArrayGetCount(allPeople);
    @autoreleasepool
    {
        for ( int i = 0; i < nPeople; i++ )
        {
            @autoreleasepool
            {
                ABRecordRef ref = CFArrayGetValueAtIndex(allPeople, i);
                [contactList addObject:CFBridgingRelease(ref)];
}
        }
    }
    return;
}


-(void)updateDeviceContacts: (NSMutableArray *)deletedContacts{
    
    CFErrorRef error = NULL;
    ABRecordRef ref;
    for ( int i = 0; i < deletedContacts.count; i++ )
    {
        ref = CFBridgingRetain([deletedContacts objectAtIndex:i]);
            ABAddressBookRemoveRecord(addressBook, ref, &error);
    }
    ABAddressBookSave(addressBook, &error);
}

@end







