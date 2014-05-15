//
//  MainViewController.h
//  RSSReader
//
//  Created by Dean Collins on 5/04/09.
//  Copyright 2009 Big Click Studios. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface MainViewController : UINavigationController {
	UINavigationController *navigationController;
    NSMutableDictionary *recordDict;
}

@property (nonatomic, retain) UINavigationController *navigationController;
@property (retain, nonatomic) NSMutableDictionary *recordDict;
@end
