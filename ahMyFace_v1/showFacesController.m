//
//  showFacesController.m
//  ahMyFace_v1
//
//  Created by Naren Sathiya on 3/23/15.
//  Copyright (c) 2015 Naren Sathiya. All rights reserved.
//

#import "showFacesController.h"
#import "emailController.h"
#import "MessageConrollerViewController.h"

@interface showFacesController ()

@end

@implementation showFacesController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
   
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithTitle:@"Send"
                                                                    style:UIBarButtonItemStyleDone
                                                                   target:self
                                                                   action:@selector(sendEmail:)];
   
    self.navigationItem.rightBarButtonItem = rightButton;

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    

}

-(void) sendEmail:(id) sender{
    NSLog(@"Sending Email (sendEmailFunction");
    [self sendSMS];
   // [self performSegueWithIdentifier:@"send" sender:self];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];

}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _faces.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier = @"faceCell";
    faceCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if(cell == nil){
        cell = [[faceCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    long row = [indexPath row];
    //cell.bounds.size.height = [[[_faces objectAtIndex:row]
    [cell.facePic setImage:[self.faces objectAtIndex:row]];
    cell.nameLabel.text = [self.names objectAtIndex:row];
    
    return cell;
}


- (void) sendSMS{
    
    if([MFMessageComposeViewController canSendText]){
        
        NSArray *recipents = @[@"8586636233"];
        NSString *message = @"MOMENTS";
        
        MFMessageComposeViewController *textView = [[MFMessageComposeViewController alloc ]init];
        textView.messageComposeDelegate = self;
        [textView setBody:message];
        [textView setRecipients:recipents];
        NSData *exportData = UIImageJPEGRepresentation([self.faces objectAtIndex:0],1.0);

        [textView addAttachmentData:exportData typeIdentifier:@"public.data" filename:@"image.png"];

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
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}




- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
     NSLog(@"Attempting to preform Segue");
    if ([[segue identifier] isEqualToString:@"send"])
    {
       
        MessageConrollerViewController *MC = [segue destinationViewController];
       // NSLog(@"%lu", sizeof(self.faces));
       // [MC setFaces:self.faces];
       //cs [MC setNames:self.names];
    }else{
        NSLog(@"we do not have a segue for you yet");
    }
}

*/

@end
