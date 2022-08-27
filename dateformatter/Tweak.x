#import <UIKit/UIKit.h>

static NSString *dateSrring;
static NSString *dateFormatString;
static NSDateFormatter *dateFormatter;

@interface SBFLockScreenDateSubtitleView : UIView 
@property NSDate *date;
@end

%hook SBFLockScreenDateSubtitleView

-(void)setString:(id)arg1{

NSDictionary *bundleDefaults = [[NSUserDefaults standardUserDefaults] persistentDomainForName:@"com.alshaman.prefdateformatter"];

id modDFormat= [bundleDefaults valueForKey:@"kCustomText"];
if ([modDFormat isEqual:@""]) {
dateFormatString = @"EEEE, yyyy/MM/dd";
}else{
dateFormatString = [[bundleDefaults objectForKey:@"kCustomText"] stringValue];
}
dateFormatter = [[NSDateFormatter alloc] init];
[dateFormatter setDateFormat:dateFormatString];     
dateSrring = [dateFormatter stringFromDate:self.date];
id isEnabled = [bundleDefaults valueForKey:@"isEnabled"];
if ([isEnabled isEqual:@0]) {
%orig;
}else{
arg1 = dateSrring;
return %orig(arg1);
}
}
%end


