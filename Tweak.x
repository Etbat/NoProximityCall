#import <Foundation/Foundation.h>


%hook UIDevice


- (BOOL)proximityState
{
    return NO;
}


%end



%hook TUCall


- (BOOL)isProximityEnabled
{
    return NO;
}


- (void)setProximityEnabled:(BOOL)value
{
    %orig(NO);
}


%end



%hook TUCallCenter


- (BOOL)isProximityEnabled
{
    return NO;
}


%end



%ctor
{

    NSString *process =
    [[NSProcessInfo processInfo] processName];


    NSLog(@"[NoProximityCall] loaded %@",process);

}