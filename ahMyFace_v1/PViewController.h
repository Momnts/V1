//
//  PViewController.h
//  ahMyFace_v1
//
//  Created by Naren Sathiya on 3/21/15.
//  Copyright (c) 2015 Naren Sathiya. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "faceDetectController.h"

@interface PViewController : UIViewController <AVCaptureVideoDataOutputSampleBufferDelegate> {
    AVCaptureSession *_captureSession;
    UIImageView *_imageView;
}

@property (nonatomic, retain) AVCaptureSession *captureSession;
@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property (nonatomic, strong) UIImage *current_image;

@property (strong, nonatomic) IBOutlet UIButton *captureButton;
- (IBAction)capturePic:(id)sender;
- (void)initCapture;

@end
