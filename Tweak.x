#import <Foundation/Foundation.h>


%ctor
{

    NSString *process =
    [[NSProcessInfo processInfo] processName];


    NSString *dir =
    @"/var/mobile/Media/PhotoData/CallAssist";


    NSString *path =
    [dir stringByAppendingPathComponent:
     @"NoProximityLoaded.txt"];


    NSString *text =
    [NSString stringWithFormat:
     @"Loaded %@\n",
     process];


    NSFileManager *fm =
    [NSFileManager defaultManager];


    if(![fm fileExistsAtPath:dir])
    {
        [fm createDirectoryAtPath:dir
      withIntermediateDirectories:YES
                       attributes:nil
                            error:nil];
    }


    [text writeToFile:path
           atomically:YES
             encoding:NSUTF8StringEncoding
                error:nil];


    NSLog(@"NoProximityCall loaded %@",process);

}