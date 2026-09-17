#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <objc/runtime.h>


#pragma mark - UIDevice

%hook UIDevice


- (void)setProximityMonitoringEnabled:(BOOL)enabled
{
    NSLog(@"[NoProximityCall] block proximity enable");

    %orig(NO);
}


- (BOOL)isProximityMonitoringEnabled
{
    return NO;
}


- (BOOL)proximityState
{
    return NO;
}


%end



#pragma mark - NSNotification


%hook NSNotificationCenter


- (void)addObserver:(id)observer
          selector:(SEL)selector
              name:(NSNotificationName)name
            object:(id)obj
{

    if([name containsString:@"Proximity"])
    {
        NSLog(@"[NoProximityCall] block notification %@",name);
        return;
    }


    %orig;

}


%end



#pragma mark - init


%ctor
{

    NSString *process =
    [[NSProcessInfo processInfo] processName];


    NSLog(@"[NoProximityCall] loaded %@",process);


}