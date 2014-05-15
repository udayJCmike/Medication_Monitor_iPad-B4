
#import <UIKit/UIKit.h>

@interface ListCell : UITableViewCell {
	UIImageView *bgImage, *petImage;
	UILabel *petNameLbl, *breedLbl, *ageLbl;
}
@property (nonatomic, retain) UIImageView *bgImage, *petImage;
@property (nonatomic, retain) UILabel *petNameLbl, *breedLbl, *ageLbl;
- (void)setData:(NSDictionary *)rowData;
- (NSString *)calculateAge:(NSString *)dob;
@end
