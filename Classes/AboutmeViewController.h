//
//  AboutmeViewController.h
//  PetLove
//
//  Created by CS Soon on 4/8/11.
//  Copyright 2011 Espressoft Technologies. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SVSegmentedControl.h"

@interface AboutmeViewController : UIViewController <UIPickerViewDelegate, UIScrollViewDelegate,UIImagePickerControllerDelegate, UIActionSheetDelegate,SVSegmentedControlDelegate>{
	NSMutableDictionary *recordDict;
	UITextField *currentField;
	UIDatePicker *dobPicker;
	IBOutlet UIScrollView *pageScroll;
	IBOutlet UITextField *name, *breed, *dob, *age, *microchip, *akc;
	IBOutlet UITextView *notes;
    BOOL share1;
   
    NSString *digit1,*digit2,*digit3;
    NSMutableArray* arrayNo,*arrayNo1 ;
    
 //   SVSegmentedControl *redSC;
    UIImage *buttonImage ;
    IBOutlet UIButton*aButton;
    IBOutlet UIButton*aButton1;
    IBOutlet UIButton*aButton2;
  IBOutlet  UIButton *iButton;
    
      IBOutlet UILabel*fromd;
      IBOutlet UILabel*tod;
    UIPopoverController*popover;
    int k;
    NSString *meDir;
    NSString*type;
    IBOutlet UIButton*admor,*addafter,*addeven;
    IBOutlet UIDatePicker *mor,*noon,*eve;
    
  
    IBOutlet  UIView*v,*v1;
    
    
   IBOutlet UIButton*mor1,*mor2;
   
    
    UIPickerView *picker1;
    
    IBOutlet UITableView*myTable;
      IBOutlet UITableView*myTable1;
    NSMutableArray *_TimeArray;
    NSMutableArray *_onceTime;
    IBOutlet  UIDatePicker*timepicker;
    IBOutlet UILabel*tim;

    IBOutlet UIDatePicker*setTimePicker;
    
}
- (IBAction)changefromTime:(id)sender;
-(IBAction)setTimer:(id)sender;
-(IBAction)changeTime:(id)sender;
-(IBAction)Morning2:(id)sender;
-(IBAction)Morning1:(id)sender;
-(IBAction)addEvening;
-(IBAction)removeEvening;
-(IBAction)addMorning;
-(IBAction)addAfter;
-(IBAction)removeAfter;
- (IBAction)checkboxButton:(UIButton *)button;
- (IBAction)checkboxButton1:(UIButton *)button;
- (IBAction)checkboxButton2:(UIButton *)button;
- (void)segmentedControlChangedValue:(SVSegmentedControl*)segmentedControl;

- (IBAction)changefromdate:(id)sender;
- (IBAction)changeTodate:(id)sender;

- (IBAction) dismissKeyboard;
-(IBAction)takePhoto;
-(IBAction)setFromDate;
-(IBAction)setToDate;
@property (nonatomic,retain) IBOutlet UIDatePicker *datePicker;
@property (nonatomic,retain) IBOutlet UIDatePicker *datePicker1;
@property (retain, nonatomic) NSMutableDictionary *recordDict;
@property (retain,nonatomic) UIDatePicker *dobPicker;
- (void)populateField;
- (NSString *)calculateAge;
- (void)updateDate;
-(BOOL)checkField;
- (void)moveUp:(UITextField *)textField;
- (void)moveUp2:(UITextView *)textView;
- (void) showDatePicker;
- (void) dismissDatePicker;
-(void)saveImage:(UIImage *)img2;
@end


