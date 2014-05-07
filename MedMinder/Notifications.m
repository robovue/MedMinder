//
//  Notifications.m
//  MedMinder
//
//  Created by Leo Chan on 3/1/14.
//  Copyright (c) 2014 Leo Chan. All rights reserved.
//

#import "Notifications.h"
#import "Schedule.h"
#import "SCUAppDelegate.h"
SCUAppDelegate *appDelegate;

@implementation Notifications
+(void) setUpLocalNotifications

{
    UIApplication *app = [UIApplication sharedApplication];
    appDelegate = app.delegate;
    
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
    NSError *error = nil;
    
    NSArray *arrayOfSchedules = [appDelegate.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
    for (Schedule *schedule in arrayOfSchedules) {
        NSCalendar *calendar = [NSCalendar currentCalendar];
        
        unsigned unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit |  NSDayCalendarUnit | NSSecondCalendarUnit;
        NSDateComponents *nowComponents = [calendar components:unitFlags fromDate: [NSDate date]];
        
        unitFlags = NSHourCalendarUnit | NSMinuteCalendarUnit;
        NSDateComponents *refComponents = [calendar components:unitFlags fromDate:schedule.time];
        
        [nowComponents setDay:nowComponents.day];
        [nowComponents setHour:refComponents.hour];
        [nowComponents setMinute:refComponents.minute];
        [nowComponents setSecond:0];
        
        NSDate *notificationDate = [calendar dateFromComponents:nowComponents];
        
        UILocalNotification *localNotif = [[UILocalNotification alloc] init];
        if (localNotif == nil)
            return;
        localNotif.fireDate = notificationDate;
        localNotif.repeatInterval= NSDayCalendarUnit;
        localNotif.timeZone = [NSTimeZone defaultTimeZone];
        localNotif.alertBody = [NSString stringWithFormat:@"Please take your meds: %@",schedule.timeOfDay];
        localNotif.alertAction = NSLocalizedString(@"View Details", nil);
        localNotif.soundName = UILocalNotificationDefaultSoundName;
        localNotif.applicationIconBadgeNumber = 0;
        [[UIApplication sharedApplication] scheduleLocalNotification:localNotif];
    }
}
@end
