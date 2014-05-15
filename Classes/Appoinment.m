//
//  RootViewController.m
//  PetLove
//
//  Created by CS Soon on 4/17/11.
//  Copyright 2011 Espressoft Technologies. All rights reserved.
//

#import "Appoinment.h"
#import "AppSharedInstance.h"
#import "ListCell.h"
#import "AboutmeViewController.h"
#import "ADLivelyTableView.h"
#import "Addremainder.h"
#import "fileMngr.h"
#define USE_CUSTOM_DRAWING 1
#define USE_CUSTOM_DRAWING 1

@implementation UINavigationBar (CustomImage)

- (void)drawRect:(CGRect)rect {
    UIImage *image = [UIImage imageNamed: @"Top_Panel.png"];
    [image drawInRect:CGRectMake(0, 40, self.frame.size.width, self.frame.size.height)];
}

@end
@implementation Appoinment




AppSharedInstance *instance;


#pragma mark -
#pragma mark View lifecycle



-(IBAction)Addremainder
{
    
}
- (void)viewDidLoad {
    
    
    
    //NSLog(@"APPONment");
    [super viewDidLoad];
    
   // [[UIApplication sharedApplication] cancelAllLocalNotifications];
    myTable.backgroundColor = [UIColor clearColor];
    self.parentViewController.view.backgroundColor = [UIColor colorWithRed:0.0 green:0.2 blue:0.5 alpha:0.7];
    
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
    
    
    //NSLog(@"APP-D-ARRA:%i",[_AppDArr count]);
    //NSLog(@"APP-N-ARR:%i",[_AppNArr count]);
    
    if([[UINavigationBar class] respondsToSelector:@selector(appearance)]) //iOS >=5.0
    {
        [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"Top_Panel.png"] forBarMetrics:UIBarMetricsDefault];
      
     
    }
    ADLivelyTableView * livelyTableView = (ADLivelyTableView *)myTable;
    livelyTableView.initialCellTransformBlock = ADLivelyTransformFan;
   

    share1=NO;
	  // self.title = @"Medication Monitor";
    UILabel *label = [[[UILabel alloc] initWithFrame:CGRectZero] autorelease];
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont boldSystemFontOfSize:20.0];
    label.shadowColor = [UIColor colorWithWhite:0.0 alpha:0.5];
    label.textAlignment = UITextAlignmentCenter;
    label.textColor = [UIColor whiteColor]; // change this color
    self.navigationItem.titleView = label;
    label.text = NSLocalizedString(@"Appoinment", @"");
    [label sizeToFit];
    
   	myTable.rowHeight=100;
	myTable.separatorColor = [UIColor clearColor];
	
    
	[myTable reloadData];
    
  
    
	
}

- (void)segmentedControlChangedValue:(SVSegmentedControl*)segmentedControl 
{
    if(segmentedControl.selectedIndex==0)
    {
         }
    else if(segmentedControl.selectedIndex==1)
    {
              
    }
       
    
}
-(void)back
{
    [[self.navigationController.navigationBar viewWithTag:111]removeFromSuperview];
      [[self navigationController] popViewControllerAnimated:YES];
}

- (void)edit_Clicked {
	if (myTable.editing) 
    {
		myTable.editing=NO;
        //	self.navigationItem.leftBarButtonItem = [[[UIBarButtonItem alloc]
        //		  initWithBarButtonSystemItem:UIBarButtonSystemItemEdit
        //	  target:self action:@selector(edit_Clicked)] autorelease];
        
        UIImage *buttonImage = [UIImage imageNamed:@"Edit.png"];
        //   UIButton *aButton = [UIButton buttonWithType:UIButtonTypeCustom];
        // [aButton setImage:buttonImage forState:UIControlStateNormal];
        //  aButton.frame = CGRectMake(200.0, 8.0, 65, 30);
        //  aButton.tag=111;
        // [aButton addTarget:self action:@selector(edit_Clicked) forControlEvents:UIControlEventTouchUpInside];
        [(UIButton*)[self.navigationController.navigationBar viewWithTag:111] setImage:buttonImage forState:UIControlStateNormal];
        
        
	}		
	else {
		myTable.editing=YES;
        UIImage *buttonImage = [UIImage imageNamed:@"Done.png"];
        //   UIButton *aButton = [UIButton buttonWithType:UIButtonTypeCustom];
        // [aButton setImage:buttonImage forState:UIControlStateNormal];
        //  aButton.frame = CGRectMake(200.0, 8.0, 65, 30);
        //  aButton.tag=111;
        // [aButton addTarget:self action:@selector(edit_Clicked) forControlEvents:UIControlEventTouchUpInside];
        [(UIButton*)[self.navigationController.navigationBar viewWithTag:111] setImage:buttonImage forState:UIControlStateNormal];
		
	}
	[myTable reloadData];
}



- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    	
    
    
    
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

    
    
    
      
    
    
	//self.navigationController.navigationBar.tintColor = [UIColor blackColor];
     [[self.navigationController.navigationBar viewWithTag:121]removeFromSuperview];
      [self.navigationController.navigationBar viewWithTag:111].hidden=NO;
	
	[myTable reloadData];
   
    [myTable reloadData];
    
     //NSLog(@"APP-D-ARR:%i",[_AppDArr count]);
     //NSLog(@"APP-N-ARR:%i",[_AppNArr count]);
        
    
    
}





#pragma mark -
#pragma mark Table view data source

// Customize the number of sections in the table view.
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return 1;
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return [_AppDArr count];
}


// Customize the appearance of table view cells.
/*- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
	static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
    }
    
    // Configure the cell...
    
	NSArray *notificationArray = [[UIApplication sharedApplication] scheduledLocalNotifications];
	UILocalNotification *notif = [notificationArray objectAtIndex:indexPath.row];
	cell.textLabel.font=[UIFont fontWithName:@"Arial" size:30];
    [cell.textLabel setText:notif.alertBody];
   cell.detailTextLabel.textColor = [UIColor greenColor];
	[cell.detailTextLabel setText:[notif.fireDate description]];
	return cell;
}
*/







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
	//UILocalNotification *notif = [notificationArray objectAtIndex:indexPath.row];
	//cell.textLabel.font=[UIFont fontWithName:@"Arial" size:30];
   // [cell.textLabel setText:notif.alertBody];
   // cell.detailTextLabel.textColor = [UIColor greenColor];
	//[cell.detailTextLabel setText:[notif.fireDate description]];
    
    topLabel.text=[_AppDArr objectAtIndex:indexPath.row];
     bottomLabel.text=[_AppNArr objectAtIndex:indexPath.row];
    
	//topLabel.text = notif.alertBody;
	//bottomLabel.text =[notif.fireDate descriptionWithLocale:[[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]autorelease]] ;
	
	
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
    //[self.navigationController.navigationBar viewWithTag:111].hidden=YES;
   
    
    /*AboutmeViewController *aboutmeViewController = [[AboutmeViewController alloc] initWithNibName:@"AddMedi" bundle:nil];
	aboutmeViewController.recordDict=recordDict;
    aboutmeViewController.recordDict = [petArray objectAtIndex:indexPath.section];
    
    [[NSUserDefaults standardUserDefaults] setInteger:indexPath.section forKey:@"select"];
	[self.navigationController pushViewController:aboutmeViewController animated:YES];
	[aboutmeViewController release];*/
  
    if(savedValue==5)
    {
        //[self btnPostPress];
        [self share];
        
       /* AboutmeViewController *aboutmeViewController = [[AboutmeViewController alloc] initWithNibName:@"AboutmeViewController" bundle:nil];
       
        aboutmeViewController.recordDict = [petArray objectAtIndex:indexPath.section];
        [self.navigationController pushViewController:aboutmeViewController animated:YES];
        [aboutmeViewController release];*/
    }
	/*PetViewController *petViewController = [[PetViewController alloc] initWithNibName:@"PetViewController" bundle:nil];
	petViewController.recordDict = [petArray objectAtIndex:indexPath.section];
	[self.navigationController pushViewController:petViewController animated:YES];
	[petViewController release];*/
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
	
	if (editingStyle == UITableViewCellEditingStyleDelete) 
    {
        
        
        
        
        NSArray *notificationArray = [[UIApplication sharedApplication] scheduledLocalNotifications];
        UILocalNotification *notif = [notificationArray objectAtIndex:indexPath.row];
       [[UIApplication sharedApplication] cancelLocalNotification:notif];
    //    [notificationArray ];
        [myTable reloadData];
      
        
		/*[instance deletePet:[petArray objectAtIndex:indexPath.section]];
		self.petArray = [instance getPet];
		[myTable reloadData];
		if ([petArray count] > 0){
			noPet.hidden=YES;
			bgImage.image = [UIImage imageNamed:@"bg.png"];*/
		}
		else{
		//	noPet.hidden=NO;
			//bgImage.image = [UIImage imageNamed:@"firstbg.png"];
		}
	
	
}


#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
	[super didReceiveMemoryWarning];
	
	// Relinquish ownership any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload 
{
	// Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
	// For example: self.myOutlet = nil;
} 







- (void)dealloc {
	[petArray release];
	[super dealloc];
}





@end

