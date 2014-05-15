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

@interface Addremainder : UIViewController<UIActionSheetDelegate> {
	NSArray *petArray;
	
	IBOutlet UILabel *noPet;
	IBOutlet UIImageView *bgImage;
    NSMutableDictionary *recordDict;
    BOOL share1;

    int savedValue;
    IBOutlet UITextField*name;
    UISegmentedControl *scheduleControl;
    NSString*reminderFile;
    NSMutableArray *_RemaindersArray;
    
    NSMutableArray *dictionary;
    NSString *dicfile;
    NSMutableArray *dictionaryArray;
    
    
        UIDatePicker *datePicker;
    IBOutlet UIButton*once;
    IBOutlet UIButton*setdate;
    IBOutlet UILabel*dateLabel;
     IBOutlet UIImageView*mask;
    
    IBOutlet UIDatePicker *timePicker;
    IBOutlet UIButton*daily;
    IBOutlet UIButton*settime;
    IBOutlet UILabel*timeLabel;
    IBOutlet UIImageView*maskDaily;
    int alertType;
    BOOL opt;
  
}
- (IBAction)changeTimeInLabel:(id)sender;
-(IBAction)once:(id)sender;
-(IBAction)setDate;
-(IBAction)setTime;
- (IBAction)changeDateInLabel:(id)sender;
@property (nonatomic,retain) IBOutlet UISegmentedControl *scheduleControl;
@property (nonatomic,retain) IBOutlet UIDatePicker *datePicker;
@property (retain,nonatomic) NSArray *petArray;
@property (retain, nonatomic) NSMutableDictionary *recordDict;
@end
