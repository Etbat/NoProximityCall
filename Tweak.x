#import <Foundation/Foundation.h>

%ctor
{
    NSLog(@"[NoProximityCall] ===== LOADED =====");
}

%hook SpringBoard

- (void)applicationDidFinishLaunching:(id)application
{
    NSLog(@"[NoProximityCall] ===== SPRINGBOARD HOOK =====");
    %orig;
}

%end
