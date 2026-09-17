#import <Foundation/Foundation.h>
#import <objc/runtime.h>


#pragma mark -
#pragma mark SBProximitySensorManager


%hook SBProximitySensorManager


- (void)setProximityDetectionEnabled:(BOOL)enabled
{

    NSLog(@"[NoProximityCall] block proximity detection");

    %orig(NO);

}


- (void)setProximityMonitoringEnabled:(BOOL)enabled
{

    NSLog(@"[NoProximityCall] block monitoring");

    %orig(NO);

}


%end



#pragma mark -
#pragma mark SBProximitySensor


%hook SBProximitySensor


- (void)setEnabled:(BOOL)enabled
{

    NSLog(@"[NoProximityCall] SB sensor blocked");

    %orig(NO);

}


- (void)setProximityState:(BOOL)state
{

    NSLog(@"[NoProximityCall] ignore state");

    %orig(NO);

}


%end



#pragma mark -
#pragma mark Display


%hook SpringBoard


- (void)applicationDidFinishLaunching:(id)application
{

    NSLog(@"[NoProximityCall] SpringBoard ready");


    %orig;

}


%end



%ctor
{

    NSString *p =
    [[NSProcessInfo processInfo] processName];


    NSLog(@"[NoProximityCall] loaded %@",p);


}