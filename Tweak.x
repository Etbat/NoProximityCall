#import <UIKit/UIKit.h>

@interface SpringBoard : NSObject
@end


%hook SpringBoard

- (void)applicationDidFinishLaunching:(id)application
{
    %orig;

    UIAlertView *alert =
    [[UIAlertView alloc]
     initWithTitle:@"NoProximityCall"
     message:@"SpringBoard Inject OK"
     delegate:nil
     cancelButtonTitle:@"OK"
     otherButtonTitles:nil];

    [alert show];
}

%end