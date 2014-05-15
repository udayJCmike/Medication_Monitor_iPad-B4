#import "NewViewController.h"
#import "fileMngr.h"
#import "JSON/JSON.h"
#import <QuartzCore/QuartzCore.h>
#import "MBProgressHUD.h"
#import "BlockAlertView.h"
#define USE_CUSTOM_DRAWING 1
#define USE_CUSTOM_DRAWING 1
@implementation NewViewController
-(void)back
{
    
    [[self navigationController] popViewControllerAnimated:YES];
}



- (void)segmentedControlChangedValue:(SVSegmentedControl*)segmentedControl
{
    if(segmentedControl.selectedIndex==0)
    {
        myTable.hidden=YES;
        myTable1.hidden=NO;
    }
    else if(segmentedControl.selectedIndex==1)
    {
        myTable.hidden=NO;
        myTable1.hidden=YES;
    }
    
    
}


- (void)viewDidLoad {
 
  [super viewDidLoad];
    
    if([[UINavigationBar class] respondsToSelector:@selector(appearance)]) //iOS >=5.0
    {
        [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"Top_Panel.png"] forBarMetrics:UIBarMetricsDefault];
        
        
    }
    
    prodId=@"";
    
    SVSegmentedControl *redSC = [[SVSegmentedControl alloc] initWithSectionTitles:[NSArray arrayWithObjects:@"My Providers    ", @"Provider List  ", nil]];
    [redSC addTarget:self action:@selector(segmentedControlChangedValue:) forControlEvents:UIControlEventValueChanged];
	redSC.titleEdgeInsets = UIEdgeInsetsMake(0, 14, 0, 94);
	redSC.crossFadeLabelsOnDrag = YES;
    
	redSC.thumb.tintColor = [UIColor redColor];
    redSC. font = [UIFont boldSystemFontOfSize:20];
    redSC.height=55;
     [self.view addSubview:redSC];
	
	redSC.center = CGPointMake(384, 408);
    redSC.tag = 2;
    
    NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *docDirectory = [path objectAtIndex:0];
    
	NSString*ProDFile=[[NSString alloc] initWithString:[docDirectory stringByAppendingPathComponent:@"ProDFile"]];
    NSString*ProNamfile=[[NSString alloc] initWithString:[docDirectory stringByAppendingPathComponent:@"ProNamfile"]];
    
    
    NSString*ProDFilel=[[NSString alloc] initWithString:[docDirectory stringByAppendingPathComponent:@"ProDFilel"]];
    NSString*ProNamfilel=[[NSString alloc] initWithString:[docDirectory stringByAppendingPathComponent:@"ProNamfilel"]];
  
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:ProDFile])
	{
		_pId=[[NSMutableArray alloc]initWithArray:[fileMngr fetchDatafrompath:ProDFile]];
		
	}
	else
	{
		_pId=[[NSMutableArray alloc]init];
	}
    
    
 
    if ([[NSFileManager defaultManager] fileExistsAtPath:ProNamfile])
	{
		_pName=[[NSMutableArray alloc]initWithArray:[fileMngr fetchDatafrompath:ProNamfile]];
		
	}
	else
	{
		_pName=[[NSMutableArray alloc]init];
	}
    
  
    
    
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:ProDFile])
	{
		_pIdl=[[NSMutableArray alloc]initWithArray:[fileMngr fetchDatafrompath:ProDFilel]];
		
	}
	else
	{
		_pIdl=[[NSMutableArray alloc]init];
	}
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:ProNamfilel])
	{
		_pNamel=[[NSMutableArray alloc]initWithArray:[fileMngr fetchDatafrompath:ProNamfilel]];
		
	}
	else
	{
		_pNamel=[[NSMutableArray alloc]init];
	}


         //NSLog(@"_pIdl:%@ %@",_pIdl,_pNamel);
    
    UILabel *label = [[[UILabel alloc] initWithFrame:CGRectZero] autorelease];
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont boldSystemFontOfSize:20.0];
    label.shadowColor = [UIColor colorWithWhite:0.0 alpha:0.5];
    label.textAlignment = UITextAlignmentCenter;
    label.textColor = [UIColor whiteColor]; // change this color
    self.navigationItem.titleView = label;
    label.text = NSLocalizedString(@"Settings", @"");
    [label sizeToFit];
    
      myTable.backgroundColor = [UIColor clearColor];
    myTable.rowHeight=120;
	myTable.separatorColor = [UIColor clearColor];
      [myTable reloadData];
    myTable.hidden=YES;
    myTable1.editing=YES;
    
    myTable1.backgroundColor = [UIColor clearColor];
    myTable1.rowHeight=120;
	myTable1.separatorColor = [UIColor clearColor];
    [myTable1 reloadData];
  
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
	
    if(tableView.tag!=1)
    {
	if (editingStyle == UITableViewCellEditingStyleDelete)
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
            
            HUD.delegate =self;
            HUD.labelText = @"Loading...";
            [HUD show:YES];
            
        }

        else
        {
            HUD.labelText = @"Check newtwork connection....";
            HUD.customView = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@""]] autorelease];
            HUD.mode = MBProgressHUDModeCustomView;
            [HUD hide:YES afterDelay:2];
            return;
        }
        
        NSError *error;
        SBJSON *json = [[SBJSON new] autorelease];
         NSString *runNumber = [[NSUserDefaults standardUserDefaults] objectForKey:@"loginid"];
           prodId=[_pIdl objectAtIndex:indexPath.row];
        NSString *resultResponse=[self HttpPostEntityFirst5:@"patid" ForValue1:runNumber EntitySecond:@"authkey" ForValue2:@"rzTFevN099Km39PV"];
        //NSLog(@"resultresponseeeeee:%@",resultResponse);
        
        
        NSString *resultResponsePROVIDER=[self HttpPostEntityFirstPROVIDER:@"patid" ForValue1:runNumber  EntityThird:@"authkey" ForValue3:@"rzTFevN099Km39PV"];
        NSString* _listOfPro=[self HttpPostEntityFirst_listOfPro:@"patid" ForValue1:runNumber  EntityThird:@"authkey" ForValue3:@"rzTFevN099Km39PV"];
        
        NSDictionary *luckyNumbersProvider = [json objectWithString:resultResponsePROVIDER error:&error];
        NSDictionary *Provideritems = [luckyNumbersProvider objectForKey:@"serviceresponse"];
        NSArray *Provideritems1=[Provideritems objectForKey:@"Select Provider"];
        
        NSDictionary *luckyNumberslistofpro = [json objectWithString:_listOfPro error:&error];
        NSDictionary *_listOfProitems = [luckyNumberslistofpro objectForKey:@"serviceresponse"];
        NSArray *_listOfProitems1=[_listOfProitems objectForKey:@"Select Providers"];;

        NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *docDirectory = [path objectAtIndex:0];
        
        NSMutableArray *ProDl=[[NSMutableArray alloc]init];
        NSMutableArray *ProNaml=[[NSMutableArray alloc]init];
        NSString*ProDFilel=[[NSString alloc] initWithString:[docDirectory stringByAppendingPathComponent:@"ProDFilel"]];
        NSString*ProNamfilel=[[NSString alloc] initWithString:[docDirectory stringByAppendingPathComponent:@"ProNamfilel"]];
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
        
        
        
        
     
    
        //NSLog(@"TIMECOUNT:%@",prodId);
		[_pIdl removeObjectAtIndex:indexPath.row];
        [myTable1 reloadData];
        [myTable reloadData];
        [self reload];
	
	}
    }
	
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






- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    //NSLog(@"tableview.tag=%i",tableView.tag);
    if(tableView.tag==1)
    {
	return [_pId count];
    }
    else
    {
        return [_pIdl count];
    }
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
		UIImage *indicatorImage = [UIImage imageNamed:@"Request.png"];
	
        //[[[UIImageView alloc]
          //initWithImage:indicatorImage]
      //   autorelease];
		
		const CGFloat LABEL_HEIGHT = 30;
		UIImage *image = [UIImage imageNamed:@"imageA.png"];
        
		//
		// Create the label for the top row of text
		//
		topLabel =
        [[[UILabel alloc]
          initWithFrame:
          CGRectMake(
                     image.size.width + 2.0 * cell.indentationWidth,
                     0.75 * (aTableView.rowHeight - 2 * LABEL_HEIGHT),
                     aTableView.bounds.size.width -
                     image.size.width - 4.0 * cell.indentationWidth
                     - indicatorImage.size.width,
                     LABEL_HEIGHT)]
         autorelease];
     //   topLabel.center=cell.cen
		[cell.contentView addSubview:topLabel];
        
		//
		// Configure the properties for the text that are the same on every row
		//
		topLabel.tag = TOP_LABEL_TAG;
		topLabel.backgroundColor = [UIColor clearColor];
		topLabel.textColor = [UIColor colorWithRed:255 green:255 blue:255 alpha:1.0];
		topLabel.highlightedTextColor = [UIColor colorWithRed:1.0 green:1.0 blue:0.9 alpha:1.0];
        if(aTableView.tag==1)
        {
            topLabel.font = [UIFont fontWithName:@"Courier" size:30];
        }
        else
        {
            topLabel.font = [UIFont fontWithName:@"Courier-Bold" size:30];
        }
		
        
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
	//UILocalNotification *notif = [reminderarray objectAtIndex:indexPath.row];
	//cell.textLabel.font=[UIFont fontWithName:@"Arial" size:30];
    // [cell.textLabel setText:notif.alertBody];
    // cell.detailTextLabel.textColor = [UIColor greenColor];
	//[cell.detailTextLabel setText:[notif.fireDate description]];
    
    if(aTableView.tag==1)
    {
	topLabel.text =[_pName objectAtIndex:indexPath.row];
    }
    else
    {
        topLabel.text =[_pNamel objectAtIndex:indexPath.row];
    }
	//bottomLabel.text =[_pName objectAtIndex:indexPath.row] ;
	
	
	UIImage *rowBackground;
	UIImage *selectionBackground;
	NSInteger sectionRows = [aTableView numberOfRowsInSection:[indexPath section]];
	NSInteger row = [indexPath row];
	if (row == 0 && row == sectionRows - 1)
	{
		rowBackground = [UIImage imageNamed:@"Strip.png"];
		selectionBackground = [UIImage imageNamed:@""];
	}
	else if (row == 0)
	{
		rowBackground = [UIImage imageNamed:@"Strip.png"];
		selectionBackground = [UIImage imageNamed:@""];
	}
	else if (row == sectionRows - 1)
	{
		rowBackground = [UIImage imageNamed:@"Strip.png"];
		selectionBackground = [UIImage imageNamed:@""];
	}
	else
	{
		rowBackground = [UIImage imageNamed:@"Strip.png"];
		selectionBackground = [UIImage imageNamed:@""];
	}
	((UIImageView *)cell.backgroundView).image = rowBackground;
	((UIImageView *)cell.selectedBackgroundView).image = selectionBackground;
	
	//
	// Here I set an image based on the row. This is just to have something
	// colorful to show on each row.
	//
    
    
      if(aTableView.tag==1)
      {
    UIButton *startButton = [[UIButton alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 120, 44)];
    [startButton setBackgroundImage:[[UIImage imageNamed:@"Request.png"] stretchableImageWithLeftCapWidth:0 topCapHeight:0] forState:UIControlStateNormal];
    [startButton setCenter:CGPointMake(195.0f, 208.0f)];
    startButton.tag=[[_pId objectAtIndex:indexPath.row]intValue];
    [startButton addTarget:self action:@selector(playSound:) forControlEvents:UIControlEventTouchUpInside];
   // [cell addSubview:startButton];
  
  
    cell.accessoryView =startButton;
}
    
	
#else
	cell.text = [NSString stringWithFormat:@"Cell at row %ld.", [indexPath row]];
#endif
	
	return cell;
}

-(void)playSound:(UIButton*)but
{
    //NSLog(@"%i",but.tag);
    str=[NSString stringWithFormat:@"%d",but.tag];
    NSString *runNumber = [[NSUserDefaults standardUserDefaults] objectForKey:@"loginid"];
    // NSString *resultResponse=[self HttpPostEntityFirst1:@"patid" ForValue1:runNumber  EntityThird:@"authkey" ForValue3:@"rzTFevN099Km39PV"];
     NSString *resultResponse=[self HttpPostEntityFirst:@"patid" ForValue1:runNumber EntitySecond:@"authkey" ForValue2:@"rzTFevN099Km39PV"];
    //NSLog(@"resultresponseeeeee:%@",resultResponse);
    
    
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
            
          /*  UIAlertView *alert1 = [[UIAlertView alloc]initWithTitle:@"Info" message:@"Your request has been sent" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
            [alert1 show];*/
           
            BlockAlertView *alert = [BlockAlertView alertWithTitle:@"Info!" message:@"Your request has been sent"];
            
            //  [alert setCancelButtonWithTitle:@"Cancel" block:nil];
            [alert setDestructiveButtonWithTitle:@"x" block:nil];
            [alert show];

            
        }

}
}



-(NSString *)HttpPostEntityFirst:(NSString*)firstEntity ForValue1:(NSString*)value1 EntitySecond:(NSString*)secondEntity ForValue2:(NSString*)value2
{
    
    // NSString *authKey=@"rzTFevN099Km39PV";
    // NSString *userId=@"alagar@ajsquare.net";
    
    
    //NSLog(@"HTTP");
    
    
    
    NSString *post =[[NSString alloc] initWithFormat:@"%@=%@&proid=%@&%@=%@",firstEntity,value1,str,secondEntity,value2];
    
    //  NSString *post =[[NSString alloc] initWithFormat:@"facebook_id=%@&facebookscore=%@&level=%@&life=%@&lifeInHand=%@&gold=%@",value1,value2,value1,value1,value1,value1];
    
    
    NSURL *url=[NSURL URLWithString:@"http://www.medsmonit.com/Service/requestresponce.php?service=addrequest"];
    
    
    
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


-(NSString *)HttpPostEntityFirst5:(NSString*)firstEntity ForValue1:(NSString*)value1 EntitySecond:(NSString*)secondEntity ForValue2:(NSString*)value2
{
    
    // NSString *authKey=@"rzTFevN099Km39PV";
    // NSString *userId=@"alagar@ajsquare.net";
    
    
    //NSLog(@"HTTP");
    
    
       //NSLog(@"asw_pIdl:%@",prodId);
    NSString *post =[[NSString alloc] initWithFormat:@"%@=%@&proid=%@&%@=%@",firstEntity,value1,prodId,secondEntity,value2];
    
    //  NSString *post =[[NSString alloc] initWithFormat:@"facebook_id=%@&facebookscore=%@&level=%@&life=%@&lifeInHand=%@&gold=%@",value1,value2,value1,value1,value1,value1];
    
    
    NSURL *url=[NSURL URLWithString:@"http://www.medsmonit.com/Service/requestresponce.php?service=removerequest"];
    
    
    
    
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
}
-(void)viewWillAppear:(BOOL)animated
{
    NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *docDirectory = [path objectAtIndex:0];
    
	NSString*ProDFile=[[NSString alloc] initWithString:[docDirectory stringByAppendingPathComponent:@"ProDFile"]];
    NSString*ProNamfile=[[NSString alloc] initWithString:[docDirectory stringByAppendingPathComponent:@"ProNamfile"]];
    
    NSString*ProDFilel=[[NSString alloc] initWithString:[docDirectory stringByAppendingPathComponent:@"ProDFilel"]];
    NSString*ProNamfilel=[[NSString alloc] initWithString:[docDirectory stringByAppendingPathComponent:@"ProNamfilel"]];
    
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:ProDFile])
	{
		_pId=[[NSMutableArray alloc]initWithArray:[fileMngr fetchDatafrompath:ProDFile]];
		
	}
	else
	{
		_pId=[[NSMutableArray alloc]init];
	}
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:ProNamfile])
	{
		_pName=[[NSMutableArray alloc]initWithArray:[fileMngr fetchDatafrompath:ProNamfile]];
		
	}
	else
	{
		_pName=[[NSMutableArray alloc]init];
	}
    
    
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:ProDFile])
	{
		_pIdl=[[NSMutableArray alloc]initWithArray:[fileMngr fetchDatafrompath:ProDFilel]];
		
	}
	else
	{
		_pIdl=[[NSMutableArray alloc]init];
	}
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:ProNamfilel])
	{
		_pNamel=[[NSMutableArray alloc]initWithArray:[fileMngr fetchDatafrompath:ProNamfilel]];
		
	}
	else
	{
		_pNamel=[[NSMutableArray alloc]init];
	}

    [myTable reloadData];
    [myTable1 reloadData];
    //NSLog(@"%@",_pId);
    
}

-(void)reload
{
    NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *docDirectory = [path objectAtIndex:0];
    
	NSString*ProDFile=[[NSString alloc] initWithString:[docDirectory stringByAppendingPathComponent:@"ProDFile"]];
    NSString*ProNamfile=[[NSString alloc] initWithString:[docDirectory stringByAppendingPathComponent:@"ProNamfile"]];
    
    NSString*ProDFilel=[[NSString alloc] initWithString:[docDirectory stringByAppendingPathComponent:@"ProDFilel"]];
    NSString*ProNamfilel=[[NSString alloc] initWithString:[docDirectory stringByAppendingPathComponent:@"ProNamfilel"]];
    
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:ProDFile])
	{
		_pId=[[NSMutableArray alloc]initWithArray:[fileMngr fetchDatafrompath:ProDFile]];
		
	}
	else
	{
		_pId=[[NSMutableArray alloc]init];
	}
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:ProNamfile])
	{
		_pName=[[NSMutableArray alloc]initWithArray:[fileMngr fetchDatafrompath:ProNamfile]];
		
	}
	else
	{
		_pName=[[NSMutableArray alloc]init];
	}
    
    
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:ProDFile])
	{
		_pIdl=[[NSMutableArray alloc]initWithArray:[fileMngr fetchDatafrompath:ProDFilel]];
		
	}
	else
	{
		_pIdl=[[NSMutableArray alloc]init];
	}
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:ProNamfilel])
	{
		_pNamel=[[NSMutableArray alloc]initWithArray:[fileMngr fetchDatafrompath:ProNamfilel]];
		
	}
	else
	{
		_pNamel=[[NSMutableArray alloc]init];
	}
    
    [myTable reloadData];
    [myTable1 reloadData];
    
    
    HUD.labelText = @"Completed.";
    HUD.customView = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"37x-Checkmark.png"]] autorelease];
	HUD.mode = MBProgressHUDModeCustomView;
    [HUD hide:YES afterDelay:0];
    
    
    
}
- (void)dealloc {
  
    
  [super dealloc];
}

@end
