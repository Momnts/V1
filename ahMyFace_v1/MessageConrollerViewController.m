//
//  MessageConrollerViewController.m
//  ahMyFace_v1
//
//  Created by Kasean Herrera on 4/2/15.
//  Copyright (c) 2015 Naren Sathiya. All rights reserved.
//

#import "MessageConrollerViewController.h"

@interface MessageConrollerViewController () <MFMessageComposeViewControllerDelegate, UINavigationControllerDelegate>

@end

@implementation MessageConrollerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"Made it this far");
    [self SendSMS];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) SendSMS{
    
    if([MFMessageComposeViewController canSendText]){
        
        NSArray *recipents = @[@"8586636233"];
        NSString *message = @"MOMENTS";
        
        MFMessageComposeViewController *textView = [[MFMessageComposeViewController alloc ]init];
        textView.messageComposeDelegate = self;
        [textView setBody:message];
        [textView setRecipients:recipents];
        
        [self presentViewController:textView animated:YES completion:nil];
        
        
    }else{
        NSString *result = @"SMS was not suported by this phone";
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Error" message:result delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: @"ok", nil];
        [alert show];
        NSLog(@"%@",result);
    }
}

- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult) result
{
    switch (result) {
        case MessageComposeResultCancelled:
            break;
            
        case MessageComposeResultFailed:
        {
            UIAlertView *warningAlert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Failed to send SMS!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [warningAlert show];
            break;
        }
            
        case MessageComposeResultSent:
            break;
            
        default:
            break;
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
