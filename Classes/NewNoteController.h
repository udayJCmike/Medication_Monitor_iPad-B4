//
//  NewNoteController.h
//  PetLove
//
//  Created by CS Soon on 4/8/11.
//  Copyright 2011 Espressoft Technologies. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface NewNoteController : UIViewController {
	IBOutlet UITextView *notesText;
	NSDictionary *recordDict;
	int pid;
}
@property (nonatomic) int pid;
@property (retain,nonatomic) NSDictionary *recordDict;
@end
