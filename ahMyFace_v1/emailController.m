//
//  ViewController.m
//  EmailPhotos
//
//  Created by Kasean Herrera on 3/26/15.
//  Copyright (c) 2015 Kasean Herrera. All rights reserved.
//





#import "emailController.h"

@interface emailController ()

@end



@implementation emailController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)emailButton:(id)sender {
    if([MFMailComposeViewController canSendMail]){
        //MAIL CONSTANTS
        NSArray *toRecipents = [NSArray arrayWithObjects:@"kaseanh@uci.edu",@"kaseanherrera@yahoo.com", nil];
        NSString *subject = @"Pictures from Moments!";
        NSString *body = @"Thank you for using Moments!";
        
        //image
        UIImage *itemImage = [UIImage imageWithContentsOfFile:@"/Users/kaseanherrera/Desktop/kimk2.png" ];
    
        //mail object
        MFMailComposeViewController *emailView = [[MFMailComposeViewController alloc] init];
        emailView.mailComposeDelegate = self;
        
        [emailView setSubject:subject];
        [emailView setToRecipients:toRecipents];
        [emailView setMessageBody:body isHTML:false];
        [emailView addAttachmentData:UIImageJPEGRepresentation(itemImage, 1) mimeType:@"image/png" fileName:@"Kimk2.png"];
        

        //present the view
        [self presentViewController:emailView animated:true completion:nil];
    }else{
        //if the device can not send email messages
        NSString *result = @"Device is not configured to send mail";
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:result delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        
        [alert show];
    }
}



-(void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error{
    NSString *outPut = nil;
    
    switch(result){
        case MFMailComposeResultCancelled:
            outPut = @"Message was cancelled";
            break;
        case MFMailComposeResultSaved:
            outPut = @"Message was saved";
            break;
        case MFMailComposeResultSent:
            outPut = @"Message was sent";
            break;
        case MFMailComposeResultFailed:
            outPut = @"Message failed to send";
            break;
        default:
            break;
    }
    
   // NSLog(@"%@",outPut);
    
    UIAlertView * resultView = [[UIAlertView alloc] initWithTitle:@"Result" message:outPut delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: @"otherButton", nil];
    [resultView show];
    [self dismissViewControllerAnimated:true completion:nil];
    
}
    
@end
