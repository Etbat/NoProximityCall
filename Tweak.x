#import <Foundation/Foundation.h>
#import <dlfcn.h>
#import <substrate.h>

typedef void (*BKSHIDServicesRequestProximityDetectionMode_t)(int mode);

static BKSHIDServicesRequestProximityDetectionMode_t
BKSHIDServicesRequestProximityDetectionMode = NULL;

static void DisableProximity(void)
{
    if (!BKSHIDServicesRequestProximityDetectionMode) {
        void *handle = dlopen(
            "/System/Library/PrivateFrameworks/BackBoardServices.framework/BackBoardServices",
            RTLD_LAZY
        );

        if (handle) {
            BKSHIDServicesRequestProximityDetectionMode =
                (BKSHIDServicesRequestProximityDetectionMode_t)
                dlsym(handle, "BKSHIDServicesRequestProximityDetectionMode");
        }
    }

    if (BKSHIDServicesRequestProximityDetectionMode) {
        BKSHIDServicesRequestProximityDetectionMode(0);
    }
}

/*
 * SpringBoard
 *
 * iOS 电话进入通话状态时会调用：
 *
 * _updateRejectedInputSettingsForInCallState:isOutgoing:triggeredbyRouteWillChangeToReceiverNotification:
 *
 * 在这里关闭 proximity detection。
 */

%hook SpringBoard

- (void)_updateRejectedInputSettingsForInCallState:(char)state
                                         isOutgoing:(char)outgoing
            triggeredbyRouteWillChangeToReceiverNotification:(char)triggered
{
    %orig(state, outgoing, triggered);

    if (state) {
        DisableProximity();
    }
}

%end
