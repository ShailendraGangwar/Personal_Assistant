//
//  PAAppDelegate.h
//  Personal Assistant
//
//  Created by Aricent Group on 15/10/13.
//  Copyright (c) 2013 Aricent Group. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PAAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;
- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end
