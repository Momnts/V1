//
//  testFaceController.h
//  ahMyFace_v1
//
//  Created by Naren Sathiya on 3/31/15.
//  Copyright (c) 2015 Naren Sathiya. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "serverCalls.h"
#import "showFacesController.h"

@interface testFaceController : UIViewController <serverCallsDelegate>

@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) UIImage *captured_image;
@property (strong, nonatomic) IBOutlet UIButton *faceButton;
@property (strong, nonatomic) NSMutableArray *faces;
@property (strong, nonatomic) NSMutableArray *names;
- (IBAction)showFaces:(id)sender;

-(void) loadImage;
-(void) detectFaces;
-(void) recognizeFaces;

@end
