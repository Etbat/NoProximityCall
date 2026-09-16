#import <Foundation/Foundation.h>
#import <objc/runtime.h>

%hook SpringBoard

- (void)_proximityChanged:(id)arg1
{
    NSLog(@"[NoProximityCall] >>> BLOCK _proximityChanged: %@", arg1);

    // 故意不执行 %orig
    // 直接阻止 SpringBoard 根据 proximity 状态继续处理
    return;
}

%end

%ctor
{
    NSLog(@"[NoProximityCall] SpringBoard tweak loaded");

    Class cls = objc_getClass("SpringBoard");

    if (cls) {
        SEL sel = NSSelectorFromString(@"_proximityChanged:");

        if ([cls instancesRespondToSelector:sel]) {
            NSLog(@"[NoProximityCall] FOUND _proximityChanged:");
        } else {
            NSLog(@"[NoProximityCall] ERROR: _proximityChanged: NOT FOUND");
        }
    }
}