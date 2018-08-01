//
//  SettingsInfoHelper.m
//

#import "SettingsInfoHelper.h"
#import <UIKit/UIKit.h>
#import <sys/utsname.h>

@implementation SettingsInfoHelper

+ (NSString *)appVersionString {
    return [[NSBundle mainBundle] objectForInfoDictionaryKey:(__bridge NSString *)kCFBundleVersionKey];
}

+ (NSInteger)buildNumber {
    return [[[[self appVersionString] componentsSeparatedByString:@"."] lastObject] integerValue];
}

+ (NSString *)appShortVersionString {
    return [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
}

+ (NSString *)deviceName {
    struct utsname systemInfo;
    uname(&systemInfo);
    return [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
}

+ (NSString *)osVersion {
    return [[UIDevice currentDevice] systemVersion];
}

+ (NSString *)uuid {
    return [[[UIDevice currentDevice] identifierForVendor] UUIDString];
}

@end
