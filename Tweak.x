#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


static BOOL forceKeepAwake = NO;



%hook UIApplication


- (void)setIdleTimerDisabled:(BOOL)disabled
{

    if(forceKeepAwake)
    {
        %orig(YES);
        return;
    }


    %orig;

}



%end



// 监听电话状态
%hook TUCallCenter


- (void)handleCallStatusChanged:(id)arg1
{

    forceKeepAwake = YES;

    [[UIApplication sharedApplication]
     setIdleTimerDisabled:YES];


    %orig;

}



%end



%ctor
{

    NSString *process =
    [[NSProcessInfo processInfo] processName];


    NSLog(@"[NoProximityCall] loaded %@",process);



    if([process isEqualToString:@"MobilePhone"] ||
       [process isEqualToString:@"InCallService"])
    {

        forceKeepAwake = YES;


        dispatch_after(
        dispatch_time(DISPATCH_TIME_NOW,
        2*NSEC_PER_SEC),
        dispatch_get_main_queue(), ^{


            [[UIApplication sharedApplication]
             setIdleTimerDisabled:YES];


        });

    }

}