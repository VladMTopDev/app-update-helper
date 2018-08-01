//
//  SettingsInfoHelper.h
//

#import <Foundation/Foundation.h>

@interface SettingsInfoHelper : NSObject

+ (nonnull NSString *)appVersionString;
+ (NSInteger)buildNumber;
+ (nonnull NSString *)appShortVersionString;
+ (nonnull NSString *)uuid;

@end
