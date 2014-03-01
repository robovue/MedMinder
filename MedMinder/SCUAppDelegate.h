//
//  SCUAppDelegate.h
//  MedMinder
//
//  Created by Leo Chan on 2/28/14.
//  Copyright (c) 2014 Leo Chan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SCUAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end
