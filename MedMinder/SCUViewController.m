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
#import "Notifications.h"

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

//-(void) setUpLocalNotifications
//
//{
//    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
//    // Edit the entity name as appropriate.
//    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Schedule" inManagedObjectContext:appDelegate.managedObjectContext];
//    [fetchRequest setEntity:entity];
//    
//    // Set the batch size to a suitable number.
//    [fetchRequest setFetchBatchSize:10];
//    
//    // Edit the sort key as appropriate.
//    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"sortBy" ascending:YES];
//    NSArray *sortDescriptors = @[sortDescriptor];
//    
//    [fetchRequest setSortDescriptors:sortDescriptors];
//    NSError *error = nil;
//    
//    NSArray *arrayOfSchedules = [appDelegate.managedObjectContext executeFetchRequest:fetchRequest error:&error];
//    
//    [[UIApplication sharedApplication] cancelAllLocalNotifications];
//    for (int i = 0; i<2; i++) {
//        for (Schedule *schedule in arrayOfSchedules) {
//            NSCalendar *calendar = [NSCalendar currentCalendar];
//            
//            unsigned unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit |  NSDayCalendarUnit;
//            NSDateComponents *nowComponents = [calendar components:unitFlags fromDate: [NSDate date]];
//            
//            unitFlags = NSHourCalendarUnit | NSMinuteCalendarUnit;
//            NSDateComponents *refComponents = [calendar components:unitFlags fromDate:schedule.time];
//            
//            [nowComponents setDay:nowComponents.day+i];
//            [nowComponents setHour:refComponents.hour];
//            [nowComponents setMinute:refComponents.minute];
//            
//            NSDate *notificationDate = [calendar dateFromComponents:nowComponents];
//            
//            if ([notificationDate compare:[NSDate date]] ==NSOrderedDescending) {
//                UILocalNotification *localNotif = [[UILocalNotification alloc] init];
//                if (localNotif == nil)
//                    return;
//                localNotif.fireDate = notificationDate;
//                localNotif.timeZone = [NSTimeZone defaultTimeZone];
//                localNotif.alertBody = @"Please take your meds";
//                
//                localNotif.alertAction = NSLocalizedString(@"View Details", nil);
//                localNotif.soundName = UILocalNotificationDefaultSoundName;
//                localNotif.applicationIconBadgeNumber = 0;
//                //    NSDictionary *infoDict = [NSDictionary dictionaryWithObject:item.eventName
//                //                                                         forKey:ToDoItemKey];
//                //    localNotif.userInfo = infoDict;
//                [[UIApplication sharedApplication] scheduleLocalNotification:localNotif];
//            }
//        }
//    }
//}

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
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    // Edit the entity name as appropriate.
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Schedule" inManagedObjectContext:appDelegate.managedObjectContext];
    [fetchRequest setEntity:entity];
    
    // Set the batch size to a suitable number.
    [fetchRequest setFetchBatchSize:10];
    
    // Edit the sort key as appropriate.
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"time" ascending:YES];
    NSArray *sortDescriptors = @[sortDescriptor];
    
    [fetchRequest setSortDescriptors:sortDescriptors];
    Schedule *currentSchedule;
    NSError *error = nil;

    NSArray *arrayOfSchedules = [appDelegate.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    if (arrayOfSchedules.count>0) {
        for (Schedule *schedule in arrayOfSchedules) {
            NSCalendar *calendar = [NSCalendar currentCalendar];
            NSDate *compareToDate = [[NSDate date] dateByAddingTimeInterval:+3600]; // subtract two hours from now
            
            unsigned unitFlags = NSHourCalendarUnit | NSMinuteCalendarUnit;

            NSDateComponents *nowComponents = [calendar components:unitFlags fromDate:compareToDate];
            NSDate *nowDate = [calendar dateFromComponents:nowComponents];
            NSDateComponents *refComponents = [calendar components:unitFlags fromDate:schedule.time];
            NSDate *refDate = [calendar dateFromComponents:refComponents];


            NSComparisonResult result = [refDate compare:nowDate];
            if (result == NSOrderedAscending) {
                currentSchedule = schedule;
            }
        }
        
        [Notifications setUpLocalNotifications];
        
        return currentSchedule;
    }
    else
        return nil;
}

@end
