#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

static void ShowLoadedAlert(void)
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)),
                   dispatch_get_main_queue(), ^{

        UIApplication *app = [UIApplication sharedApplication];

        UIWindow *window = app.keyWindow;

        if (!window) {
            for (UIWindow *w in app.windows) {
                if (!w.hidden && w.windowLevel == UIWindowLevelNormal) {
                    window = w;
                    break;
                }
            }
        }

        if (!window) {
            NSLog(@"[NoProximityCall] No window found");
            return;
        }

        UIViewController *rootVC = window.rootViewController;

        if (!rootVC) {
            NSLog(@"[NoProximityCall] No rootViewController found");
            return;
        }

        UIViewController *vc = rootVC;

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
