//
//  SCUDetailViewController.m
//  MedMinder
//
//  Created by Leo Chan on 2/28/14.
//  Copyright (c) 2014 Leo Chan. All rights reserved.
//

#import "SCUDetailViewController.h"
#import "SCUSchedMasterViewController.h"
#import "Prescription.h"

@interface SCUDetailViewController ()
- (void)configureView;

@property (weak, nonatomic) IBOutlet UITextField *drugName;
@property (weak, nonatomic) IBOutlet UITextField *commonName;
@property (weak, nonatomic) IBOutlet UITextField *doseStrength;
@property (weak, nonatomic) IBOutlet UITextView *directions;
@property (weak, nonatomic) IBOutlet UITextView *directionTextView;
@property (weak, nonatomic) IBOutlet UITextField *drugNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *commonNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *doseStrengthTextField;
@property (weak, nonatomic) IBOutlet UITextField *imageURLTextField;
@end

@implementation SCUDetailViewController

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
    [self.directionTextView resignFirstResponder];
    [self.drugName resignFirstResponder];
    [self.commonName resignFirstResponder];
    [self.doseStrength resignFirstResponder];
    [self.imageURLTextField resignFirstResponder];
}
- (IBAction)save:(UIBarButtonItem *)sender {
    Prescription *prescription = (Prescription*)self.detailItem;
    prescription.drugName = self.drugName.text;
    prescription.commonName=self.commonName.text;
    prescription.doseStrength=self.doseStrength.text;
    prescription.directions=self.directions.text;
    prescription.imageURL=self.imageURLTextField.text;
    // Save the context.
    NSError *error = nil;
    NSManagedObjectContext *context = prescription.managedObjectContext;
    if (![context save:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    [self.navigationController popViewControllerAnimated:NO];
}

- (void)configureView
{
    // Update the user interface for the detail item.

    if (self.detailItem) {
        Prescription *prescription = (Prescription*)self.detailItem;
        self.drugName.text=prescription.drugName;
        self.commonName.text=prescription.commonName;
        self.doseStrength.text=prescription.doseStrength;
        self.directions.text=prescription.directions;
        self.imageURLTextField.text=prescription.imageURL;
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

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"schedule"]) {
        NSManagedObject *object = self.detailItem;
        SCUSchedMasterViewController *destVC = [segue destinationViewController];
        destVC.forSelection=YES;
        [destVC setDetailItem:object];
    }
}

@end
