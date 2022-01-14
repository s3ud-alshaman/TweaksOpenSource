@interface T1ProfileUserInfoView : UIView
@property NSDate *createdDate;
@property UIButton *createdDateButton;
@end

@interface T1ProfileUserInfoViewController : UIViewController
@property T1ProfileUserInfoView *infoView;
@end

static NSDateFormatter *dateFormatter;

%hook NSDate
- (NSString *)tfs_monthYearDateStringNoTime {
  return [dateFormatter stringFromDate:self];
}
%end

%hook T1ProfileUserInfoView
- (UIButton *)_t1_buildBulletpointButtonWithLineBreakMode:
                  (NSInteger)lineBreakMode
                                  accessibilityIdentifier:
                                      (NSString *)accessibilityIdentifier
                                                   action:(SEL)action {
  if ([accessibilityIdentifier isEqualToString:@"ProfileHeaderCreatedDate"]) {
    action = @selector(_didTapCreatedDateButton:);
  }
  return %orig;
}
- (void)_t1_refreshBulletpointButton:(UIButton *)button
                           withTitle:(NSString *)title
                               image:(NSString *)image
                            linkable:(BOOL)linkable
                       invisibleLink:(BOOL)invisibleLink
                 accessibilityFormat:(BOOL)accessibilityFormat {
  if ([button isEqual:self.createdDateButton]) {
    linkable = YES;
    invisibleLink = YES;
  }
  return %orig;
}
%new
- (void)_didTapCreatedDateButton:(id)sender {
  NSString *languageCode =
      [NSLocale componentsFromLocaleIdentifier:[NSLocale preferredLanguages][0]]
          [(__bridge NSString *)kCFLocaleLanguageCode];

  NSString *dateString = [dateFormatter stringFromDate:self.createdDate];

  UIAlertController *alert = [UIAlertController
      alertControllerWithTitle:
          [languageCode isEqualToString:@"ar"]
              ? @"‎هل تريد نسخ المعلومات ؟"
              : @"Copy date?"
                       message:dateString
                preferredStyle:UIAlertControllerStyleAlert];

  [alert
      addAction:[UIAlertAction actionWithTitle:@"Copy"
                                         style:UIAlertActionStyleDefault
                                       handler:^(UIAlertAction *action) {
                                         UIPasteboard.generalPasteboard.string =
                                             dateString;
                                       }]];

  [alert addAction:[UIAlertAction actionWithTitle:@"Cancel"
                                            style:UIAlertActionStyleCancel
                                          handler:nil]];

  UIResponder *responder = self;
  while (![responder isKindOfClass:[UIViewController class]]) {
    responder = responder.nextResponder;
  }
  [(UIViewController *)responder presentViewController:alert
                                              animated:YES
                                            completion:nil];
}
%end

%ctor {
  dateFormatter = [[NSDateFormatter alloc] init];
  [dateFormatter setDateFormat:@"dd/MM/yyyy h:mm a"];
}
