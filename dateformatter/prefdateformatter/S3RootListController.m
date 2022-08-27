#import <Foundation/Foundation.h>
#include "S3RootListController.h"

@implementation S3RootListController

- (NSArray *)specifiers {
	if (!_specifiers) {
		_specifiers = [self loadSpecifiersFromPlistName:@"Root" target:self];

	}
	return _specifiers;
}

-(void)openSource{

[[UIApplication sharedApplication]
openURL:[NSURL URLWithString:@"https://github.com/s3ud-alshaman/TweaksOpenSource/tree/main/dateformatter"]
options:@{}
completionHandler:nil];
}

@end
