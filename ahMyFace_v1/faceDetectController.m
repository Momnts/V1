//
//  faceDetectController.m
//  ahMyFace_v1
//
//  Created by Naren Sathiya on 3/21/15.
//  Copyright (c) 2015 Naren Sathiya. All rights reserved.
//

#import "faceDetectController.h"

@interface faceDetectController ()

@end

@implementation faceDetectController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.

    //add Button
    self.view.backgroundColor = [UIColor darkGrayColor];
    self.facesButton.layer.cornerRadius = 2;
    self.facesButton.layer.borderWidth = 2;
    self.facesButton.layer.borderColor = [UIColor redColor].CGColor;
    
    //add text field
    CGRect labelTextFieldFrame = CGRectMake(20.0f, 200.0f, 280.0f, 31.0f);
    _labelTextField.placeholder = @"Name";
    _labelTextField.backgroundColor = [UIColor whiteColor];
    _labelTextField.textColor = [UIColor blackColor];
    _labelTextField.font = [UIFont systemFontOfSize:14.0f];
    _labelTextField.borderStyle = UITextBorderStyleRoundedRect;
    _labelTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    _labelTextField.returnKeyType = UIReturnKeyDone;
    _labelTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    _labelTextField.tag = 1;
    _labelTextField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    //_labelTextField.delegate = self;
    //[self.view addSubview:_labelTextField];
    
    self.imageView = nil;
    //Adding new picture
    [self loadImage];
    //Detect face
    //[self faceDetector];
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    NSLog(@"touchesBegan:withEvent:");
    [self.view endEditing:YES];
    [super touchesBegan:touches withEvent:event];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

- (IBAction)showFaces:(id)sender {
    //[self performSegueWithIdentifier:@"showFaces" sender:Nil];
    serverCalls *client = [[serverCalls alloc] init];
    client.delegate = self;
    
    NSLog(@"person name is %@", _labelTextField.text);
    [client train_image:self.captured_image file_name:@"test.jpg" person_id:_labelTextField.text];
    
}

/*

-(void)faceDetector
{
    NSLog(@"size is %f, %f", self.captured_image.size.width, self.captured_image.size.height);
    //for parallel threading
    [self performSelectorInBackground:@selector(markFaces:) withObject:self.captured_image];
    
    [self.view addSubview:self.imageView];
    // flip image on y-axis to match coordinate system used by core image
    //[self.imageView setTransform:CGAffineTransformMakeScale(1, -1)];
    
    // flip the entire window to make everything right side up
    //[self.view setTransform:CGAffineTransformMakeScale(1, -1)];
}

- (UIImage *)imageByCroppingImage:(UIImage *)image withSize:(CGRect)bounds
{
    CGRect cropRect = CGRectMake(bounds.origin.x-50, bounds.origin.y-50, bounds.size.width+100, bounds.size.height+100);
    CGImageRef imageRef = CGImageCreateWithImageInRect([image CGImage], cropRect);
    
    UIImage *cropped = [UIImage imageWithCGImage:imageRef];
    CGImageRelease(imageRef);
    UIImage *cropped_rotated = [UIImage imageWithCGImage:cropped.CGImage
                                                   scale:1.0
                                             orientation:UIImageOrientationRight];
    
    return cropped_rotated;
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
    
    NSLog(@"Inside markFaces size is %f, %f",facePicture.size.width, facePicture.size.height);
    
    // create a face detector - since speed is not an issue we'll use a high accuracy
    // detector
    CIDetector* detector = [CIDetector detectorOfType:CIDetectorTypeFace
                                              context:nil options:[NSDictionary dictionaryWithObject:CIDetectorAccuracyHigh forKey:CIDetectorAccuracy]];
    // create an array containing all the detected faces from the detector
    NSArray* features = [detector featuresInImage:image
                                          options:@{CIDetectorImageOrientation:[NSNumber numberWithInt:exifOrientation]}];
    
    // we'll iterate through every detected face. CIFaceFeature provides us
    // with the width for the entire face, and the coordinates of each eye
    // and the mouth if detected. Also provided are BOOL's for the eye's and
    // mouth so we can check if they already exist.
    CGFloat imgViewCoeff_width = self.imageView.bounds.size.width/self.captured_image.size.width;
    CGFloat imgViewCoeff_height = self.imageView.bounds.size.height/self.captured_image.size.height;
    NSLog(@"number of faces detected is %lu", (unsigned long)features.count);
    
    _faceArray = [[NSMutableArray alloc] init];
    
    for(CIFaceFeature* faceFeature in features)
    {
        // get the width of the face
        CGFloat faceWidth = faceFeature.bounds.size.width;
        NSLog(@"[width, height] is %f, %f", self.imageView.bounds.size.width, self.imageView.bounds.size.height);
         NSLog(@"[width, height, x, y] is %f, %f, %f, %f", faceFeature.bounds.size.width, faceFeature.bounds.size.height, faceFeature.bounds.origin.x, faceFeature.bounds.origin.y);
        
        // create a UIView using the bounds of the face
        //CGRect face_bounds = CGRectMake(faceFeature.bounds.origin.x*imgViewCoeff_width, faceFeature.bounds.origin.y*imgViewCoeff_height, faceFeature.bounds.size.width*imgViewCoeff_width, faceFeature.bounds.size.height*imgViewCoeff_height);
        CGRect face_bounds = CGRectMake(faceFeature.bounds.origin.y*imgViewCoeff_height, faceFeature.bounds.origin.x*imgViewCoeff_width, faceFeature.bounds.size.height*imgViewCoeff_height, faceFeature.bounds.size.width*imgViewCoeff_width);
        UIView* faceView = [[UIView alloc] initWithFrame:face_bounds];
        
        // add a border around the newly created UIView
        faceView.layer.borderWidth = 1;
        faceView.layer.borderColor = [[UIColor redColor] CGColor];
        
        // add the new view to create a box around the face
        [self.imageView addSubview:faceView];
        
        [_faceArray addObject:[self imageByCroppingImage:facePicture withSize:faceFeature.bounds]];
        
 
        if(faceFeature.hasLeftEyePosition)
        {
            // create a UIView with a size based on the width of the face
            UIView* leftEyeView = [[UIView alloc] initWithFrame:CGRectMake(faceFeature.leftEyePosition.x-faceWidth*0.15, faceFeature.leftEyePosition.y-faceWidth*0.15, faceWidth*0.3, faceWidth*0.3)];
            // change the background color of the eye view
            [leftEyeView setBackgroundColor:[[UIColor blueColor] colorWithAlphaComponent:0.3]];
            // set the position of the leftEyeView based on the face
            [leftEyeView setCenter:faceFeature.leftEyePosition];
            // round the corners
            leftEyeView.layer.cornerRadius = faceWidth*0.15;
            // add the view to the window
            [faceView addSubview:leftEyeView];
        }
        
        if(faceFeature.hasRightEyePosition)
        {
            // create a UIView with a size based on the width of the face
            UIView* leftEye = [[UIView alloc] initWithFrame:CGRectMake(faceFeature.rightEyePosition.x-faceWidth*0.15, faceFeature.rightEyePosition.y-faceWidth*0.15, faceWidth*0.3, faceWidth*0.3)];
            // change the background color of the eye view
            [leftEye setBackgroundColor:[[UIColor blueColor] colorWithAlphaComponent:0.3]];
            // set the position of the rightEyeView based on the face
            [leftEye setCenter:faceFeature.rightEyePosition];
            // round the corners
            leftEye.layer.cornerRadius = faceWidth*0.15;
            // add the new view to the window
            [faceView addSubview:leftEye];
        }
        if(faceFeature.hasMouthPosition)
        {
            // create a UIView with a size based on the width of the face
            UIView* mouth = [[UIView alloc] initWithFrame:CGRectMake(faceFeature.mouthPosition.x-faceWidth*0.2, faceFeature.mouthPosition.y-faceWidth*0.2, faceWidth*0.4, faceWidth*0.4)];
            // change the background color for the mouth to green
            [mouth setBackgroundColor:[[UIColor greenColor] colorWithAlphaComponent:0.3]];
            // set the position of the mouthView based on the face
            [mouth setCenter:faceFeature.mouthPosition];
            // round the corners
            mouth.layer.cornerRadius = faceWidth*0.2;
            // add the new view to the window
            [faceView addSubview:mouth];
        }
 
    }
}
*/

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    if ([[segue identifier] isEqualToString:@"showFaces"])
    {
        showFacesController *SFC = [segue destinationViewController];
        [SFC setFaces:_faceArray];
    }
}

@end
