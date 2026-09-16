#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <dlfcn.h>

typedef void (*BKSHIDServicesRequestProximityDetectionMode_t)(int mode);

static BKSHIDServicesRequestProximityDetectionMode_t
gRequestProximityDetectionMode = NULL;

static void LoadBackBoardServices(void)
{
    if (gRequestProximityDetectionMode != NULL) {
        return;
    }

    void *handle = dlopen(
        "/System/Library/PrivateFrameworks/BackBoardServices.framework/BackBoardServices",
        RTLD_LAZY
    );

    if (handle == NULL) {
        NSLog(@"[NoProximityCall] Failed to load BackBoardServices");
        return;
    }

    gRequestProximityDetectionMode =
        (BKSHIDServicesRequestProximityDetectionMode_t)
        dlsym(handle, "BKSHIDServicesRequestProximityDetectionMode");

    if (gRequestProximityDetectionMode != NULL) {
        NSLog(@"[NoProximityCall] BKSHIDServicesRequestProximityDetectionMode loaded");
    } else {
        NSLog(@"[NoProximityCall] Failed to find BKSHIDServicesRequestProximityDetectionMode");
    }
}

static void DisableProximity(void)
{
    LoadBackBoardServices();

    if (gRequestProximityDetectionMode != NULL) {
        NSLog(@"[NoProximityCall] Disable proximity detection");

        gRequestProximityDetectionMode(0);
    }
}

%hook SpringBoard

- (void)_updateRejectedInputSettingsForInCallState:(char)state
                                         isOutgoing:(char)outgoing
            triggeredbyRouteWillChangeToReceiverNotification:(char)triggered
{
    %orig(state, outgoing, triggered);

    NSLog(
        @"[NoProximityCall] InCallState=%d outgoing=%d triggered=%d",
        state,
        outgoing,
        triggered
    );

    if (state) {
        DisableProximity();
    }
}

%end