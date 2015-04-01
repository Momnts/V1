//
//  ViewController.h
//  EmailPhotos
//
//  Created by Kasean Herrera on 3/26/15.
//  Copyright (c) 2015 Kasean Herrera. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MFMailComposeViewController.h>
@interface emailController : UIViewController <MFMailComposeViewControllerDelegate>
- (IBAction)emailButton:(id)sender;

@property (strong, nonatomic) NSMutableArray *faces;
@property (strong, nonatomic) NSMutableArray *names;

@end

