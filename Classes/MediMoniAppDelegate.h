//
//  MediMoniAppDelegate.h
//  MediMoni
//
//  Created by Aj-Earnest on 7/21/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GTabBar.h"


@interface MediMoniAppDelegate : NSObject <UIApplicationDelegate,UITabBarControllerDelegate> {
    
    NSString *databaseName;
	NSString *databasePath;	
    NSMutableArray*notificationsArray;
    UIWindow *window;
    UITabBarController *tabBarController;
    GTabBar *tabView;
}
- (void)createEditableCopyOfDatabaseIfNeeded;
@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) UITabBarController *tabBarController;
@property (nonatomic, retain) NSMutableArray*notificationsArray;

@end

