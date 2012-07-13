//
//  ViewController.h
//  Camera-Filters
//
//  Created by A1Brains Infotech on 11/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GPUImage.h"
#import "ImageFilter.h"
@interface ViewController : UIViewController<UIImagePickerControllerDelegate,UINavigationControllerDelegate>{
    UIImagePickerController* imagePickerController;
}
-(IBAction)takePhoto:(id)sender;
- (void)imagePickerController:(UIImagePickerController *)picker
        didFinishPickingImage:(UIImage *)image
                  editingInfo:(NSDictionary *)editingInfo;
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker;

@end
