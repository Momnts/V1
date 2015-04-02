//
//  showFacesController.h
//  ahMyFace_v1
//
//  Created by Naren Sathiya on 3/23/15.
//  Copyright (c) 2015 Naren Sathiya. All rights reserved.
//
#import <MessageUI/MessageUI.h>
#import <UIKit/UIKit.h>
#import "faceCell.h"
#import "serverCalls.h"
#import "emailController.h"

@interface showFacesController : UITableViewController <serverCallsDelegate,MFMessageComposeViewControllerDelegate>

@property (strong, nonatomic) NSMutableArray *faces;
@property (strong, nonatomic) NSMutableArray *names;



@end
