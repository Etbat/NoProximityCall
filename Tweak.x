#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

static void ShowLoadedAlert(void)
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW,
                                  (int64_t)(4.0 * NSEC_PER_SEC)),
                   dispatch_get_main_queue(), ^{

        UIApplication *app = [UIApplication sharedApplication];

        UIWindow *window = nil;

        // iOS 13+：通过 UIWindowScene 查找窗口
        for (UIScene *scene in app.connectedScenes) {

            if (![scene isKindOfClass:[UIWindowScene class]]) {
                continue;
            }

            UIWindowScene *windowScene = (UIWindowScene *)scene;

            if (windowScene.activationState != UISceneActivationStateForegroundActive &&
                windowScene.activationState != UISceneActivationStateForegroundInactive) {
                continue;
            }

            for (UIWindow *w in windowScene.windows) {

                if (!w.hidden &&
                    w.alpha > 0.0 &&
                    w.windowLevel == UIWindowLevelNormal) {

                    window = w;
                    break;
                }
            }

            if (window) {
                break;
            }
        }

        if (!window) {
            NSLog(@"[NoProximityCall] No suitable window found");
            return;
        }

        UIViewController *vc = window.rootViewController;

        if (!vc) {
            NSLog(@"[NoProximityCall] No rootViewController found");
            return;
        }

        while (vc.presentedViewController) {
            vc = vc.presentedViewController;
        }

        UIAlertController *alert =
        [UIAlertController alertControllerWithTitle:@"NoProximityCall"
                                            message:@"插件已成功加载 ✓"
                                     preferredStyle:UIAlertControllerStyleAlert];

        [alert addAction:
         [UIAlertAction actionWithTitle:@"确定"
                                  style:UIAlertActionStyleDefault
                                handler:nil]];

        [vc presentViewController:alert
                         animated:YES
                       completion:nil];

        NSLog(@"[NoProximityCall] ===== ALERT SHOWN =====");
    });
}


%ctor
{
    NSLog(@"[NoProximityCall] ===== LOADED =====");

    ShowLoadedAlert();
}


%hook SpringBoard

- (void)applicationDidFinishLaunching:(id)application
{
    NSLog(@"[NoProximityCall] ===== SPRINGBOARD HOOK =====");

    %orig;
}

%end
