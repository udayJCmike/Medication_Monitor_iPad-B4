//
//  Communicate.m
//  MediMoni
//
//  Created by hsa1 on 26/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Communicate.h"

@interface Communicate ()

@end

@implementation Communicate

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(IBAction)FaceClicked
{
    [[UIApplication sharedApplication] canOpenURL: [NSURL URLWithString: @"facetime://5555555555"]];
}
-(IBAction)SkypeClicked
{
 //   NSString* urlString = [NSString stringWithFormat:@\"skype://%@?call\", raja.seenivasan];
                       //    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString]];
}
-(IBAction)mailClicked
{
    
    
    
    if ([MFMailComposeViewController canSendMail])
    {
        MFMailComposeViewController *mailer = [[MFMailComposeViewController alloc] init];
        mailer.mailComposeDelegate = self;
        
        
        // UIImageView* view1 = [[UIImageView alloc] initWithImage: [UIImage imageNamed:@"Panel_Top.png"]];
        //  [mailer.navigationBar addSubview:view1];
        // [self.view sendSubviewToBack:view1];
        [mailer setSubject:@"Mail"];
        
        UIImage *barButton = [UIImage imageNamed:@"sSend.png"];
        [[UIBarButtonItem appearance] setBackgroundImage:barButton forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
        
        if([[UINavigationBar class] respondsToSelector:@selector(appearance)]) //iOS >=5.0
        {
           [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"Top_Panel.png"] forBarMetrics:UIBarMetricsDefault];
            
            
        }
        
        
        NSArray *toRecipients = [NSArray arrayWithObjects:@"info@example.com", nil];
        [mailer setToRecipients:toRecipients];
        
        UIImage *myImage = [UIImage imageNamed:@"mobiletuts-logo.png"];
        NSData *imageData = UIImagePNGRepresentation(myImage);
        //   [mailer addAttachmentData:imageData mimeType:@"image/png" fileName:@"mobiletutsImage"];
        
        
       /* NSString *emailBody1 =[NSString stringWithFormat:@"First Choice: %@\n"
                               "SecondChoice: %@.\n",[_DataArray objectAtIndex:0],[_DataArray objectAtIndex:1]];
        
        NSString *emailBody2 =[NSString stringWithFormat:@"FirstChoice AM/PM: %@\n"
                               "SecondChoice AM/PM: %@.\n",[_DataArray objectAtIndex:2],[_DataArray objectAtIndex:3]];
        
        NSString *emailBody3 =[NSString stringWithFormat:@"Appt.Type: %@\n",[_DataArray objectAtIndex:4]];
        
        NSString *emailBody4 =[NSString stringWithFormat:@"Name: %@\n" "Address: %@.\n",[_DataArray objectAtIndex:5],[_DataArray objectAtIndex:6]];
        NSString *emailBody5 =[NSString stringWithFormat:@"Phone: %@\n" "Email: %@.\n",[_DataArray objectAtIndex:7],[_DataArray objectAtIndex:8]];
        
        */
        
        
        NSString *emailBody = [NSString stringWithFormat:@"hi"];
        [mailer setMessageBody:emailBody isHTML:NO];
        
        // only for iPad
        // mailer.modalPresentationStyle = UIModalPresentationPageSheet;
        
        [self presentModalViewController:mailer animated:YES];
        
        [mailer release];
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Failure"
                                                        message:@"Your device doesn't support the composer sheet"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles: nil];
        [alert show];
        [alert release];
    }

    
    
    
    
    
}


- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error
{
	switch (result)
	{
		case MFMailComposeResultCancelled:
			//NSLog(@"Mail cancelled: you cancelled the operation and no email message was queued");
			break;
		case MFMailComposeResultSaved:
			//NSLog(@"Mail saved: you saved the email message in the Drafts folder");
			break;
		case MFMailComposeResultSent:
			//NSLog(@"Mail send: the email message is queued in the outbox. It is ready to send the next time the user connects to email");
			break;
		case MFMailComposeResultFailed:
			//NSLog(@"Mail failed: the email message was nog saved or queued, possibly due to an error");
			break;
		default:
			//NSLog(@"Mail not sent");
			break;
	}
    
	[self dismissModalViewControllerAnimated:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    
    if([[UINavigationBar class] respondsToSelector:@selector(appearance)]) //iOS >=5.0
    {
        [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"Top_Panel.png"] forBarMetrics:UIBarMetricsDefault];
        
        
    }
    
  
    UILabel *label = [[[UILabel alloc] initWithFrame:CGRectZero] autorelease];
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont boldSystemFontOfSize:20.0];
    label.shadowColor = [UIColor colorWithWhite:0.0 alpha:0.5];
    label.textAlignment = UITextAlignmentCenter;
    label.textColor = [UIColor whiteColor]; // change this color
    self.navigationItem.titleView = label;
    label.text = NSLocalizedString(@"Communicate", @"");
    [label sizeToFit];

    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return YES;
}

@end
