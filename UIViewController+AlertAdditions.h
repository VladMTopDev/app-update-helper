//
//  UIViewController+AlertAdditions.h
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger) {
    noThanks,
    later,
    updateNow
} RecommendedBlockAction;

typedef void(^AlertControllerDummyBlock)(void);
typedef void(^AlertControllerRecommendUpdateBlock)(RecommendedBlockAction action);

@interface UIViewController (AlertAdditions)

- (void)showAppUpdateRecommendAlertWithCompletion:(AlertControllerRecommendUpdateBlock)block;
- (void)showAppUpdateRequiredAlertWithCompletion:(AlertControllerDummyBlock)block;

@end
