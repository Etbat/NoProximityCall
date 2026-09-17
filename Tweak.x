#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


static void WriteBackboardMark()
{
    NSString *process =
    [[NSProcessInfo processInfo] processName];


    NSString *text =
    [NSString stringWithFormat:
     @"NoProximityCall loaded: %@\n",
     process];


    NSString *path =
    @"/var/jb/tmp/NoProximityCall.txt";


    [text writeToFile:path
           atomically:YES
             encoding:NSUTF8StringEncoding
                error:nil];


    NSLog(@"%@", text);
}



static void ShowSpringBoardAlert()
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW,
                                 (int64_t)(5*NSEC_PER_SEC)),
                   dispatch_get_main_queue(), ^{


        UIWindow *window = nil;


        for (UIScene *scene in
             UIApplication.sharedApplication.connectedScenes)
        {

            if (![scene isKindOfClass:
                  [UIWindowScene class]])
                continue;


            UIWindowScene *ws =
            (UIWindowScene *)scene;


            for (UIWindow *w in ws.windows)
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



        UIViewController *vc =
        window.rootViewController;


        while (vc.presentedViewController)
            vc = vc.presentedViewController;



        UIAlertController *alert =
        [UIAlertController
         alertControllerWithTitle:@"NoProximityCall 1.9"
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


    WriteBackboardMark();


    if ([process isEqualToString:@"SpringBoard"])
    {
        ShowSpringBoardAlert();
    }

}