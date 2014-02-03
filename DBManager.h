//
//  DBManager.h
//  Personal Assistant
//
//  Created by Aricent Group on 23/10/13.
//  Copyright (c) 2013 Aricent Group. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DBManager : NSObject{
    
}
@property(nonatomic,strong,readonly)NSManagedObjectContext *mainObjectContext;
+ (id)getInstance;
- (void)printOnConsole;
- (void) reInitializeManageObjectConext;
-(NSInteger)addTaskListinDb: (NSString *) TaskListName;
-(NSInteger)addRecordinDb: (NSDictionary *) recordDict;
-(NSInteger)deleteRecordinDb: (NSNumber *) transactionId;
-(NSInteger)addOrUpdateTaskinDb: (NSDictionary *) taskDict;

@end
