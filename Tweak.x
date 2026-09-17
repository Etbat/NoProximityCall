#import <Foundation/Foundation.h>


%hook SpringBoard


// iOS 15/16 常见距离感应控制入口之一
- (void)_setProximityDetectionEnabled:(BOOL)enabled
{
    NSLog(@"[NoProximityCall] Block phone proximity enable=%d", enabled);

    %orig(NO);
}


// 备用接口
- (void)setProximityDetectionEnabled:(BOOL)enabled
{
    NSLog(@"[NoProximityCall] Block proximity detection");

    %orig(NO);
}


%end



%ctor
{
    NSLog(@"[NoProximityCall] Phone mode loaded");
}
