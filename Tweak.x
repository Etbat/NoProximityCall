#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


static void alert(NSString *msg)
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW,
    2*NSEC_PER_SEC),
    dispatch_get_main_queue(), ^{

        UIWindow *window=nil;

        for(UIWindow *w in
        UIApplication.sharedApplication.windows)
        {
            if(!w.hidden)
            {
                window=w;
                break;
            }
        }

        if(!window)
            return;


        UIViewController *vc =
        window.rootViewController;


        UIAlertController *a =
        [UIAlertController
        alertControllerWithTitle:@"NoProximityCall"
        message:msg
        preferredStyle:UIAlertControllerStyleAlert];


        [a addAction:
        [UIAlertAction
        actionWithTitle:@"OK"
        style:UIAlertActionStyleDefault
        handler:nil]];


        [vc presentViewController:a
        animated:YES
        completion:nil];

    });
}



%ctor
{

NSString *p =
[[NSProcessInfo processInfo] processName];


NSLog(@"NoProximityCall %@",p);



if([p isEqualToString:@"MobilePhone"])
{
    alert(@"MobilePhone 注入成功");
}


if([p isEqualToString:@"InCallService"])
{
    alert(@"InCallService 注入成功");
}


if([p isEqualToString:@"callservicesd"])
{
    alert(@"callservicesd 注入成功");
}


}