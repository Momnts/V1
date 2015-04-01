//
//  serverCalls.h
//  ahMyFace_v1
//
//  Created by Naren Sathiya on 3/25/15.
//  Copyright (c) 2015 Naren Sathiya. All rights reserved.
//

#import <Foundation/Foundation.h>
@class serverCalls;

@protocol serverCallsDelegate


@optional
-(void) client:(serverCalls *) serverCalls sendWithData:(NSDictionary*) responseObject;
-(void) client:(serverCalls *) serverCalls sendWithNames:(NSMutableArray*) names;

@end


@interface serverCalls : NSObject

@property (nonatomic, assign)id delegate;
@property(strong, nonatomic) NSString *zipCode;

- (void) recognize_image: (NSMutableArray*)image file_name:(NSString*)name;
- (void) train_image: (UIImage*)image file_name:(NSString*)name person_id:(NSString*)pid;
- (void) rebuild_album;

@end
