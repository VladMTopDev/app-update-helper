//
//  UIViewController+AlertAdditions.m
//

#import "UIViewController+AlertAdditions.h"
#import "SettingsInfoHelper.h"

@implementation UIViewController (AlertAdditions)

- (void)showAppUpdateRecommendAlertWithCompletion:(AlertControllerRecommendUpdateBlock)block {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Recommend" message:@"Please update" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *laterAction = [UIAlertAction actionWithTitle:@"Later" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if (block) {
            block(later);
        }
    }];
    UIAlertAction *updateAction = [UIAlertAction actionWithTitle:@"Update now" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if (block) {
            block(updateNow);
        }
    }];
    UIAlertAction *noThanksAction = [UIAlertAction actionWithTitle:@"No, thanks" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if (block) {
            block(noThanks);
        }
    }];
    [alertController addAction:laterAction];
    [alertController addAction:noThanksAction];
    [alertController addAction:updateAction];
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)showAppUpdateRequiredAlertWithCompletion:(AlertControllerDummyBlock)block {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Required" message:@"Please update" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *updateAction = [UIAlertAction actionWithTitle:@"Update" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
    }];
    [alertController addAction:updateAction];
    [self presentViewController:alertController animated:YES completion:nil];
}


@end
