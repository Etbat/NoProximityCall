#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


static UIWindow *GetKeyWindow()
{

    for (UIScene *scene in UIApplication.sharedApplication.connectedScenes)
    {

        if (![scene isKindOfClass:[UIWindowScene class]])
            continue;


        UIWindowScene *windowScene =
        (UIWindowScene *)scene;


        for (UIWindow *window in windowScene.windows)
        {
            if (!window.hidden && window.alpha > 0)
            {
                return window;
            }
        }
    }


    return nil;
}



static void ShowAlert(NSString *msg)
{

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW,
                                 2 * NSEC_PER_SEC),
                   dispatch_get_main_queue(), ^{


        UIWindow *window = GetKeyWindow();


        if (!window)
            return;


        UIViewController *vc =
        window.rootViewController;


        while (vc.presentedViewController)
        {
            vc = vc.presentedViewController;
        }



        UIAlertController *alert =
        [UIAlertController
         alertControllerWithTitle:@"NoProximityCall"
         message:msg
         preferredStyle:UIAlertControllerStyleAlert];


        [alert addAction:
         [UIAlertAction
          actionWithTitle:@"OK"
          style:UIAlertActionStyleDefault
          handler:nil]];


        [vc presentViewController:alert
                         animated:YES
                       completion:nil];

    });
}



%ctor
{

    NSString *process =
    [[NSProcessInfo processInfo] processName];


    NSLog(@"[NoProximityCall] Loaded %@",process);



    if ([process isEqualToString:@"SpringBoard"])
    {
        ShowAlert(@"SpringBoard 注入成功");
    }


    if ([process isEqualToString:@"MobilePhone"])
    {
        ShowAlert(@"MobilePhone 注入成功");
    }


    if ([process isEqualToString:@"InCallService"])
    {
        ShowAlert(@"InCallService 注入成功");
    }


    if ([process isEqualToString:@"callservicesd"])
    {
        NSLog(@"[NoProximityCall] callservicesd loaded");
    }


    if ([process isEqualToString:@"backboardd"])
    {
        NSLog(@"[NoProximityCall] backboardd loaded");
    }

}