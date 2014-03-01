//
//  SCUSchedMasterViewController.h
//  MedMinder
//
//  Created by Leo Chan on 2/28/14.
//  Copyright (c) 2014 Leo Chan. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <CoreData/CoreData.h>

@interface SCUSchedMasterViewController : UITableViewController <NSFetchedResultsControllerDelegate>
@property (strong, nonatomic) id detailItem;
@property BOOL forSelection;
@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@end
