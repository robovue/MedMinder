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
    if ([[segue identifier] isEqualToString:@"prescription"]) {
        UINavigationController *navigationController = [segue destinationViewController];
        SCUMasterViewController *destVC = (SCUMasterViewController *)navigationController.topViewController;
        NSManagedObjectContext *context = appDelegate.managedObjectContext;
        destVC.managedObjectContext = context;
    }
    if ([[segue identifier] isEqualToString:@"schedule"]) {
        UINavigationController *navigationController = [segue destinationViewController];
        SCUSchedMasterViewController *destVC = (SCUSchedMasterViewController *)navigationController.topViewController;
        NSManagedObjectContext *context = appDelegate.managedObjectContext;
        destVC.managedObjectContext = context;
        destVC.forSelection=YES;
    }
}

@end
