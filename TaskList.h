//
//  TaskList.h
//  Personal Assistant
//
//  Created by Apple on 05/12/13.
//  Copyright (c) 2013 Aricent Group. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface TaskList : NSManagedObject

@property (nonatomic, retain) NSNumber * isTaskListActive;
@property (nonatomic, retain) NSNumber * taskAlarmstatus;
@property (nonatomic, retain) NSString * taskDesc;
@property (nonatomic, retain) NSString * taskEndtime;
@property (nonatomic, retain) NSNumber * taskid;
@property (nonatomic, retain) NSString * taskListName;
@property (nonatomic, retain) NSString * taskName;
@property (nonatomic, retain) NSString * taskPriority;
@property (nonatomic, retain) NSString * taskStartTime;
@property (nonatomic, retain) NSString * taskStatus;

@end
