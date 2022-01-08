#import <UIKit/UIKit.h>

@interface T1ProfileUserInfoView : UIView
{
    NSDate *_createdDate; 
}
@property (nonatomic, retain) UIButton *btn; 
@end

static NSString *dateString;  

%hook T1ProfileUserInfoView 
-(void)setCreatedDate:(id)arg1 {
%orig;

NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
[dateFormatter setDateFormat:@"dd/MM/yyyy      h:mm a"];

dateString = [dateFormatter stringFromDate:[self valueForKey:@"_createdDate"]];

return %orig;
}

%property (nonatomic, retain) UIButton *btn;
-(void)didMoveToWindow {

   %orig;

if(!self.btn) {

self.btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
[self.btn addTarget:self action:@selector(ShowMessageAction:) forControlEvents:UIControlEventAllTouchEvents];

[self.btn setTitle:dateString forState:UIControlStateNormal];

[self.btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];

self.btn.titleLabel.numberOfLines = 0;
self.btn.frame = CGRectMake(2, -5, 180, 20);
     [self addSubview:self.btn];
     [self bringSubviewToFront:self.btn];
     [self setUserInteractionEnabled:YES];
}
    }
    
    %new
-(void)ShowMessageAction:(id)sender {


NSString * MssgTitle;

NSString * language = [[NSLocale preferredLanguages] objectAtIndex:0];

NSDictionary *languageDic = [NSLocale componentsFromLocaleIdentifier:language];

NSString *languageCode = [languageDic objectForKey:@"kCFLocaleLanguageCodeKey"];

if ([languageCode isEqualToString:@"ar"]){
MssgTitle = @"‎هل تريد نسخ المعلومات ؟"; 
}
else{
MssgTitle = @"Are you copy info?"; 
}


UIAlertController *alert = [UIAlertController alertControllerWithTitle:MssgTitle message:dateString preferredStyle:UIAlertControllerStyleAlert];



UIAlertAction* copyBtn = [UIAlertAction actionWithTitle:@"Copy" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {

UIPasteboard.generalPasteboard.string = dateString;

}];

[alert addAction:copyBtn];

[alert addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil]];

[[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alert animated:YES completion:nil];

}

%end