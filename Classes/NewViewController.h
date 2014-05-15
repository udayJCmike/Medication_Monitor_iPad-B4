#import <UIKit/UIKit.h>
#import "SVSegmentedControl.h"
#import "Reachability.h"
#import "MBProgressHUD.h"
@interface NewViewController : UIViewController<UIWebViewDelegate,MBProgressHUDDelegate> {
     IBOutlet UITableView *myTable;
    IBOutlet UITableView *myTable1;
    NSMutableArray *_pId;
    NSMutableArray *_pName;
    
     MBProgressHUD *HUD;
    NSMutableArray *_pIdl;
    NSMutableArray *_pNamel;
    NSString*str;
    NSString *prodId;
    BOOL isConnect;
    
    
}
- (IBAction)checkboxButton:(UIButton *)button;
- (void)segmentedControlChangedValue:(SVSegmentedControl*)segmentedControl;
@end
