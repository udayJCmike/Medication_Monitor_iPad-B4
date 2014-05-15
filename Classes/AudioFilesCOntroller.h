//
//  AudioFilesCOntroller.h
//  MediMoni
//
//  Created by hsa1 on 27/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AudioFilesCOntroller : UIViewController
{
    IBOutlet UIScrollView *scrollView;
	IBOutlet UILabel *msgLbl;
	NSArray *photoArray;
	NSMutableDictionary *recordDict;
    int k;
}
@property (retain, nonatomic) NSMutableDictionary *recordDict;

@end
