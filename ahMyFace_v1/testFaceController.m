//
//  testFaceController.m
//  ahMyFace_v1
//
//  Created by Naren Sathiya on 3/31/15.
//  Copyright (c) 2015 Naren Sathiya. All rights reserved.
//

#import "testFaceController.h"

@interface testFaceController ()

@end

@implementation testFaceController

@synthesize faces;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // Add button
    self.view.backgroundColor = [UIColor lightGrayColor];
    self.faceButton.layer.cornerRadius = 2;
    self.faceButton.layer.borderWidth = 2;
    self.faceButton.layer.borderColor = [UIColor redColor].CGColor;
    
    // For API Auth. Find a better place to put this.
    [KairosSDK initWithAppId:@"1bf095ad" appKey:@"64b5e29cf8484c0d25d61467b4da7558"];
    
    // Load taken image
    [self loadImage];
    
    // Identidy faces
    [self detectFaces];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)showFaces:(id)sender {
    //[self performSegueWithIdentifier:@"seperateFaces" sender:nil];
}

- (void) loadImage
{
    //self.captured_image = [UIImage imageNamed:@"jimStark.png"];
    
    self.imageView = [[UIImageView alloc] init];
    self.imageView.frame = CGRectMake(0, 0, 300, 400);
    //self.imageView.contentMode = UIViewContentModeCenter;
    [self.imageView setCenter:CGPointMake(self.view.bounds.size.width/2, (self.view.bounds.size.height/2)-30)];                //setPosition:CGPointMake(CGRectGetMidX(layerRect), CGRectGetMidY(layerRect))
    self.imageView.image = self.captured_image;
    [self.view addSubview:self.imageView];
}

- (void) detectFaces
{
    NSLog(@"size is %f, %f", self.captured_image.size.width, self.captured_image.size.height);
    
    [self performSelectorInBackground:@selector(markFaces:) withObject:self.captured_image];
    
    [self.view addSubview:self.imageView];
    
    
    
    // flip image on y-axis to match coordinate system used by core image
    //[self.imageView setTransform:CGAffineTransformMakeScale(1, -1)];
    
    // flip the entire window to make everything right side up
    //[self.view setTransform:CGAffineTransformMakeScale(1, -1)];
    
}

- (UIImage *)imageByCroppingImage:(UIImage *)image withSize:(CGRect)bounds
{
    //UIImage *cropped_rotated = [UIImage imageWithCGImage:image.CGImage
                                                   //scale:1.0
                                             //orientation:UIImageOrientationRight];
    CGRect cropRect = CGRectMake(bounds.origin.y, image.size.width-bounds.origin.x, bounds.size.height, bounds.size.width);
    CGImageRef imageRef = CGImageCreateWithImageInRect([image CGImage], cropRect);
    
    UIImage *cropped = [UIImage imageWithCGImage:imageRef];
    CGImageRelease(imageRef);
   
    
    return cropped;
}

-(void)markFaces:(UIImage *)facePicture
{
    int exifOrientation;
    NSLog(@"face orientation is %ld", facePicture.imageOrientation);
    switch (facePicture.imageOrientation) {
        case UIImageOrientationUp:
            exifOrientation = 1;
            break;
        case UIImageOrientationDown:
            exifOrientation = 3;
            break;
        case UIImageOrientationLeft:
            exifOrientation = 8;
            break;
        case UIImageOrientationRight:
            exifOrientation = 6;
            break;
        case UIImageOrientationUpMirrored:
            exifOrientation = 2;
            break;
        case UIImageOrientationDownMirrored:
            exifOrientation = 4;
            break;
        case UIImageOrientationLeftMirrored:
            exifOrientation = 5;
            break;
        case UIImageOrientationRightMirrored:
            exifOrientation = 7;
            break;
        default:
            break;
    }
    
    // draw a CI image with the previously loaded face detection picture
    CIImage* image = [CIImage imageWithCGImage:facePicture.CGImage];
    
    NSLog(@"Inside markFaces size is %f, %f",self.imageView.image.size.width, self.imageView.image.size.height);
    
    CIDetector* detector = [CIDetector detectorOfType:CIDetectorTypeFace
                                              context:nil options:[NSDictionary dictionaryWithObject:CIDetectorAccuracyHigh forKey:CIDetectorAccuracy]];
    
    NSArray* features = [detector featuresInImage:image
                                          options:@{CIDetectorImageOrientation:[NSNumber numberWithInt:exifOrientation]}];
    
    CGFloat imgViewCoeff_width = self.imageView.bounds.size.width/self.captured_image.size.width;
    CGFloat imgViewCoeff_height = self.imageView.bounds.size.height/self.captured_image.size.height;
    NSLog(@"number of faces detected is %lu", (unsigned long)features.count);
    
    self.faces = [[NSMutableArray alloc] init];
    self.names = [[NSMutableArray alloc] init];
    
    for(CIFaceFeature* faceFeature in features)
    {
        // create a UIView using the bounds of the face
        //CGRect face_bounds = CGRectMake(faceFeature.bounds.origin.x*imgViewCoeff_width, faceFeature.bounds.origin.y*imgViewCoeff_height, faceFeature.bounds.size.width*imgViewCoeff_width, faceFeature.bounds.size.height*imgViewCoeff_height);
        CGRect face_bounds = CGRectMake(faceFeature.bounds.origin.y*imgViewCoeff_height, faceFeature.bounds.origin.x*imgViewCoeff_width, faceFeature.bounds.size.height*imgViewCoeff_height, faceFeature.bounds.size.width*imgViewCoeff_width);
        UIView* faceView = [[UIView alloc] initWithFrame:face_bounds];
        
        // add a border around the newly created UIView
        faceView.layer.borderWidth = 1;
        faceView.layer.borderColor = [[UIColor redColor] CGColor];
        
        // add the new view to create a box around the face
        [self.imageView addSubview:faceView];
        
        CGRect biggerRectangle = CGRectInset(faceFeature.bounds, -10.0f, -10.0f);
        CGImageRef imageRef = CGImageCreateWithImageInRect([facePicture CGImage], biggerRectangle);
        
        CIContext *context = [CIContext contextWithOptions:nil];
        UIImage *returnImage =
        [UIImage imageWithCGImage:[context createCGImage:[CIImage imageWithCGImage:facePicture.CGImage] fromRect:biggerRectangle]
                            scale:1.0
                      orientation:UIImageOrientationRight];
        //[self.faces addObject:[UIImage imageWithCGImage:returnImage]];
        [self.faces addObject:returnImage];
    }
    
    [self recognizeFaces];
}


- (void) recognizeFaces
{
    serverCalls *client = [[serverCalls alloc] init];
    client.delegate = self;
    NSLog(@"in recognize faces count is %lu", (unsigned long)self.faces.count);
    
    if (self.faces == nil || [self.faces count] == 0) {
        NSLog(@"array is empty");
        
    }
    
    [client recognize_image:self.faces file_name:@"test.jpg"];
}

-(void)client:(serverCalls *)serverCalls sendWithNames:(NSMutableArray *)names {
    self.names = names;
    [self performSegueWithIdentifier:@"seperateFaces" sender:nil];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([[segue identifier] isEqualToString:@"seperateFaces"])
    {
        showFacesController *HC = [segue destinationViewController];
        [HC setFaces:self.faces];
        [HC setNames:self.names];
        [HC setCaptured_image:self.captured_image];
    }
}


@end
