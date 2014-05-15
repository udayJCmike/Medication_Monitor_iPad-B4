#import <UIKit/UIKit.h>
#import "AppSharedInstance.h"
#import "SVSegmentedControl.h"
#import <AVFoundation/AVFoundation.h>
@interface history : UIViewController<UIWebViewDelegate,UIActionSheetDelegate,AVAudioPlayerDelegate, AVAudioRecorderDelegate> {
   
   
    NSMutableDictionary *recordDict;
    int number;
    int questionid;
    IBOutlet UITableView*myTable;
    IBOutlet UILabel*question;
    
    IBOutlet UILabel *Qdate;
    
  
    AVAudioPlayer *audioPlayerRecord;
 
    NSMutableArray*musicA;
    NSMutableArray*_Question;
    NSMutableArray*_Answer;
  
    NSString*questiontype;
    NSMutableArray*_assQues;
	
   
}
@property (nonatomic) int currentPage;

@property (retain, nonatomic) NSMutableDictionary *recordDict;

@end
