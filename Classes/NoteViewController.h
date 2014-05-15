//
//  NoteViewController.h
//  PetLove
//
//  Created by CS Soon on 4/8/11.
//  Copyright 2011 Espressoft Technologies. All rights reserved.
//
#import <UIKit/UIKit.h>


#import <UIKit/UIKit.h>


@interface NoteViewController : UIViewController {
	NSArray *notesArray;
	NSDictionary *recordDict;
	IBOutlet UITableView *myTable;
	IBOutlet UILabel *msgLbl;
    
   
    
}
@property (retain,nonatomic) NSArray *notesArray;
@property (retain,nonatomic) NSDictionary *recordDict;
@end
