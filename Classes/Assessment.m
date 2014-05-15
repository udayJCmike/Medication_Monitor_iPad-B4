#import "Assessment.h"
#import "AppSharedInstance.h"
#import "que.h"
#import "SVSegmentedControl.h"
#import "history.h"
#define USE_CUSTOM_DRAWING 1
#define USE_CUSTOM_DRAWING 1
@implementation Assessment
@synthesize recordDict;

@synthesize _assQues;
@synthesize _assAns;

AppSharedInstance *instance;


-(void)back
{
    
   
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return 1;
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(tableView.tag==200)
    {
        return [photoArray count];
    }
    else{
	return [self._assQues count];
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
		topLabel.font = [UIFont systemFontOfSize:[UIFont labelFontSize]+10];
        
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
//	UILocalNotification *notif = [reminderarray objectAtIndex:indexPath.row];
	//cell.textLabel.font=[UIFont fontWithName:@"Arial" size:30];
    // [cell.textLabel setText:notif.alertBody];
    // cell.detailTextLabel.textColor = [UIColor greenColor];
	//[cell.detailTextLabel setText:[notif.fireDate description]];
    
    
    NSUInteger row1 = [indexPath row];
    NSUInteger count = [photoArray count];
    if(aTableView.tag==200)
    {
        topLabel.text =@"RAJA";
        topLabel.frame= CGRectMake(30,10,800,40);
        
        topLabel.text = [NSString stringWithFormat:@"%@",[[photoArray objectAtIndex:(count-row1-1)]objectForKey:@"type" ]];
        bottomLabel.text=[NSString stringWithFormat:@"%@",[[photoArray objectAtIndex:(count-row1-1)]objectForKey:@"date" ]];
    }
    else
    {
        topLabel.text = [NSString stringWithFormat:@"%@",[[self._assQues objectAtIndex:indexPath.row]objectForKey:@"name" ]];
      
    }
   
 
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
          initWithImage:nil]
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
        ((UIImageView *)cell.backgroundView).image = rowBackground;
        ((UIImageView *)cell.selectedBackgroundView).image = selectionBackground;
        
        
        
        
        
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
        ((UIImageView *)cell.backgroundView).image = rowBackground;
        ((UIImageView *)cell.selectedBackgroundView).image = selectionBackground;
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
        
        NSUInteger row1 = [indexPath row];
        NSUInteger count = [photoArray count];
        NSString*str=[[photoArray objectAtIndex:(count-row1-1)]objectForKey:@"pk" ];
        NSLog(@"pk:%@",str);
        [[NSUserDefaults standardUserDefaults]setObject:str forKey:@"kiss"];
        
        NSString*name=[NSString stringWithFormat:@"%@",[[photoArray objectAtIndex:(count-row1-1)]objectForKey:@"type" ]];
         [[NSUserDefaults standardUserDefaults]setObject:name forKey:@"kissname"];
         //NSLog(@"nameSSSSSSS:%@",name);
        NSString*date=[NSString stringWithFormat:@"%@",[[photoArray objectAtIndex:(count-row1-1)]objectForKey:@"date" ]];
        [[NSUserDefaults standardUserDefaults]setObject:date forKey:@"kissdate"];
       // NSLog(@"DATEEEEE:%@",date);
        
        NSString*str6=[[photoArray objectAtIndex:(count-row1-1)]objectForKey:@"name" ];
         NSLog(@"DATEEEEE:%@",str6);
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@", str]];
    NSLog(@"raja:%@",url);
        [[NSUserDefaults standardUserDefaults]setObject:str6 forKey:@"musicAA"];
        history *aboutmeViewController = [[history alloc] initWithNibName:@"history" bundle:nil];
        aboutmeViewController.recordDict=recordDict;
       // aboutmeViewController.recordDict = [self._assQues objectAtIndex:indexPath.row];
                   [self.navigationController pushViewController:aboutmeViewController animated:YES];
        [aboutmeViewController release];
   
       /* NSString*str=[[photoArray objectAtIndex:indexPath.row]objectForKey:@"name" ];

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
        
        questiontype=[NSString stringWithFormat:@"%@",[[self._assQues objectAtIndex:indexPath.row]objectForKey:@"name" ]];
        [[NSUserDefaults standardUserDefaults] setObject:questiontype forKey:@"questionType"];

        que *aboutmeViewController = [[que alloc] initWithNibName:@"que" bundle:nil];
        aboutmeViewController.recordDict=recordDict;
        aboutmeViewController.recordDict = [self._assQues objectAtIndex:indexPath.row];
        //  ////NSLog(@" aboutmeViewController.recordDict:%@", aboutmeViewController.recordDict);
        
        
        NSNumber *num1 = [[self._assQues objectAtIndex:indexPath.row]objectForKey:@"id" ];
        int theValue1 = [num1 intValue];
        //    ////NSLog(@"[recordDict objectForKey:%i",theValue1);
        [[NSUserDefaults standardUserDefaults] setInteger:theValue1 forKey:@"selectAss"];
        [self.navigationController pushViewController:aboutmeViewController animated:YES];
        [aboutmeViewController release];
    }

}



- (void)segmentedControlChangedValue:(SVSegmentedControl*)segmentedControl
{
    
    
    if(segmentedControl.selectedIndex==0)
    {
     
         myTable.hidden=NO;
        Audio.hidden=YES;
        
        
    }
    else if(segmentedControl.selectedIndex==1)
    {
       myTable.hidden=YES;
        Audio.hidden=NO;
     //   [self displayPhoto];
        
      //  NSURL *url = [[NSUserDefaults standardUserDefaults]URLForKey:@"url"];
        
       //;
        
        //    NSURL *url = [NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/recordTest.caf", [[NSBundle mainBundle] resourcePath]]];
     //   NSError *error;
       // audioPlayerRecord = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:&error];
     //   [audioPlayerRecord play];
      //  ////NSLog(@"Recoder file >");

    }
    
    
}


-(void)displayPhoto {
	
}


-(void)showPhoto:(id)sender
{
    
}





- (void)viewDidLoad {
 
  [super viewDidLoad];
   // [self displayPhoto];
    
    
    
    
  SVSegmentedControl *redSC = [[SVSegmentedControl alloc] initWithSectionTitles:[NSArray arrayWithObjects:@"Questionnaire    ", @"Questionnaire History  ", nil]];
      [redSC addTarget:self action:@selector(segmentedControlChangedValue:) forControlEvents:UIControlEventValueChanged];
    redSC.titleEdgeInsets = UIEdgeInsetsMake(0, 14, 0, 200);
    redSC.crossFadeLabelsOnDrag = YES;
    
    redSC.thumb.tintColor = [UIColor redColor];
    redSC.thumb.textShadowColor = [UIColor colorWithWhite:1 alpha:0.5];
    redSC.thumb.textShadowOffset = CGSizeMake(0, 1);
    redSC. font = [UIFont boldSystemFontOfSize:20];
    redSC.height=50;
    
    // redSC.selectedIndex=1;
    [self.view addSubview:redSC];
    redSC.center = CGPointMake(384, 25);
    redSC.tag = 2;

    
     myTable.backgroundColor = [UIColor clearColor];
    myTable.rowHeight=100;
	myTable.separatorColor = [UIColor clearColor];
     [myTable reloadData];
    
    
    Audio.backgroundColor = [UIColor clearColor];
    Audio.rowHeight=120;
	Audio.separatorColor = [UIColor clearColor];
    [Audio reloadData];

    
    
    _assArray=[[NSMutableArray alloc]init];
    number=0;
    
    	instance = [AppSharedInstance sharedInstance];
     self._assQues=[instance getAssesment];
      self._assAns=[instance getAssAnswer];
    photoArray=[instance getAudio];
    
    
    
   // //NSLog(@"%i",[photoArray count]);
      NSMutableArray*a=[[NSMutableArray alloc]init];
    for(int j=0;j<[photoArray count];j++)
    {
      //  //NSLog(@"yes");
        NSString*s1= [[photoArray objectAtIndex:j] objectForKey:@"patid"];
        NSString *UserId = [[NSUserDefaults standardUserDefaults] objectForKey:@"loginid"];
        //  //NSLog(@"AAAAAAAAAAs1:%@",UserId);
        //  ////NSLog(@"s:%@",s);
        if([s1 isEqualToString:UserId])
        {
            [a addObject:[photoArray objectAtIndex:j]];
            
            
        }
    }
    
    // }
    photoArray=a;
  //  //NSLog(@"YES:%@",photoArray);
   
    
     photoArray = [[photoArray reverseObjectEnumerator] allObjects];
  //  ////NSLog(@"SELF>_ASSAns::::%@",self._assAns);
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
    
  
   
}


-(void)viewWillAppear:(BOOL)animated
{
    instance = [AppSharedInstance sharedInstance];
    
    
  
	//[self displayPhoto];
    
    
    self._assQues=[instance getAssesment];
     self._assAns=[instance getAssAnswer];
    
    
    
    photoArray=[instance getAudio];
    if ([recordDict count]>0) {
        
	}
	else {
		recordDict = [[NSMutableDictionary alloc] init];
        
	}
  ////NSLog(@"SELF>_ASSQUES::::%@",  self._assQues);
   //  ////NSLog(@"SELF>_ASSAns::::%@",  self._assAns);
    
    
    
      photoArray = [instance getAudio];
    
   // //NSLog(@"%i",[photoArray count]);
    NSMutableArray*a=[[NSMutableArray alloc]init];
    for(int j=0;j<[photoArray count];j++)
    {
       // //NSLog(@"yes");
        NSString*s1= [[photoArray objectAtIndex:j] objectForKey:@"patid"];
        NSString *UserId = [[NSUserDefaults standardUserDefaults] objectForKey:@"loginid"];
        //  //NSLog(@"AAAAAAAAAAs1:%@",UserId);
        //  ////NSLog(@"s:%@",s);
        if([s1 isEqualToString:UserId])
        {
            [a addObject:[photoArray objectAtIndex:j]];
            
            
        }
    }
    
    // }
    photoArray=a;
   // //NSLog(@"YES:%@",photoArray);
 //   ////NSLog(@"PHOto:%i",[photoArray count]);
  //   photoArray = [[photoArray reverseObjectEnumerator] allObjects];
    [myTable reloadData];
      [Audio reloadData];
    
/*for (id anUpdate in self._assQues)
{
      NSDictionary *arrayList=[(NSDictionary*)anUpdate objectForKey:@"assparentquestionid"];
   // ////NSLog(@"assparentquestionid:%@",arrayList);
    NSNumber *num = [(NSDictionary*)anUpdate objectForKey:@"assparentanswerid"];
    int theValue = [num intValue];
     [num release];
    if(theValue==number)
    {
         NSDictionary *arrayList=[(NSDictionary*)anUpdate objectForKey:@"assquestion"];
        ////NSLog(@"assquestion:%@",arrayList);
        question.text=[(NSDictionary*)anUpdate objectForKey:@"assquestion"];
        
        NSNumber *num = [(NSDictionary*)anUpdate objectForKey:@"assquestionid"];
        questionid = [num intValue];
        [num release];
        //return;
        
    }
}
    
     int x=0;
    for (id anUpdate in self._assAns)
    {
        NSDictionary *arrayList=[(NSDictionary*)anUpdate objectForKey:@"assquestionid"];
        
        NSNumber *num = [(NSDictionary*)anUpdate objectForKey:@"assquestionid"];
        int theValue = [num intValue];
      //  [num release];
       
        if(theValue==questionid)
        {
        // ////NSLog(@"questionid:%@",arrayList);
            NSDictionary *arrayList=[(NSDictionary*)anUpdate objectForKey:@"answer"];
               NSDictionary *arrayList2=[(NSDictionary*)anUpdate objectForKey:@"ansid"];
            
            ////NSLog(@"ANSID:::%@",arrayList2);
            NSNumber *num = [(NSDictionary*)anUpdate objectForKey:@"assquestionid"];
          
            
            UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
            [button addTarget:self
                       action:@selector(aMethod:)
             forControlEvents:UIControlEventTouchUpInside];
            [button setTitle:[(NSDictionary*)anUpdate objectForKey:@"answer"]  forState:UIControlStateNormal];
            button.frame = CGRectMake(80.0, 210.0, 360.0, 40.0);
            button.center=CGPointMake(384, 304+x);
            button.tag= [num intValue];
            [self.view addSubview:button];
            x=x+60;
          //  [num release];
            
        }
       
    }
    
    
   */

    
}

-(void)aMethod:(UIButton*)but
{
    
    number=but.tag;
    NSString*str=but.titleLabel.text;
    ////NSLog(@"STR:%@",str);
    for (UIButton *but in [self.view subviews]) {
        if ([but isKindOfClass:[UIButton class]] ) {
            [but removeFromSuperview];
        }
    }
       [self NextQuestion];
    
}
-(void)NextQuestion
{
    
     ////NSLog(@"STR:");
    self._assQues=[instance getAssQue];
    self._assAns=[instance getAssAnswer];
    
    for (id anUpdate in self._assQues)
    {
        NSDictionary *arrayList=[(NSDictionary*)anUpdate objectForKey:@"assparentquestionid"];
        // ////NSLog(@"assparentquestionid:%@",arrayList);
        NSNumber *num = [(NSDictionary*)anUpdate objectForKey:@"assparentanswerid"];
        int theValue = [num intValue];
        [num release];
        if(theValue==number)
        {
            NSDictionary *arrayList=[(NSDictionary*)anUpdate objectForKey:@"assquestion"];
         //   ////NSLog(@"assquestion:%@",arrayList);
            question.text=[(NSDictionary*)anUpdate objectForKey:@"assquestion"];
            
            NSNumber *num = [(NSDictionary*)anUpdate objectForKey:@"assquestionid"];
            questionid = [num intValue];
            [num release];
            //return;
            
        }
    }
    
  //  ////NSLog(@"RAJA");
    int x=0;
    for (id anUpdate in self._assAns)
    {
        NSDictionary *arrayList=[(NSDictionary*)anUpdate objectForKey:@"assquestionid"];
        
        NSNumber *num = [(NSDictionary*)anUpdate objectForKey:@"assquestionid"];
        int theValue = [num intValue];
        [num release];
        
        if(theValue==questionid)
        {
            // ////NSLog(@"questionid:%@",arrayList);
            NSDictionary *arrayList=[(NSDictionary*)anUpdate objectForKey:@"answer"];
            NSDictionary *arrayList2=[(NSDictionary*)anUpdate objectForKey:@"ansid"];
            
       //     ////NSLog(@"ANSID:::%@",arrayList2);
            NSNumber *num = [(NSDictionary*)anUpdate objectForKey:@"assquestionid"];
            
            
            UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
            [button addTarget:self
                       action:@selector(aMethod:)
             forControlEvents:UIControlEventTouchUpInside];
            [button setTitle:[(NSDictionary*)anUpdate objectForKey:@"answer"]  forState:UIControlStateNormal];
            button.frame = CGRectMake(80.0, 210.0, 360.0, 40.0);
            button.center=CGPointMake(384, 304+x);
            button.tag= [num intValue];
            [self.view addSubview:button];
            x=x+60;
        //    [num release];
            
        }
        
    }
    
    
}
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
}
- (void)dealloc {
  
    
  [super dealloc];
}

@end
