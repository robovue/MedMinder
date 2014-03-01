//
//  SCUViewController.m
//  MedMinder
//
//  Created by Leo Chan on 2/28/14.
//  Copyright (c) 2014 Leo Chan. All rights reserved.
//

#import "SCUViewController.h"
#import "SCUMasterViewController.h"
#import "SCUSchedMasterViewController.h"
#import "SCUAppDelegate.h"
#import "Schedule.h"

SCUAppDelegate *appDelegate;

@interface SCUViewController ()

@end

@implementation SCUViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    UIApplication *app = [UIApplication sharedApplication];
    appDelegate = app.delegate;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"takeMeds"]) {
        UINavigationController *navigationController = [segue destinationViewController];
        SCUMasterViewController *destVC = (SCUMasterViewController *)navigationController.topViewController;
        NSManagedObjectContext *context = appDelegate.managedObjectContext;
        destVC.managedObjectContext = context;
        destVC.forTakingMeds=YES;
        destVC.detailItem=[self fetchCurrentSchedule];
        
    }
    
    if ([[segue identifier] isEqualToString:@"prescription"]) {
        UINavigationController *navigationController = [segue destinationViewController];
        SCUMasterViewController *destVC = (SCUMasterViewController *)navigationController.topViewController;
        NSManagedObjectContext *context = appDelegate.managedObjectContext;
        destVC.managedObjectContext = context;
        destVC.forTakingMeds=NO;

    }
    if ([[segue identifier] isEqualToString:@"schedule"]) {
        UINavigationController *navigationController = [segue destinationViewController];
        SCUSchedMasterViewController *destVC = (SCUSchedMasterViewController *)navigationController.topViewController;
        NSManagedObjectContext *context = appDelegate.managedObjectContext;
        destVC.managedObjectContext = context;
        destVC.forSelection=NO;
    }
}

-(Schedule*) fetchCurrentSchedule
{
    // !!! still need to find out current schedule based on current time.
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    // Edit the entity name as appropriate.
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Schedule" inManagedObjectContext:appDelegate.managedObjectContext];
    [fetchRequest setEntity:entity];
    
    // Set the batch size to a suitable number.
    [fetchRequest setFetchBatchSize:10];
    
    // Edit the sort key as appropriate.
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"sortBy" ascending:YES];
    NSArray *sortDescriptors = @[sortDescriptor];
    
    [fetchRequest setSortDescriptors:sortDescriptors];
    
    NSError *error = nil;

    NSArray *arrayOfSchedules = [appDelegate.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    if (arrayOfSchedules.count>0) {
        Schedule *schedule = arrayOfSchedules[0];
        return schedule;
    }
    else
        return nil;
}

@end
