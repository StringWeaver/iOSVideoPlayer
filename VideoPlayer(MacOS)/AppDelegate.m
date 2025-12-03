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
    [self setupMenus];
    NSRect frame = NSMakeRect(500, 500, 500, 300);
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

- (BOOL)applicationShouldTerminateAfterLastWindowClosed:(NSApplication *)sender {
    return YES;
}


- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}


- (BOOL)applicationSupportsSecureRestorableState:(NSApplication *)app {
    return YES;
}

- (void)setupMenus {
    NSMenu *mainMenu = [[NSMenu alloc] initWithTitle:@"MainMenu"];
    [NSApp setMainMenu:mainMenu];


    NSMenuItem *appMenuItem = [[NSMenuItem alloc] initWithTitle:@"" action:NULL keyEquivalent:@""];
    [mainMenu addItem:appMenuItem];

    NSMenu *appMenu = [[NSMenu alloc] initWithTitle:@"App"];
    appMenuItem.submenu = appMenu;

    NSString *appName = [[NSProcessInfo processInfo] processName];

    // Quit
    NSMenuItem *quitItem = [[NSMenuItem alloc] initWithTitle:[NSString stringWithFormat:@"Quit %@", appName]
                                                      action:@selector(terminate:)
                                               keyEquivalent:@"q"];
    quitItem.keyEquivalentModifierMask = NSEventModifierFlagCommand;
    [appMenu addItem:quitItem];

    // File 菜单
    NSMenuItem *fileMenuItem = [[NSMenuItem alloc] initWithTitle:@"" action:NULL keyEquivalent:@""];
    [mainMenu addItem:fileMenuItem];
    NSMenu *fileMenu = [[NSMenu alloc] initWithTitle:@"File"];
    fileMenuItem.submenu = fileMenu;

    NSMenuItem *closeItem = [[NSMenuItem alloc] initWithTitle:@"Close Window"
                                                       action:@selector(performClose:)
                                                keyEquivalent:@"w"];
    closeItem.keyEquivalentModifierMask = NSEventModifierFlagCommand;
    [fileMenu addItem:closeItem];

}


@end
