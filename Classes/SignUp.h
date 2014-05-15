//
//  SignUp.h
//  MediMoni
//
//  Created by hsa1 on 31/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
#import "Reachability.h"
@interface SignUp : UIViewController<MBProgressHUDDelegate>
{
    MBProgressHUD *HUD;
    IBOutlet UITextField *name, *pass,*cpass,*email,*skype,*face,*mobile,*state,*city,*age,*country;
    IBOutlet UIButton*male,*female;
    NSString *sex;
    BOOL isConnect;
    
   IBOutlet UIImageView*us,*pa,*copa,*sa,*eid,*mob,*con,*st,*cty;
}
- (IBAction)checkboxButton:(UIButton *)button;
-(IBAction)SingnUp;
@end
