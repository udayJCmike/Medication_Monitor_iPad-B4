//
//  AudioFilesCOntroller.m
//  MediMoni
//
//  Created by hsa1 on 27/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AudioFilesCOntroller.h"
#import "AppSharedInstance.h"
#import <AVFoundation/AVFoundation.h>
#import "SpeakHereViewController.h"

@interface AudioFilesCOntroller ()

@end

@implementation AudioFilesCOntroller
@synthesize recordDict;

AppSharedInstance *instance;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)displayPhoto {
    
	for(UIView *subview in [scrollView subviews]) {
		[subview removeFromSuperview];
	}
	
    
    NSLog(@"PHOTO_ARRAY_COUNT::::::%i",[photoArray count]);
	CGPoint currentPos;
	currentPos.x = 5;
	currentPos.y = 5;
	for (int i=0; i<[photoArray count]; i++) 
    {
		if ((i > 0) && (i%3==0)) {
			currentPos.y = currentPos.y + 105;
			currentPos.x = 5;
		}
		
		NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
		NSString *documentsDirectory = [paths objectAtIndex:0];
		NSString *path = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"au%d.caf", [[[photoArray objectAtIndex:i] objectForKey:@"pk"] intValue]]];	
         
		NSData *imageData = [NSData dataWithContentsOfFile:path];
         NSLog(@"%@", path);
		UIImage *monthImg = [UIImage imageNamed:@"Done.png"];
		
		UIButton *thumbButton = [[UIButton alloc] initWithFrame:CGRectMake(currentPos.x, currentPos.y, 100, 100)];
		thumbButton.tag = i;
		[thumbButton addTarget:self action:@selector(showPhoto:) forControlEvents:UIControlEventTouchUpInside];
		//UIImage *thumbImage = [[UIImage alloc] initWithData:[[photoArray objectAtIndex:i] objectForKey:@"thumbnail"]  ];
		//UIImage *frameImage = [self applyFrame:thumbImage timestamp:[[photoArray objectAtIndex:i] objectForKey:@"timestamp"]];
		//[thumbImage release];
		[thumbButton setBackgroundImage:monthImg forState:UIControlStateNormal];
		[scrollView addSubview:thumbButton];
		[thumbButton release];
		currentPos.x = currentPos.x + 105;
	}	
	if ([photoArray count] > 0) {
		msgLbl.hidden = YES;
	}
	else {
		msgLbl.hidden = NO;
	}
    
	[scrollView setContentSize:CGSizeMake(scrollView.frame.size.width, currentPos.y + 105)];	
}


-(void)showPhoto:(id)sender
{
    
    NSLog(@"PLAY");
    NSError *error;
    	//UIButton *tmpButton = sender;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *path = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"au%i.caf", [[[photoArray objectAtIndex:0] objectForKey:@"pk"] intValue]]];	
    
   //  NSLog(@"FILENAME:%@",[documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"au%i.caf", [[[photoArray objectAtIndex:0] objectForKey:@"pk"] intValue]]] );
    
  NSData *imageData = [NSData dataWithContentsOfFile:path];
  
    NSString *content = [[[NSString alloc] initWithData:imageData
                                               encoding:NSUTF8StringEncoding] autorelease];
    NSLog(@"FILENAME:%@",content);
        NSString *pewPewPath = [[NSBundle mainBundle] 
                            pathForResource:@"au1" ofType:@"caf"];
    NSURL *pewPewURL = [NSURL fileURLWithPath:path isDirectory:YES];
    
    
   AVAudioPlayer* avPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:pewPewURL error:&error];
    [avPlayer prepareToPlay];
    [avPlayer play];

    
}


-(void)back
{
    
    [[self navigationController] popViewControllerAnimated:YES];
}
- (void)viewDidLoad
{
    
    k= [[NSUserDefaults standardUserDefaults]
        integerForKey:@"select"];
   // instance = [AppSharedInstance sharedInstance];
    [super viewDidLoad];
      
	
    UILabel *label = [[[UILabel alloc] initWithFrame:CGRectZero] autorelease];
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont boldSystemFontOfSize:20.0];
    label.shadowColor = [UIColor colorWithWhite:0.0 alpha:0.5];
    label.textAlignment = UITextAlignmentCenter;
    label.textColor = [UIColor whiteColor]; // change this color
    self.navigationItem.titleView = label;
    label.text = NSLocalizedString(@"Audio", @"");
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
    
    
    UIButton *save1 = [UIButton buttonWithType:UIButtonTypeCustom];  
    UIImage *saveImage1 = [UIImage imageNamed:@"+.png"]  ;
    [save1 setBackgroundImage:saveImage1 forState:UIControlStateNormal];  
    [save1 addTarget:self action:@selector(addAudio)  
    forControlEvents:UIControlEventTouchUpInside];  
    save1.frame = CGRectMake(0, 0, 35, 30);  
    UIBarButtonItem *saveButton1 = [[[UIBarButtonItem alloc]  
                                     initWithCustomView:save1] autorelease];  
    self.navigationItem.rightBarButtonItem = saveButton1;
    
    NSLog(@"viewdidload");

}

-(void)addAudio
{
    SpeakHereViewController *newNoteController = [[SpeakHereViewController alloc] initWithNibName:@"AudioRecord" bundle:nil];
   newNoteController.recordDict = recordDict;
    [self.navigationController pushViewController:newNoteController animated:YES];
    [newNoteController release];

}




#pragma mark -
#pragma mark Table view delegate


- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}
- (void)viewWillAppear:(BOOL)animated {
   
    NSLog(@"viewwillappear");
    //instance = [AppSharedInstance sharedInstance];
 //   NSLog(@"sdf::::%i",[[recordDict objectForKey:@"pk"] intValue]);
        photoArray = [instance getPhoto:k];
        [self displayPhoto];
   
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return YES;
}

@end
