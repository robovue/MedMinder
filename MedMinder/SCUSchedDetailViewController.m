//
//  SCUSchedDetailViewController.m
//  MedMinder
//
//  Created by Leo Chan on 2/28/14.
//  Copyright (c) 2014 Leo Chan. All rights reserved.
//

#import "SCUSchedDetailViewController.h"
#import "Prescription.h"
#import "Schedule.h"
#import "Notifications.h"

@interface SCUSchedDetailViewController ()
- (void)configureView;
@property (weak, nonatomic) IBOutlet UITextField *timeOfDay;
@property (weak, nonatomic) IBOutlet UITextField *sortBy;
@property (weak, nonatomic) IBOutlet UIDatePicker *timePicker;

@end

@implementation SCUSchedDetailViewController

#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem
{
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        
        // Update the view.
        [self configureView];
    }
}
- (IBAction)dismissKeyboard:(id)sender {
    [sender resignFirstResponder];
}
- (IBAction)dismissKB:(UIControl *)sender {
    [self.timeOfDay resignFirstResponder];
    [self.sortBy resignFirstResponder];
}
- (IBAction)save:(UIBarButtonItem *)sender {
    Schedule *schedule = (Schedule*)self.detailItem;
    schedule.timeOfDay = self.timeOfDay.text;
    schedule.sortBy=self.sortBy.text;
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    unsigned unitFlags = NSHourCalendarUnit | NSMinuteCalendarUnit;
    NSDateComponents *refComponents = [calendar components:unitFlags fromDate:self.timePicker.date];
    
    schedule.time=[calendar dateFromComponents:refComponents];

    // Save the context.
    NSError *error = nil;
    NSManagedObjectContext *context = schedule.managedObjectContext;
    if (![context save:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    [Notifications setUpLocalNotifications];

    [self.navigationController popViewControllerAnimated:NO];
}

- (void)configureView
{
    // Update the user interface for the detail item.

    if (self.detailItem) {
        Schedule *schedule = (Schedule*)self.detailItem;
        self.timeOfDay.text=schedule.timeOfDay;
        self.sortBy.text=schedule.sortBy;
        if (schedule.time) {
            self.timePicker.date=schedule.time;
        }
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self configureView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
