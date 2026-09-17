#import <UIKit/UIKit.h>

%ctor
{
    NSLog(@"[NoProximityCall] ===== LOADED =====");
}

%hook SpringBoard

- (void)applicationDidFinishLaunching:(id)application
{
    %orig;

    NSLog(@"[NoProximityCall] SpringBoard applicationDidFinishLaunching");

    UIAlertController *alert =
        [UIAlertController alertControllerWithTitle:@"NoProximityCall"
                                            message:@"SpringBoard Inject OK"
                                     preferredStyle:UIAlertControllerStyleAlert];

    [alert addAction:
        [UIAlertAction actionWithTitle:@"OK"
                                 style:UIAlertActionStyleDefault
                               handler:nil]];

    UIWindow *window = nil;

    for (UIWindow *w in [UIApplication sharedApplication].windows) {
        if (w.isKeyWindow) {
            window = w;
            break;
        }
    }

    if (window.rootViewController) {
        [window.rootViewController presentViewController:alert
                                                 animated:YES
                                               completion:nil];
    }
}

%end
