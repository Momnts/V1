//
//  HomeController.m
//  ahMyFace_v1
//
//  Created by Naren Sathiya on 3/26/15.
//  Copyright (c) 2015 Naren Sathiya. All rights reserved.
//

#import "HomeController.h"

@interface HomeController ()

@end

@implementation HomeController

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)signIn:(id)sender {
    [self performSegueWithIdentifier:@"signIn" sender:nil];
}

- (IBAction)momntMe:(id)sender {
    [self performSegueWithIdentifier:@"momntMe" sender:nil];
}

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    if ([[segue identifier] isEqualToString:@"signIn"])
    {
        PViewController *PVS = [segue destinationViewController];
    }
    else if([[segue identifier] isEqualToString:@"momntMe"])
    {
        MomntMeController *MMC = [segue destinationViewController];
    }
}

@end
