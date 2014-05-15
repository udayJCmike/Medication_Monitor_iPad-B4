//
//  Welcome.h
//  MediMoni
//
//  Created by hsa1 on 01/08/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
#import "Reachability.h"
@interface Welcome : UIViewController<MBProgressHUDDelegate>
{
    MBProgressHUD *HUD;
    NSString*appoFile;
      NSString*appoNFile;
    NSMutableDictionary *recordDict;
    NSMutableArray *_AppDArr;
    NSMutableArray *_AppNArr;
    NSArray *petArray;
    IBOutlet UIButton*syn;
    NSArray *_assQues;
    NSArray *_assAns;
    UIBarButtonItem *saveButton;
    
    IBOutlet UITableView *myTable;
    IBOutlet UILabel *welcome;
    
    NSMutableArray *reminderarray;
    NSArray *assesment;
    int Add;
    BOOL isConnect;
    
}
-(IBAction)back1;
-(IBAction)sunc:(id)sender;
@property (retain,nonatomic) NSArray *petArray;
@property (retain,nonatomic) NSArray *_assQues;

@property (retain,nonatomic) NSArray *_assAns;
@property (retain,nonatomic) NSArray *assesment;
@property (retain, nonatomic) NSMutableDictionary *recordDict;

@end
