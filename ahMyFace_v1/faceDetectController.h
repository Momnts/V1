//
//  faceDetectController.h
//  ahMyFace_v1
//
//  Created by Naren Sathiya on 3/21/15.
//  Copyright (c) 2015 Naren Sathiya. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "showFacesController.h"
#import "serverCalls.h"
#import "HomeController.h"

@interface faceDetectController : UIViewController <serverCallsDelegate, UIAlertViewDelegate>

@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property UIImage *captured_image;
@property (strong, nonatomic) NSMutableArray *faceArray;
@property (strong, nonatomic) IBOutlet UIButton *facesButton;
@property (strong, nonatomic) IBOutlet UITextField *labelTextField;

- (void) loadImage;
- (void) faceDetector;
- (void) markFaces:(UIImage *)facePicture;
- (UIImage *)imageByCroppingImage:(UIImage *)image withSize:(CGRect)bounds;
- (IBAction)showFaces:(id)sender;

@end
