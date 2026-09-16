#import <UIKit/UIKit.h>

%hook UIDevice

// 阻止 Phone / WeChat 开启距离感应监测
- (void)setProximityMonitoringEnabled:(BOOL)enabled
{
    %orig(NO);
}

// 查询距离感应是否开启时，始终返回 NO
- (BOOL)isProximityMonitoringEnabled
{
    return NO;
}

// 查询距离状态时，始终返回“远离”
- (BOOL)proximityState
{
    return NO;
}

%end
