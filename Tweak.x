#import <substrate.h>
#import <UIKit/UIKit.h>

static BOOL origProximityEnabled;

// hook 距离传感器的 setProximityMonitoringEnabled
void (*originalSetProximityEnabled)(id, SEL, BOOL);
void hookedSetProximityEnabled(id self, SEL _cmd, BOOL enable) {
    origProximityEnabled = enable;
    // 强制关闭距离感应监测，永远不启用
    originalSetProximityEnabled(self, _cmd, NO);
}

// hook proximityState 获取当前遮挡状态
BOOL (*originalProximityState)(id, SEL);
BOOL hookedProximityState(id self, SEL _cmd) {
    // 永远返回 NO：没有物体靠近，不会触发熄屏
    return NO;
}

%ctor {
    Class proximityClass = objc_getClass("UIDevice");
    if (proximityClass) {
        MSHookMessageEx(proximityClass, @selector(setProximityMonitoringEnabled:), (IMP)hookedSetProximityEnabled, (IMP *)&originalSetProximityEnabled);
        MSHookMessageEx(proximityClass, @selector(proximityState), (IMP)hookedProximityState, (IMP *)&originalProximityState);
    }
}

// RootHide 进程白名单：只注入电话、微信
%roothideProcess MobilePhone,WeChat
