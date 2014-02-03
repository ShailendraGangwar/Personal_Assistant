//
//  Expense.h
//  Personal Assistant
//
//  Created by Aricent Technologies on 25/10/13.
//  Copyright (c) 2013 Aricent Group. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Expense : NSManagedObject

@property (nonatomic, retain) NSNumber * balance;
@property (nonatomic, retain) NSString * category;
@property (nonatomic, retain) NSNumber * transactionAmount;
@property (nonatomic, retain) NSString * transactionDate;
@property (nonatomic, retain) NSNumber * transactionId;
@property (nonatomic, retain) NSString * transactionMode;
@property (nonatomic, retain) NSString * transactionType;
@property (nonatomic, retain) NSString * transactionNote;

@end
