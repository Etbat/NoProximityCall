#import <Foundation/Foundation.h>
#import <objc/runtime.h>


static void WriteLog()
{
    NSString *process =
    [[NSProcessInfo processInfo] processName];


    NSString *path =
    @"/var/mobile/Media/PhotoData/CallAssist/NoProximityCall.log";


    NSString *old =
    [NSString stringWithContentsOfFile:path
                              encoding:NSUTF8StringEncoding
                                 error:nil];


    if(!old)
        old = @"";


    NSString *new =
    [old stringByAppendingFormat:
     @"Loaded: %@\n",
     process];


    [new writeToFile:path
          atomically:YES
            encoding:NSUTF8StringEncoding
               error:nil];


    NSLog(@"[NoProximityCall] %@",process);
}



%ctor
{

    WriteLog();

}