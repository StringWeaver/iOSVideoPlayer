//
//  main.m
//  VideoPlayer(MacOS)
//
//  Created by StringWeaver on 2025/12/2.
//

#import <Cocoa/Cocoa.h>
#import "AppDelegate.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // Setup code that might create autoreleased objects goes here.
        
    }
    NSApplication *application = [NSApplication sharedApplication];
    AppDelegate *delegate = [[AppDelegate alloc] init];
    [application setDelegate:delegate];
    return NSApplicationMain(argc, argv);
}
