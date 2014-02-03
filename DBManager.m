//
//  DBManager.m
//  Personal Assistant
//
//  Created by Aricent Group on 23/10/13.
//  Copyright (c) 2013 Aricent Group. All rights reserved.
//

#import "DBManager.h"
#import "PAAppDelegate.h"
#import "Expense.h"
#import "TaskList.h"
static DBManager *dbManager = nil;

@implementation DBManager

@synthesize mainObjectContext;




/*!
 * @method getInstance
 * @abstract This method faclitates singleton pattern.
 * @result Retrurns the instance of DBManager.
 */
+ (id)getInstance {
    @synchronized(self) {
        if (dbManager == nil){
            dbManager = [[self alloc] init];
        }
    }
    return dbManager;
}

/*!
 * @method reInitializeManageObjectConext
 * @abstract This method reinitializes the mainobjectcontext when called.
 * @result a void value.
 */
- (void) reInitializeManageObjectConext
{
    mainObjectContext = nil;
    [self mainObjectContext];
}

/*!
 * @method init
 * @abstract This method used intialize the instance.
 */
- (id)init {
    if (self = [super init]) {
        [self mainObjectContext];
    }
    return self;
}

/*!
 * @method mainObjectContext
 * @abstract This method used to retrieving the main NSManagedObjectContext from the app delegate.
 * @result Retrurns the instance of NSManagedObjectContext.
 */
- (NSManagedObjectContext *) mainObjectContext {
    if (mainObjectContext != nil) {
        return mainObjectContext;
    }

    PAAppDelegate *delegate = (PAAppDelegate*)[[UIApplication sharedApplication]delegate];
    mainObjectContext = [delegate managedObjectContext];
    return mainObjectContext;
}



-(NSInteger)addTaskListinDb: (NSString *) TaskListName{
    NSError *error;
    BOOL isDuplicateValue;
    isDuplicateValue =  [self isDuplicateValue:TaskListName];
    if(isDuplicateValue)
    {
        return 0;
        
    }
    NSManagedObject *userDetails = [NSEntityDescription
                                    insertNewObjectForEntityForName:@"Task"
                                    inManagedObjectContext:mainObjectContext];
    [userDetails setValue:TaskListName forKey:@"tasklistname"];
    if (![mainObjectContext save:&error]) {
        NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
        return 0;
    }
    return 1;
}




-(BOOL)isDuplicateValue:(NSString *)TaskListName{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription
                                   entityForName:@"Task" inManagedObjectContext:mainObjectContext];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"tasklistname == %@",TaskListName];
    [fetchRequest setPredicate: predicate];
    [fetchRequest setEntity:entity];
    NSError *error;
    NSArray *fetchedObjects = [mainObjectContext executeFetchRequest:fetchRequest error:&error];
    if([fetchedObjects count] > 0)
        return YES;
    else
        return NO;
}

-(NSInteger)addRecordinDb: (NSDictionary *) recordDict{
    NSError *error;
    if (recordDict == nil)
    {
        return 0;
    }
    if([recordDict objectForKey:@"id"] == nil)                                      // Adding a record
    {
        NSManagedObject *userDetails = [NSEntityDescription
                                    insertNewObjectForEntityForName:@"Expense"
                                    inManagedObjectContext:mainObjectContext];
        [userDetails setValue:[recordDict objectForKey:@"amount"] forKey:@"transactionAmount"];
        [userDetails setValue:[recordDict objectForKey:@"date"] forKey:@"transactionDate"];
        [userDetails setValue:[recordDict objectForKey:@"mode"] forKey:@"transactionMode"];
        [userDetails setValue:[recordDict objectForKey:@"category"] forKey:@"category"];
        [userDetails setValue:[recordDict objectForKey:@"type"] forKey:@"transactionType"];
        [userDetails setValue:[recordDict objectForKey:@"note"] forKey:@"transactionNote"];
        //[userDetails setValue:[recordDict objectForKey:@"balance"] forKey:@"balance"];

        NSTimeInterval milisecondedDate = ([[NSDate date] timeIntervalSince1970] * 1000);
        [userDetails setValue:[NSNumber numberWithDouble:milisecondedDate] forKey:@"transactionId"];
    }
    else                                                                                //updating a record
    {
        NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
        NSEntityDescription *entity = [NSEntityDescription
                                       entityForName:@"Expense" inManagedObjectContext:mainObjectContext];
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"transactionId == %@",[recordDict objectForKey:@"id"]];
        
        [fetchRequest setPredicate: predicate];
        [fetchRequest setEntity:entity];
        NSError *error;
        NSArray *fetchedObjects = [mainObjectContext executeFetchRequest:fetchRequest error:&error];
        for ( int i = 0; i < fetchedObjects.count; i++)
        {
            [[fetchedObjects objectAtIndex:i] setValue:[recordDict objectForKey:@"amount"] forKey:@"transactionAmount"];
            [[fetchedObjects objectAtIndex:i] setValue:[recordDict objectForKey:@"date"] forKey:@"transactionDate"];
            [[fetchedObjects objectAtIndex:i] setValue:[recordDict objectForKey:@"mode"] forKey:@"transactionMode"];
            [[fetchedObjects objectAtIndex:i] setValue:[recordDict objectForKey:@"category"] forKey:@"category"];
            [[fetchedObjects objectAtIndex:i] setValue:[recordDict objectForKey:@"type"] forKey:@"transactionType"];
            [[fetchedObjects objectAtIndex:i] setValue:[recordDict objectForKey:@"note"] forKey:@"transactionNote"];
            [[fetchedObjects objectAtIndex:i] setValue:[recordDict objectForKey:@"id"] forKey:@"transactionId"];
            //[[fetchedObjects objectAtIndex:i] setValue:[recordDict objectForKey:@"balance"] forKey:@"balance"];
        }
    }
    if (![mainObjectContext save:&error]) {
        NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
        return 0;
    }
    return 1;
}


-(NSInteger)deleteRecordinDb: (NSNumber *) transactionId
{
   NSEntityDescription *tempExpense=[NSEntityDescription entityForName:@"Expense" inManagedObjectContext:mainObjectContext];
    NSFetchRequest *fetch=[[NSFetchRequest alloc] init];
    [fetch setEntity:tempExpense];
    NSPredicate *predicate=[NSPredicate predicateWithFormat:@"transactionId == %@", transactionId];
    [fetch setPredicate:predicate];
    NSError *fetchError;
    NSError *error;
    NSArray *fetchedProducts=[mainObjectContext executeFetchRequest:fetch error:&fetchError];
    for (NSManagedObject *product in fetchedProducts)
    {
        [mainObjectContext deleteObject:product];
    }
    [mainObjectContext save:&error];
    return 1;
}


-(NSInteger)addOrUpdateTaskinDb: (NSDictionary *) taskDict
{
    if (taskDict == nil)
    {
        return 0;
    }
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription
                                   entityForName:@"TaskList" inManagedObjectContext:mainObjectContext];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(taskListName == %@ AND taskid == %@)",[taskDict objectForKey:@"taskListName"],[taskDict objectForKey:@"taskid"]];
    
    [fetchRequest setPredicate: predicate];
    [fetchRequest setEntity:entity];
    NSError *error;
    NSArray *fetchedObjects = [mainObjectContext executeFetchRequest:fetchRequest error:&error];

    if(fetchedObjects.count == 0 )                                      // Adding a record
    {
        NSManagedObject *userDetails = [NSEntityDescription
                                        insertNewObjectForEntityForName:@"TaskList"
                                        inManagedObjectContext:mainObjectContext];
        [userDetails setValue:[taskDict objectForKey:@"taskListName"] forKey:@"taskListName"];
        [userDetails setValue:[taskDict objectForKey:@"taskName"] forKey:@"taskName"];
        [userDetails setValue:[taskDict objectForKey:@"taskPriority"] forKey:@"taskPriority"];
        [userDetails setValue:[taskDict objectForKey:@"taskDesc"] forKey:@"taskDesc"];
        [userDetails setValue:[taskDict objectForKey:@"taskStatus"] forKey:@"taskStatus"];
        [userDetails setValue:[taskDict objectForKey:@"taskStartTime"] forKey:@"taskStartTime"];
        [userDetails setValue:[taskDict objectForKey:@"taskEndtime"] forKey:@"taskEndtime"];
        [userDetails setValue:[taskDict objectForKey:@"taskAlarmstatus"] forKey:@"taskAlarmstatus"];
        [userDetails setValue:[taskDict objectForKey:@"isTaskListActive"] forKey:@"isTaskListActive"];
        NSTimeInterval milisecondedDate = ([[NSDate date] timeIntervalSince1970] * 1000);
        [userDetails setValue:[NSNumber numberWithDouble:milisecondedDate] forKey:@"taskid"];
    }
    else     //updating a record
    {
        //[[fetchedObjects objectAtIndex:0] setValue:[taskDict objectForKey:@"taskListName"] forKey:@"taskListName"];
        [[fetchedObjects objectAtIndex:0] setValue:[taskDict objectForKey:@"taskName"] forKey:@"taskName"];
        [[fetchedObjects objectAtIndex:0] setValue:[taskDict objectForKey:@"taskPriority"] forKey:@"taskPriority"];
        [[fetchedObjects objectAtIndex:0] setValue:[taskDict objectForKey:@"taskDesc"] forKey:@"taskDesc"];
        [[fetchedObjects objectAtIndex:0] setValue:[taskDict objectForKey:@"taskStatus"] forKey:@"taskStatus"];
        [[fetchedObjects objectAtIndex:0] setValue:[taskDict objectForKey:@"taskStartTime"] forKey:@"taskStartTime"];
        [[fetchedObjects objectAtIndex:0] setValue:[taskDict objectForKey:@"taskEndtime"] forKey:@"taskEndtime"];
        [[fetchedObjects objectAtIndex:0] setValue:[taskDict objectForKey:@"taskAlarmstatus"] forKey:@"taskAlarmstatus"];
        [[fetchedObjects objectAtIndex:0] setValue:[taskDict objectForKey:@"isTaskListActive"] forKey:@"isTaskListActive"];
        
    }
    if (![mainObjectContext save:&error]) {
        NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
        return 0;
    }
    return 1;
}


-(NSInteger)deleteTaskfromDb: (NSNumber *) taskId
{
    NSEntityDescription *tempTask=[NSEntityDescription entityForName:@"TaskList" inManagedObjectContext:mainObjectContext];
    NSFetchRequest *fetch=[[NSFetchRequest alloc] init];
    [fetch setEntity:tempTask];
    NSPredicate *predicate=[NSPredicate predicateWithFormat:@"taskid == %@", taskId];
    [fetch setPredicate:predicate];
    NSError *fetchError;
    NSError *error;
    NSArray *fetchedProducts=[mainObjectContext executeFetchRequest:fetch error:&fetchError];
    for (NSManagedObject *product in fetchedProducts)
    {
        [mainObjectContext deleteObject:product];
    }
    [mainObjectContext save:&error];
    return 1;
}


-(NSInteger)deleteTaskListfromDb: (NSString *) taskListName
{
    NSEntityDescription *tempTask=[NSEntityDescription entityForName:@"TaskList" inManagedObjectContext:mainObjectContext];
    NSFetchRequest *fetch=[[NSFetchRequest alloc] init];
    [fetch setEntity:tempTask];
    NSPredicate *predicate=[NSPredicate predicateWithFormat:@"taskListName == %@", taskListName];
    [fetch setPredicate:predicate];
    NSError *fetchError;
    NSError *error;
    NSArray *fetchedProducts=[mainObjectContext executeFetchRequest:fetch error:&fetchError];
    for (NSManagedObject *product in fetchedProducts)
    {
        [mainObjectContext deleteObject:product];
    }
    [mainObjectContext save:&error];
    return 1;
}


@end
