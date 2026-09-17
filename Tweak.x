#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


static void ShowProximityAlert(NSString *msg)
{
    dispatch_async(dispatch_get_main_queue(), ^{

        UIWindow *window = nil;

        for (UIScene *scene in UIApplication.sharedApplication.connectedScenes)
        {
            if (![scene isKindOfClass:[UIWindowScene class]])
                continue;

            for (UIWindow *w in ((UIWindowScene *)scene).windows)
            {
                if (!w.hidden)
                {
                    window = w;
                    break;
                }
            }
        }


        if (!window)
            return;


        UIViewController *vc = window.rootViewController;

        while (vc.presentedViewController)
            vc = vc.presentedViewController;


        UIAlertController *alert =
        [UIAlertController alertControllerWithTitle:@"NoProximityCall"
                                            message:msg
                                     preferredStyle:UIAlertControllerStyleAlert];


        [alert addAction:
         [UIAlertAction actionWithTitle:@"OK"
                                  style:UIAlertActionStyleDefault
                                handler:nil]];


        [vc presentViewController:alert
                         animated:YES
                       completion:nil];

    });
}




%hook SBProximitySensor


- (void)_proximityChanged:(BOOL)near
{
    ShowProximityAlert(
        near ?
        @"SBProximitySensor ON" :
        @"SBProximitySensor OFF"
    );


    %orig;
}


%end




%hook UIDevice


- (BOOL)proximityState
{
    ShowProximityAlert(@"UIDevice proximityState called");

    return %orig;
}


%end




%ctor
{
    NSLog(@"[NoProximityCall] 1.6 loaded");
}
