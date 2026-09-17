#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


static void ShowAlert(void)
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW,
                                  3 * NSEC_PER_SEC),
                   dispatch_get_main_queue(), ^{

        UIWindow *window = nil;

        for (UIScene *scene in UIApplication.sharedApplication.connectedScenes)
        {
            if ([scene isKindOfClass:[UIWindowScene class]])
            {
                UIWindowScene *ws = (UIWindowScene *)scene;

                for (UIWindow *w in ws.windows)
                {
                    if (!w.hidden)
                    {
                        window = w;
                        break;
                    }
                }
            }
        }


        if (!window)
            return;


        UIViewController *vc =
        window.rootViewController;


        while (vc.presentedViewController)
            vc = vc.presentedViewController;


        UIAlertController *alert =
        [UIAlertController
         alertControllerWithTitle:@"NoProximityCall"
         message:@"SpringBoard 注入成功"
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


    NSLog(@"[NoProximityCall] Loaded in %@", process);



    if ([process isEqualToString:@"SpringBoard"])
    {
        ShowAlert();
    }

}