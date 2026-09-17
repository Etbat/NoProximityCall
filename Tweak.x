#import <Foundation/Foundation.h>


static void Notice(NSString *text)
{
    NSLog(@"[NoProximityCall] %@", text);
}


%hook TUCall


- (void)setProximityMonitoringEnabled:(BOOL)enabled
{
    Notice(@"TUCall proximity");

    %orig(NO);
}


%end



%hook InCallService


- (void)setProximityState:(BOOL)state
{
    Notice(@"InCallService proximity");

    %orig(NO);
}


%end



%hook SBProximityManager


- (void)setProximityEnabled:(BOOL)enabled
{
    Notice(@"SBProximityManager");

    %orig(NO);
}


%end



%ctor
{
    NSLog(@"[NoProximityCall] 1.7 loaded");
}