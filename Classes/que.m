#import "que.h"
#import "AppSharedInstance.h"
#import "SpeakHereViewController.h"
#define DOCUMENTS_FOLDER [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"]
#define USE_CUSTOM_DRAWING 1
#define USE_CUSTOM_DRAWING 1
@implementation que
@synthesize recordDict;

@synthesize _assQues;
@synthesize _assAns;

AppSharedInstance *instance;


#pragma mark - AVAudioPlayerDelegate


#pragma mark - AVAudioRecorderDelegate

- (void)audioRecorderDidFinishRecording:(AVAudioRecorder *) aRecorder successfully:(BOOL)flag
{
    
    ////NSLog (@"audioRecorderDidFinishRecording:successfully:");
    // your actions here
    
}

- (IBAction)playAudioClicked:(id)sender {
    
    if (audioPlayer) {
        if (audioPlayer.isPlaying) [audioPlayer stop];
        else [audioPlayer play];
        
        return;
    }
    
    ////NSLog(@"play");
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    [audioSession setCategory:AVAudioSessionCategoryPlayAndRecord error:nil];
    
    NSString *path = [[NSBundle mainBundle] pathForResource: @"Track1" ofType: @"m4a"];
    
   
    NSURL *url = [NSURL fileURLWithPath: path];
    
    NSError *error;
    
    audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL: url error: &error];
    [audioPlayer setNumberOfLoops:0];
    [audioPlayer play];
}

- (IBAction)startRecordClicked:(id)sender {
    
    
    
    rec.hidden=NO;
    recording.hidden=NO;
    
    
    
    record.width=0.01;
    stop.width=0;
    [audioRecorder release];
    audioRecorder = nil;
    
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    [audioSession setCategory:AVAudioSessionCategoryPlayAndRecord error:nil];
    
    NSMutableDictionary *recordSetting = [[NSMutableDictionary alloc] initWithCapacity:0];
    
    if (recordEncoding == ENC_PCM) {
        [recordSetting setValue:[NSNumber numberWithInt:kAudioFormatLinearPCM]  forKey:AVFormatIDKey];
        [recordSetting setValue:[NSNumber numberWithFloat:44100.0]              forKey:AVSampleRateKey];
        [recordSetting setValue:[NSNumber numberWithInt:2]                      forKey:AVNumberOfChannelsKey];
        
        [recordSetting setValue:[NSNumber numberWithInt:16]                     forKey:AVLinearPCMBitDepthKey];
        [recordSetting setValue:[NSNumber numberWithBool:NO]                    forKey:AVLinearPCMIsBigEndianKey];
        [recordSetting setValue:[NSNumber numberWithBool:NO]                    forKey:AVLinearPCMIsFloatKey];
    } else {
        
        NSNumber *formatObject;
        
        switch (recordEncoding) {
            case ENC_AAC:
                formatObject = [NSNumber numberWithInt:kAudioFormatMPEG4AAC];
                break;
                
            case ENC_ALAC:
                formatObject = [NSNumber numberWithInt:kAudioFormatAppleLossless];
                break;
                
            case ENC_IMA4:
                formatObject = [NSNumber numberWithInt:kAudioFormatAppleIMA4];
                break;
                
            case ENC_ILBC:
                formatObject = [NSNumber numberWithInt:kAudioFormatiLBC];
                break;
                
            case ENC_ULAW:
                formatObject = [NSNumber numberWithInt:kAudioFormatULaw];
                break;
                
            default:
                formatObject = [NSNumber numberWithInt:kAudioFormatAppleIMA4];
                break;
        }
        
        [recordSetting setValue:formatObject forKey:AVFormatIDKey];
        [recordSetting setValue:[NSNumber numberWithFloat:44100.0]forKey:AVSampleRateKey];
        [recordSetting setValue:[NSNumber numberWithInt:2]forKey:AVNumberOfChannelsKey];
        [recordSetting setValue:[NSNumber numberWithInt:12800]forKey:AVEncoderBitRateKey];
        [recordSetting setValue:[NSNumber numberWithInt:16]forKey:AVLinearPCMBitDepthKey];
        [recordSetting setValue:[NSNumber numberWithInt:AVAudioQualityHigh] forKey:AVEncoderAudioQualityKey];
        
    }
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *recDir = [paths objectAtIndex:0];
      int i=0+arc4random()%1000;
    NSURL *url = [NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/%irecordTest.caf", recDir,i]];
    
    filenew=[[NSString alloc]init];
    filenew=[NSString stringWithFormat:@"%irecordTest.caf", i];
    ////NSLog(@"FileNew:%@",filenew);
    curentAudio=url;
    //////NSLog(@"URLNNNNN:%@,    %@",url,curentAudio);
    
    //    NSURL *url = [NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/recordTest.caf", [[NSBundle mainBundle] resourcePath]]];
    
    
    NSError *error = nil;
    audioRecorder = [[ AVAudioRecorder alloc] initWithURL:url settings:recordSetting error:&error];
    [audioRecorder setMeteringEnabled:YES];
    int channels = audioPlayerRecord.numberOfChannels;
    ////NSLog(@"Channels:%i",channels);
    [audioRecorder updateMeters];
  audioPlayer.delegate = self;
    
      BOOL audioHWAvailable = audioSession.inputIsAvailable;
    if (! audioHWAvailable) {
        UIAlertView *cantRecordAlert =
        [[UIAlertView alloc] initWithTitle: @"Warning"
                                   message: @"Audio input hardware not available"
                                  delegate: nil
                         cancelButtonTitle:@"OK"
                         otherButtonTitles:nil];
        [cantRecordAlert show];
        [cantRecordAlert release];
        return;
    }
    
   
    if ([audioRecorder prepareToRecord]) {
        [audioRecorder record];
        if (!playerTimer)
        {
            playerTimer = [NSTimer scheduledTimerWithTimeInterval:0.001
                                                           target:self selector:@selector(monitorAudioPlayer)
                                                         userInfo:nil
                                                          repeats:YES];
        }

        //////NSLog(@"recording");
    } else {
        //        int errorCode = CFSwapInt32HostToBig ([error code]);
        //        ////NSLog(@"Error: %@ [%4.4s])" , [error localizedDescription], (char*)&errorCode);
    //    ////NSLog(@"recorder: %@ %d %@", [error domain], [error code], [[error userInfo] description]);
    }
    
    
    
}


-(void) monitorAudioPlayer
{
  //  ////NSLog(@"raja");
   /* [audioRecorder updateMeters];
    
    for (int i=0; i<audioPlayerRecord.numberOfChannels; i++)
    {
        //Log the peak and average power
        ////NSLog(@"%d %0.2f %0.2f", i, [audioPlayerRecord peakPowerForChannel:i],[audioPlayerRecord averagePowerForChannel:i]);
    }*/
}

- (IBAction)stopRecordClicked:(id)sender {
    
    rec.hidden=YES;
    recording.hidden=YES;
    stop.width=0.01;
    record.width=0;
    [audioRecorder stop];
    
    if (audioPlayer) [audioPlayer stop];
    
    if (audioPlayerRecord) {
        if (audioPlayerRecord.isPlaying)
            [audioPlayerRecord stop];
        else [audioPlayerRecord play];
        
        return;
    }
    
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    [audioSession setCategory:AVAudioSessionCategoryPlayback error:nil];
    
    
    
    
    NSDate* now = [NSDate date];
    NSString *n=[NSString stringWithFormat:@"%@",now];
    
    
    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
    [outputFormatter setDateFormat:@"d:MM:yyyh:mma"];
    
    NSString *timetofill = [outputFormatter stringFromDate:now];
    n=timetofill;
    
    
    
   
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *recDir = [paths objectAtIndex:0];
    
	//NSDate*now=
    ////NSLog(@"CurrentAudio:%@",curentAudio);
    NSURL *url = curentAudio;
    
    
    //  NSString*str=[NSString stringWithFormat:@"%@",url];
    CCC=[NSString stringWithFormat:@"%@",url];
    //NSLog(@"raja:%@",CCC);
    ///  ////NSLog(@"STR:%@",str);
    [recordDict setObject:CCC forKey:@"name"];
    
     
  }


-(NSString *)applicationDocumentsDirectory {
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *basePath = ([paths count] > 0) ? [paths objectAtIndex:0] : nil;
    return basePath;
    
}

-(void)save1
{
    
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    [audioSession setCategory:AVAudioSessionCategoryPlayback error:nil];
    
    
    NSDate* now = [NSDate date];
    NSString *n=[NSString stringWithFormat:@"%@",now];
    
    
    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
    [outputFormatter setDateFormat:@" d:MM:yyy    h:mm a"];
    
    NSString *timetofill = [outputFormatter stringFromDate:now];
    n=timetofill;
    [recordDict setObject:n forKey:@"date"];
    
    
    int a=[[NSUserDefaults standardUserDefaults]integerForKey:@"selectAss"];
    if(a==1)
    {
        NSString*str=@"Daily Questionaries";
        [recordDict setObject:str forKey:@"type"];
    }
    NSString *UserId = [[NSUserDefaults standardUserDefaults] objectForKey:@"loginid"];
    [recordDict setObject:UserId forKey:@"patid"];
    [instance insertAudio:recordDict];
    
    
  
    
    NSMutableArray *ar=[instance getAudio];
    

    NSString*str=[[ar lastObject]objectForKey:@"pk" ];
    NSString*Astr=[NSString stringWithFormat:@"A%@",[[ar lastObject]objectForKey:@"pk" ]];
     NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *recDir = [paths objectAtIndex:0];
    
    NSString*p=[NSString stringWithFormat:@"%@/%@recordTest.text", recDir,str];
      NSString*pa=[NSString stringWithFormat:@"%@/%@recordTest.text", recDir,Astr];
    //NSLog(@"P:%@",p);
     //NSLog(@"PAp:%@",pa);
    [_QuestionArray writeToFile:p atomically:YES];
       [_AnswerArray writeToFile:pa atomically:YES];
    
    
    
       
    NSString *newString = CCC;
    NSString *newString1 = [newString stringByReplacingOccurrencesOfString:@"file://localhost" withString:@""];
    //  NSString *newString12 = [newString1 stringByReplacingOccurrencesOfString:@"like" withString:@""];
    //   NSString *final = [newString12 stringByReplacingOccurrencesOfString:@"and" withString:@""];
    
    
//    //NSLog(@"FIna:%@",newString1);
    
    
    NSString *result;
    NSData *responseData;
    
    //  int UserId=12;
    
    UserId = [[NSUserDefaults standardUserDefaults] objectForKey:@"loginid"];
    
    
    
    
    
    
    NSString *filePath5 = [[self applicationDocumentsDirectory] stringByAppendingPathComponent:newString1];
    
    
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    
    
    if ([fileManager fileExistsAtPath:newString1])
    {
        //NSLog(@"UNDU:%@",newString1);
        
    }
    else
    {
        //NSLog(@"ILLAAAA");
    }
    
    NSData *userImageData = [[NSData alloc] initWithContentsOfFile:newString1];
    
    
    
    @try {
        NSURL *url = [[NSURL alloc] initWithString:@"http://medsmonit.com/Service/patassessresponce.php?service=assessinsert"];
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
        
        [postBody appendData:[[NSString stringWithString:@"Content-Disposition: form-data; name=\"patid\"\r\n\r\n"] dataUsingEncoding:NSASCIIStringEncoding]];
        [postBody appendData:[[NSString stringWithFormat:@"%@",UserId] dataUsingEncoding:NSASCIIStringEncoding]];
        
        
        xmlFile=[NSString stringWithFormat:@"<Result><Question>%@,,%@</Question><Answer>%@,,%@</Answer></Result>",[_QuestionArray objectAtIndex:0],[_QuestionArray objectAtIndex:1],[_AnswerArray objectAtIndex:0],[_AnswerArray objectAtIndex:1]];

        ////NSLog(@"XMLFile:%@",_QuestionArray);
      //  [recordDict setObject:_QuestionArray forKey:@"name"];
        
      //  [postBody appendData:[[NSString stringWithFormat:@"--%@\r\n",stringBoundary] dataUsingEncoding:NSASCIIStringEncoding]];
        
    //    [postBody appendData:[[NSString stringWithString:@"Content-Disposition: form-data; name=\"assessxml\"\r\n\r\n"] dataUsingEncoding:NSASCIIStringEncoding]];
     //   [postBody appendData:[[NSString stringWithFormat:@"%@",xmlFile] dataUsingEncoding:NSASCIIStringEncoding]];
        
        
        [postBody appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n",stringBoundary] dataUsingEncoding:NSASCIIStringEncoding]];
        [postBody appendData:[[NSString stringWithFormat:@"--%@\r\n",stringBoundary] dataUsingEncoding:NSASCIIStringEncoding]];
        [postBody appendData:[[NSString stringWithString:@"Content-Disposition: form-data; name=\"assessxml\"\r\n\r\n"] dataUsingEncoding:NSASCIIStringEncoding]];
        [postBody appendData:[[NSString stringWithFormat:@"%@",xmlFile] dataUsingEncoding:NSASCIIStringEncoding]];
        [postBody appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n",stringBoundary] dataUsingEncoding:NSASCIIStringEncoding]];
        
        
        
        
        int type=[[NSUserDefaults standardUserDefaults]integerForKey:@"selectAss"];
        
        NSString* myNewString = [NSString stringWithFormat:@"%i", type];
        
        
        [postBody appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n",stringBoundary] dataUsingEncoding:NSASCIIStringEncoding]];
        [postBody appendData:[[NSString stringWithFormat:@"--%@\r\n",stringBoundary] dataUsingEncoding:NSASCIIStringEncoding]];
        [postBody appendData:[[NSString stringWithString:@"Content-Disposition: form-data; name=\"assessid\"\r\n\r\n"] dataUsingEncoding:NSASCIIStringEncoding]];
        [postBody appendData:[[NSString stringWithFormat:@"%@",myNewString] dataUsingEncoding:NSASCIIStringEncoding]];
        [postBody appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n",stringBoundary] dataUsingEncoding:NSASCIIStringEncoding]];
        
        
        [postBody appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n",stringBoundary] dataUsingEncoding:NSASCIIStringEncoding]];
        [postBody appendData:[[NSString stringWithFormat:@"--%@\r\n",stringBoundary] dataUsingEncoding:NSASCIIStringEncoding]];
        [postBody appendData:[[NSString stringWithString:@"Content-Disposition: form-data; name=\"patientaudio\"; filename=\"Record.caf\"\r\nContent-Type: audio/caf\r\n\r\n"] dataUsingEncoding:NSASCIIStringEncoding]];
        [postBody appendData:[NSData dataWithData:userImageData]];
        [postBody appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n",stringBoundary] dataUsingEncoding:NSASCIIStringEncoding]];
        
        
        [req setHTTPBody: postBody];//putParams];
        
        NSHTTPURLResponse* response = nil;
        NSError* error = [[[NSError alloc] init] autorelease];
        
        responseData = [NSURLConnection sendSynchronousRequest:req returningResponse:&response error:&error];
        result = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
        
        
        [url release];
        [req release];
        
        
    }
    @catch (NSException* ex) {
        ////NSLog(@"Error: %@",ex);
    }
    
    //NSLog(@"resulr:%@",result);
    
    
    
    ////NSLog(@"QUESTION%@",_QuestionArray);
    ////NSLog(@"ANSWER%@",_AnswerArray);
    
     //  [recordDict setObject:UserId forKey:@"patid"];
  //  [recordDict setObject:_QuestionArray forKey:@"ques"];
 //   [recordDict setObject:_AnswerArray forKey:@"ans"];
   //  [instance insertHis:recordDict];
    
  //  NSMutableArray*aa=[instance getHis];
  //  //NSLog(@"AAAAA:%@",aa);
    
    
    [_QuestionArray addObject:@""];
    [_AnswerArray   addObject:@""];
      
    
  //  NSString *runNumber = [[NSUserDefaults standardUserDefaults] objectForKey:@"loginid"];
  //  NSString *resultResponse=[self HttpPostEntityFirst:@"patid" ForValue1:runNumber EntitySecond:@"authkey" ForValue2:@"rzTFevN099Km39PV"];
    ////NSLog(@"ResulrTEsponse:%@",resultResponse);
    
    
    [[self navigationController] popViewControllerAnimated:YES];
}
- (IBAction)save:(id)sender
{
    
    
	HUD.delegate = self;
	
    [HUD show:YES];
    HUD.labelText = @"Processing....";
//    HUD.customView = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"37x-Checkmark.png"]] autorelease];
  //  HUD.mode = MBProgressHUDModeCustomView;
    [HUD hide:YES afterDelay:2.6];
     [self performSelector:@selector(save1) withObject:nil afterDelay:0.2];
   
    
    
 
}
- (IBAction)playRecordClicked:(id)sender {
    
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
   
	//NSDate*now=
    ////NSLog(@"CurrentAudio:%@",curentAudio);
    NSURL *url = curentAudio;
   
    
  //  NSString*str=[NSString stringWithFormat:@"%@",url];
    CCC=[NSString stringWithFormat:@"%@",url];
    ////NSLog(@"raja:%@",url);
  ///  ////NSLog(@"STR:%@",str);
    [recordDict setObject:CCC forKey:@"name"];
   // [instance insertAudio:recordDict];
    
    ////NSLog(@"reco:%@",recordDict);
    ////NSLog(@"getaudio%@",[instance getAudio]);
    
    //    NSURL *url = [NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/recordTest.caf", [[NSBundle mainBundle] resourcePath]]];
    NSError *error;
    audioPlayerRecord = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:&error];
      audioPlayerRecord.delegate=self;
    [audioPlayerRecord play];
    
    ////NSLog(@"Recoder file >");
}

- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag
{
    if (player == audioPlayerRecord) {
        audioPlayerRecord = nil;
    }
}

-(void)back
{
    [[self navigationController] popViewControllerAnimated:YES];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return 1;
}


- (void)viewDidLoad
{
 
    HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
	[self.navigationController.view addSubview:HUD];
    
    _QuestionArray=[[NSMutableArray alloc]init];
    _AnswerArray=[[NSMutableArray alloc]init];
     recordEncoding = ENC_PCM;
    stop.width=0.01;
  [super viewDidLoad];
    ret=1;
    ret1=0;
    monthindex=0;
   
    daily=[[NSUserDefaults standardUserDefaults]integerForKey:@"daily"];
    ////NSLog(@"Daily:%i",daily);
    
    
    _assArray=[[NSMutableArray alloc]init];
    lables=[[NSMutableArray alloc]init];
    number=0;
    
    	instance = [AppSharedInstance sharedInstance];
     self._assQues=[instance getAssQue];
      self._assAns=[instance getAssAnswer];
   
    
  
        buttonsToRemove = [[NSMutableArray alloc]init];
   //  [self speak];
  //  //////NSLog(@"SELF>_ASSAns::::%@",self._assAns);
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
    
    UIButton *home = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *homeImage = [UIImage imageNamed:@"Back.png"]  ;
    [home setBackgroundImage:homeImage forState:UIControlStateNormal];
    [home addTarget:self action:@selector(back)
   forControlEvents:UIControlEventTouchUpInside];
    home.frame = CGRectMake(0, 0, 50, 30);
    UIBarButtonItem *cancelButton = [[[UIBarButtonItem alloc]
                                      initWithCustomView:home] autorelease];
    self.navigationItem.leftBarButtonItem = cancelButton;
   
}



-(void)monthans
{
    int x=0;
    for (id anUpdate in self._assAns)
    {
        NSDictionary *arrayList=[(NSDictionary*)anUpdate objectForKey:@"assquestionid"];
        
        NSNumber *num1 = [(NSDictionary*)anUpdate objectForKey:@"assid"];
        int theValue1 = [num1 intValue];
          int okok=[[NSUserDefaults standardUserDefaults]integerForKey:@"selectAss"];
        if(theValue1==okok)
        {
            NSNumber *num = [(NSDictionary*)anUpdate objectForKey:@"assquestionid"];
            int theValue = [num intValue];
            //  [num release];
            
            if(theValue==questionid)
            {
                
                NSDictionary *arrayList=[(NSDictionary*)anUpdate objectForKey:@"answer"];
                NSDictionary *arrayList2=[(NSDictionary*)anUpdate objectForKey:@"ansid"];
                
                
                NSNumber *num = [(NSDictionary*)anUpdate objectForKey:@"assquestionid"];
                
                
                
                
                NSNumber *numid = [(NSDictionary*)anUpdate objectForKey:@"ansid"];
                int nextID = [numid intValue];
                
                
                ////NSLog(@"YES");
                UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
                [button addTarget:self
                           action:@selector(checkMethod1:)
                 forControlEvents:UIControlEventTouchUpInside];
                [button setSelected:NO];
                [button setTitle:@"OK"  forState:UIControlStateNormal];
                button.frame = CGRectMake(40.0, 210.0, 42, 38);
                button.center=CGPointMake(134, 300+x);
                [button setImage:[UIImage imageNamed:@"AAUnselect.png"] forState:UIControlStateNormal];
                [self.view addSubview:button];
                button.tag=x;
                
                [buttonsToRemove addObject:button];
                
                UILabel *label = [[[UILabel alloc] initWithFrame:CGRectZero] autorelease];
                label.backgroundColor = [UIColor clearColor];
                label.font = [UIFont boldSystemFontOfSize:20.0];
                label.frame = CGRectMake(80.0, 210.0, 360.0, 40.0);
                label.shadowColor = [UIColor colorWithWhite:0.0 alpha:0.5];
                label.center=CGPointMake(384, 308+x);
                label.textAlignment = UITextAlignmentCenter;
                label.textColor = [UIColor whiteColor]; // change this color
                [lables addObject:label];
                label.text =[(NSDictionary*)anUpdate objectForKey:@"answer"];
                
                 [button setTitle:[(NSDictionary*)anUpdate objectForKey:@"answer"]  forState:UIControlStateNormal];
                [label sizeToFit];
                label.tag=x;
                [self.view addSubview:label];
                x=x+60;
                
                
            }
            
        }
    }

}

-(void)saveMonth
{
    ////NSLog(@"_QuestionArrayP:%@",_QuestionArray);
    
}


-(NSString *)HttpPostEntityFirst:(NSString*)firstEntity ForValue1:(NSString*)value1 EntitySecond:(NSString*)secondEntity ForValue2:(NSString*)value2
{
    
    // NSString *type=[[NSUserDefaults standardUserDefaults]objectForKey:@"questionType"];
    int type=[[NSUserDefaults standardUserDefaults]integerForKey:@"selectAss"];
    
    NSString *post =[[NSString alloc] initWithFormat:@"%@=%@  &%@=%@  &assessid=%d  &assessxml=%@",firstEntity,value1,secondEntity,value2,type,xmlFile];
    NSURL *url=[NSURL URLWithString:@"http://medsmonit.com/Service/patassessresponce.php?service=assessinsert"];
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




-(void)mothly
{
    
    
   // [self performSelector:@selector() withObject:nil afterDelay:0.3];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button addTarget:self
               action:@selector(rem)   forControlEvents:UIControlEventTouchUpInside];
     UIImage*btnImage = [UIImage imageNamed:@"NExt.png"];
     [button setImage:btnImage forState:UIControlStateNormal];
    button.backgroundColor=[UIColor clearColor];
    //[button setTitle:[(NSDictionary*)anUpdate objectForKey:@"answer"]  forState:UIControlStateNormal];
    button.frame = CGRectMake(80.0, 210.0, 120, 44);
    button.center=CGPointMake(384, 704);
    [self.view addSubview:button];
    button.hidden=YES;
    button.tag=2048;
   
    
    
    
    
      int okok=[[NSUserDefaults standardUserDefaults]integerForKey:@"selectAss"];
  //  ////NSLog(@"[self._assQues objectAtIndex:0]:%@",[self._assQues objectAtIndex:0]);
  //  return;
    
    
    for (id anUpdate in self._assQues)
    {
        
        
        NSDictionary *arrayList=[(NSDictionary*)anUpdate objectForKey:@"assid"];
        ////NSLog(@"assid:%@",arrayList);
        
        NSNumber *num1 = [(NSDictionary*)anUpdate objectForKey:@"assid"];
        int theValue1 = [num1 intValue];
        
        if(theValue1==okok)
        {
            ////NSLog(@"OKOK:%i",okok);
              ////NSLog(@"theValue1:%i",theValue1);
            NSNumber *num = [(NSDictionary*)anUpdate objectForKey:@"assparentanswerid"];
            int theValue = [num intValue];
         //   [num release];
        //    ////NSLog(@"NUMBER:%i",number);
            if(theValue==number)
            {
                  
                NSDictionary *arrayList=[(NSDictionary*)anUpdate objectForKey:@"assquestion"];
                //    ////NSLog(@"assquestion:%@",arrayList);
                question.text=[(NSDictionary*)anUpdate objectForKey:@"assquestion"];
             //   question.textAlignment = NSTextAlignmentJustified;
                question.numberOfLines = 0;
                 //   question.textAlignment = NSTextAlignmentJustified;
              /*  CGSize labelSize = [question.text sizeWithFont:question.font
                                          constrainedToSize:question.frame.size
                                              lineBreakMode:question.lineBreakMode];
                question.frame = CGRectMake(
                                         question.frame.origin.x, question.frame.origin.y,
                                         question.frame.size.width, labelSize.height);*/
                
                NSNumber *num = [(NSDictionary*)anUpdate objectForKey:@"assquestionid"];
                questionid = [num intValue];
           //     [num release];
                
                ret1++;
                if(ret==ret1)
                {
                    ret=ret1+1;
                    ////NSLog(@"RET:%i   RET!!!:%i",ret,ret1);
                    ret1=0;
                    [self monthans];
                     return;
                }
                else if(ret==13)
                {
                     question.text=@"Thank you for completing this questionnaire.";
                     //   question.textAlignment = NSTextAlignmentJustified;
                    ////NSLog(@"_QuestionArrayP:%@",_QuestionArray);
                      ////NSLog(@"_QuestionArrayP:%@",_AnswerArray);
                    
                     xmlFile=[NSString stringWithFormat:@"<Result><Question>%@,,%@,,%@,,%@,,%@,,%@,,%@,,%@,,%@,,%@,,%@,,%@</Question><Answer>%@,,%@,,%@,,%@,,%@,,%@,,%@,,%@,,%@,,%@,,%@,,%@</Answer></Result>",[_QuestionArray objectAtIndex:0],[_QuestionArray objectAtIndex:1],[_QuestionArray objectAtIndex:2],[_QuestionArray objectAtIndex:3],[_QuestionArray objectAtIndex:4],[_QuestionArray objectAtIndex:5],[_QuestionArray objectAtIndex:6],[_QuestionArray objectAtIndex:7],[_QuestionArray objectAtIndex:8],[_QuestionArray objectAtIndex:9],[_QuestionArray objectAtIndex:10],[_QuestionArray objectAtIndex:11],[_AnswerArray objectAtIndex:0],[_AnswerArray objectAtIndex:1],[_AnswerArray objectAtIndex:2],[_AnswerArray objectAtIndex:3],[_AnswerArray objectAtIndex:4],[_AnswerArray objectAtIndex:5],[_AnswerArray objectAtIndex:6],[_AnswerArray objectAtIndex:7],[_AnswerArray objectAtIndex:8],[_AnswerArray objectAtIndex:9],[_AnswerArray objectAtIndex:10],[_AnswerArray objectAtIndex:11]];
                    
                    NSDate* now = [NSDate date];
                    NSString *n=[NSString stringWithFormat:@"%@",now];
                    
                    
                    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
                    [outputFormatter setDateFormat:@" d:MM:yyy    h:mm a"];
                    
                    NSString *timetofill = [outputFormatter stringFromDate:now];
                    n=timetofill;
                    [recordDict setObject:n forKey:@"date"];
                    
                    
                    int a=[[NSUserDefaults standardUserDefaults]integerForKey:@"selectAss"];
                    //NSLog(@"asstype:%i",a);
                    if(a==1)
                    {
                        NSString*str=@"Daily Questionaries";
                        [recordDict setObject:str forKey:@"type"];
                    }
                   else if(a==3)
                    {
                        NSString*str=@"Monthly Questionaries";
                        [recordDict setObject:str forKey:@"type"];
                    }
                        [recordDict setObject:@"" forKey:@"name"];
                    NSString *UserId = [[NSUserDefaults standardUserDefaults] objectForKey:@"loginid"];
                    [recordDict setObject:UserId forKey:@"patid"];
                    [instance insertAudio:recordDict];
                    
                    NSMutableArray *ar=[instance getAudio];
                    NSString *runNumber = [[NSUserDefaults standardUserDefaults] objectForKey:@"loginid"];
                     NSString *resultResponse=[self HttpPostEntityFirst:@"patid" ForValue1:runNumber EntitySecond:@"authkey" ForValue2:@"rzTFevN099Km39PV"];
                    ////NSLog(@"UPDATED....:%@",resultResponse);
                      question.numberOfLines = 0;
                    
                   
                    NSString*str=[[ar lastObject]objectForKey:@"pk" ];
                    NSString*Astr=[NSString stringWithFormat:@"A%@",[[ar lastObject]objectForKey:@"pk" ]];
                    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
                    NSString *recDir = [paths objectAtIndex:0];
                    
                    NSString*p=[NSString stringWithFormat:@"%@/%@recordTest.text", recDir,str];
                    NSString*pa=[NSString stringWithFormat:@"%@/%@recordTest.text", recDir,Astr];
                    //NSLog(@"P:%@",p);
                    //NSLog(@"PAp:%@",pa);
                    [_QuestionArray writeToFile:p atomically:YES];
                    [_AnswerArray writeToFile:pa atomically:YES];
                    
                    return;
                  /*  UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
                    [button addTarget:self
                               action:@selector(saveMonth)   forControlEvents:UIControlEventTouchUpInside];
                    UIImage*btnImage = [UIImage imageNamed:@"NExt.png"];
                    [button setImage:btnImage forState:UIControlStateNormal];
                    button.backgroundColor=[UIColor clearColor];
                    //[button setTitle:[(NSDictionary*)anUpdate objectForKey:@"answer"]  forState:UIControlStateNormal];
                    button.frame = CGRectMake(10.0, 210.0, 120, 44);
                    button.center=CGPointMake(314, 704);
                    [self.view addSubview:button];
                   // button.hidden=YES;
                    button.tag=2088;*/
                      
                }
               
                
             //  if(ret==1)
             //  {
                   
            //    return;
              // }
             
            }
            else
            {
              
             //   ////NSLog(@"COMPLETE");
            }
        }

        
        
    }
    
    //  ////NSLog(@"_assAns:%@",self._assQues);
    
    
       
    

    
    
    
    
    
}

-(void)viewWillAppear:(BOOL)animated
{
    
  
  
    
    NSDate* now = [NSDate date];
    NSDate*old=[[NSUserDefaults standardUserDefaults]objectForKey:@"nowold"];
    
  //  ////NSLog(@"now:%@",now);
  //   ////NSLog(@"old:%@",old);
    if ([now compare:old] == NSOrderedDescending) {
     //   ////NSLog(@"now is later than date2");
        [[NSUserDefaults standardUserDefaults]setInteger:0 forKey:@"daily"];
        
    }  if ([now compare:old] == NSOrderedAscending) {
      //  ////NSLog(@"date1 is earlier than date2");
        
    } else {
     //   ////NSLog(@"dates are the same");
        
    }
    
     daily=[[NSUserDefaults standardUserDefaults]integerForKey:@"daily"];
    int okok=[[NSUserDefaults standardUserDefaults]integerForKey:@"selectAss"];
    //  [[NSUserDefaults standardUserDefaults] setInteger:indexPath.section forKey:@"selectAss"];
    //////NSLog(@"okok:%i",okok);
    if(okok==1 && daily==1 )
    {
        
           question.text =@"You have already answer your daily assessment. Your next daily assessment is on _____.";
         //   question.textAlignment = NSTextAlignmentJustified;
        
          question.numberOfLines = 0;
        
        return;
    }
        
    instance = [AppSharedInstance sharedInstance];
    self._assQues=[instance getAssQue];
     self._assAns=[instance getAssAnswer];
       buttonsToRemove = [[NSMutableArray alloc]init];
    if ([recordDict count]>0) {
        
	}
	else {
		recordDict = [[NSMutableDictionary alloc] init];
        
	}
    
     
  //////NSLog(@"SELF>_ASSQUES::::%@",  self._assQues);
//  ////NSLog(@"SELF>_ASSAns::::%@",  [self._assQues objectAtIndex:0]);
    
    
    
    
     //[[NSUserDefaults standardUserDefaults] setObject:questiontype forKey:@"questionType"];
    NSString *type=[[NSUserDefaults standardUserDefaults]objectForKey:@"questionType"];
    if([type isEqualToString:@"Monthly Questionnaire"])
    {
        [self mothly];
        return;
    }
   
  
    
for (id anUpdate in self._assQues)
{
    
    
      NSDictionary *arrayList=[(NSDictionary*)anUpdate objectForKey:@"assid"];
      ////NSLog(@"assid:%@",arrayList);
    
    NSNumber *num1 = [(NSDictionary*)anUpdate objectForKey:@"assid"];
    int theValue1 = [num1 intValue];
    
    if(theValue1==okok)
    {
    NSNumber *num = [(NSDictionary*)anUpdate objectForKey:@"assparentanswerid"];
    int theValue = [num intValue];
     [num release];
    if(theValue==number)
    {
         NSDictionary *arrayList=[(NSDictionary*)anUpdate objectForKey:@"assquestion"];
    //    ////NSLog(@"assquestion:%@",arrayList);
        question.text=[(NSDictionary*)anUpdate objectForKey:@"assquestion"];
          question.numberOfLines = 0;
         //   question.textAlignment = NSTextAlignmentJustified;
        NSNumber *num = [(NSDictionary*)anUpdate objectForKey:@"assquestionid"];
        questionid = [num intValue];
        [num release];
        //return;
    }
}
}
   
  //  ////NSLog(@"_assAns:%@",self._assQues);
    
    
     int x=0;
    for (id anUpdate in self._assAns)
    {
        NSDictionary *arrayList=[(NSDictionary*)anUpdate objectForKey:@"assquestionid"];
        
        NSNumber *num1 = [(NSDictionary*)anUpdate objectForKey:@"assid"];
        int theValue1 = [num1 intValue];
        
        if(theValue1==okok)
        {
        NSNumber *num = [(NSDictionary*)anUpdate objectForKey:@"assquestionid"];
        int theValue = [num intValue];
      //  [num release];
       
        if(theValue==questionid)
        {
            
          
        // //////NSLog(@"questionid:%@",arrayList);
            NSDictionary *arrayList=[(NSDictionary*)anUpdate objectForKey:@"answer"];
               NSDictionary *arrayList2=[(NSDictionary*)anUpdate objectForKey:@"ansid"];
            
         //////NSLog(@"ANSID:::%@",arrayList2);
            NSNumber *num = [(NSDictionary*)anUpdate objectForKey:@"assquestionid"];
            
            
            
            
            NSNumber *numid = [(NSDictionary*)anUpdate objectForKey:@"ansid"];
            int nextID = [numid intValue];
          
            
            UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
            [button addTarget:self
                       action:@selector(aMethod:)
             forControlEvents:UIControlEventTouchUpInside];
            [button setTitle:[(NSDictionary*)anUpdate objectForKey:@"answer"]  forState:UIControlStateNormal];
            button.frame = CGRectMake(80.0, 210.0, 360.0, 40.0);
            button.center=CGPointMake(384, 304+x);
            button.tag= nextID;
            [buttonsToRemove addObject:button];
            NSDictionary *assname=[(NSDictionary*)anUpdate objectForKey:@"assname"];
            
            NSString *s=[NSString stringWithFormat:@"%@",[(NSDictionary*)anUpdate objectForKey:@"assname"]];
            
            if([s isEqualToString:@"Daily Questionnaire"])
            {
                    [self.view addSubview:button];
            }
            else
            {
                     [scrollview addSubview:button];
            }

       
            x=x+60;
          //  [num release];
            
        }
       
      }
    }
    
    
   

    
}

-(void)aMethod:(UIButton*)but
{
    
    [_QuestionArray addObject:question.text];
    
    [_AnswerArray addObject:but.titleLabel.text];
    number=but.tag;
    NSString*st=but.titleLabel.text;
    ////NSLog(@"NUMBER:%@",st);
//[[self.view viewWithTag:number]removeFromSuperview];
    

    if([st isEqualToString:@"No"])
        {
         
            ////NSLog(@"butt:%i",[buttonsToRemove count]);
            for (int i=0; i<=1; i++)
            {
                UIButton*but=[buttonsToRemove objectAtIndex:i];
                
                
                [but removeFromSuperview];
                ////NSLog(@"butttttt:%i",[buttonsToRemove count]);
            }
            [buttonsToRemove removeAllObjects];
               if([question.text isEqualToString:@"Do you have any other thoughts you would like to share about your new prescription?"])
               {
                   ////NSLog(@"return");
                   [self complete1];
                   return;
               }
            check=YES;
        }
    else
    {
        ////NSLog(@"butt:%i",[buttonsToRemove count]);
        for (int i=0; i<=1; i++)
        {
            UIButton*but=[buttonsToRemove objectAtIndex:i];
            
            
            [but removeFromSuperview];
            ////NSLog(@"butttttt:%i",[buttonsToRemove count]);
        }
        [buttonsToRemove removeAllObjects];
        check=NO;
         
    }
    
      
    if(check==YES)
    {
        [self explainRecord];
        //  [self speak];
    }
   
    [self NextQuestion];
    
}


-(void)explainRecord1
{
    UILabel *label = [[[UILabel alloc] initWithFrame:CGRectZero] autorelease];
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont boldSystemFontOfSize:17.0];
    label.frame = CGRectMake(80.0, 510.0, 360.0, 40.0);
    label.shadowColor = [UIColor colorWithWhite:0.0 alpha:0.5];
    label.center=CGPointMake(204, 280);
    label.textAlignment = UITextAlignmentCenter;
    label.textColor = [UIColor whiteColor]; // change this color
    
    label.text =@"Please explain by recording your answer.";
    [label sizeToFit];
    [self.view addSubview:label];
    
    
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button addTarget:self
               action:@selector(record:)
     forControlEvents:UIControlEventTouchUpInside];
    
    [button setTitle:@"Record"  forState:UIControlStateNormal];
    button.frame = CGRectMake(80.0, 210.0, 360.0, 40.0);
    button.center=CGPointMake(384, 800);
    
    toolbar.center=CGPointMake(384, 400);
    recording.center=CGPointMake(353,400 );
    rec.center=CGPointMake(278, 400);
    toolbar.hidden=NO;
    //  [self.view addSubview:button];
    [buttonsToRemove addObject:button];
    
}



-(void)explainRecord
{
    UILabel *label = [[[UILabel alloc] initWithFrame:CGRectZero] autorelease];
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont boldSystemFontOfSize:17.0];
    label.frame = CGRectMake(80.0, 210.0, 360.0, 40.0);
    label.shadowColor = [UIColor colorWithWhite:0.0 alpha:0.5];
    label.center=CGPointMake(204, 680);
    label.textAlignment = UITextAlignmentCenter;
    label.textColor = [UIColor whiteColor]; // change this color
    
    label.text =@"Please explain by recording your answer.";
    [label sizeToFit];
    [self.view addSubview:label];
    
    
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button addTarget:self
               action:@selector(record:)
     forControlEvents:UIControlEventTouchUpInside];
    
    [button setTitle:@"Record"  forState:UIControlStateNormal];
    button.frame = CGRectMake(80.0, 210.0, 360.0, 40.0);
    button.center=CGPointMake(384, 800);
    
    toolbar.hidden=NO;
  //  [self.view addSubview:button];
    [buttonsToRemove addObject:button];
 
}
-(void)record:(UIButton*)sender
{
    [sender removeFromSuperview];
    [self speak];
}
-(void)checkMethod:(UIButton*)but
{
    
    [_QuestionArray addObject:question.text];
    [_AnswerArray addObject:but.titleLabel.text];
   //       [button setSelected:NO];
  if([but isSelected])
  {
      [but setSelected:NO];
        [but setImage:[UIImage imageNamed:@"AAUnselect.png"] forState:UIControlStateNormal];
  }
    else
    {
          [but setImage:[UIImage imageNamed:@"AASelect.png"] forState:UIControlStateNormal];
         [but setSelected:YES];
    }
    
    
    
     
}

-(void)rem
{
    [_QuestionArray addObject:question.text];
    [_AnswerArray addObject:SelectAns];
    //NSString*SelectAns
  //  ////NSLog(@"SelectAns%@",SelectAns);
    
    
    [self.view viewWithTag:2048].hidden=YES;
    question.text=@"";
    for(int i=0;i< [buttonsToRemove count];i++)
    {
        UIButton*but=[buttonsToRemove objectAtIndex:i];
        [but removeFromSuperview];
        
        
    }
    [buttonsToRemove removeAllObjects];
    
    for(int i=0;i< [lables count];i++)
    {
        UILabel*but=[lables objectAtIndex:i];
        [but removeFromSuperview];
        
        
    }
    [lables removeAllObjects];
    
    ////NSLog(@"MOTHLY");
    [self mothly];
}
-(void)checkMethod1:(UIButton*)but
{
    
    //
    
    
    SelectAns=but.titleLabel.text;
    
    [self.view viewWithTag:2048].hidden=NO;
    //       [button setSelected:NO];
    for(int i=0;i< [buttonsToRemove count];i++)
    {
        UIButton*but=[buttonsToRemove objectAtIndex:i];
        if([but isSelected])
        {
            [but setSelected:NO];
            [but setImage:[UIImage imageNamed:@"AAUnselect.png"] forState:UIControlStateNormal];
        }

        
    }

    if([but isSelected])
    {
        [but setSelected:NO];
        [but setImage:[UIImage imageNamed:@"AAUnselect.png"] forState:UIControlStateNormal];
    }
    else
    {
        [but setImage:[UIImage imageNamed:@"AASelect.png"] forState:UIControlStateNormal];
        [but setSelected:YES];
    }
  
  
    
}







-(void)NextQuestion
{
    
   
  
    
   
    self._assQues=[instance getAssQue];
    self._assAns=[instance getAssAnswer];
 //   ////NSLog(@"self._assQues:%@",self._assQues);
    
    
    for (id anUpdate in self._assQues)
    {
       
        NSDictionary *arrayList=[(NSDictionary*)anUpdate objectForKey:@"assparentquestionid"];
        // //////NSLog(@"assparentquestionid:%@",arrayList);
        NSNumber *num = [(NSDictionary*)anUpdate objectForKey:@"assparentanswerid"];
        int theValue = [num intValue];
        [num release];
        ////NSLog(@"theVAle:::%i   Number:::%i",theValue,number);
        if(theValue==number)
        {
            
            NSDictionary *arrayList=[(NSDictionary*)anUpdate objectForKey:@"assquestion"];
    //  ////NSLog(@"assquestion:%@",arrayList);
            question.text=[(NSDictionary*)anUpdate objectForKey:@"assquestion"];
              question.numberOfLines = 0;
             //   question.textAlignment = NSTextAlignmentJustified;
            NSNumber *num = [(NSDictionary*)anUpdate objectForKey:@"assquestionid"];
            questionid = [num intValue];
            [num release];
            //return;
            hh=1;
            break;
        }
        else
        {
            
            hh=0;
         //   return;
            
        }
    }
    
    
    int x=0;
    for (id anUpdate in self._assAns)
    {
        NSDictionary *arrayList=[(NSDictionary*)anUpdate objectForKey:@"assquestionid"];
        
        NSNumber *num = [(NSDictionary*)anUpdate objectForKey:@"assquestionid"];
        int theValue = [num intValue];
        [num release];
        
        if(theValue==questionid)
        {
            ////NSLog(@"questionid:%@",arrayList);
            NSDictionary *arrayList=[(NSDictionary*)anUpdate objectForKey:@"answer"];
            NSDictionary *arrayList2=[(NSDictionary*)anUpdate objectForKey:@"ansid"];
            
            NSNumber *numid = [(NSDictionary*)anUpdate objectForKey:@"ansid"];
            int nextID = [numid intValue];
            
  //     ////NSLog(@"ANSID:::%@",arrayList2);
            NSNumber *num = [(NSDictionary*)anUpdate objectForKey:@"assquestionid"];
            
            
            if(check==NO)
            {
                
            UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
            [button addTarget:self
                       action:@selector(aMethod:)
             forControlEvents:UIControlEventTouchUpInside];
                
            [button setTitle:[(NSDictionary*)anUpdate objectForKey:@"answer"]  forState:UIControlStateNormal];
            button.frame = CGRectMake(80.0, 210.0, 360.0, 40.0);
            button.center=CGPointMake(384, 304+x);
            button.tag= nextID;
            [self.view addSubview:button];
            [buttonsToRemove addObject:button];
            x=x+60;
                ////NSLog(@"NONO");
            }
            else
            {
              
             ////NSLog(@"YES");
                UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
                [button addTarget:self
                           action:@selector(checkMethod:)
                 forControlEvents:UIControlEventTouchUpInside];
                [button setSelected:NO];
                [button setTitle:@"OK"  forState:UIControlStateNormal];
                button.frame = CGRectMake(40.0, 210.0, 42, 38);
                button.center=CGPointMake(134, 300+x);
               [button setImage:[UIImage imageNamed:@"AAUnselect.png"] forState:UIControlStateNormal];
                [self.view addSubview:button];
           
                
                UILabel *label = [[[UILabel alloc] initWithFrame:CGRectZero] autorelease];
                label.backgroundColor = [UIColor clearColor];
                label.font = [UIFont boldSystemFontOfSize:20.0];
                 label.frame = CGRectMake(80.0, 210.0, 360.0, 40.0);
                label.shadowColor = [UIColor colorWithWhite:0.0 alpha:0.5];
                   label.center=CGPointMake(384, 308+x);
                label.textAlignment = UITextAlignmentCenter;
                label.textColor = [UIColor whiteColor]; // change this color
                
                label.text =[(NSDictionary*)anUpdate objectForKey:@"answer"];
                   [button setTitle:[(NSDictionary*)anUpdate objectForKey:@"answer"]  forState:UIControlStateNormal];
                [label sizeToFit];
                   [self.view addSubview:label];
                   x=x+60;
            
            }
            
        //    [num release];
            
        }
        
    }
    
    
    if(hh==0)
    {
      //  [self speak];
        ////NSLog(@"Complete");
        [self complete];
    }
    
}
-(void)complete
{
  
    ////NSLog(@"[buttonsToRemove count]:%i",[buttonsToRemove count]);
    if([buttonsToRemove count]!=0)
    {
    for (int i=0; i<[buttonsToRemove count]; i++)
    {
        UIButton*but=[buttonsToRemove objectAtIndex:i];
        
        
        [but removeFromSuperview];
        ////NSLog(@"butttttt:%i",[buttonsToRemove count]);
    }
            [buttonsToRemove removeAllObjects];
    }

    question.text =@"Thank you for completing this questionnaire.";
      question.numberOfLines = 0;
     //   question.textAlignment = NSTextAlignmentJustified;
      NSDate* now = [NSDate date];
    [[NSUserDefaults standardUserDefaults]setObject:now forKey:@"nowold"];
    [[NSUserDefaults standardUserDefaults]setInteger:1 forKey:@"daily"];
    
    [self explainRecord1];
 //   return;
  
  
}

-(void)complete1
{
    
    
    
    
    
    ////NSLog(@"COMPLETE1[_QuestionArray _QuestionArray]:%@",_QuestionArray);
    ////NSLog(@"COMPLETE1[_QuestionArray _QuestionArray]:%@",_AnswerArray);
    if([buttonsToRemove count]!=0)
    {
        for (int i=0; i<[buttonsToRemove count]; i++)
        {
            UIButton*but=[buttonsToRemove objectAtIndex:i];
            
            
            [but removeFromSuperview];
            ////NSLog(@"butttttt:%i",[buttonsToRemove count]);
        }
        [buttonsToRemove removeAllObjects];
    }
    
    question.text =@"Thank you for completing this questionnaire.";
      question.numberOfLines = 0;
    NSDate* now = [NSDate date];
    [[NSUserDefaults standardUserDefaults]setObject:now forKey:@"nowold"];
    [[NSUserDefaults standardUserDefaults]setInteger:1 forKey:@"daily"];
    
    
    xmlFile=[NSString stringWithFormat:@"<Result><Question>%@,,%@,,%@</Question><Answer>%@,,%@,,%@</Answer></Result>",[_QuestionArray objectAtIndex:0],[_QuestionArray objectAtIndex:1],[_QuestionArray objectAtIndex:2],[_AnswerArray objectAtIndex:0],[_AnswerArray objectAtIndex:1],[_AnswerArray objectAtIndex:2]];
    
    
    NSString *runNumber = [[NSUserDefaults standardUserDefaults] objectForKey:@"loginid"];
    NSString *resultResponse=[self HttpPostEntityFirst:@"patid" ForValue1:runNumber EntitySecond:@"authkey" ForValue2:@"rzTFevN099Km39PV"];
    
  //  NSDate* now = [NSDate date];
    NSString *n=[NSString stringWithFormat:@"%@",now];
    
    
    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
    [outputFormatter setDateFormat:@" d:MM:yyy    h:mm a"];
    
    NSString *timetofill = [outputFormatter stringFromDate:now];
    n=timetofill;
    [recordDict setObject:n forKey:@"date"];
    
    
    int a=[[NSUserDefaults standardUserDefaults]integerForKey:@"selectAss"];
    //NSLog(@"asstype:%i",a);
    if(a==1)
    {
        NSString*str=@"Daily Questionaries";
        [recordDict setObject:str forKey:@"type"];
    }
    else if(a==3)
    {
        NSString*str=@"Monthly Questionaries";
        [recordDict setObject:str forKey:@"type"];
    }
    
    NSString *UserId = [[NSUserDefaults standardUserDefaults] objectForKey:@"loginid"];
    [recordDict setObject:UserId forKey:@"patid"];
     [recordDict setObject:@"" forKey:@"name"];
    [instance insertAudio:recordDict];
    NSMutableArray *ar=[instance getAudio];
    NSString*str=[[ar lastObject]objectForKey:@"pk" ];
    NSString*Astr=[NSString stringWithFormat:@"A%@",[[ar lastObject]objectForKey:@"pk" ]];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *recDir = [paths objectAtIndex:0];
    
    NSString*p=[NSString stringWithFormat:@"%@/%@recordTest.text", recDir,str];
    NSString*pa=[NSString stringWithFormat:@"%@/%@recordTest.text", recDir,Astr];
    //NSLog(@"P:%@",p);
    //NSLog(@"PAp:%@",pa);
    [_QuestionArray writeToFile:p atomically:YES];
    [_AnswerArray writeToFile:pa atomically:YES];
    ////NSLog(@"ResulrTEsponse:%@",resultResponse);
    
   // [self explainRecord1];
    //   return;
    
    
}




-(void)completeAfterRecord
{
    
    
    
    
    
    ////NSLog(@"COMPLETE1[_QuestionArray _QuestionArray]:%@",_QuestionArray);
    ////NSLog(@"COMPLETE1[_QuestionArray _QuestionArray]:%@",_AnswerArray);
    if([buttonsToRemove count]!=0)
    {
        for (int i=0; i<[buttonsToRemove count]; i++)
        {
            UIButton*but=[buttonsToRemove objectAtIndex:i];
            
            
            [but removeFromSuperview];
            ////NSLog(@"butttttt:%i",[buttonsToRemove count]);
        }
        [buttonsToRemove removeAllObjects];
    }
    
    question.text =@"Thank you for completing this questionnaire.";
    question.numberOfLines = 0;
     
    [_QuestionArray addObject:@""];
    [_AnswerArray addObject:@""];
    xmlFile=[NSString stringWithFormat:@"<Result><Question>%@,,%@</Question><Answer>%@,,%@</Answer></Result>",[_QuestionArray objectAtIndex:0],[_QuestionArray objectAtIndex:1],[_AnswerArray objectAtIndex:0],[_AnswerArray objectAtIndex:1]];
    
    
    NSString *runNumber = [[NSUserDefaults standardUserDefaults] objectForKey:@"loginid"];
    NSString *resultResponse=[self HttpPostEntityFirst:@"patid" ForValue1:runNumber EntitySecond:@"authkey" ForValue2:@"rzTFevN099Km39PV"];
    ////NSLog(@"ResulrTEsponse:%@",resultResponse);
    
    // [self explainRecord1];
    //   return;
    
    
}






-(void)speak
{
    SpeakHereViewController *newNoteController = [[SpeakHereViewController alloc] initWithNibName:@"AudioRecord" bundle:nil];
  
    newNoteController.recordDict = recordDict;
    [self.view addSubview:newNoteController.view];
//[self.navigationController pushViewController:newNoteController animated:YES];
    [newNoteController release];
}
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
}
- (void)dealloc {
  
    [audioPlayer release];
    [audioRecorder release];
    [audioPlayerRecord release];
  [super dealloc];
}

@end
