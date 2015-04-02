//
//  MessageConrollerViewController.h
//  ahMyFace_v1
//
//  Created by Kasean Herrera on 4/2/15.
//  Copyright (c) 2015 Naren Sathiya. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>


@interface MessageConrollerViewController : MFMessageComposeViewController
@property (strong, nonatomic) NSMutableArray *faces;
@property (strong, nonatomic) NSMutableArray *names;
@end
