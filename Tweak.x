#import <Foundation/Foundation.h>

static void createTestFile(void)
{
    NSString *path = @"/var/mobile/NoProximityCall_loaded.txt";

    NSString *text = @"NoProximityCall SpringBoard loaded";

    [text writeToFile:path
           atomically:YES
             encoding:NSUTF8StringEncoding
                error:nil];
}


%ctor
{
    createTestFile();
}