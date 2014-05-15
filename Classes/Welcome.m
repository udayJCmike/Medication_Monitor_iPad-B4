//
//  Welcome.m
//  MediMoni
//
//  Created by hsa1 on 01/08/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Welcome.h"
#import "DemoHintView.h"
#import "JSON/JSON.h"
#import "fileMngr.h"
#import "AppSharedInstance.h"
#import "ADLivelyTableView.h"
#import "BlockAlertView.h"
#define USE_CUSTOM_DRAWING 1
#define USE_CUSTOM_DRAWING 1
@interface Welcome ()

@end

@implementation Welcome
@synthesize recordDict;
@synthesize petArray;
@synthesize _assQues;
@synthesize _assAns;
@synthesize assesment;

AppSharedInstance *instance;
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
    
}


- (void)myTask {
	
	sleep(20);
}

-(IBAction)sunc:(id)sender
{
    	
    HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
	[self.navigationController.view addSubview:HUD];
	
    
	HUD.delegate = self;
	HUD.labelText = @"Loading...";
    [HUD show:YES];
    [self performSelector:@selector(sunc1) withObject:nil afterDelay:0.2 ];
}

-(IBAction)sunc1
{
    
  
   
      instance = [AppSharedInstance sharedInstance];
    self.petArray = [instance getPet];
    self._assQues=[instance getAssQue];
    self._assAns=[instance getAssAnswer];
    self.assesment=[instance getAssesment];
    NSString *runNumber = [[NSUserDefaults standardUserDefaults] objectForKey:@"loginid"];
 
    
    
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
        HUD.labelText = @"Check network connection....";
        HUD.customView = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@""]] autorelease];
        HUD.mode = MBProgressHUDModeCustomView;
        [HUD hide:YES afterDelay:2];
        return;
    }
    
    
    
NSString *resultResponse=[self HttpPostEntityFirst1:@"patid" ForValue1:runNumber  EntityThird:@"authkey" ForValue3:@"rzTFevN099Km39PV"];
NSString *resultResponse1=[self HttpPostEntityFirst:@"patid" ForValue1:runNumber  EntityThird:@"authkey" ForValue3:@"rzTFevN099Km39PV"];
NSString *resultResponseASS=[self HttpPostEntityFirstASS:@"patid" ForValue1:runNumber  EntityThird:@"authkey" ForValue3:@"rzTFevN099Km39PV"];
NSString *resultResponseREMINDER=[self HttpPostEntityFirstREMINDER:@"patid" ForValue1:runNumber  EntityThird:@"authkey" ForValue3:@"rzTFevN099Km39PV"];
    
    
NSString *resultResponsePROVIDER=[self HttpPostEntityFirstPROVIDER:@"patid" ForValue1:runNumber  EntityThird:@"authkey" ForValue3:@"rzTFevN099Km39PV"];
NSString* _listOfPro=[self HttpPostEntityFirst_listOfPro:@"patid" ForValue1:runNumber  EntityThird:@"authkey" ForValue3:@"rzTFevN099Km39PV"];
    

    
    
    
    
    NSError *error;
    SBJSON *json = [[SBJSON new] autorelease];
    
	NSDictionary *luckyNumbers = [json objectWithString:resultResponse error:&error];
    NSDictionary *luckyNumbers1 = [json objectWithString:resultResponse1 error:&error];
    NSDictionary *luckyNumbersASS = [json objectWithString:resultResponseASS error:&error];
    
    NSDictionary *luckyNumbersProvider = [json objectWithString:resultResponsePROVIDER error:&error];
    NSDictionary *Provideritems = [luckyNumbersProvider objectForKey:@"serviceresponse"];
    NSArray *Provideritems1=[Provideritems objectForKey:@"Select Provider"];
    
    
    NSDictionary *luckyNumberslistofpro = [json objectWithString:_listOfPro error:&error];
     NSDictionary *_listOfProitems = [luckyNumberslistofpro objectForKey:@"serviceresponse"];
    NSArray *_listOfProitems1=[_listOfProitems objectForKey:@"Select Providers"];
   
    NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *docDirectory = [path objectAtIndex:0];
    
    NSMutableArray *ProDl=[[NSMutableArray alloc]init];
    NSMutableArray *ProNaml=[[NSMutableArray alloc]init];
    NSString*ProDFilel=[[NSString alloc] initWithString:[docDirectory stringByAppendingPathComponent:@"ProDFilel"]];
    NSString*ProNamfilel=[[NSString alloc] initWithString:[docDirectory stringByAppendingPathComponent:@"ProNamfilel"]];
    NSLog(@"_listOfProitems1:%@",_listOfProitems1);
                               for (id anUpdate in _listOfProitems1)
                               {
                                   NSDictionary *ProID=[(NSDictionary*)anUpdate objectForKey:@"provideid"];
                                   NSDictionary *ProName=[(NSDictionary*)anUpdate objectForKey:@"providername"];
                                   ////NSLog(@"providerId:");
                                   ////NSLog(@"ProviderName:%@",ProName);
                                   [ProDl addObject:[NSString stringWithFormat:@"%@",ProID]];
                                   [ProNaml addObject:[NSString stringWithFormat:@"%@",ProName]];
                               }
    
    [fileMngr saveDatapath:ProDFilel contentarray:ProDl];
    [fileMngr saveDatapath:ProNamfilel contentarray:ProNaml];
    
    HUD.labelText = @"Feteching Data...";
   // return;
    
   // ////NSLog(@"Provideritems1 =%@",Provideritems1);
    
    NSMutableArray *ProD=[[NSMutableArray alloc]init];
    NSMutableArray *ProNam=[[NSMutableArray alloc]init];
    
      NSLog(@"Provideritems1:%@",Provideritems1);
    for (id anUpdate in Provideritems1)
    {
       NSDictionary *ProID=[(NSDictionary*)anUpdate objectForKey:@"provideid"];
        NSDictionary *ProName=[(NSDictionary*)anUpdate objectForKey:@"providername"];
        ////NSLog(@"providerId:%@",ProID);
        ////NSLog(@"ProviderName:%@",ProID);
        [ProD addObject:[NSString stringWithFormat:@"%@",ProID]];
        [ProNam addObject:[NSString stringWithFormat:@"%@",ProName]];
     
    }
    
    
	NSString*ProDFile=[[NSString alloc] initWithString:[docDirectory stringByAppendingPathComponent:@"ProDFile"]];
    NSString*ProNamfile=[[NSString alloc] initWithString:[docDirectory stringByAppendingPathComponent:@"ProNamfile"]];
    [fileMngr saveDatapath:ProDFile contentarray:ProD];
        [fileMngr saveDatapath:ProNamfile contentarray:ProNam];
    
    ////NSLog(@"%@",ProD);
    ////NSLog(@"%@",ProNam);
    
   
    
    
    
    
    
    
    /*REMINDERS***************/
    
    
    
   
    
     NSDictionary *luckyNumbersREMINDER = [json objectWithString:resultResponseREMINDER error:&error];
    NSDictionary *REMINDERitems = [luckyNumbersREMINDER objectForKey:@"serviceresponse"];
    NSArray *REMINDERitems1=[REMINDERitems objectForKey:@"Patient Reminder"];
    
      
    
    for (id anUpdate in REMINDERitems1)
    {
        
        NSDictionary *arrayList=[(NSDictionary*)anUpdate objectForKey:@"remindername"];
        NSDictionary *arrayListType=[(NSDictionary*)anUpdate objectForKey:@"remindertype"];
        NSDictionary *arrayListDate=[(NSDictionary*)anUpdate objectForKey:@"reminderdate"];
        ////NSLog(@"remaindername:%@",arrayList);
        ////NSLog(@"remaindername:%@",arrayListType);
        ////NSLog(@"remaindername:%@",arrayListDate);
        
     
        
        NSString *dateString = [NSString stringWithFormat:@"%@",arrayListDate];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd  hh:mm"];
        NSDate *dateFromString = [[NSDate alloc] init];
        dateFromString = [dateFormatter dateFromString:dateString];
        [dateFormatter release];
        
        
        UILocalNotification *localNotif = [[UILocalNotification alloc] init];
        if (localNotif == nil)
            return;
        localNotif.fireDate = dateFromString;
        localNotif.timeZone = [NSTimeZone systemTimeZone];
        localNotif.alertBody = [NSString stringWithFormat:@"%@",arrayList ];
        localNotif.alertAction = @"View";
        localNotif.soundName = UILocalNotificationDefaultSoundName;
        localNotif.applicationIconBadgeNumber = 0;
        NSString*s=[NSString stringWithFormat:@"%@",arrayListType];
        if([s isEqualToString:@"Daily"])
        {
               localNotif.repeatInterval = NSDayCalendarUnit;
        }
        else
        {
            localNotif.repeatInterval = 0;
        }
        
     //    NSDictionary *infoDict = [NSDictionary dictionaryWithObject: localNotif.fireDate forKey:@"date"];
      //  localNotif.userInfo = infoDict;
        [[UIApplication sharedApplication] scheduleLocalNotification:localNotif];
        [localNotif release];
        
        
        
    }

    
    
    
    //////***********************ASSESSMENT*********************??//
    
    NSDictionary *items = [luckyNumbers objectForKey:@"serviceresponse"];
     NSArray *items1=[items objectForKey:@"Patient Medicines"];
    
    NSDictionary *itemsApp = [luckyNumbers1 objectForKey:@"serviceresponse"];
     NSArray *items1App=[itemsApp objectForKey:@"Patient Appointment"];
    
    
    NSDictionary *qusres = [luckyNumbersASS objectForKey:@"serviceresponse"];
    
    NSArray *patQuestion=[qusres objectForKey:@"Patient Question"];
    
     // NSArray *assessment=[luckyNumbersASS objectForKey:@"assessment"];
//NSDictionary *qusres1 = [luckyNumbersASS objectForKey:@"assessment"];
    
   // ////NSLog(@"RESULT ASSESS =%@",patQuestion);ass
    
      
    
    for (id anUpdate in patQuestion)
    {
        NSDictionary *arrayList=[(NSDictionary*)anUpdate objectForKey:@"assid"];
        NSDictionary *arrayList1=[(NSDictionary*)anUpdate objectForKey:@"assname"];
        
      //  //NSLog(@"self.assesment.count:%i",[self.assesment count]);
        
        if([self.assesment count]==0)
        {
            [recordDict setObject:arrayList forKey:@"id"];
            [recordDict setObject:arrayList1 forKey:@"name"];
            [instance insertAssesment:recordDict];
            
            
            
            NSDictionary *arrayList2=[(NSDictionary*)anUpdate objectForKey:@"assessment"];
            
            for (id anUpdate in arrayList2)
            {
                
                [recordDict setObject:arrayList forKey:@"assid"];
                ////NSLog(@"assid:%@",arrayList);
                [recordDict setObject:arrayList1 forKey:@"assname"];
             //   [instance insertAss:recordDict];
                
                
                NSDictionary *arrayListid=[(NSDictionary*)anUpdate objectForKey:@"assquestionid"];
                NSDictionary *arrayList1=[(NSDictionary*)anUpdate objectForKey:@"assquestion"];
                NSDictionary *arrayList2=[(NSDictionary*)anUpdate objectForKey:@"assparentquestionid"];
                NSDictionary *arrayList3=[(NSDictionary*)anUpdate objectForKey:@"assparentanswerid"];
                
                [recordDict setObject:arrayListid forKey:@"assquestionid"];
                
                
                [recordDict setObject:arrayList1 forKey:@"assquestion"];
                [recordDict setObject:arrayList2 forKey:@"assparentquestionid"];
                [recordDict setObject:arrayList3 forKey:@"assparentanswerid"];
                [instance insertAss:recordDict];
                
                
                
                
                
                //**************ANSWERS*************
                NSDictionary *arrayList22=[(NSDictionary*)anUpdate objectForKey:@"answer"];
                for (id anUpdate in arrayList22)
                {
                    
                    
                  //  //NSLog(@"RAJA");
                    [recordDict setObject:arrayList forKey:@"assid"];
                  //  [instance insertAnswer:recordDict];
                    
                    
                    NSDictionary *arrayList1=[(NSDictionary*)anUpdate objectForKey:@"assanswerid"];
                    NSDictionary *arrayList2=[(NSDictionary*)anUpdate objectForKey:@"assanswer"];
                    [recordDict setObject:arrayList1 forKey:@"ansid"];
                    [recordDict setObject:arrayList2 forKey:@"answer"];
                    [instance insertAnswer:recordDict];
                    
                //    //NSLog(@"recordDict:R%@",recordDict);
                  
                }
              
                
                
            }
            
        }
        else
        {
            Add=0;
            for(int j=0;j<[self.assesment count];j++)
            {
                NSString*s1= [[self.assesment objectAtIndex:j] objectForKey:@"id"];
                NSString*s=[(NSDictionary*)anUpdate objectForKey:@"assid"];
          //  //NSLog(@"AAAAAAAAAAs1:%@",s);
              //  //NSLog(@"s:%@",s);
                if(![s1 isEqualToString:s])
                {
                    Add++;
                  /* 
                    
                    */
                    
                }
                
            }
            
            if(Add==[self.assesment count])
            {
                [recordDict setObject:arrayList forKey:@"id"];
                [recordDict setObject:arrayList1 forKey:@"name"];
                [instance insertAssesment:recordDict];
                
                
                
                NSDictionary *arrayList2=[(NSDictionary*)anUpdate objectForKey:@"assessment"];
                
                for (id anUpdate in arrayList2)
                {
                    
                    [recordDict setObject:arrayList forKey:@"assid"];
                    ////NSLog(@"assid:%@",arrayList);
                    [recordDict setObject:arrayList1 forKey:@"assname"];
                    //[instance insertAss:recordDict];
                    
                    
                    NSDictionary *arrayListid=[(NSDictionary*)anUpdate objectForKey:@"assquestionid"];
                    NSDictionary *arrayList1=[(NSDictionary*)anUpdate objectForKey:@"assquestion"];
                    NSDictionary *arrayList2=[(NSDictionary*)anUpdate objectForKey:@"assparentquestionid"];
                    NSDictionary *arrayList3=[(NSDictionary*)anUpdate objectForKey:@"assparentanswerid"];
                    
                    [recordDict setObject:arrayListid forKey:@"assquestionid"];
                    
                    
                    [recordDict setObject:arrayList1 forKey:@"assquestion"];
                    [recordDict setObject:arrayList2 forKey:@"assparentquestionid"];
                    [recordDict setObject:arrayList3 forKey:@"assparentanswerid"];
                    [instance insertAss:recordDict];
                    
                    
                    
                    
                    
                    //**************ANSWERS*************
                    NSDictionary *arrayList22=[(NSDictionary*)anUpdate objectForKey:@"answer"];
                    for (id anUpdate in arrayList22)
                    {
                        
                        [recordDict setObject:arrayList forKey:@"assid"];
                    //    [instance insertAnswer:recordDict];
                        
                        NSDictionary *arrayList1=[(NSDictionary*)anUpdate objectForKey:@"assanswerid"];
                        NSDictionary *arrayList2=[(NSDictionary*)anUpdate objectForKey:@"assanswer"];
                      
                        
                        [recordDict setObject:arrayList1 forKey:@"ansid"];
                        [recordDict setObject:arrayList2 forKey:@"answer"];
                        [instance insertAnswer:recordDict];
                    }
                }
             //   //NSLog(@"RAJAADDASS");
            }
            
            
            
            
        }
        
        
             
        
    }
    
    //********************ASSESSMENT   END***********************************************??//
    
    
    
    
    
    
    
    
    
    NSMutableArray*tempM=[[NSMutableArray alloc]init];
    for (id anUpdate in items1)
    {
        NSDictionary *arrayList1=[(NSDictionary*)anUpdate objectForKey:@"serviceresponse"];
    //NSLog(@"MEDI NAME:%@",[arrayList1 objectForKey:@"medicinename"]);
        //  ////NSLog(@"DIRECTION:%@",[arrayList1 objectForKey:@"direction"]);
        
        [tempM addObject:[arrayList1 objectForKey:@"medicinename"]];
        
      
        
    }
    
  //    ////NSLog(@"PETARRAYCOUNT::%i",[petArray count]);
    
    if([petArray count]==0)
    {
        for(int j=0;j<[tempM count];j++)
        {
            [recordDict setObject:[tempM objectAtIndex:j] forKey:@"name"];
            [instance insertPet:recordDict];
            
        }
    }
    else
    {
        
        
        int xx=0;
        for(int i=0;i<[tempM count];i++)
        {
            xx=0;
            for(int j=0;j<[petArray count];j++)
            {
                
                NSString*s=[tempM objectAtIndex:i];
                NSString*s1= [[petArray objectAtIndex:j] objectForKey:@"name"];
                
               //NSLog(@"PPPPPPPPPPPPPP:%@ %@",s,s1);
                
                if([s isEqualToString:s1])
                {
                    
                }
                else {
                    
                    xx++;
                    
                    if(xx==[petArray count])
                    {
                        xx=0;
                        ////NSLog(@"raja");
                        [recordDict setObject:[tempM objectAtIndex:i] forKey:@"name"];
                        [instance insertPet:recordDict];
                        //  [_AppDArr addObject:[tempM objectAtIndex:i]];
                        
                        
                    }
                }
            }
        }
    }
    
    
    
    
    
    //NSLog(@"Petarrat:%@",self.petArray);
    
    
    
    
    
    
    
    
    
    /********************AppoinMent********************/
    
    NSMutableArray*temp=[[NSMutableArray alloc]init];
    NSMutableArray*temp1=[[NSMutableArray alloc]init];
    for (id anUpdate1 in items1App)
    {
        NSDictionary *arrayList1=[(NSDictionary*)anUpdate1 objectForKey:@"serviceresponse"];
        
        
        [temp addObject:[arrayList1 objectForKey:@"appdate"]];
        [temp1 addObject:[arrayList1 objectForKey:@"appnotes"]];
        
        
    }
    
    
    
    
    
    if([_AppDArr count]==0&&[_AppNArr count]==0)
    {
        for(int j=0;j<[temp count];j++)
        {
            [_AppDArr addObject:[temp objectAtIndex:j]];
            [_AppNArr addObject:[temp1 objectAtIndex:j]];
        }
    }
    else {
        int x=0;
        for(int i=0;i<[temp1 count];i++)
        {
            x=0;
            for(int j=0;j<[_AppNArr count];j++)
            {
                
                NSString*s=[temp1 objectAtIndex:i];
                NSString*s1=[_AppNArr objectAtIndex:j];
                
                if([s isEqualToString:s1])
                {
                    
                }
                else {
                    
                    x++;
                    
                    if(x==[_AppNArr count])
                    {
                        x=0;
                        
                        [_AppDArr addObject:[temp objectAtIndex:i]];
                        [_AppNArr addObject:[temp1 objectAtIndex:i]];
                        
                    }
                }
            }
            
            
            
        }
        
    }
    
    
    
    [fileMngr saveDatapath:appoFile contentarray:_AppDArr];
    [fileMngr saveDatapath:appoNFile contentarray:_AppNArr];
    
    
//    ////NSLog(@"%@",self._assQues);
     //NSLog(@"self._assAns:%@",self._assAns);
    
     // [HUD hide:YES];
    HUD.labelText = @"Completed.";
    HUD.customView = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"37x-Checkmark.png"]] autorelease];
	HUD.mode = MBProgressHUDModeCustomView;
    [HUD hide:YES afterDelay:0];
    
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return 1;
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return [reminderarray count];
}
- (UITableViewCell *)tableView:(UITableView *)aTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
#if USE_CUSTOM_DRAWING
	const NSInteger TOP_LABEL_TAG = 1001;
	const NSInteger BOTTOM_LABEL_TAG = 1002;
	UILabel *topLabel;
	UILabel *bottomLabel;
#endif
    
	static NSString *CellIdentifier = @"Cell";
	UITableViewCell *cell = [aTableView dequeueReusableCellWithIdentifier:CellIdentifier];
	if (cell == nil)
	{
		
		cell =[[[UITableViewCell alloc]initWithFrame:CGRectZero
                                     reuseIdentifier:CellIdentifier]
               autorelease];
        
#if USE_CUSTOM_DRAWING
		UIImage *indicatorImage = [UIImage imageNamed:@"indicator.png"];
		cell.accessoryView =
        [[[UIImageView alloc]
          initWithImage:nil]
         autorelease];
		
		const CGFloat LABEL_HEIGHT = 20;
		UIImage *image = [UIImage imageNamed:@"imageA.png"];
        
		//
		// Create the label for the top row of text
		//
		topLabel =
        [[[UILabel alloc]
          initWithFrame:
          CGRectMake(
                     image.size.width + 2.0 * cell.indentationWidth,
                     0.5 * (aTableView.rowHeight - 2 * LABEL_HEIGHT),
                     aTableView.bounds.size.width -
                     image.size.width - 4.0 * cell.indentationWidth
                     - indicatorImage.size.width,
                     LABEL_HEIGHT)]
         autorelease];
		[cell.contentView addSubview:topLabel];
        
		//
		// Configure the properties for the text that are the same on every row
		//
		topLabel.tag = TOP_LABEL_TAG;
		topLabel.backgroundColor = [UIColor clearColor];
		topLabel.textColor = [UIColor colorWithRed:0.25 green:0.0 blue:0.0 alpha:1.0];
		topLabel.highlightedTextColor = [UIColor colorWithRed:1.0 green:1.0 blue:0.9 alpha:1.0];
		topLabel.font = [UIFont systemFontOfSize:[UIFont labelFontSize]];
        
		//
		// Create the label for the top row of text
		//
		bottomLabel =
        [[[UILabel alloc]
          initWithFrame:
          CGRectMake(
                     image.size.width + 2.0 * cell.indentationWidth,
                     0.5 * (aTableView.rowHeight - 2 * LABEL_HEIGHT) + LABEL_HEIGHT,
                     aTableView.bounds.size.width -
                     image.size.width - 4.0 * cell.indentationWidth
                     - indicatorImage.size.width,
                     LABEL_HEIGHT)]
         autorelease];
		[cell.contentView addSubview:bottomLabel];
        
		//
		// Configure the properties for the text that are the same on every row
		//
		bottomLabel.tag = BOTTOM_LABEL_TAG;
		bottomLabel.backgroundColor = [UIColor clearColor];
		bottomLabel.textColor = [UIColor colorWithRed:0.25 green:0.0 blue:0.0 alpha:1.0];
		bottomLabel.highlightedTextColor = [UIColor colorWithRed:1.0 green:1.0 blue:0.9 alpha:1.0];
		bottomLabel.font = [UIFont systemFontOfSize:[UIFont labelFontSize] - 2];
        
		//
		// Create a background image view.
		//
		cell.backgroundView =
        [[[UIImageView alloc] init] autorelease];
		cell.selectedBackgroundView =
        [[[UIImageView alloc] init] autorelease];
#endif
	}
    
#if USE_CUSTOM_DRAWING
	else
	{
		topLabel = (UILabel *)[cell viewWithTag:TOP_LABEL_TAG];
		bottomLabel = (UILabel *)[cell viewWithTag:BOTTOM_LABEL_TAG];
	}
	
    
    
   // NSArray *notificationArray = [[UIApplication sharedApplication] scheduledLocalNotifications];
	UILocalNotification *notif = [reminderarray objectAtIndex:indexPath.row];
	//cell.textLabel.font=[UIFont fontWithName:@"Arial" size:30];
    // [cell.textLabel setText:notif.alertBody];
    // cell.detailTextLabel.textColor = [UIColor greenColor];
	//[cell.detailTextLabel setText:[notif.fireDate description]];
    
    
	topLabel.text = notif.alertBody;
	bottomLabel.text =[notif.fireDate descriptionWithLocale:[[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]autorelease]] ;
	
	
	UIImage *rowBackground;
	UIImage *selectionBackground;
	NSInteger sectionRows = [aTableView numberOfRowsInSection:[indexPath section]];
	NSInteger row = [indexPath row];
	if (row == 0 && row == sectionRows - 1)
	{
		rowBackground = [UIImage imageNamed:@"Normal.png"];
		selectionBackground = [UIImage imageNamed:@"Higlight.png"];
	}
	else if (row == 0)
	{
		rowBackground = [UIImage imageNamed:@"Normal.png"];
		selectionBackground = [UIImage imageNamed:@"Higlight.png"];
	}
	else if (row == sectionRows - 1)
	{
		rowBackground = [UIImage imageNamed:@"Normal.png"];
		selectionBackground = [UIImage imageNamed:@"Higlight.png"];
	}
	else
	{
		rowBackground = [UIImage imageNamed:@"Normal.png"];
		selectionBackground = [UIImage imageNamed:@"Higlight.png"];
	}
	((UIImageView *)cell.backgroundView).image = rowBackground;
	((UIImageView *)cell.selectedBackgroundView).image = selectionBackground;
	
	//
	// Here I set an image based on the row. This is just to have something
	// colorful to show on each row.
	//
	
#else
	cell.text = [NSString stringWithFormat:@"Cell at row %ld.", [indexPath row]];
#endif
	
	return cell;
}




#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}








-(IBAction)back1;
{
    
    [[self navigationController] popViewControllerAnimated:YES];
}
- (void)viewWillAppear:(BOOL)animated
{
    int syncType=[[NSUserDefaults standardUserDefaults]integerForKey:@"syncType"];
      instance = [AppSharedInstance sharedInstance];
    self._assQues=[instance getAssQue];
    self._assAns=[instance getAssAnswer];
    self.assesment=[instance getAssesment];
    [myTable reloadData];
    //NSLog(@"self._assAns:::%@",self._assQues);
    ////NSLog(@"self._assAnswer:::%@",self._assAns);
    
    if(syncType==1)
    {
        if(self.navigationItem.rightBarButtonItem==nil)
        {
            UIButton *save = [UIButton buttonWithType:UIButtonTypeCustom];
            UIImage *saveImage = [UIImage imageNamed:@"Sync.png"]  ;
            [save setBackgroundImage:saveImage forState:UIControlStateNormal];
            [save addTarget:self action:@selector(sunc:)
           forControlEvents:UIControlEventTouchUpInside];
            save.frame = CGRectMake(0, 0, 80, 40);
            saveButton = [[[UIBarButtonItem alloc]
                           initWithCustomView:save] autorelease];
            
              self.navigationItem.rightBarButtonItem = saveButton;
        }
        else
        {
         self.navigationItem.rightBarButtonItem = saveButton;
        }
        
    }
    else
    {
        if(self.navigationItem.rightBarButtonItem!=nil)
        {
          self.navigationItem.rightBarButtonItem = nil;
        }
    }
    

    
    reminderarray=[[NSMutableArray alloc]init];
    
    NSArray *notificationArray = [[UIApplication sharedApplication] scheduledLocalNotifications];
    for(int i=0;i<[notificationArray count];i++)
    {
        UILocalNotification *notif = [notificationArray objectAtIndex:i];
        NSDictionary *userInfoCurrent = notif.userInfo;
        
        NSDate *dateCurrent = [userInfoCurrent valueForKey:@"date"];
        //  ////NSLog(@"Found scheduled alarm with date:%@", userInfoCurrent );
        
        
        [reminderarray addObject:notif];
        
        NSDateFormatter* df = [[NSDateFormatter alloc]init];
        [df setDateFormat:@"MM/dd/yyyy"];
        NSString *result = [df stringFromDate:dateCurrent];
        [df release];
        
        
        
        NSDate* date = [NSDate date];
        NSDateFormatter* df1 = [[NSDateFormatter alloc]init];
        [df1 setDateFormat:@"MM/dd/yyyy"];
        NSString *result1 = [df1 stringFromDate:date];
        
        
        
        if([result isEqualToString:result1])
        {
            ////NSLog(@"result schedulh date:%@", result );
            ////NSLog(@"Result1:::::::%@", result1);
            //   [reminderarray addObject:notif];
        }
        
        
        
        /*NSInteger nWords = 10;
         NSRange wordRange = NSMakeRange(0,10);
         NSArray *firstWords = [[[NSString stringWithFormat:@"%@",userInfoCurrent] componentsSeparatedByString:@" "] subarrayWithRange:wordRange];
         NSString *result = [firstWords componentsJoinedByString:@" "];
         ////NSLog(@"RESULT:%@",result);*/
    }
    

        
      [myTable reloadData];
    
        
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
     myTable.backgroundColor = [UIColor clearColor];
    reminderarray=[[NSMutableArray alloc]init];
    
    NSArray *notificationArray = [[UIApplication sharedApplication] scheduledLocalNotifications];
    for(int i=0;i<[notificationArray count];i++)
    {
    UILocalNotification *notif = [notificationArray objectAtIndex:i];
        NSDictionary *userInfoCurrent = notif.userInfo;
        
        NSDate *dateCurrent = [userInfoCurrent valueForKey:@"date"];
      //  ////NSLog(@"Found scheduled alarm with date:%@", userInfoCurrent );
        
        
         [reminderarray addObject:notif];
        
        NSDateFormatter* df = [[NSDateFormatter alloc]init];
        [df setDateFormat:@"MM/dd/yyyy"];
        NSString *result = [df stringFromDate:dateCurrent];
        [df release];
   
        
        
        NSDate* date = [NSDate date];
        NSDateFormatter* df1 = [[NSDateFormatter alloc]init];
        [df1 setDateFormat:@"MM/dd/yyyy"];
        NSString *result1 = [df1 stringFromDate:date];
       
        
        
        if([result isEqualToString:result1])
        {
                ////NSLog(@"result schedulh date:%@", result );
            ////NSLog(@"Result1:::::::%@", result1);
          //   [reminderarray addObject:notif];
        }
        
       
        
        /*NSInteger nWords = 10;
        NSRange wordRange = NSMakeRange(0,10);
        NSArray *firstWords = [[[NSString stringWithFormat:@"%@",userInfoCurrent] componentsSeparatedByString:@" "] subarrayWithRange:wordRange];
        NSString *result = [firstWords componentsJoinedByString:@" "];
        ////NSLog(@"RESULT:%@",result);*/
    }
    
    
    ADLivelyTableView * livelyTableView = (ADLivelyTableView *)myTable;
    livelyTableView.initialCellTransformBlock = ADLivelyTransformFan;
    
    myTable.rowHeight=100;
	myTable.separatorColor = [UIColor clearColor];
    
    UIButton *home = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *homeImage = [UIImage imageNamed:@"Back.jng"]  ;
    [home setBackgroundImage:homeImage forState:UIControlStateNormal];
    [home addTarget:self action:@selector(back)
   forControlEvents:UIControlEventTouchUpInside];
    home.frame = CGRectMake(0, 0, 50, 30);
    UIBarButtonItem *cancelButton = [[[UIBarButtonItem alloc]
                                      initWithCustomView:home] autorelease];
    self.navigationItem.leftBarButtonItem = cancelButton;
    
    
    UILabel *label = [[[UILabel alloc] initWithFrame:CGRectZero] autorelease];
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont boldSystemFontOfSize:20.0];
    label.shadowColor = [UIColor colorWithWhite:0.0 alpha:0.5];
    label.textAlignment = UITextAlignmentCenter;
    label.textColor = [UIColor whiteColor]; // change this color
    self.navigationItem.titleView = label;
    label.text = NSLocalizedString(@"Medication Monitor", @"");
    [label sizeToFit];
    
    
    
    UIButton *save = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *saveImage = [UIImage imageNamed:@"Sync.png"]  ;
    [save setBackgroundImage:saveImage forState:UIControlStateNormal];
    [save addTarget:self action:@selector(sunc:)
   forControlEvents:UIControlEventTouchUpInside];
    save.frame = CGRectMake(0, 0, 80, 40);
    saveButton = [[[UIBarButtonItem alloc]
                                    initWithCustomView:save] autorelease];
   
    
    int syncType=[[NSUserDefaults standardUserDefaults]integerForKey:@"syncType"];
    
    if(syncType==1)
    {
    
       self.navigationItem.rightBarButtonItem = saveButton;
        
    }
    else
    {
       //  syn.hidden=YES;
    }
    
    
    
    instance = [AppSharedInstance sharedInstance];
 
  
    if ([recordDict count]>0) {
	
             ////NSLog(@"recordDictA:%@",recordDict);
	}
	else {
		recordDict = [[NSMutableDictionary alloc] init];
	}
    
      //  [recordDict setObject:@"RAJA" forKey:@"name"];
	//	[instance insertPet:recordDict];
    
    
    
    
    NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *docDirectory = [path objectAtIndex:0];
    
	appoFile=[[NSString alloc] initWithString:[docDirectory stringByAppendingPathComponent:@"appoFile.hsa"]];
    	appoNFile=[[NSString alloc] initWithString:[docDirectory stringByAppendingPathComponent:@"appoNFile.hsa"]];
    
    
	if ([[NSFileManager defaultManager] fileExistsAtPath:appoFile]) 
	{
		_AppDArr=[[NSMutableArray alloc]initWithArray:[fileMngr fetchDatafrompath:appoFile]];
		
	}
	else
	{
		_AppDArr=[[NSMutableArray alloc]init];
	}
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:appoNFile]) 
	{
		_AppNArr=[[NSMutableArray alloc]initWithArray:[fileMngr fetchDatafrompath:appoNFile]];
		
	}
	else
	{
		_AppNArr=[[NSMutableArray alloc]init];
	}

    
    
    
    
    
   
    
    /********************AppoinMent   End********************/
    
   // ////NSLog(@"APP-D-ARRA:%i",[_AppDArr count]);
  //  ////NSLog(@"APP-N-ARR:%i",[_AppNArr count]);
    NSString*name=[[NSUserDefaults standardUserDefaults] objectForKey:@"username"];
     
    NSString *runNumber = [[NSUserDefaults standardUserDefaults] objectForKey:@"loginid"];
 /*   __block DemoHintView* hintView = [DemoHintView  infoHintView];
    hintView.hintID = kHintID_Home;
    hintView.title = @"Welcome!";
    [hintView addPageWithTitle:@"Info" text:name];
    [hintView showInView:self.view orientation:kHintViewOrientationTop];*/
    
    
    BlockAlertView *alert = [BlockAlertView alertWithTitle:@"Welcome!" message:name];
    welcome.text=[NSString stringWithFormat:@"Welcome : %@",name];
    //  [alert setCancelButtonWithTitle:@"Cancel" block:nil];
    [alert setDestructiveButtonWithTitle:@"x" block:nil];
    [alert show];
    
    
    [myTable reloadData];
    
  

    
   
}




//Apponment
-(NSString *)HttpPostEntityFirst:(NSString*)firstEntity ForValue1:(NSString*)value1  EntityThird:(NSString*)thirdEntity ForValue3:(NSString*)value3
{
    
    HUD.labelText = @"Feteching Apoinments...";
    
    NSString *post =[[NSString alloc] initWithFormat:@"%@=%@&%@=%@",firstEntity,value1,thirdEntity,value3];
    NSURL *url=[NSURL URLWithString:@"http://www.medsmonit.com/Service/appointmentresponce.php?service=appdetail"];
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
    
    NSMutableURLRequest *request = [[[NSMutableURLRequest alloc] init] autorelease];
    [request setURL:url];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    
    NSError *error;
    NSURLResponse *response;
    NSData *urlData=[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    
    NSString *data=[[NSString alloc]initWithData:urlData encoding:NSUTF8StringEncoding];
    
    
  
    
    return data;
    
}













-(NSString *)HttpPostEntityFirst1:(NSString*)firstEntity ForValue1:(NSString*)value1  EntityThird:(NSString*)thirdEntity ForValue3:(NSString*)value3
{
    
        HUD.labelText = @"Feteching Medicines...";
    NSString *post =[[NSString alloc] initWithFormat:@"%@=%@&%@=%@",firstEntity,value1,thirdEntity,value3];
    
  
    
    
    NSURL *url=[NSURL URLWithString:@"http://www.medsmonit.com/Service/medicineresponce.php?service=patmeddetail"];
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
    
    NSMutableURLRequest *request = [[[NSMutableURLRequest alloc] init] autorelease];
    [request setURL:url];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    
        NSError *error;
    NSURLResponse *response;
    NSData *urlData=[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    
    NSString *data=[[NSString alloc]initWithData:urlData encoding:NSUTF8StringEncoding];
    
    
       
    return data;
    
}






//Assessment
-(NSString *)HttpPostEntityFirstASS:(NSString*)firstEntity ForValue1:(NSString*)value1  EntityThird:(NSString*)thirdEntity ForValue3:(NSString*)value3
{
    
       HUD.labelText = @"Feteching Assesments...";
    NSString *post =[[NSString alloc] initWithFormat:@"%@=%@&%@=%@",firstEntity,value1,thirdEntity,value3];
    
    
    
    
    NSURL *url=[NSURL URLWithString:@"http://www.medsmonit.com/Service/questionresponce.php?service=question"];
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
    
    NSMutableURLRequest *request = [[[NSMutableURLRequest alloc] init] autorelease];
    [request setURL:url];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    
    NSError *error;
    NSURLResponse *response;
    NSData *urlData=[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    
    NSString *data=[[NSString alloc]initWithData:urlData encoding:NSUTF8StringEncoding];
    
    
    
    
    return data;
    
}


-(NSString *)HttpPostEntityFirstREMINDER:(NSString*)firstEntity ForValue1:(NSString*)value1  EntityThird:(NSString*)thirdEntity ForValue3:(NSString*)value3
{
    HUD.labelText = @"Feteching reminders...";
    
    NSString *post =[[NSString alloc] initWithFormat:@"%@=%@&%@=%@",firstEntity,value1,thirdEntity,value3];
    
    
    
    
    NSURL *url=[NSURL URLWithString:@"http://www.medsmonit.com/Service/reminderresponce.php?service=reminder"];
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
    
    NSMutableURLRequest *request = [[[NSMutableURLRequest alloc] init] autorelease];
    [request setURL:url];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    
    NSError *error;
    NSURLResponse *response;
    NSData *urlData=[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    
    NSString *data=[[NSString alloc]initWithData:urlData encoding:NSUTF8StringEncoding];
    
    
    
    
    return data;
    
}


-(NSString *)HttpPostEntityFirstPROVIDER:(NSString*)firstEntity ForValue1:(NSString*)value1  EntityThird:(NSString*)thirdEntity ForValue3:(NSString*)value3
{
    
    
    HUD.labelText = @"Feteching ProvidersRequests..";
    NSString *post =[[NSString alloc] initWithFormat:@"%@=%@&%@=%@",firstEntity,value1,thirdEntity,value3];
    
    
    
    
    NSURL *url=[NSURL URLWithString:@"http://www.medsmonit.com/Service/requestresponce.php?service=providerlist"];
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
    
    NSMutableURLRequest *request = [[[NSMutableURLRequest alloc] init] autorelease];
    [request setURL:url];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    
    NSError *error;
    NSURLResponse *response;
    NSData *urlData=[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    
    NSString *data=[[NSString alloc]initWithData:urlData encoding:NSUTF8StringEncoding];
    
    
    
    
    return data;
    
}





-(NSString *)HttpPostEntityFirst_listOfPro:(NSString*)firstEntity ForValue1:(NSString*)value1  EntityThird:(NSString*)thirdEntity ForValue3:(NSString*)value3
{
    
    HUD.labelText = @"Feteching Providers...";
    NSString *post =[[NSString alloc] initWithFormat:@"%@=%@&%@=%@",firstEntity,value1,thirdEntity,value3];
    
    
    
    
    NSURL *url=[NSURL URLWithString:@"http://www.medsmonit.com/Service/requestresponce.php?service=providers"];
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
    
    NSMutableURLRequest *request = [[[NSMutableURLRequest alloc] init] autorelease];
    [request setURL:url];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    
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
