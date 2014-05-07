//
//  SCUImageViewController.m
//  MedMinder
//
//  Created by Leo Chan on 3/1/14.
//  Copyright (c) 2014 Leo Chan. All rights reserved.
//

#import "SCUImageViewController.h"

@interface SCUImageViewController ()
@property (nonatomic) UIImagePickerController *imagePickerController;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIImageView *referenceView;


@end

@implementation SCUImageViewController

// testing github integration again

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view
    NSString *path = [[NSBundle mainBundle] pathForResource:[self.detailItem valueForKey:@"imageURL"] ofType:@"png"];
    UIImage *theImage = [UIImage imageWithContentsOfFile:path];
    self.referenceView.image = theImage;
}
- (IBAction)magnifyBtn:(UIButton *)sender {
        [self showImagePickerForSourceType:UIImagePickerControllerSourceTypeCamera];
}


- (IBAction)takenBtn:(UIButton *)sender {
    
    
    [self.navigationController popViewControllerAnimated:NO];
}

- (void)showImagePickerForSourceType:(UIImagePickerControllerSourceType)sourceType
{
    if (self.imageView.isAnimating)
    {
        [self.imageView stopAnimating];
    }
    
//    if (self.capturedImages.count > 0)
//    {
//        [self.capturedImages removeAllObjects];
//    }
    
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.modalPresentationStyle = UIModalPresentationCurrentContext;
    imagePickerController.sourceType = sourceType;
    CGAffineTransform transform =  CGAffineTransformMakeScale (3,3);
    imagePickerController.cameraViewTransform =transform;
    imagePickerController.allowsEditing=YES;
    imagePickerController.cameraFlashMode=UIImagePickerControllerCameraFlashModeOn;
//    imagePickerController.delegate = self;
    
    if (sourceType == UIImagePickerControllerSourceTypeCamera)
    {
        /*
         The user wants to use the camera interface. Set up our custom overlay view for the camera.
         */
        imagePickerController.showsCameraControls = YES;
        
        /*
         Load the overlay view from the OverlayView nib file. Self is the File's Owner for the nib file, so the overlayView outlet is set to the main view in the nib. Pass that view to the image picker controller to use as its overlay view, and set self's reference to the view to nil.
         */

//        [[NSBundle mainBundle] loadNibNamed:@"OverlayView" owner:self options:nil];
//        self.overlayView.frame = imagePickerController.cameraOverlayView.frame;
//        imagePickerController.cameraOverlayView = self.overlayView;
//        self.overlayView = nil;
    }
    
    self.imagePickerController = imagePickerController;
    [self presentViewController:self.imagePickerController animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - UIImagePickerControllerDelegate

// This method is called when an image has been chosen from the library or taken from the camera.
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
//    UIImage *image = [info valueForKey:UIImagePickerControllerOriginalImage];
    
//    [self.capturedImages addObject:image];
//    
//    if ([self.cameraTimer isValid])
//    {
//        return;
//    }
//    
//    [self finishAndUpdate];
}


- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:NULL];
}
@end
