//
//  LoginScreen.m
//  MediMoni
//
//  Created by hsa1 on 30/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "LoginScreen.h"
#import "JSON/JSON.h"
#import "DemoHintView.h"
#import "SignUp.h"
#import "Welcome.h"
#import "BlockAlertView.h"
@interface LoginScreen ()

@end

@implementation LoginScreen





- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
       
    }
    return self;
}

-(IBAction)rem:(UIButton *)button
{
    for (UIButton *but in [self.view subviews]) {
        if ([but isKindOfClass:[UIButton class]] && ![but isEqual:button]) {
            [but setSelected:NO];
        }
    }
    if (!button.selected)
    {
        ////NSLog(@"button.tag:%i",button.tag);
        button.selected = !button.selected;
        [[NSUserDefaults standardUserDefaults]setInteger:1 forKey:@"rem"];
        [[NSUserDefaults standardUserDefaults]setObject:name.text forKey:@"remuser"];
        [[NSUserDefaults standardUserDefaults]setObject:pass.text forKey:@"rempass"];
    }
    else
    {
         [button setSelected:NO];
          [[NSUserDefaults standardUserDefaults]setInteger:2 forKey:@"rem"];
    }
    
}







-(void)audio
{
    
    NSString *result;
    NSData *responseData;
    
    int UserId=12;
  //  UIImage *image1=[UIImage imageNamed:@"Medig.png"];
	//NSData *userImageData = UIImageJPEGRepresentation(image1, 90);
    
    
    
    NSString *file2 = [[NSBundle mainBundle] pathForResource:@"09 - Ayayayo Aananthamey [www.PureMP3.net]" ofType:@"mp3"];
    
    NSData *userImageData = [[NSData alloc] initWithContentsOfFile:file2];
    
    
    @try {
        NSURL *url = [[NSURL alloc] initWithString:@"http://192.168.1.113/MedicationMonitor/Service/patientaudioresponce.php?service=audioinsert"];
        NSMutableURLRequest *req = [[NSMutableURLRequest alloc] initWithURL:url];
        [req setHTTPMethod:@"POST"];
        
        [req setValue:@"multipart/form-data; boundary=*****" forHTTPHeaderField:@"Content-Type"];//
        
        NSMutableData *postBody = [NSMutableData data];
        NSString *stringBoundary = [NSString stringWithString:@"*****"];
        
        [postBody appendData:[[NSString stringWithFormat:@"--%@\r\n",stringBoundary] dataUsingEncoding:NSASCIIStringEncoding]];
        [postBody appendData:[[NSString stringWithString:@"Content-Disposition: form-data; name=\"insertImage\"\r\n\r\n"] dataUsingEncoding:NSASCIIStringEncoding]];
        [postBody appendData:[[NSString stringWithFormat:@"true"] dataUsingEncoding:NSASCIIStringEncoding]];
        [postBody appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n",stringBoundary] dataUsingEncoding:NSASCIIStringEncoding]];
        
        
        [postBody appendData:[[NSString stringWithFormat:@"--%@\r\n",stringBoundary] dataUsingEncoding:NSASCIIStringEncoding]];
        [postBody appendData:[[NSString stringWithString:@"Content-Disposition: form-data; name=\"userId\"\r\n\r\n"] dataUsingEncoding:NSASCIIStringEncoding]];
        [postBody appendData:[[NSString stringWithFormat:@"%d",UserId] dataUsingEncoding:NSASCIIStringEncoding]];
        [postBody appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n",stringBoundary] dataUsingEncoding:NSASCIIStringEncoding]];
        
        [postBody appendData:[[NSString stringWithFormat:@"--%@\r\n",stringBoundary] dataUsingEncoding:NSASCIIStringEncoding]];
        [postBody appendData:[[NSString stringWithString:@"Content-Disposition: form-data; name=\"patientaudio\"; filename=\"myimagefile.mp3\"\r\nContent-Type: audio/mp3\r\n\r\n"] dataUsingEncoding:NSASCIIStringEncoding]];
        
        [postBody appendData:[NSData dataWithData:userImageData]];
        [postBody appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n",stringBoundary] dataUsingEncoding:NSASCIIStringEncoding]];
        [req setHTTPBody: postBody];//putParams];
        
        NSHTTPURLResponse* response = nil;
        NSError* error = [[[NSError alloc] init] autorelease];
        
        responseData = [NSURLConnection sendSynchronousRequest:req returningResponse:&response error:&error];
        result = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
        // if(isInDebugMode)
        //  //NSLog(@"Result: %@", result);
        
        [url release];
        [req release];
        
        //   IceCreamManFinderAppDelegate *delegate1=(IceCreamManFinderAppDelegate *)[UIApplication sharedApplication].delegate;
        
    }
    @catch (NSException* ex) {
        //NSLog(@"Error: %@",ex);
    }
    //return responseData;
    
    //NSLog(@"res:%@",result);

    
}


- (void)viewDidLoad
{
     
    [super viewDidLoad];
   
    
  
    
    UILabel *label = [[[UILabel alloc] initWithFrame:CGRectZero] autorelease];
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont boldSystemFontOfSize:20.0];
    label.shadowColor = [UIColor colorWithWhite:0.0 alpha:0.5];
    label.textAlignment = UITextAlignmentCenter;
    label.textColor = [UIColor whiteColor]; // change this color
    self.navigationItem.titleView = label;
    label.text = NSLocalizedString(@"Medication Monitor", @"");
    [label sizeToFit];
    
    
    
    int reme=[[NSUserDefaults standardUserDefaults]integerForKey:@"rem"];
    if(reme==1)
    {
        NSString *remuse=[[NSUserDefaults standardUserDefaults]objectForKey:@"remuser"];
         NSString *rempass=[[NSUserDefaults standardUserDefaults]objectForKey:@"rempass"];
        name.text=remuse;
        pass.text=rempass;
            [rem setSelected:YES];
    }
    else
    {
        [rem setSelected:NO];
    }

    // Do any additional setup after loading the view from its nib.
}




-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
    {
        CGRect frame;
    if(textField.tag==102)
    {
        frame=CGRectMake(0, -100, 320, 436);
    }
       else if(textField.tag==101)
        {
            frame=CGRectMake(0, -60, 320, 436);
        }
    [UIView beginAnimations:@"" context:NULL];
    
    //The new frame size
    self.view.frame=frame;
    //The animation duration
    [UIView setAnimationDuration:2.0];
    
    [UIView setAnimationDelay: UIViewAnimationCurveEaseIn];
    
    [UIView commitAnimations];
    
    }
    
}

-(IBAction)SingnUp
{
    [(UITextField*)[self.view viewWithTag:101] resignFirstResponder];
    [(UITextField*)[self.view viewWithTag:102] resignFirstResponder];
    ////NSLog(@"SIgnUP");
    
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        
        SignUp *noteViewController = [[SignUp alloc] initWithNibName:@"SignUp_iPhone" bundle:nil];
        [self.navigationController pushViewController:noteViewController animated:YES];
        [noteViewController release];
    }
    else
    {
         SignUp *noteViewController = [[SignUp alloc] initWithNibName:@"SignUp" bundle:nil];
        [self.navigationController pushViewController:noteViewController animated:YES];
        [noteViewController release];
    }
   
	
}
-(void)SignIn
{
  
    [(UITextField*)[self.view viewWithTag:101] resignFirstResponder];
    [(UITextField*)[self.view viewWithTag:102] resignFirstResponder];

   //  [self audio];
  //  [self uploadImage];
    if ([name.text length] == 0)
    {
     
        
    /*    __block DemoHintView* hintView = [DemoHintView  infoHintView];
        hintView.hintID = kHintID_Home;
        hintView.title = @"Info!";
        [hintView addPageWithTitle:@"Info" text:@"Please Enter Your user Name"];
       [hintView showInView:self.view orientation:kHintViewOrientationTop];*/
        
        
        BlockAlertView *alert = [BlockAlertView alertWithTitle:@" Info!" message:@"Please Enter Your user Name" ];
    
      //  [alert setCancelButtonWithTitle:@"Cancel" block:nil];
        [alert setDestructiveButtonWithTitle:@"x" block:nil];
        [alert show];
        
     
        
    }
    else  if ([pass.text length] == 0) 
    {
               
      /*  __block DemoHintView* hintView = [DemoHintView  infoHintView];
        hintView.hintID = kHintID_Home;
        hintView.title = @"Info!";
        [hintView addPageWithTitle:@"Info" text:@"Please Enter CorrectPassword"];
        [hintView showInView:self.view orientation:kHintViewOrientationTop];*/
                
        
        BlockAlertView *alert = [BlockAlertView alertWithTitle: @" Info!" message:@"Please Enter Correct Password"];
        
        //  [alert setCancelButtonWithTitle:@"Cancel" block:nil];
        
        [alert setDestructiveButtonWithTitle:@"x" block:nil];
        [alert show];
    }
else {
       
    HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
	[self.navigationController.view addSubview:HUD];
	
    
	HUD.delegate = self;
	HUD.labelText = @"Authenticating...";
	
	[HUD show:YES];
    [self performSelector:@selector(SignInCheck) withObject:nil afterDelay:0.2];
    
}

}


-(void) uploadImage
{
    
    
    UIImage *image = [UIImage imageNamed:@"AddAftn.png"];
    NSData *imageData = UIImagePNGRepresentation(image);
  //  NSData *imageData = UIImagePNGRepresentation([dic objectForKey:@"image"]);
    // setting up the URL to post to
    NSString *urlString =[NSString stringWithFormat:@"http://192.168.1.88/MedicationMonitor/Service/medicineresponce.php?service=medinsert&patid=2"];
    
    // setting up the request object now
    
    NSMutableURLRequest *request = [[[NSMutableURLRequest alloc] init] autorelease];
    [request setURL:[NSURL URLWithString:urlString]];
    [request setHTTPMethod:@"POST"];
    [request setTimeoutInterval:10];
    
    /*
     add some header info now
     we always need a boundary when we post a file
     also we need to set the content type
     
     You might want to generate a random boundary.. this is just the same
     as my output from wireshark on a valid html post
     */
    
    NSString *boundary = @"---------------------------14737809831466499882746641449";
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@",boundary];
    [request addValue:contentType forHTTPHeaderField: @"Content-Type"];
    
    /*
     now lets create the body of the post
     */
    
    NSMutableData *body = [NSMutableData data];
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[@"Content-Disposition: form-data; name=\"profile_photo\"; filename=\"AddAftn.png\"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    // where profile_photo is the key value or parameter value on server. must be confirm
    
    [body appendData:[@"Content-Type: application/octet-stream\r\n\r\n"dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[NSData dataWithData:imageData]];
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    // setting the body of the post to the reqeust
    [request setHTTPBody:body];
    
    // now lets make the connection to the web
    NSData *returnData = [ NSURLConnection sendSynchronousRequest: request returningResponse: nil error: nil ]; // send data to the web service
    NSString *returnString = [[NSString alloc] initWithData:returnData encoding:NSASCIIStringEncoding];
     ////NSLog(@"Raja:%@",returnString);
    
    
    NSString *trimmedString = [returnString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    NSString *trimmedString1 = [trimmedString stringByReplacingOccurrencesOfString:@"\t" withString:@""];
    trimmedString1 = [trimmedString1 stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    
   
    NSMutableArray *dic0 = [trimmedString1 JSONValue];
  //   //NSLog(@"Raja:%@",trimmedString);
    NSMutableDictionary *dic1 = [dic0 objectAtIndex:0];
  //  //NSLog(@"Profile photo status : %@",[dic1 valueForKey:@"id"]);
    
}
- (void)myTask {
	
	sleep(4);
}
-(void)SignInCheck
{
   
    
    Reachability* wifiReach = [[Reachability reachabilityWithHostName: @"www.apple.com"] retain];
	NetworkStatus netStatus = [wifiReach currentReachabilityStatus];
    
	switch (netStatus)
	{
		case NotReachable:
		{
			isConnect=NO;
			//NSLog(@"Access Not Available");
			break;
		}
			
		case ReachableViaWWAN:
		{
			isConnect=YES;
			//NSLog(@"Reachable WWAN");
			break;
		}
		case ReachableViaWiFi:
		{
			isConnect=YES;
			//NSLog(@"Reachable WiFi");
			break;
		}
	}
	
	
    
    if(isConnect)
    {
        
    }
      //  imgName=@"Connected.png";
    else
    {
        HUD.labelText = @"Check newtwork connection....";
        HUD.customView = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@""]] autorelease];
        HUD.mode = MBProgressHUDModeCustomView;
        [HUD hide:YES afterDelay:2];
        return;
    }
        
        //imgName=@"disconnect.png";
    

    
    
    
       
    NSString *resultResponse=[self HttpPostEntityFirst1:@"username" ForValue1:name.text EntitySecond:@"pswd" ForValue2:pass.text EntityThird:@"authkey" ForValue3:@"rzTFevN099Km39PV"];
    
    
   
    
	NSError *error;
    
    SBJSON *json = [[SBJSON new] autorelease];
	NSDictionary *luckyNumbers = [json objectWithString:resultResponse error:&error];
      ////NSLog(@"RESULT RESPONSE =%@",luckyNumbers);
    if (luckyNumbers == nil)
    {
        ////NSLog(@"Failed");
        
    }
    else 
    {
        
        NSDictionary* menu = [luckyNumbers objectForKey:@"serviceresponse"];
        //////NSLog(@"Menu id: %@", [menu objectForKey:@"success"]);
        
        if ([[menu objectForKey:@"success"] isEqualToString:@"Yes"])
        {
          
            HUD.labelText = @"Completed.";
            HUD.customView = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"37x-Checkmark.png"]] autorelease];
            HUD.mode = MBProgressHUDModeCustomView;
            [HUD hide:YES afterDelay:0];

            NSString *LoginId=[menu objectForKey:@"userid"];
              NSString *LoginId1=[menu objectForKey:@"message"];
            ////NSLog(@"USERID:%@",LoginId);
              ////NSLog(@"USERID:%@",LoginId1);
           
            // [[NSUserDefaults standardUserDefaults] setInteger:  forKey:@"username"];
        
            [[NSUserDefaults standardUserDefaults] setObject:LoginId    forKey:@"loginid"];
            [[NSUserDefaults standardUserDefaults] setObject:name.text forKey:@"username"];
            name.text=Nil;
            pass.text=nil;
          //  [self.navigationController popViewControllerAnimated:YES];
      //deepthi
            
            
            
          Welcome *noteViewController = [[Welcome alloc] initWithNibName:@"Welcome" bundle:nil];
        [self.navigationController pushViewController:noteViewController animated:YES];
        [noteViewController release];
            
            //NSLog(@"success");
            
        }
        else
        {
         BlockAlertView *alert = [BlockAlertView alertWithTitle:@"Info!" message:@"Please Enter Correct Password.!"];
           /* HUD.labelText = @"Invalid Username & Password.";
            HUD.customView = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"37x-Checkmark.png"]] autorelease];
            HUD.mode = MBProgressHUDModeCustomView;
            [HUD hide:YES afterDelay:1.6];
            //NSLog(@"raja");
            */
            [HUD hide:YES];

        [alert setDestructiveButtonWithTitle:@"x" block:nil];
        [alert show];

    }
        
        
    }
    
    
    
    
    
    
    
    /*   
     Login url: http://192.168.1.116/bephit/service/?do=loginservice
     
     For checing use my username and password..
     Username: predeepa@ajsquare.net
     Password: 9940965088
     
     */
    
    
}



-(NSString *)HttpPostEntityFirst1:(NSString*)firstEntity ForValue1:(NSString*)value1 EntitySecond:(NSString*)secondEntity ForValue2:(NSString*)value2 EntityThird:(NSString*)thirdEntity ForValue3:(NSString*)value3
{
    
    
    
    // NSString *authKey=@"rzTFevN099Km39PV";
    // NSString *userId=@"alagar@ajsquare.net";
    
    
    
    NSString *post =[[NSString alloc] initWithFormat:@"%@=%@&%@=%@&%@=%@",firstEntity,value1,secondEntity,value2,thirdEntity,value3];
    
     ////NSLog(@"POST:%@",post);
    
    
    
    NSURL *url=[NSURL URLWithString:@"http://www.medsmonit.com/Service/loginresponce.php?service=login"];

  
    //////NSLog(post);  
  
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
    NSMutableURLRequest *request = [[[NSMutableURLRequest alloc] init] autorelease];
    [request setURL:url];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    
    //when we user https, we need to allow any HTTPS cerificates, so add the one line code,to tell teh NSURLRequest to accept any https certificate, i'm not sure //about the security aspects
    
    
    //[NSURLRequest setAllowsAnyHTTPSCertificate:YES forHost:[url host]];
    
    NSError *error;
    NSURLResponse *response;
    NSData *urlData=[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    NSString *data=[[NSString alloc]initWithData:urlData encoding:NSUTF8StringEncoding];
    //NSLog(@"data:%@",data);
    ////NSLog(@"%@",data);
    
    return data;
    
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
  
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
    {
        CGRect frame;
    if(textField.tag==102)
    {
        frame=CGRectMake(0,0, 320, 436);
       }
        [UIView beginAnimations:@"" context:NULL];
        
        //The new frame size
        self.view.frame=   frame=CGRectMake(0, 0, 320, 436);
        //The animation duration
        [UIView setAnimationDuration:2.0];
        
        [UIView setAnimationDelay: UIViewAnimationCurveEaseIn];
        
        [UIView commitAnimations];
    }
    
    if ([name.text length] == 0) 
    {
        
     /*   __block DemoHintView* hintView = [DemoHintView  infoHintView];
        hintView.hintID = kHintID_Home;
        hintView.title = @"Info!";
        [hintView addPageWithTitle:@"Info" text:@"Please Enter Your user Name"];
        [hintView showInView:self.view orientation:kHintViewOrientationTop];*/
        
        
        BlockAlertView *alert = [BlockAlertView alertWithTitle:@" Info!" message:@"Please Enter Your user Name"];
        
        //  [alert setCancelButtonWithTitle:@"Cancel" block:nil];
        [alert setDestructiveButtonWithTitle:@"x" block:nil];
        [alert show];
        
       

    }
   else  if ([pass.text length] == 0)
    {
       /* __block DemoHintView* hintView = [DemoHintView  infoHintView];
        hintView.hintID = kHintID_Home;
        hintView.title = @"Info!";
        [hintView addPageWithTitle:@"Info" text:@"Please Enter CorrectPassword"];
        [hintView showInView:self.view orientation:kHintViewOrientationTop];*/
        
        BlockAlertView *alert = [BlockAlertView alertWithTitle:@" Info!" message:@"Please Enter Correct Password"];
        
        //  [alert setCancelButtonWithTitle:@"Cancel" block:nil];
        [alert setDestructiveButtonWithTitle:@"x" block:nil];
        [alert show];

    }
        [textField resignFirstResponder];

    return YES;
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
