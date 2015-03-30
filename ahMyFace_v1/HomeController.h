//
//  HomeController.h
//  ahMyFace_v1
//
//  Created by Naren Sathiya on 3/26/15.
//  Copyright (c) 2015 Naren Sathiya. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PViewController.h"
#import "MomntMeController.h"

@interface HomeController : UIViewController
@property (strong, nonatomic) IBOutlet UIButton *signInButton;
@property (strong, nonatomic) IBOutlet UIButton *momntButton;
- (IBAction)signIn:(id)sender;
- (IBAction)momntMe:(id)sender;

@end
