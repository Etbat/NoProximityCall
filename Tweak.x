#import <Foundation/Foundation.h>


static void WriteLog(NSString *text)
{
    NSString *path =
    @"/var/mobile/NoProximityCall_loaded.txt";


    NSString *old =
    [NSString stringWithContentsOfFile:path
                              encoding:NSUTF8StringEncoding
                                 error:nil];


    NSString *newText =
    [NSString stringWithFormat:@"%@\n%@",
     old ?: @"",
     text];


    [newText writeToFile:path
              atomically:YES
                encoding:NSUTF8StringEncoding
                   error:nil];
}



%ctor
{

    NSString *process =
    [[NSProcessInfo processInfo] processName];


    NSString *msg =
    [NSString stringWithFormat:
     @"NoProximityCall loaded in %@",
     process];


    WriteLog(msg);


    NSLog(@"%@",msg);


}