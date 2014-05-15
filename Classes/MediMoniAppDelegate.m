//
//  MediMoniAppDelegate.m
//  MediMoni
//
//  Created by Aj-Earnest on 7/21/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "MediMoniAppDelegate.h"
#import "MainViewController.h"
#import "GTabBar.h"
#import <QuartzCore/QuartzCore.h>
#import "JSON.h"
@implementation MediMoniAppDelegate

@synthesize window;
@synthesize tabBarController;
@synthesize notificationsArray;

- (void)applicationWillResignActive:(UIApplication *)application {
    
   // [self arrangeBadgeNumbers];
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
     If your application supports background execution, called instead of applicationWillTerminate: when the user quits.
     */
   // [self arrangeBadgeNumbers];
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    /*
     Called as part of  transition from the background to the inactive state: here you can undo many of the changes made on entering the background.
     */
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}


- (void)applicationWillTerminate:(UIApplication *)application
{
  //  [self arrangeBadgeNumbers];
  }


#pragma mark -
#pragma mark Memory management

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
   
}

-(void)arrangeBadgeNumbers{
    self.notificationsArray = [NSMutableArray arrayWithArray:[[UIApplication sharedApplication] scheduledLocalNotifications]];
    //NSLog(@"notifications array count: %d",self.notificationsArray.count);
    NSMutableArray *fireDates = [[NSMutableArray alloc]init];
    for (NSInteger i=0; i<self.notificationsArray.count; i++)
    {
        UILocalNotification *notif = [self.notificationsArray objectAtIndex:i];
        NSDate *firedate = notif.fireDate;
        [fireDates addObject:firedate];
    }
    NSArray *sortedFireDates= [fireDates sortedArrayUsingSelector:@selector(compare:)];
    
    for (NSInteger i=0; i<self.notificationsArray.count; i++)
    {
        UILocalNotification *notif = [self.notificationsArray objectAtIndex:i];
        notif.applicationIconBadgeNumber=[sortedFireDates indexOfObject:notif.fireDate]+1;
    }
    [[UIApplication sharedApplication] setScheduledLocalNotifications:self.notificationsArray];
    [fireDates release];
}

- (void)createEditableCopyOfDatabaseIfNeeded {
    BOOL success;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *writableDBPath = [documentsDirectory stringByAppendingPathComponent:databaseName];
	success = [fileManager fileExistsAtPath:writableDBPath];
    if (success) return;
    // The writable database does not exist, so copy the default to the appropriate location.
    NSString *defaultDBPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:databaseName];
    success = [fileManager copyItemAtPath:defaultDBPath toPath:writableDBPath error:&error];
    if (!success) {
        NSAssert1(0, @"Failed to create writable database file with message '%@'.", [error localizedDescription]);
        
    }
}

- (void)application:(UIApplication *)app didReceiveLocalNotification:(UILocalNotification *)notif {
    
  NSLog(@"Notification Recived, %@, set for Date %@",notif.alertBody,notif.fireDate);
   
}
- (void)application:(UIApplication *)app didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)devToken {
    const void *devTokenBytes = [devToken bytes];
 
  
}

- (void)application:(UIApplication *)app didFailToRegisterForRemoteNotificationsWithError:(NSError *)err {
 //   NSLog(@"Error in registration. Error: %@", err);
}
- (void)applicationDidFinishLaunching:(UIApplication *)application 
{    
   [[UIApplication sharedApplication] registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound)];
    
  //  UILocalNotification *localNotif =[launchOptions objectForKey:UIApplicationLaunchOptionsLocalNotificationKey];
    
    application.applicationIconBadgeNumber=0;
    
    databaseName = @"petlove1.0.db";
    
        [[NSUserDefaults standardUserDefaults]setInteger:1 forKey:@"syncType"];
	[self createEditableCopyOfDatabaseIfNeeded];
    
    
    
   // NSLog(@"%f", window.frame.size.height);
    
    GTabTabItem *tabItem1;
    GTabTabItem *tabItem2;
    GTabTabItem *tabItem3;
    GTabTabItem *tabItem4;
    GTabTabItem *tabItem5;
    GTabTabItem *tabItem6;
    GTabTabItem *tabItem7;
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        
       tabItem1 = [[GTabTabItem alloc] initWithFrame:CGRectMake(0, 0.6 ,109.7/2, 109/2) normalState:@"Home1.png" toggledState:@"Home2.png"];
        tabItem2 = [[GTabTabItem alloc] initWithFrame:CGRectMake((109.7/2), 0.6 ,109.7/2, 109/2)normalState:@"Medication1.png" toggledState:@"Medication2.png"];
       tabItem3 = [[GTabTabItem alloc] initWithFrame:CGRectMake((109.7/2)*2, 0.6 ,109.7/2, 109/2) normalState:@"Reminders1.png" toggledState:@"Reminders2.png"];
        tabItem4 = [[GTabTabItem alloc] initWithFrame:CGRectMake((109.7/2)*3,0.6 ,109.7/2, 109/2) normalState:@"Assesment1.png" toggledState:@"Assesment2.png"];
        tabItem5 = [[GTabTabItem alloc] initWithFrame:CGRectMake((109.7/2)*4, 0.6 ,109.7/2, 109/2) normalState:@"Appointment1.png" toggledState:@"Appointment2.png"];
        tabItem6 = [[GTabTabItem alloc] initWithFrame:CGRectMake((109.7/2)*5, 0.6 ,109.7/2, 109/2) normalState:@"Communicate1.png" toggledState:@"Communicate2.png"];
     tabItem7 = [[GTabTabItem alloc] initWithFrame:CGRectMake((109.7/2)*6, 0.6 ,109.7/2, 109/2) normalState:@"Settings1.png" toggledState:@"Settings2.png"];
    }
    else
    {
       tabItem1 = [[GTabTabItem alloc] initWithFrame:CGRectMake(0, 0.6 ,109.7, 109) normalState:@"Home1.png" toggledState:@"Home2.png"];
      tabItem2 = [[GTabTabItem alloc] initWithFrame:CGRectMake(109.7, 0.6 ,109.7, 109)normalState:@"Medication1.png" toggledState:@"Medication2.png"];
     tabItem3 = [[GTabTabItem alloc] initWithFrame:CGRectMake(109.7*2, 0.6 ,109.7, 109) normalState:@"Reminders1.png" toggledState:@"Reminders2.png"];
        tabItem4 = [[GTabTabItem alloc] initWithFrame:CGRectMake(109.7*3,0.6 ,109.7, 109) normalState:@"Assesment1.png" toggledState:@"Assesment2.png"];
        tabItem5 = [[GTabTabItem alloc] initWithFrame:CGRectMake(109.7*4, 0.6 ,109.7, 109) normalState:@"Appointment1.png" toggledState:@"Appointment2.png"];
       tabItem6 = [[GTabTabItem alloc] initWithFrame:CGRectMake(109.7*5, 0.6 ,109.7, 109) normalState:@"Communicate1.png" toggledState:@"Communicate2.png"];
        tabItem7 = [[GTabTabItem alloc] initWithFrame:CGRectMake(109.7*6, 0.6 ,109.7, 109) normalState:@"Settings1.png" toggledState:@"Settings2.png"];
    }

   
    
    
	
	MainViewController *viewController1 =[[[MainViewController alloc] initWithNibName:@"MainViewController.xib" bundle:nil] autorelease];
    
	viewController1.tabBarItem.title = @"Home";
    viewController1.tabBarItem.image = [UIImage imageNamed:@"Button.png"];
    
    
    
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
     
    } else {
    
    }
    
    
	MainViewController *viewController2 = [[[MainViewController alloc] initWithNibName:@"MainViewController.xib" bundle:nil] autorelease];
    
	viewController2.tabBarItem.title = @"Medication";
    viewController2.tabBarItem.image = [UIImage imageNamed:@"Button.png"];
    
    
    
    
    
    
	MainViewController *viewController3 =[[[MainViewController alloc] initWithNibName:nil bundle:nil] autorelease];
	viewController3.tabBarItem.title = @"Remainders";
    viewController3.tabBarItem.image = [UIImage imageNamed:@"Button.png"];
    
    
    
    
    
    
    
	MainViewController *viewController4 =[[[MainViewController alloc] initWithNibName:nil bundle:nil] autorelease];
	viewController4.tabBarItem.title = @"Assessment";
    viewController4.tabBarItem.image = [UIImage imageNamed:@"Button.png"];

    
    
    
    
    
    MainViewController *viewController5 =[[[MainViewController alloc] initWithNibName:nil bundle:nil] autorelease];
	viewController5.tabBarItem.title = @"Appoinment";
    viewController5.tabBarItem.image = [UIImage imageNamed:@"Button.png"];
    
    MainViewController *viewController6 = [[[MainViewController alloc] initWithNibName:nil bundle:nil] autorelease];
	viewController6.tabBarItem.title = @"Communicate";
    viewController6.tabBarItem.image = [UIImage imageNamed:@"Button.png"];
    
    MainViewController *viewController7 =[[[MainViewController alloc] initWithNibName:nil bundle:nil] autorelease];
	viewController7.tabBarItem.title = @"Settings";
    viewController7.tabBarItem.image = [UIImage imageNamed:@"Button.png"];
    
    
    
    NSMutableArray *viewControllersArray = [[NSMutableArray alloc] init];
	[viewControllersArray addObject:viewController1];
	[viewControllersArray addObject:viewController2];
	[viewControllersArray addObject:viewController3];
	[viewControllersArray addObject:viewController4];
	[viewControllersArray addObject:viewController5];
    [viewControllersArray addObject:viewController6];
    [viewControllersArray addObject:viewController7];
    // [viewControllersArray addObject:viewController6];
	
	NSMutableArray *tabItemsArray = [[NSMutableArray alloc] init];
	[tabItemsArray addObject:tabItem1];
	[tabItemsArray addObject:tabItem2];
	[tabItemsArray addObject:tabItem3];
	[tabItemsArray addObject:tabItem4];
	[tabItemsArray addObject:tabItem5];
    [tabItemsArray addObject:tabItem6];
    [tabItemsArray addObject:tabItem7];
    // [tabItemsArray addObject:tabItem6];
    
    
    
	tabView = [[GTabBar alloc] initWithTabViewControllers:viewControllersArray tabItems:tabItemsArray initialTab:0];
    
    
	[window addSubview:tabView.view];
    
    
    // Override point for customization after application launch
    [window makeKeyAndVisible];
    
    
    
    
}


- (void)dealloc {
	[tabBarController release];
    [window release];
    [super dealloc];
}


@end
