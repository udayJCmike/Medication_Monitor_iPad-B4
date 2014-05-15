//
//  RootViewController.m
//  PetLove
//
//  Created by CS Soon on 4/17/11.
//  Copyright 2011 Espressoft Technologies. All rights reserved.
//

#import "RootViewController.h"
#import "AppSharedInstance.h"
#import "ListCell.h"
#import "AboutmeViewController.h"
#import "ADLivelyTableView.h"


@implementation UINavigationBar (CustomImage)

- (void)drawRect:(CGRect)rect {
    UIImage *image = [UIImage imageNamed: @"Top_Panel.png"];
    [image drawInRect:CGRectMake(0, 40, self.frame.size.width, self.frame.size.height)];
}

@end
@implementation RootViewController
@synthesize petArray;
@synthesize recordDict;
AppSharedInstance *instance;

#pragma mark -
#pragma mark View lifecycle


- (void)viewDidLoad {
    
    UIImageView *i=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"BG.jpg"]];
    //[self.view addSubview:i];
    //[self.view sendSubviewToBack:i];
    
    [super viewDidLoad];
    
  
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
    label.text = NSLocalizedString(@"Medication Monitor", @"");
    [label sizeToFit];
    
    
	myTable.rowHeight=110;
	myTable.separatorColor = [UIColor clearColor];
	instance = [AppSharedInstance sharedInstance];
	//UIImage *barButton = [UIImage imageNamed:@"Edit.png"];
   // [[UIBarButtonItem appearance] setBackgroundImage:barButton forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
	
	//UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:nil action:nil];
	//self.navigationItem.backBarButtonItem = backButton;
	//[backButton release];
    
    UIButton *home = [UIButton buttonWithType:UIButtonTypeCustom];  
    UIImage *homeImage = [UIImage imageNamed:@"back.png"]  ;
    [home setBackgroundImage:homeImage forState:UIControlStateNormal];  
    [home addTarget:self action:@selector(back)  
   forControlEvents:UIControlEventTouchUpInside];  
    home.frame = CGRectMake(0, 0, 50, 30);  
    UIBarButtonItem *cancelButton = [[[UIBarButtonItem alloc]  
                                      initWithCustomView:home] autorelease];  
    //self.navigationItem.leftBarButtonItem = cancelButton;	
	
     savedValue = [[NSUserDefaults standardUserDefaults]
                      integerForKey:@"ApptType"];
    
    savedValue=1;
    if(savedValue!=5)
    {
        

        
	UIImage *buttonImage = [UIImage imageNamed:@"Edit.png"];
	UIButton *aButton = [UIButton buttonWithType:UIButtonTypeCustom];
	[aButton setImage:buttonImage forState:UIControlStateNormal];
	aButton.frame = CGRectMake(0, 0, 50, 30);
        aButton.tag=111;
	[aButton addTarget:self action:@selector(edit_Clicked) forControlEvents:UIControlEventTouchUpInside];
   // [self.navigationController.navigationBar addSubview:aButton];
        UIBarButtonItem *saveButton11 = [[[UIBarButtonItem alloc]  
                                         initWithCustomView:aButton] autorelease];  
        self.navigationItem.leftBarButtonItem = saveButton11;
        	
	    
    
    UIButton *save1 = [UIButton buttonWithType:UIButtonTypeCustom];  
          save1.frame = CGRectMake(0, 0, 35, 30);  
    UIImage *saveImage1 = [UIImage imageNamed:@"+.png"]  ;
    [save1 setBackgroundImage:saveImage1 forState:UIControlStateNormal];  
    [save1 addTarget:self action:@selector(addPet)  
   forControlEvents:UIControlEventTouchUpInside];  
  
    UIBarButtonItem *saveButton1 = [[[UIBarButtonItem alloc]  
                                    initWithCustomView:save1] autorelease];  
     
    self.navigationItem.rightBarButtonItem = saveButton1;
    }
    
    
    
    
    
	
}
-(void)back
{
    [[self.navigationController.navigationBar viewWithTag:111]removeFromSuperview];
      [[self navigationController] popViewControllerAnimated:YES];
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
	//self.navigationController.navigationBar.tintColor = [UIColor blackColor];
     [[self.navigationController.navigationBar viewWithTag:121]removeFromSuperview];
      [self.navigationController.navigationBar viewWithTag:111].hidden=NO;
	self.petArray = [instance getPet];
       NSLog(@"self.petarray:%@",self.petArray);
    NSMutableArray*a=[[NSMutableArray alloc]init];
   // for (id anUpdate in self.petArray)
  //  {
       // NSDictionary *arrayList=[(NSDictionary*)anUpdate objectForKey:@"patid"];
        NSLog(@"%i",[self.petArray count]);
        for(int j=0;j<[self.petArray count];j++)
        {
            NSLog(@"yes");
        NSString*s1= [[self.petArray objectAtIndex:j] objectForKey:@"patid"];
          NSString *UserId = [[NSUserDefaults standardUserDefaults] objectForKey:@"loginid"];
      //  NSLog(@"AAAAAAAAAAs1:%@",UserId);
        //  //NSLog(@"s:%@",s);
        if([s1 isEqualToString:UserId])
        {
            [a addObject:[self.petArray objectAtIndex:j]];
        
            
        }
        }
       
   // }
    self.petArray=a;
        NSLog(@"YES:%@",petArray);
    
    
//NSLog(@"Petarrat:%@",self.petArray);
    
	[myTable reloadData];
	if ([petArray count] > 0){
		noPet.hidden=YES;
		bgImage.image = [UIImage imageNamed:@"Background.jpg"];
	}
	else{
		noPet.hidden=NO;
		//bgImage.image = [UIImage imageNamed:@"firstbg.png"];
	}
    
    
    
    
 /*   self.title = [recordDict objectForKey:@"name"];
	//name.text = [recordDict objectForKey:@"name"];
	if ([[recordDict objectForKey:@"breed"] length] > 0)
	//	breed.text = [NSString stringWithFormat:@"Breed: %@",[recordDict objectForKey:@"breed"]];
	else
	//	breed.text = @"Breed: unknown";
	
	if ([[recordDict objectForKey:@"dob"] length] > 0) {
		//age.text = [NSString stringWithFormat:@"Age: %@",[self calculateAge:[recordDict objectForKey:@"dob"]]];
	}
	else {
	//	age.text = @"Age: unspecified";
	}*/
	
	
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
	NSString *path = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"pet_%d.png",[[recordDict objectForKey:@"pk"] intValue]]];			

    
    
    
    
    
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

- (void)addPet {
    
    
       //   [self.navigationController.navigationBar viewWithTag:111].hidden=YES;
        AboutmeViewController *aboutmeViewController = [[AboutmeViewController alloc] initWithNibName:@"AddMedi" bundle:nil];
      //  aboutmeViewController.recordDict=recordDict;
        //  aboutmeViewController.recordDict = ;
        [self.navigationController pushViewController:aboutmeViewController animated:YES];
        [aboutmeViewController release];	
   
   
    
 		
	//}
}


#pragma mark -
#pragma mark Table view data source

// Customize the number of sections in the table view.
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return [petArray count];
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return 1;
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
	static NSString *CellIdentifier = @"Cell";
	ListCell *cell = (ListCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	if (cell == nil) {
		cell = [[[ListCell alloc] initWithFrame:CGRectZero reuseIdentifier:CellIdentifier] autorelease];
	}
	
	[cell setData:[petArray objectAtIndex:indexPath.section]];
	// Configure the cell.
	cell.selectionStyle = UITableViewCellSelectionStyleNone;
	return cell;
}


#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath 
{
    //[self.navigationController.navigationBar viewWithTag:111].hidden=YES;
   
    
    AboutmeViewController *aboutmeViewController = [[AboutmeViewController alloc] initWithNibName:@"AddMedi" bundle:nil];
	aboutmeViewController.recordDict=recordDict;
    aboutmeViewController.recordDict = [petArray objectAtIndex:indexPath.section];
    ////NSLog(@"aboutmeViewController.recordDict:%@",aboutmeViewController.recordDict);
    [[NSUserDefaults standardUserDefaults] setInteger:indexPath.section forKey:@"select"];
	[self.navigationController pushViewController:aboutmeViewController animated:YES];
	[aboutmeViewController release];
  
    if(savedValue==5)
    {
        //[self btnPostPress];
        [self share];
         self.recordDict=recordDict;
        self.recordDict=[petArray objectAtIndex:indexPath.section];
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
	
	if (editingStyle == UITableViewCellEditingStyleDelete) {
		[instance deletePet:[petArray objectAtIndex:indexPath.section]];
		self.petArray = [instance getPet];
		[myTable reloadData];
		if ([petArray count] > 0){
			noPet.hidden=YES;
			bgImage.image = [UIImage imageNamed:@"bg.png"];
		}
		else{
			noPet.hidden=NO;
			//bgImage.image = [UIImage imageNamed:@"firstbg.png"];
		}
	}
	
}


#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
	[super didReceiveMemoryWarning];
	
	// Relinquish ownership any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
	// For example: self.myOutlet = nil;
}







- (void)dealloc {
	[petArray release];
	[super dealloc];
}





@end

