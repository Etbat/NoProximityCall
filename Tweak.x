#import <substrate.h>
#import <UIKit/UIKit.h>

static BOOL isInCall = NO;
static BOOL isInWeChat = NO;

// Hook UIDevice 的距离感应方法
%hook UIDevice

- (void)setProximityMonitoringEnabled:(BOOL)enable {
    // 通话时禁用距离感应
    if (isInCall) {
        %orig(NO);
        return;
    }
    %orig(enable);
}

- (BOOL)proximityState {
    // 通话时始终返回 NO（屏幕不关闭）
    if (isInCall) {
        return NO;
    }
    return %orig;
}

%end

// Hook UIApplication 检测前台应用
%hook UIApplication

- (BOOL)sendAction:(SEL)action to:(id)target from:(id)sender forEvent:(UIEvent *)event {
    // 检查当前应用是否是通话或微信
    NSString *bundleID = [[NSBundle mainBundle] bundleIdentifier];
    
    if ([bundleID isEqualToString:@"com.apple.mobilephone"]) {
        isInCall = YES;
    } else if ([bundleID isEqualToString:@"com.tencent.xin"]) {
        isInWeChat = YES;
    } else {
        isInCall = NO;
        isInWeChat = NO;
    }
    
    return %orig;
}

%end

// 防止屏幕自动熄灭
%hook UIApplication

- (void)setIdleTimerDisabled:(BOOL)disabled {
    // 通话或微信语音时禁用自动熄灭
    if (isInCall || isInWeChat) {
        %orig(YES);
        return;
    }
    %orig(disabled);
}

%end
