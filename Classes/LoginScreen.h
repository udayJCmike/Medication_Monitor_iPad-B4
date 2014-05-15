//
//  LoginScreen.h
//  MediMoni
//
//  Created by hsa1 on 30/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
#import "Reachability.h"

@interface LoginScreen : UIViewController<UITextFieldDelegate,MBProgressHUDDelegate>
{
    IBOutlet UITextField *name, *pass;
    IBOutlet UIButton *rem;
    MBProgressHUD *HUD;
    BOOL isConnect;
}
-(IBAction)rem:(id)sender;
- (IBAction) SignIn;
-(IBAction)SingnUp;
@end
