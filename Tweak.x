#import <Foundation/Foundation.h>
#import <objc/runtime.h>


static void ScanProximity()
{

    int count = objc_getClassList(NULL,0);

    Class *classes =
    (__unsafe_unretained Class *)
    malloc(sizeof(Class)*count);


    count = objc_getClassList(classes,count);


    NSString *process =
    [[NSProcessInfo processInfo] processName];


    NSString *path =
    @"/var/mobile/Media/PhotoData/CallAssist/NoProximityScan.txt";


    NSMutableString *out =
    [NSMutableString string];


    [out appendFormat:@"PROCESS:%@\n",process];


    for(int i=0;i<count;i++)
    {

        NSString *name =
        NSStringFromClass(classes[i]);


        NSString *low =
        name.lowercaseString;


        if([low containsString:@"prox"]
        ||
        [low containsString:@"sensor"]
        ||
        [low containsString:@"backlight"]
        ||
        [low containsString:@"display"])
        {

            [out appendFormat:@"%@\n",name];

        }

    }


    free(classes);


    [out writeToFile:path
          atomically:YES
            encoding:NSUTF8StringEncoding
               error:nil];


}



%ctor
{

    ScanProximity();


}