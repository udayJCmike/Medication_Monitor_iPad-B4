//
//  RootViewController.h
//  PetLove
//
//  Created by CS Soon on 4/17/11.
//  Copyright 2011 Espressoft Technologies. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <UIKit/UIKit.h>
#import "SVSegmentedControl.h"

@interface Appoinment : UIViewController<UIActionSheetDelegate> {
	NSArray *petArray;
	IBOutlet UITableView *myTable;
	IBOutlet UILabel *noPet;
	IBOutlet UIImageView *bgImage;
  
    BOOL share1;
    int savedValue;
    NSString*appoFile;
    NSString*appoNFile;
    NSMutableArray *_AppDArr;
    NSMutableArray *_AppNArr;
  
}



@end
