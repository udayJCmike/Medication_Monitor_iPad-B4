//
//  NewNoteController.m
//  PetLove
//
//  Created by CS Soon on 4/8/11.
//  Copyright 2011 Espressoft Technologies. All rights reserved.
//

#import "NewNoteController.h"
#import "AppSharedInstance.h"

@implementation NewNoteController
@synthesize pid;
@synthesize recordDict;
AppSharedInstance *instance;
// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
/*
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
    }
    return self;
}
*/
-(void)back
{
    
    [[self navigationController] popViewControllerAnimated:YES];
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad 
{
    [super viewDidLoad];
    
    UILabel *label = [[[UILabel alloc] initWithFrame:CGRectZero] autorelease];
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont boldSystemFontOfSize:20.0];
    label.shadowColor = [UIColor colorWithWhite:0.0 alpha:0.5];
    label.textAlignment = UITextAlignmentCenter;
    label.textColor = [UIColor whiteColor]; // change this color
  
    
    
	if ([recordDict count] > 0) 
    {
	
		notesText.text = [recordDict objectForKey:@"notes"];
         label.text = NSLocalizedString(@"Edit Notes", @"");
	}
	else
    {
		
         label.text = NSLocalizedString(@"Add Notes", @"");
    }
    self.navigationItem.titleView = label;
   
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
    
    UIButton *save = [UIButton buttonWithType:UIButtonTypeCustom];  
    UIImage *saveImage = [UIImage imageNamed:@"Save.png"]  ;
    [save setBackgroundImage:saveImage forState:UIControlStateNormal];  
    [save addTarget:self action:@selector(saveNotes)  
   forControlEvents:UIControlEventTouchUpInside];  
    save.frame = CGRectMake(0, 0, 50, 30);  
    UIBarButtonItem *saveButton = [[[UIBarButtonItem alloc]  
                                    initWithCustomView:save] autorelease];  
    self.navigationItem.rightBarButtonItem = saveButton;
    
    
    
	}

- (void)saveNotes 
{
	NSMutableDictionary *dbDict = [[NSMutableDictionary alloc] init];
	[dbDict setObject:notesText.text forKey:@"notes"];
	[dbDict setObject:[NSNumber numberWithInt:pid] forKey:@"pid"];
	NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
	[formatter setDateFormat:@"yyyymmdd"];
	[dbDict setObject:[formatter stringFromDate:[NSDate date]] forKey:@"date"];

	if ([recordDict count] > 0) {
		[dbDict setObject:[NSNumber numberWithInt:[[recordDict objectForKey:@"pk"] intValue]] forKey:@"pk"];
		[instance updateNotes:dbDict];
	}
	else
		[instance insertNotes:dbDict];
	[dbDict release];
	[self.navigationController popViewControllerAnimated:YES];
}
/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
	[recordDict release];
    [super dealloc];
}


@end
