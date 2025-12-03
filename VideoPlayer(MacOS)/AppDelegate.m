//
//  AppDelegate.m
//  VideoPlayer(MacOS)
//
//  Created by StringWeaver on 2025/12/2.
//

#import "AppDelegate.h"
#import "NSDocumentBrowserViewController.h"

@interface AppDelegate ()

@property (strong) NSWindow *window;
@property (strong) NSDocumentBrowserViewController *browserVC;

@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    NSRect frame = NSMakeRect(100, 100, 900, 600);
    self.window = [[NSWindow alloc] initWithContentRect:frame
                                              styleMask:(NSWindowStyleMaskTitled |
                                                         NSWindowStyleMaskClosable |
                                                         NSWindowStyleMaskResizable)
                                                backing:NSBackingStoreBuffered
                                                  defer:NO];
    self.window.title = @"VideoPlayer";

    _browserVC = [[NSDocumentBrowserViewController alloc] init];
    self.window.contentViewController = _browserVC;
    [self.window makeKeyAndOrderFront:nil];
}


- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}


- (BOOL)applicationSupportsSecureRestorableState:(NSApplication *)app {
    return YES;
}


@end
