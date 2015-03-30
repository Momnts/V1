//
//  showFacesController.h
//  ahMyFace_v1
//
//  Created by Naren Sathiya on 3/23/15.
//  Copyright (c) 2015 Naren Sathiya. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "faceCell.h"
#import "serverCalls.h"

@interface showFacesController : UITableViewController <serverCallsDelegate>

@property (strong, nonatomic) NSMutableArray *faces;

@end
