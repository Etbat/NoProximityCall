#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>


static void ShowLoadedAlert()
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW,
                                 (int64_t)(5 * NSEC_PER_SEC)),
                   dispatch_get_main_queue(), ^{

        UIWindow *window = nil;

        for (UIScene *scene in [UIApplication sharedApplication].connectedScenes)
        {
            if (![scene isKindOfClass:[UIWindowScene class]])
                continue;

            UIWindowScene *ws = (UIWindowScene *)scene;

            for (UIWindow *w in ws.windows)
            {
                if (!w.hidden &&
                    w.alpha > 0 &&
                    w.windowLevel == UIWindowLevelNormal)
                {
                    window = w;
                    break;
                }
            }

            if (window)
                break;
        }


        if (!window)
        {
            NSLog(@"[NoProximityCall] No window");
            return;
        }


        UIViewController *vc = window.rootViewController;

        while (vc.presentedViewController)
        {
            vc = vc.presentedViewController;
        }


        UIAlertController *alert =
        [UIAlertController alertControllerWithTitle:@"NoProximityCall"
                                            message:@"RootHide 注入成功"
                                     preferredStyle:UIAlertControllerStyleAlert];


        [alert addAction:
         [UIAlertAction actionWithTitle:@"OK"
                                  style:UIAlertActionStyleDefault
                                handler:nil]];


        [vc presentViewController:alert
                         animated:YES
                       completion:nil];


        NSLog(@"[NoProximityCall] Alert shown");

    });
}



%ctor
{
    NSLog(@"[NoProximityCall] ===== DYLIB LOADED =====");

    ShowLoadedAlert();
}



%hook SpringBoard


- (void)applicationDidFinishLaunching:(id)application
{

    NSLog(@"[NoProximityCall] ===== SPRINGBOARD HOOK =====");

    %orig;

}


%end
