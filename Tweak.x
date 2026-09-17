#import <Foundation/Foundation.h>

static void WriteProcessFile(void)
{
    NSString *process =
        [[NSProcessInfo processInfo] processName];

    NSString *path =
        @"/tmp/NoProximityCall_loaded.txt";

    NSString *old =
        [NSString stringWithContentsOfFile:path
                                  encoding:NSUTF8StringEncoding
                                     error:nil];

    NSString *line =
        [NSString stringWithFormat:@"Loaded in %@\n", process];

    NSString *content =
        [NSString stringWithFormat:@"%@%@",
         old ?: @"",
         line];

    [content writeToFile:path
               atomically:YES
                 encoding:NSUTF8StringEncoding
                    error:nil];

    NSLog(@"[NoProximityCall] %@", line);
}

%ctor
{
    WriteProcessFile();
}