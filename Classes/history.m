#import "history.h"
#import "AppSharedInstance.h"
#import "que.h"
#import "SVSegmentedControl.h"
#define USE_CUSTOM_DRAWING 1
#define USE_CUSTOM_DRAWING 1
@implementation history
@synthesize recordDict;



AppSharedInstance *instance;



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return 1;
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    NSLog(@"COUNR:%i",[_Question count]);
        return [_Question count];
   
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
                     40)]
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
		bottomLabel.textColor = [UIColor colorWithRed:0.25 green:0.76 blue:0.0 alpha:1.0];
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
    
    
    NSUInteger row1 = [indexPath row];
    NSUInteger count = [_Question count];
  
  //      topLabel.text =@"RAJA";
        topLabel.frame= CGRectMake(30,10,600,60);
        
        topLabel.text =[NSString stringWithFormat:@"%d.   Q: %@", [indexPath row]+1, [_Question objectAtIndex:indexPath.row]];
       topLabel.numberOfLines = 0;
    
    
    bottomLabel.frame= CGRectMake(35,54,400,60);
    bottomLabel.text = [NSString stringWithFormat:@"        A: %@", [_Answer objectAtIndex:indexPath.row]];
       // bottomLabel.text=[NSString stringWithFormat:@"%@",[[photoArray objectAtIndex:(count-row1-1)]objectForKey:@"date" ]];
    
     
 
	//bottomLabel.text =[notif.fireDate descriptionWithLocale:[[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]autorelease]] ;
	
	
	UIImage *rowBackground;
	UIImage *selectionBackground;
	NSInteger sectionRows = [aTableView numberOfRowsInSection:[indexPath section]];
	NSInteger row = [indexPath row];
	if(aTableView.tag==200)
    {
        
        UIImage *indicatorImage = [UIImage imageNamed:@"Music File.png"];
        cell.accessoryView =
        [[[UIImageView alloc]
          initWithImage:indicatorImage]
         autorelease];
        
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
     //   ((UIImageView *)cell.backgroundView).image = rowBackground;
      //  ((UIImageView *)cell.selectedBackgroundView).image = selectionBackground;
        
        
        
        
        
    }
    else
    {
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
    //    ((UIImageView *)cell.backgroundView).image = rowBackground;
     //   ((UIImageView *)cell.selectedBackgroundView).image = selectionBackground;
    }

	
	//
	// Here I set an image based on the row. This is just to have something
	// colorful to show on each row.
	//
	
#else
	cell.text = [NSString stringWithFormat:@"Cell at row %ld.", [indexPath row]];
#endif
	
	return cell;
}


- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag
{
    if (player == audioPlayerRecord) {
        audioPlayerRecord = nil;
    }
}

#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView.tag==200)
    {
        
       /*
    //    tableView.hidden=YES;
        
     //   ////NSLog(@"raja");
        NSString*str=[[photoArray objectAtIndex:indexPath.row]objectForKey:@"name" ];
    //     ////NSLog(@"str:%@",str);
           // ////NSLog(@"STR:%@",str);
        
        
        if (audioPlayerRecord)
        {
            if (audioPlayerRecord.isPlaying)
                [audioPlayerRecord stop];
            else [audioPlayerRecord play];
            
            return;
        }
        AVAudioSession *audioSession = [AVAudioSession sharedInstance];
        [audioSession setCategory:AVAudioSessionCategoryPlayback error:nil];
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *recDir = [paths objectAtIndex:0];
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@", str]];
        ////NSLog(@"raja:%@",url);
        NSError *error;
        audioPlayerRecord = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:&error];
        audioPlayerRecord.delegate=self;
        [audioPlayerRecord play];*/
          
    }
    else
    {
        
      
    }

}






-(void)displayPhoto {
	
}


-(void)showPhoto:(id)sender
{
    
}






-(void)play
{
       NSString*str=[[NSUserDefaults standardUserDefaults]objectForKey:@"musicAA"];
    if (audioPlayerRecord)
    {
        if (audioPlayerRecord.isPlaying)
            [audioPlayerRecord stop];
        else [audioPlayerRecord play];
        
        return;
    }
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    [audioSession setCategory:AVAudioSessionCategoryPlayback error:nil];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *recDir = [paths objectAtIndex:0];
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@", str]];
    ////NSLog(@"raja:%@",url);
    NSError *error;
    audioPlayerRecord = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:&error];
    audioPlayerRecord.delegate=self;
    [audioPlayerRecord play];
}
-(void)back
{
    
    [[self navigationController] popViewControllerAnimated:YES];
}
- (void)viewDidLoad {
 
  [super viewDidLoad];
   // [self displayPhoto];
    
    
    UIButton *save = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *saveImage = [UIImage imageNamed:@"hisPlay.png"]  ;
    [save setBackgroundImage:saveImage forState:UIControlStateNormal];
    [save addTarget:self action:@selector(play)
     
   forControlEvents:UIControlEventTouchUpInside];
    save.tag=90;
    save.frame = CGRectMake(660, 10, 100, 100);
    [self.view addSubview:save];
    save.hidden=YES;
 
    
    
    
    UIButton *home = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *homeImage = [UIImage imageNamed:@"Back.png"]  ;
    [home setBackgroundImage:homeImage forState:UIControlStateNormal];
    [home addTarget:self action:@selector(back)
   forControlEvents:UIControlEventTouchUpInside];
    home.frame = CGRectMake(0, 0, 50, 30);
    UIBarButtonItem *cancelButton = [[[UIBarButtonItem alloc]
                                      initWithCustomView:home] autorelease];
    self.navigationItem.leftBarButtonItem = cancelButton;
    
    
    
     myTable.backgroundColor = [UIColor clearColor];
    myTable.rowHeight=110;
	myTable.separatorColor = [UIColor clearColor];
    
    
   
     NSString*mus=[[NSUserDefaults standardUserDefaults]objectForKey:@"musicAA"];
    NSLog(@"music:%@",mus);
    
    
    NSString*name=[[NSUserDefaults standardUserDefaults]objectForKey:@"kissname"];
    
    NSString*date=[[NSUserDefaults standardUserDefaults]objectForKey:@"kissdate"];
    if([name isEqualToString:@"1"])
    {
        question.text=@"Daily";
    }
    else if([name isEqualToString:@"3"])
    {
        question.text=@"Monthly";
    }
    
   
    NSString*str=[[NSUserDefaults standardUserDefaults]objectForKey:@"kiss"];
    
    
    //NSLog(@"STE:%@",str);
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *recDir = [paths objectAtIndex:0];
    NSString*p=[NSString stringWithFormat:@"%@/%@recordTest.text", recDir,str];
    NSString*pa=[NSString stringWithFormat:@"%@/%@recordTest.text", recDir,[NSString stringWithFormat:@"A%@",str]];
    
    
    
    
    _Question=[[NSMutableArray alloc]initWithContentsOfFile:p];
    //NSLog(@"STR:%@",_Question);
    _Answer=[[NSMutableArray alloc]initWithContentsOfFile:pa];
    //NSLog(@"STR:%@",_Answer);
    /*NSFileManager*fm=[NSFileManager defaultManager];
    
	NSFileHandle *fh;
	NSData *buf;
    if ([fm fileExistsAtPath:p]==YES)
	{
		//NSLog(@"Yup..!");
		fh=[NSFileHandle fileHandleForReadingAtPath:p];
		if (fh==nil)
		{
			//NSLog(@"Fail To Open");
		}
		else
		{
			buf=[fh readDataToEndOfFile];
			//NSLog(@"File Opened & Copied");
			NSString *str = [[NSString alloc] initWithData:buf encoding:NSUTF8StringEncoding];
           
            _Question=[[NSMutableArray alloc]initWithContentsOfFile:p];
             //NSLog(@"STR:%@",_Question);
            _Answer=[[NSMutableArray alloc]initWithContentsOfFile:pa];
            //NSLog(@"STR:%@",_Answer);
		}
		[fh closeFile];
    }
	else
	{
		//NSLog(@"NO..!");
	}
    
    
    /*NSUserDefaults *currentDefaults = [NSUserDefaults standardUserDefaults];
    NSData *dataRepresentingSavedArray = [currentDefaults objectForKey:str];
    if (dataRepresentingSavedArray != nil)
    {
        NSMutableArray *oldSavedArray = [NSKeyedUnarchiver unarchiveObjectWithData:dataRepresentingSavedArray];
        if (oldSavedArray != nil)
            _Question = [[NSMutableArray alloc] initWithArray:oldSavedArray];
        else
            _Question = [[NSMutableArray alloc] init];
    }
    //NSLog(@"A:%@",_Question);
    
    
    NSUserDefaults *currentDefaults1 = [NSUserDefaults standardUserDefaults];
    NSData *dataRepresentingSavedArray1 = [currentDefaults1 objectForKey:[NSString stringWithFormat:@"A%@",str]];
    //NSLog(@"[NSString stringWithFormastr]:%@",[NSString stringWithFormat:@"A%@",str]);
    if (dataRepresentingSavedArray1 != nil)
    {
        NSMutableArray *oldSavedArray1 = [NSKeyedUnarchiver unarchiveObjectWithData:dataRepresentingSavedArray1];
        if (oldSavedArray1 != nil)
            _Answer = [[NSMutableArray alloc] initWithArray:oldSavedArray1];
        else
            _Answer = [[NSMutableArray alloc] init];
    }
*/
    
    
    
    
    
    number=0;
    
    	instance = [AppSharedInstance sharedInstance];
     
    
    _assQues=[instance getAssesment];
    
  
   
    
    
 
    if ([recordDict count]>0) {
	
	}
	else {
		recordDict = [[NSMutableDictionary alloc] init];
      
	}
    
    
    
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
    label.text = NSLocalizedString(@"Questionnaire?", @"");
    [label sizeToFit];
    
   [myTable reloadData];
   
}


-(void)viewWillAppear:(BOOL)animated
{
    
    
    NSString*mus=[[NSUserDefaults standardUserDefaults]objectForKey:@"musicAA"];
  
    
    if([mus isEqualToString:@""])
    {
          NSLog(@"music:%@",mus);
        [self.view viewWithTag:90].hidden=YES;
    }
    else{
        [self.view viewWithTag:90].hidden=NO;

    }
    NSString*str=[[NSUserDefaults standardUserDefaults]objectForKey:@"kiss"];
    
    
   
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *recDir = [paths objectAtIndex:0];
    NSString*p=[NSString stringWithFormat:@"%@/%@recordTest.text", recDir,str];
    NSString*pa=[NSString stringWithFormat:@"%@/%@recordTest.text", recDir,[NSString stringWithFormat:@"A%@",str]];
     //NSLog(@"STE:%@",p);
    NSFileManager*fm=[NSFileManager defaultManager];
    NSMutableArray* s=[[NSMutableArray alloc]initWithContentsOfFile:p];
    //NSLog(@"STR:%@",s);
    _Question=[[NSMutableArray alloc]initWithArray:s];
    _Answer=[[NSMutableArray alloc]initWithContentsOfFile:pa];
    //NSLog(@"STR:%@",_Question);

    /*
	NSFileHandle *fh;
	NSData *buf;
    if ([fm fileExistsAtPath:p]==YES)
	{
		//NSLog(@"Yup..!");
		fh=[NSFileHandle fileHandleForReadingAtPath:p];
		if (fh==nil)
		{
			//NSLog(@"Fail To Open");
		}
		else
		{
			buf=[fh readDataToEndOfFile];
			//NSLog(@"File Opened & Copied");
			NSString *str = [[NSString alloc] initWithData:buf encoding:NSUTF8StringEncoding];
            
            _Question=[[NSMutableArray alloc]initWithContentsOfFile:p];
            //NSLog(@"STR:%@",_Question);
            _Answer=[[NSMutableArray alloc]initWithContentsOfFile:pa];
            //NSLog(@"STR:%@",_Answer);
		}
		[fh closeFile];
    }
	else
	{
		//NSLog(@"NO..!");
	}
*/
    instance = [AppSharedInstance sharedInstance];
    _assQues=[instance getAssQue];
     //  //NSLog(@"A:%@",_assQues);
    
    if ([recordDict count]>0) {
        
	}
	else {
		recordDict = [[NSMutableDictionary alloc] init];
        
	}
    
    NSString*name=[[NSUserDefaults standardUserDefaults]objectForKey:@"kissname"];
    
    NSString*date=[[NSUserDefaults standardUserDefaults]objectForKey:@"kissdate"];
    //NSLog(@"NAMEEEEEE:%@",name);
            question.text=name;
    Qdate.text=[NSString stringWithFormat:@"Date & Time: %@",date];

    
    
    [myTable reloadData];
    
  
    
    
  
  
         
}




- (void)dealloc {
  
    
  [super dealloc];
}

@end
