#import <substrate.h>
#import <UIKit/UIKit.h>

static BOOL origProximityEnabled;

void (*originalSetProximityEnabled)(id, SEL, BOOL);
void hookedSetProximityEnabled(id self, SEL _cmd, BOOL enable) {
    origProximityEnabled = enable;
    originalSetProximityEnabled(self, _cmd, NO);
}

BOOL (*originalProximityState)(id, SEL);
BOOL hookedProximityState(id self, SEL _cmd) {
    return NO;
}

%ctor {
    Class proximityClass = objc_getClass("UIDevice");
    if (proximityClass) {
        MSHookMessageEx(proximityClass, @selector(setProximityMonitoringEnabled:), (IMP)hookedSetProximityEnabled, (IMP *)&originalSetProximityEnabled);
        MSHookMessageEx(proximityClass, @selector(proximityState), (IMP)hookedProximityState, (IMP *)&originalProximityState);
    }
}
