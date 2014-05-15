//
//  NoteViewController.m
//  PetLove
//
//  Created by CS Soon on 4/8/11.
//  Copyright 2011 Espressoft Technologies. All rights reserved.
//

#import "NoteViewController.h"
#import "NewNoteController.h"
#import "AppSharedInstance.h"
#import "ADLivelyTableView.h"
@implementation NoteViewController
@synthesize notesArray;
@synthesize recordDict;
AppSharedInstance *instance;

#pragma mark -
#pragma mark View lifecycle

-(void)back
{

    [[self navigationController] popViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
   
    ADLivelyTableView * livelyTableView = (ADLivelyTableView *)myTable;
    livelyTableView.initialCellTransformBlock = ADLivelyTransformTilt;
    

	instance = [AppSharedInstance sharedInstance];
    UILabel *label = [[[UILabel alloc] initWithFrame:CGRectZero] autorelease];
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont boldSystemFontOfSize:20.0];
    label.shadowColor = [UIColor colorWithWhite:0.0 alpha:0.5];
    label.textAlignment = UITextAlignmentCenter;
    label.textColor = [UIColor whiteColor]; // change this color
    self.navigationItem.titleView = label;
    label.text = NSLocalizedString(@"Notes", @"");
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
    [save1 addTarget:self action:@selector(addNotes)  
    forControlEvents:UIControlEventTouchUpInside];  
    save1.frame = CGRectMake(0, 0, 35, 30);  
    UIBarButtonItem *saveButton1 = [[[UIBarButtonItem alloc]  
                                     initWithCustomView:save1] autorelease];  
    self.navigationItem.rightBarButtonItem = saveButton1;
    
    
	
	//self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:57.0/255.0 green:57.0/255.0 blue:57.0/255.0 alpha:1.0];

    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
	if (buttonIndex == 1) 
	{	
        
           
        
        
		//[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://itunes.apple.com/us/app/id437425138?mt=8"]];
	}
}

-(void)addNotes 
{
    
        NewNoteController *newNoteController = [[NewNoteController alloc] initWithNibName:@"NewNote" bundle:nil];
        newNoteController.pid = [[recordDict objectForKey:@"pk"] intValue];
        [self.navigationController pushViewController:newNoteController animated:YES];
        [newNoteController release];
    
	
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
	self.notesArray = [instance getNotes:[[recordDict objectForKey:@"pk"] intValue]];
	[myTable reloadData];
	if ([notesArray count] > 0) {
		msgLbl.hidden = YES;
	}
	else {
		msgLbl.hidden = NO;
	}

}


#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [notesArray count];
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier] autorelease];
    }
    cell.textLabel.text = [[notesArray objectAtIndex:indexPath.row] objectForKey:@"notes"];
	
	NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
	[formatter setDateFormat:@"yyyymmdd"];
	NSDate *startDate = [formatter dateFromString:[[notesArray objectAtIndex:indexPath.row] objectForKey:@"date"]];
	[formatter setDateFormat:@"MMM dd"];
	cell.detailTextLabel.text = [formatter stringFromDate:startDate];

	[formatter release];
	

	cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    // Configure the cell...
    
    return cell;
}

#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	NewNoteController *newNoteController = [[NewNoteController alloc] initWithNibName:@"NewNote" bundle:nil];
	newNoteController.pid = [[recordDict objectForKey:@"pk"] intValue];
	newNoteController.recordDict = [notesArray objectAtIndex:indexPath.row];
	[self.navigationController pushViewController:newNoteController animated:YES];
	[newNoteController release];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
		[instance deleteNotes:[notesArray objectAtIndex:indexPath.row]];
		self.notesArray = [instance getNotes:[[recordDict objectForKey:@"pk"] intValue]];
		[myTable reloadData];
	}
	
}

#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Relinquish ownership any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
    // For example: self.myOutlet = nil;
}



- (void)dealloc {
	[notesArray release];
	[recordDict release];
    [super dealloc];
}


@end

