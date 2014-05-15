//
/*




*/

#import "SpeakHereController.h"
#import "AppSharedInstance.h"
@implementation SpeakHereController
@synthesize recordDict;
@synthesize player;
@synthesize recorder;

@synthesize btn_record;
@synthesize btn_play;
@synthesize fileDescription;
@synthesize lvlMeter_in;
@synthesize playbackWasInterrupted;
AppSharedInstance *instance;


char *OSTypeToStr(char *buf, OSType t)
{
	char *p = buf;
	char str[4], *q = str;
	*(UInt32 *)str = CFSwapInt32(t);
	for (int i = 0; i < 4; ++i) {
		if (isprint(*q) && *q != '\\')
			*p++ = *q++;
		else {
			sprintf(p, "\\x%02x", *q++);
			p += 4;
		}
	}
	*p = '\0';
	return buf;
}

-(void)setFileDescriptionForFormat: (CAStreamBasicDescription)format withName:(NSString*)name
{
	char buf[5];
	const char *dataFormat = OSTypeToStr(buf, format.mFormatID);
	NSString* description = [[NSString alloc] initWithFormat:@"(%d ch. %s @ %g Hz)", format.NumberChannels(), dataFormat, format.mSampleRate, nil];
	fileDescription.text = description;
	[description release];	
}

#pragma mark Playback routines

-(void)stopPlayQueue
{
	player->StopQueue();
	[lvlMeter_in setAq: nil];
	btn_record.enabled = YES;
}

-(void)pausePlayQueue
{
	player->PauseQueue();
	playbackWasPaused = YES;
}

- (void)stopRecord
{
	// Disconnect our level meter from the audio queue
	[lvlMeter_in setAq: nil];
	
	recorder->StopRecord();
	
	// dispose the previous playback queue
	player->DisposeQueue(true);

	// now create a new queue for the recorded file
	recordFilePath = (CFStringRef)[NSTemporaryDirectory() stringByAppendingPathComponent: @"recordedFile.caf"];
	player->CreateQueueForFile(recordFilePath);
		
    
    int rowId = [instance insertPhoto:[[recordDict objectForKey:@"pk"] intValue]];
	int pk = [instance getPhotoPK:rowId];
    
    NSString *filename = [NSString stringWithFormat:@"au%d.caf",pk];
    NSLog(@"FILENAME:%@",filename);
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
//	[UIImagePNGRepresentation(thumbImage) writeToFile:[documentsDirectory stringByAppendingPathComponent:filename] atomically:YES];	
    
      // NSString *file1 = [[NSBundle mainBundle] pathForResource:@"file1" ofType:@"caf"]; // Using PCM format
    
 
     NSData *file1Data = [[NSData alloc] initWithContentsOfFile:@"recordedFile.caf"];
     [file1Data writeToFile:[documentsDirectory stringByAppendingPathComponent:filename] atomically:YES];
    
    
    
    
    
    
//	[UIImagePNGRepresentation(thumbImage) writeToFile:[documentsDirectory stringByAppendingPathComponent:filename] atomically:YES];	

    
   
	// Set the button's state back to "record"
	btn_record.title = @"Record";
	btn_play.enabled = YES;
}
-(void)viewDidLoad
{
    
    [super viewDidLoad];
}
- (void)viewWillAppear:(BOOL)animated {
    
   
	photoArray = [instance getPhoto:[[recordDict objectForKey:@"pk"] intValue]];
	
}
- (IBAction)play:(id)sender
{
	if (player->IsRunning())
	{
		if (playbackWasPaused) {
			OSStatus result = player->StartQueue(true);
			if (result == noErr)
				[[NSNotificationCenter defaultCenter] postNotificationName:@"playbackQueueResumed" object:self];
		}
		else
			[self stopPlayQueue];
	}
	else
	{		
		OSStatus result = player->StartQueue(false);
		if (result == noErr)
			[[NSNotificationCenter defaultCenter] postNotificationName:@"playbackQueueResumed" object:self];
	}
}

- (IBAction)record:(id)sender
{
    
    
     self.view.frame=CGRectMake(0, 600, 768, 400);
    
	if (recorder->IsRunning()) // If we are currently recording, stop and save the file.
	{
		[self stopRecord];
	}
	else // If we're not recording, start.
	{
		btn_play.enabled = NO;	
		
		// Set the button's state to "stop"
		btn_record.title = @"Stop";
				
		// Start the recorder
		recorder->StartRecord(CFSTR("recordedFile.caf"));
		
		[self setFileDescriptionForFormat:recorder->DataFormat() withName:@"Recorded File"];
		
		// Hook the level meter up to the Audio Queue for the recorder
		[lvlMeter_in setAq: recorder->Queue()];
	}	
}

#pragma mark AudioSession listeners
void interruptionListener(	void *	inClientData,
							UInt32	inInterruptionState)
{
	SpeakHereController *THIS = (SpeakHereController*)inClientData;
	if (inInterruptionState == kAudioSessionBeginInterruption)
	{
		if (THIS->recorder->IsRunning()) {
			[THIS stopRecord];
		}
		else if (THIS->player->IsRunning()) {
			//the queue will stop itself on an interruption, we just need to update the UI
			[[NSNotificationCenter defaultCenter] postNotificationName:@"playbackQueueStopped" object:THIS];
			THIS->playbackWasInterrupted = YES;
		}
	}
	else if ((inInterruptionState == kAudioSessionEndInterruption) && THIS->playbackWasInterrupted)
	{
		// we were playing back when we were interrupted, so reset and resume now
		THIS->player->StartQueue(true);
		[[NSNotificationCenter defaultCenter] postNotificationName:@"playbackQueueResumed" object:THIS];
		THIS->playbackWasInterrupted = NO;
	}
}

void propListener(	void *                  inClientData,
					AudioSessionPropertyID	inID,
					UInt32                  inDataSize,
					const void *            inData)
{
	SpeakHereController *THIS = (SpeakHereController*)inClientData;
	if (inID == kAudioSessionProperty_AudioRouteChange)
	{
		CFDictionaryRef routeDictionary = (CFDictionaryRef)inData;			
		//CFShow(routeDictionary);
		CFNumberRef reason = (CFNumberRef)CFDictionaryGetValue(routeDictionary, CFSTR(kAudioSession_AudioRouteChangeKey_Reason));
		SInt32 reasonVal;
		CFNumberGetValue(reason, kCFNumberSInt32Type, &reasonVal);
		if (reasonVal != kAudioSessionRouteChangeReason_CategoryChange)
		{
			/*CFStringRef oldRoute = (CFStringRef)CFDictionaryGetValue(routeDictionary, CFSTR(kAudioSession_AudioRouteChangeKey_OldRoute));
			if (oldRoute)	
			{
				printf("old route:\n");
				CFShow(oldRoute);
			}
			else 
				printf("ERROR GETTING OLD AUDIO ROUTE!\n");
			
			CFStringRef newRoute;
			UInt32 size; size = sizeof(CFStringRef);
			OSStatus error = AudioSessionGetProperty(kAudioSessionProperty_AudioRoute, &size, &newRoute);
			if (error) printf("ERROR GETTING NEW AUDIO ROUTE! %d\n", error);
			else
			{
				printf("new route:\n");
				CFShow(newRoute);
			}*/

			if (reasonVal == kAudioSessionRouteChangeReason_OldDeviceUnavailable)
			{			
				if (THIS->player->IsRunning()) 
                {
					[THIS pausePlayQueue];
					[[NSNotificationCenter defaultCenter] postNotificationName:@"playbackQueueStopped" object:THIS];
				}		
			}

			// stop the queue if we had a non-policy route change
			if (THIS->recorder->IsRunning()) {
				[THIS stopRecord];
			}
		}	
	}
	else if (inID == kAudioSessionProperty_AudioInputAvailable)
	{
		if (inDataSize == sizeof(UInt32)) {
			UInt32 isAvailable = *(UInt32*)inData;
			// disable recording if input is not available
			THIS->btn_record.enabled = (isAvailable > 0) ? YES : NO;
		}
	}
}
				
#pragma mark Initialization routines
- (void)awakeFromNib
{		
	// Allocate our singleton instance for the recorder & player object
	recorder = new AQRecorder();
	player = new AQPlayer();
		
	OSStatus error = AudioSessionInitialize(NULL, NULL, interruptionListener, self);
	if (error) printf("ERROR INITIALIZING AUDIO SESSION! %d\n", error);
	else 
	{
		UInt32 category = kAudioSessionCategory_PlayAndRecord;	
		error = AudioSessionSetProperty(kAudioSessionProperty_AudioCategory, sizeof(category), &category);
		if (error) printf("couldn't set audio category!");
									
		error = AudioSessionAddPropertyListener(kAudioSessionProperty_AudioRouteChange, propListener, self);
		if (error) printf("ERROR ADDING AUDIO SESSION PROP LISTENER! %d\n", error);
		UInt32 inputAvailable = 0;
		UInt32 size = sizeof(inputAvailable);
		
		// we do not want to allow recording if input is not available
		error = AudioSessionGetProperty(kAudioSessionProperty_AudioInputAvailable, &size, &inputAvailable);
		if (error) printf("ERROR GETTING INPUT AVAILABILITY! %d\n", error);
		btn_record.enabled = (inputAvailable) ? YES : NO;
		
		// we also need to listen to see if input availability changes
		error = AudioSessionAddPropertyListener(kAudioSessionProperty_AudioInputAvailable, propListener, self);
		if (error) printf("ERROR ADDING AUDIO SESSION PROP LISTENER! %d\n", error);

		error = AudioSessionSetActive(true); 
		if (error) printf("AudioSessionSetActive (true) failed");
	}
	
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playbackQueueStopped:) name:@"playbackQueueStopped" object:nil];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playbackQueueResumed:) name:@"playbackQueueResumed" object:nil];

	UIColor *bgColor = [[UIColor alloc] initWithRed:.39 green:.44 blue:.57 alpha:.5];
	[lvlMeter_in setBackgroundColor:bgColor];
	[lvlMeter_in setBorderColor:bgColor];
	[bgColor release];
	
	// disable the play button since we have no recording to play yet
	btn_play.enabled = NO;
	playbackWasInterrupted = NO;
	playbackWasPaused = NO;
}

# pragma mark Notification routines
- (void)playbackQueueStopped:(NSNotification *)note
{
	btn_play.title = @"Play";
	[lvlMeter_in setAq: nil];
	btn_record.enabled = YES;
}

- (void)playbackQueueResumed:(NSNotification *)note
{
	btn_play.title = @"Stop";
	btn_record.enabled = NO;
	[lvlMeter_in setAq: player->Queue()];
}

#pragma mark Cleanup
- (void)dealloc
{
	[btn_record release];
	[btn_play release];
	[fileDescription release];
	[lvlMeter_in release];
	
	delete player;
	delete recorder;
	
	[super dealloc];
}

@end
