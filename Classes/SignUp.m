//
//  SignUp.m
//  MediMoni
//
//  Created by hsa1 on 31/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SignUp.h"
#import "DemoHintView.h"
#import "BlockAlertView.h"
#import "JSON/JSON.h"
@interface SignUp ()

@end

@implementation SignUp

- (IBAction)checkboxButton:(UIButton *)button{
    
    for (UIButton *but in [self.view subviews]) {
        if ([but isKindOfClass:[UIButton class]] && ![but isEqual:button]) {
            [but setSelected:NO];
        }
    }
    if (!button.selected)
    {
        //NSLog(@"button.tag:%i",button.tag);
        button.selected = !button.selected;
        [[NSUserDefaults standardUserDefaults]setInteger:button.tag forKey:@"syncType"];
    }
    
    if(button.tag==1)
    {
        sex=@"male";
    }
    else{
         sex=@"female";
    }
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)back
{
     [[self navigationController] popViewControllerAnimated:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    sex=@"null";
    UIButton *home = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *homeImage = [UIImage imageNamed:@"Back.png"]  ;
    [home setBackgroundImage:homeImage forState:UIControlStateNormal];
    [home addTarget:self action:@selector(back)
   forControlEvents:UIControlEventTouchUpInside];
    home.frame = CGRectMake(0, 0, 50, 30);
    UIBarButtonItem *cancelButton = [[[UIBarButtonItem alloc]
                                      initWithCustomView:home] autorelease];
    self.navigationItem.leftBarButtonItem = cancelButton;
    
    
    
    
    
    UIButton *save = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *saveImage = [UIImage imageNamed:@"Signup2.png"]  ;
    [save setBackgroundImage:saveImage forState:UIControlStateNormal];
    [save addTarget:self action:@selector(SingnUp)
   forControlEvents:UIControlEventTouchUpInside];
    save.frame = CGRectMake(0, 0, 100, 40);
    UIBarButtonItem *saveButton = [[[UIBarButtonItem alloc]
                                    initWithCustomView:save] autorelease];
    self.navigationItem.rightBarButtonItem = saveButton;
    
    // Do any additional setup after loading the view from its nib.
}

-(IBAction)SingnUp
{
    
    [(UITextField*)[self.view viewWithTag:101] resignFirstResponder];
    [(UITextField*)[self.view viewWithTag:102] resignFirstResponder];
     [(UITextField*)[self.view viewWithTag:103] resignFirstResponder];
     [(UITextField*)[self.view viewWithTag:104] resignFirstResponder];
     [(UITextField*)[self.view viewWithTag:105] resignFirstResponder];
     [(UITextField*)[self.view viewWithTag:106] resignFirstResponder];
     [(UITextField*)[self.view viewWithTag:107] resignFirstResponder];
     [(UITextField*)[self.view viewWithTag:108] resignFirstResponder];
     [(UITextField*)[self.view viewWithTag:109] resignFirstResponder];
     [(UITextField*)[self.view viewWithTag:110] resignFirstResponder];
     [(UITextField*)[self.view viewWithTag:111] resignFirstResponder];
    
    //NSLog(@"signUp1");
    if ([name.text length] == 0) 
    {
        us.hidden=NO;
    }
    else
    {
         us.hidden=YES;
    }
    
   if ([pass.text length] == 0) 
    {
        pa.hidden=NO;
    }
   else
   {
       pa.hidden=YES;
   }
     if ([cpass.text length] == 0)
    {
        
      copa.hidden=NO;
    }
     else
     {
         copa.hidden=YES;
     }
    
    
    if([sex isEqualToString: @"null"] )
    {
 /*       __block DemoHintView* hintView = [DemoHintView  infoHintView];
        hintView.hintID = kHintID_Home;
        hintView.title = @"Info!";
        [hintView addPageWithTitle:@"Info" text:@"Please select Gender"];
        [hintView showInView:self.view orientation:kHintViewOrientationTop];*/
        
        BlockAlertView *alert = [BlockAlertView alertWithTitle:@" Info!" message:@"Please select Gender"];
        
        //  [alert setCancelButtonWithTitle:@"Cancel" block:nil];
        [alert setDestructiveButtonWithTitle:@"x" block:nil];
        [alert show];
    }
    
    
    
      if ([age.text length] == 0)
    {
        
        sa.hidden=NO;
    } else
    {
        sa.hidden=YES;
    }
    
    
     if ([email.text length] == 0)
    {
        
        eid.hidden=NO;
    }
     else
     {
         eid.hidden=YES;
     }
    
      if ([mobile.text length] == 0)
    {
        
        mob.hidden=NO;
    }
      else
      {
          mob.hidden=YES;
      }
    if ([country.text length] == 0)
    {
        
        con.hidden=NO;
    }
    else
    {
        con.hidden=YES;
    }
    
    
    
    if ([state.text length] == 0)
    {
        
        st.hidden=NO;
    }
    else
    {
        st.hidden=YES;
    }
    
    if ([city.text length] == 0)
    {
        
        cty.hidden=NO;
    }
    else
    {
        cty.hidden=YES;
    }
    

   if([city.text length] != 0 &&[state.text length] != 0&&[country.text length] != 0 &&[mobile.text length] != 0&&[email.text length] != 0&&[age.text length] != 0&&[cpass.text length] != 0&&[pass.text length] != 0&&[name.text length] != 0&&! [sex isEqualToString: @"null"])
      {
          if ([pass.text isEqualToString:cpass.text])
          {
              
              HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
              [self.navigationController.view addSubview:HUD];
              
              
              HUD.delegate = self;
              HUD.labelText = @"Registering....";
              [HUD show:YES];
              [self performSelector:@selector(signUpMethod) withObject:nil afterDelay:0.2 ];
                
          }
          else {
           /*   __block DemoHintView* hintView = [DemoHintView  infoHintView];
              hintView.hintID = kHintID_Home;
              hintView.title = @"Info!";
              [hintView addPageWithTitle:@"Info" text:@"Password Doesn't Match"];
              [hintView showInView:self.view orientation:kHintViewOrientationTop];*/
              
              
              BlockAlertView *alert = [BlockAlertView alertWithTitle:@"Info!" message:@"Password Doesn't Match"];
              
              //  [alert setCancelButtonWithTitle:@"Cancel" block:nil];
              [alert setDestructiveButtonWithTitle:@"x" block:nil];
              [alert show];
          }
    }
    
    
    
}



- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSString *alertIndex = [alertView buttonTitleAtIndex:buttonIndex];
    
    if([alertIndex isEqualToString:@"Login"])
    {
         [[self navigationController] popViewControllerAnimated:YES];
    }
}


-(void)signUpMethod
{
    
    //NSLog(@"checkService");
    
    
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
        [HUD hide:YES afterDelay:1];
        return;
    }
    
    
    
    [name resignFirstResponder];
    [pass resignFirstResponder];
    [cpass resignFirstResponder];
    
    ////NSLog(@"signup");
    if ([[pass text]isEqualToString:[cpass text]]) 
    {
        
        
        ////NSLog(@"REGISTRATION"); 
        NSString *resultResponse=[self HttpPostEntityFirst:@"username" ForValue1:name.text EntitySecond:@"authkey" ForValue2:@"rzTFevN099Km39PV"];
        
        //NSLog(@"********%@",resultResponse);
        
        
        NSError *error;
        
        SBJSON *json = [[SBJSON new] autorelease];
        NSDictionary *luckyNumbers = [json objectWithString:resultResponse error:&error];
        
     
        if (luckyNumbers == nil)
        {
            
            //NSLog(@"RAJA");
            
        }
        else 
        {
            
            NSDictionary* menu = [luckyNumbers objectForKey:@"serviceresponse"];
            //NSLog(@"Menu id: %@", [menu objectForKey:@"servicename"]);
            
            
            
            if ([[menu objectForKey:@"servicename"] isEqualToString:@"Signup"]) 
            {
                if ([[menu objectForKey:@"success"] isEqualToString:@"Yes"]) 
                {
                    HUD.labelText = @"Completed.";
                    HUD.customView = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"37x-Checkmark.png"]] autorelease];
                    HUD.mode = MBProgressHUDModeCustomView;
                    [HUD hide:YES afterDelay:0];
                    
                 /*   UIAlertView *mes6=[[UIAlertView alloc] initWithTitle:@"INFO" message:@"Registration successful" delegate:self cancelButtonTitle:@"Login" otherButtonTitles:nil, nil];
                    [mes6 show];
                    [mes6 release];*/
                    
                    
                    BlockAlertView *alert = [BlockAlertView alertWithTitle:@"Info!" message:@"Registration successful!"];
                    
                    //  [alert setCancelButtonWithTitle:@"Cancel" block:nil];
                    [alert setDestructiveButtonWithTitle:@"x" block:nil];
                    [alert show];
                    

                    
                }
                else
                {
                    
           
                    
                    if ([[menu objectForKey:@"message"] isEqualToString:@"Already Exist"])
                    {
                        
                      /*  __block DemoHintView* hintView = [DemoHintView  infoHintView];
                        hintView.hintID = kHintID_Home;
                        hintView.title = @"Info!";
                        [hintView addPageWithTitle:@"Info" text:@"UserName Already Exits and active"];
                        [hintView showInView:self.view orientation:kHintViewOrientationTop];*/
                        
                        
                        BlockAlertView *alert = [BlockAlertView alertWithTitle:@"Info!" message:@"UserName Already Exits and active!"];
                        
                        //  [alert setCancelButtonWithTitle:@"Cancel" block:nil];
                        [alert setDestructiveButtonWithTitle:@"x" block:nil];
                        [alert show];
                        
                           [HUD hide:YES];
                        return;
                    }
                                    
                    
                }
            }
            
            
            
            
            
            
        }
        
          
    }
    else if([[name text] isEqualToString:@""])
    {
        
  /*      UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Failed!" message:@"Registration Failed!" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        
        [alert show];
        [alert release];*/
        
        BlockAlertView *alert = [BlockAlertView alertWithTitle:@"Failed!" message:@"Registration Failed!"];
        
        //  [alert setCancelButtonWithTitle:@"Cancel" block:nil];
        [alert setDestructiveButtonWithTitle:@"x" block:nil];
        [alert show];
        
    }
    else
    {
        
      //  UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"password!" message:@"Incorrect Password" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        
       // [alert show];
    //    [alert release];
        
        BlockAlertView *alert = [BlockAlertView alertWithTitle:@"password!" message:@"Incorrect Password"];
        
        //  [alert setCancelButtonWithTitle:@"Cancel" block:nil];
        [alert setDestructiveButtonWithTitle:@"x" block:nil];
        [alert show];
        
        
        
        }
    
 
       [HUD hide:YES];
    
}


-(NSString *)HttpPostEntityFirst:(NSString*)firstEntity ForValue1:(NSString*)value1 EntitySecond:(NSString*)secondEntity ForValue2:(NSString*)value2
{
    
    // NSString *authKey=@"rzTFevN099Km39PV";
    // NSString *userId=@"alagar@ajsquare.net";
    
    
    //NSLog(@"HTTP");
    
    
    
    NSString *post =[[NSString alloc] initWithFormat:@"%@=%@&pswd=%@&sex=%@&age=%@&email=%@&skype=%@&facetime=%@&mobile=%@&country=%@&state=%@&city=%@&%@=%@",firstEntity,value1,pass.text,sex,age.text,email.text,skype.text,face.text,mobile.text,country.text,state.text,city.text,secondEntity,value2];
    
   //  NSString *post =[[NSString alloc] initWithFormat:@"facebook_id=%@&facebookscore=%@&level=%@&life=%@&lifeInHand=%@&gold=%@",value1,value2,value1,value1,value1,value1];
    
    
      NSURL *url=[NSURL URLWithString:@"http://www.medsmonit.com/Service/patientresponce.php?service=patinsert"];
   
    
    
    ////NSLog(post);
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    
    NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
     //NSLog(@"postlenth%@",postLength);
    NSMutableURLRequest *request = [[[NSMutableURLRequest alloc] init] autorelease];
    [request setURL:url];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    
    //when we user https, we need to allow any HTTPS cerificates, so add the one line code,to tell teh NSURLRequest to accept any https certificate, i'm not sure //about the security aspects
    
    
    //    [NSURLRequest setAllowsAnyHTTPSCertificate:YES forHost:[url host]];
    
    NSError *error;
    NSURLResponse *response;
    NSData *urlData=[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    
    NSString *data=[[NSString alloc]initWithData:urlData encoding:NSUTF8StringEncoding];
    
    
    
    
    
    
   
    
    return data;
    
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
