//
//  serverCalls.m
//  ahMyFace_v1
//
//  Created by Naren Sathiya on 3/25/15.
//  Copyright (c) 2015 Naren Sathiya. All rights reserved.
//

#import "serverCalls.h"

static NSString* const BaseURLString = @"https://lambda-face-recognition.p.mashape.com/";
static NSString* const XMashapeKey = @"0X1zARJjhmmshXbHV6KvwsU4M8sPp1xLNiVjsn8MyiiQLStWPG";
static NSString* const Album = @"TEST5";
static NSString* const AlbumKey = @"af373ab0fbe1ec28578a56c025821f7cdef595bc0403c48d1075de6bb4af3470";

@implementation serverCalls

@synthesize delegate;


- (void) recognize_image: (UIImage*)image file_name: (NSString*) name
{
    NSURL *baseURL = [NSURL URLWithString:BaseURLString];
    
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:baseURL];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    //params[@"X-Mashape-Key"] = XMashapeKey;
    params[@"album"] = Album;
    params[@"albumkey"] = AlbumKey;
    
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:XMashapeKey forHTTPHeaderField:@"X-Mashape-Key"];

    
    NSData *imageData = UIImageJPEGRepresentation(image, 0.5);
    
    AFHTTPRequestOperation *op = [manager POST:@"recognize" parameters:params
                     constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
                         [formData appendPartWithFileData:imageData name:@"files" fileName:name
                                                 mimeType:@"image/jpeg"];
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
        NSDictionary *json = (NSDictionary *)responseObject;
        NSArray *data = [json objectForKey:@"photos"];
        [delegate client:self sendWithData:data];// to:@"getCategoryDeals"];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@ ***** %@", operation.responseString, error);
    }];
    [op start];
    
}

- (void) train_image:(UIImage*)image file_name:(NSString*)name person_id:(NSString*)pid
{
    NSURL *baseURL = [NSURL URLWithString:BaseURLString];
    
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:baseURL];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    //params[@"X-Mashape-Key"] = XMashapeKey;
    params[@"album"] = Album;
    params[@"albumkey"] = AlbumKey;
    params[@"entryid"] = pid;
    
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:XMashapeKey forHTTPHeaderField:@"X-Mashape-Key"];
    
    
    NSData *imageData = UIImageJPEGRepresentation(image, 0.5);
    
    AFHTTPRequestOperation *op = [manager POST:@"recognize" parameters:params
                     constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
                         [formData appendPartWithFileData:imageData name:@"files" fileName:name
                                                 mimeType:@"image/jpeg"];
                     } success:^(AFHTTPRequestOperation *operation, id responseObject) {
                         NSLog(@"JSON: %@", responseObject);
                         NSDictionary *json = (NSDictionary *)responseObject;
                         NSDictionary *data = [json objectForKey:@"photos"];
                         [delegate client:self sendWithData:data];// to:@"getCategoryDeals"];
                     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                         NSLog(@"Error: %@ ***** %@", operation.responseString, error);
                     }];
    [op start];

}

- (void) rebuild_album
{
    
}

@end

