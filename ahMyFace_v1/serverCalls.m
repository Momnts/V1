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
    
    
    //[image release];
    
    NSURL *baseURL = [NSURL URLWithString:BaseURLString];
    
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:baseURL];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    //params[@"X-Mashape-Key"] = XMashapeKey;
    params[@"album"] = Album;
    params[@"albumkey"] = AlbumKey;
    params[@"entryid"] = pid;
    
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:XMashapeKey forHTTPHeaderField:@"X-Mashape-Key"];
    
    
    // Create path.
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    //NSString *filePath = [[paths objectAtIndex:0] stringByAppendingPathComponent:@"image.jpg"];
    NSString *filePath = [[paths objectAtIndex:0] stringByAppendingPathComponent:@"image.jpg"];
    //NSURL *fileURL = [NSURL fileURLWithPath:filePath];
    [UIImageJPEGRepresentation(image,0.7) writeToFile:filePath atomically:YES];
    /*
    NSURL *fileURL = [NSURL URLWithString:filePath];
     NSLog(@"in train image. found place for picture");
    // Save image.
     NSLog(@"in train image. made picture");
    params[@"urls"] = [fileURL absoluteString];
    NSLog(@"the file path is %@", filePath);
     NSLog(@"in train image. saved picture");
    [manager POST:@"album_train" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
          NSLog(@"success!");
         NSLog(@"JSON: %@", responseObject);
         NSDictionary *json = (NSDictionary *)responseObject;
         //NSLog(@"after json dictionary before arry");
         //NSArray *data = [json objectForKey:@"dealDetail"];
         //[delegate client:self sendWithData:data to:@"getDealDetail"];
         
     } failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         NSLog(@"Error: %@", error);
     }];
    */
    /*
    //NSData *imageData = UIImageJPEGRepresentation(image, 0.3);
    NSLog(@"in train image. made picture");
    AFHTTPRequestOperation *op = [manager POST:@"album_train" parameters:params
                     constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
                         NSError *error;
                         [formData appendPartWithFileURL:fileURL
                                                    name:@"urls"
                                                fileName:filePath
                                                mimeType:@"image/jpeg"
                                                   error:&error];
                         
                     } success:^(AFHTTPRequestOperation *operation, id responseObject) {
                         NSLog(@"success!");
                         NSDictionary *json = (NSDictionary *)responseObject;
                         //NSDictionary *data = [json objectForKey:@"image_count"];
                         NSLog(@"JSON: %@", json);
                         [delegate client:self sendWithData:json];// to:@"getCategoryDeals"];
                     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                         NSLog(@"Error: %@ ***** %@", operation.responseString, error);
                     }];
    NSLog(@"in train image. made op. about to start");
    [op start];
    
    
    NSDictionary *headers = @{@"X-Mashape-Key": XMashapeKey};
    NSDictionary *parameters = params;
  /*
  @{@"album": @"CELEBS", @"albumkey": @"b1ccb6caa8cefb7347d0cfb65146d5e3f84608f6ee55b1c90d37ed4ecca9b273", @"entryid": @"TigerWoods", @"urls": @"http://www.lambdal.com/tiger.jpg"};
   */
    
    NSString *filePathat = [@"@" stringByAppendingString:filePath];
    NSURL *urlfiles = [NSURL URLWithString:filePathat];
    NSArray *paths_load = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                         NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths_load objectAtIndex:0];
    NSString* path = [documentsDirectory stringByAppendingPathComponent:
                      @"image.jpg"];
    UIImage* image_loaded = [UIImage imageWithContentsOfFile:path];
    
    
    CGImageRef cgref = [image_loaded CGImage];
    CIImage *cim = [image_loaded CIImage];
    
    if (cim == nil && cgref == NULL)
    {
        NSLog(@"no underlying data");
    }
    
    NSLog(@"the file path is %@", [urlfiles absoluteURL]);
    NSDictionary *headers = @{@"X-Mashape-Key": XMashapeKey};
    NSDictionary *parameters = @{@"album": @"TEST5", @"albumkey": @"af373ab0fbe1ec28578a56c025821f7cdef595bc0403c48d1075de6bb4af3470", @"entryid": @"naren", @"files": urlfiles};
    UNIUrlConnection *asyncConnection = [[UNIRest post:^(UNISimpleRequest *request) {
        [request setUrl:@"https://lambda-face-recognition.p.mashape.com/album_train"];
        [request setHeaders:headers];
        [request setParameters:parameters];
    }] asJsonAsync:^(UNIHTTPJsonResponse *response, NSError *error) {
        NSInteger code = response.code;
        NSDictionary *responseHeaders = response.headers;
        UNIJsonNode *body = response.body;
        NSData *rawBody = response.rawBody;
        NSLog(@"discionaty is %@", body.JSONObject);
    }];
   

}

- (void) rebuild_album
{
    
}

@end

