//
//  ListCell.m
//  ListCell


#import "ListCell.h"
#import <QuartzCore/QuartzCore.h>

@interface ListCell()
- (UILabel *)newLabelWithPrimaryColor:(UIColor *)primaryColor selectedColor:
(UIColor *)selectedColor fontSize:(CGFloat)fontSize bold:(BOOL)bold;
@end

@implementation ListCell

@synthesize bgImage, petImage;
@synthesize petNameLbl, breedLbl, ageLbl;
+ (void)initialize
{

}

- (id)initWithFrame:(CGRect)frame reuseIdentifier:(NSString *)reuseIdentifier {
	if (self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier]) {
        UIView *myContentView = self.contentView;
		
		self.bgImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ListBg.png"]];
		[myContentView addSubview:self.bgImage];
		
        
   //     self.petImage =[self.petImage resizedImageWithContentMode:UIViewContentModeScaleAspectFill bounds:CGSizeMake(90, 90) interpolationQuality:kCGInterpolationHigh];
        
		self.petImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 78, 80)];
		[myContentView addSubview:self.petImage];
		
        self.petNameLbl = [self newLabelWithPrimaryColor:[UIColor blackColor] 
										  selectedColor:[UIColor redColor] fontSize:20.0 bold:YES]; 
		[myContentView addSubview:self.petNameLbl];
		[self.petNameLbl release];

		self.breedLbl = [self newLabelWithPrimaryColor:[UIColor whiteColor] 
										   selectedColor:[UIColor whiteColor] fontSize:15.0 bold:NO]; 
	//	[myContentView addSubview:self.breedLbl];
		[self.breedLbl release];
		
		self.ageLbl = [self newLabelWithPrimaryColor:[UIColor whiteColor] 
										 selectedColor:[UIColor whiteColor] fontSize:15.0 bold:NO]; 
	//	[myContentView addSubview:self.ageLbl];
		[self.ageLbl release];
	}
    return self;
}

- (void)setData:(NSDictionary *)rowData
{
	self.petNameLbl.text = [rowData objectForKey:@"name"];
	if ([[rowData objectForKey:@"breed"] length] > 0) {
		self.breedLbl.text = [NSString stringWithFormat:@"Breed: %@",[rowData objectForKey:@"breed"]];
	}
	else {
		self.breedLbl.text = @"Breed: unknown";
	}

	if ([[rowData objectForKey:@"dob"] length] > 0) {
		self.ageLbl.text = [self calculateAge:[rowData objectForKey:@"dob"]];
	}
	else {
		self.ageLbl.text = @"Age: unspecified";
	}

	
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
	NSString *path = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"pet_%d.png",[[rowData objectForKey:@"pk"] intValue]]];			
	NSData *imageData = [NSData dataWithContentsOfFile:path];
	[self.petImage setImage:[UIImage imageWithData:imageData]];
	
	[self setNeedsDisplay];
}

- (NSString *)calculateAge:(NSString *)dob {
	NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
	[formatter setDateFormat:@"MM/dd/yyyy"];
	NSDate *startDate = [formatter dateFromString:dob];
	[formatter release];

	NSDate *endDate = [NSDate date];
	NSCalendar *gregorian = [[NSCalendar alloc]
							 initWithCalendarIdentifier:NSGregorianCalendar];
	unsigned int unitFlags = NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit;
	NSDateComponents *components = [gregorian components:unitFlags
												fromDate:startDate
												  toDate:endDate options:0];
	int month = [components month];
	int years= [components year];
	[gregorian release];
	
	NSString *ageStr=@"";
	if (years > 0)
		ageStr = [NSString stringWithFormat:@"%d years ",years];
	ageStr = [ageStr stringByAppendingString:[NSString stringWithFormat:@"%d months",month]];
	return ageStr;
}


- (void)layoutSubviews {
    
    [super layoutSubviews];
	
	
    if (!self.editing) {
        
        		
        
		[self.bgImage setFrame:CGRectMake(60, 0, 650, 105)];
		[self.petImage setFrame:CGRectMake(75, 14, 83, 75)];
		[self.petNameLbl setFrame:CGRectMake(344, 44.5, 158, 24)];
		[self.breedLbl setFrame:CGRectMake(116, 49, 158, 19)];
		[self.ageLbl setFrame:CGRectMake(116, 65, 158, 19)];
		
		CALayer * l = [self.petImage layer];
		[l setMasksToBounds:YES];
		[l setCornerRadius:15.0];
        [l setEdgeAntialiasingMask:50];
       
    }
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
	
	[super setSelected:selected animated:animated];
	
	UIColor *backgroundColor = nil;
	if (selected) {
	    backgroundColor = [UIColor clearColor];
	} else {
		backgroundColor = [UIColor clearColor];
	}
}


- (UILabel *)newLabelWithPrimaryColor:(UIColor *)primaryColor 
						selectedColor:(UIColor *)selectedColor fontSize:(CGFloat)fontSize bold:(BOOL)bold
{
	
    UIFont *font;
    if (bold) {
        font = [UIFont boldSystemFontOfSize:fontSize];
    } else {
        font = [UIFont systemFontOfSize:fontSize];
    }
    
	UILabel *newLabel = [[UILabel alloc] initWithFrame:CGRectZero];
	newLabel.backgroundColor = [UIColor clearColor];
	newLabel.opaque = YES;
	newLabel.textColor = primaryColor;
	newLabel.highlightedTextColor = selectedColor;
	newLabel.font = font;
	
	return newLabel;
}


- (void)dealloc {
	[super dealloc];
}


@end
