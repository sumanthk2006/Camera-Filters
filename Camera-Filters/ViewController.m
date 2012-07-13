//
//  ViewController.m
//  Camera-Filters
//
//  Created by A1Brains Infotech on 11/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"
#import <AssetsLibrary/AssetsLibrary.h>
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

}
-(IBAction)takePhoto:(id)sender{
    
    imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.view.frame = self.view.frame;
    imagePickerController.delegate = self;
    imagePickerController.sourceType =  UIImagePickerControllerSourceTypeCamera;
    imagePickerController.showsCameraControls = YES;
    imagePickerController.navigationBarHidden = NO;
    imagePickerController.toolbarHidden = YES;
    
    //    [self.view addSubview:imagePickerController.view];
    [self.navigationController presentModalViewController:imagePickerController animated:YES];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:NO];
    self.navigationController.navigationBarHidden = YES;
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:NO];
    self.navigationController.navigationBarHidden = NO;
}
- (void)imagePickerController:(UIImagePickerController *)picker 
        didFinishPickingImage:(UIImage *)image
                  editingInfo:(NSDictionary *)editingInfo
{
    // Dismiss the image selection, hide the picker and
    //show the image view with the picked image
    [picker dismissModalViewControllerAnimated:YES];
    imagePickerController.view.hidden = YES;
    ImageFilter *imagefilter;
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        imagefilter =  [[ImageFilter alloc] initWithNibName:@"ImageFilter" bundle:nil];
    }
    else {
        imagefilter =  [[ImageFilter alloc] initWithNibName:@"ImageFilter_iPad" bundle:nil];
    }
    [imagefilter imageFilter:image];
    [self.navigationController pushViewController:imagefilter animated:YES];
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    // Dismiss the image selection and close the program
    [imagePickerController dismissModalViewControllerAnimated:YES];
}
- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
