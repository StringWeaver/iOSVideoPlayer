//
//  NSDocumentBrowserViewController.m
//  VideoPlayer(MacOS)
//
//  Created by StringWeaver on 2025/12/2.
//


#import <UniformTypeIdentifiers/UniformTypeIdentifiers.h>
#import "NSDocumentBrowserViewController.h"

@implementation NSDocumentBrowserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self commonInit];
}

- (void)commonInit {
    self.playerVC = [[NSVideoPlayerViewController alloc] init];
    [self openDocumentPicker];
}



- (void)openDocumentPicker {
    NSOpenPanel *panel = [NSOpenPanel openPanel];

    panel.canChooseFiles = YES;
    panel.canChooseDirectories = NO;
    panel.allowsMultipleSelection = YES;
    panel.allowedContentTypes = @[UTTypeMovie ,UTTypeVideo, UTTypeAudio];

    [panel beginSheetModalForWindow:self.view.window completionHandler:^(NSModalResponse result) {
        if (result == NSModalResponseOK) {
            NSURL *url = panel.URLs.firstObject;
            if (url) {
                [self presentPlayerWithURL:url];
            }
        }
    }];
}


- (void)presentPlayerWithURL:(NSURL *)url {


    [self.playerVC openWithURL:url];

    [self addChildViewController:self.playerVC];
    NSView *pv = self.playerVC.view;

    pv.frame = self.view.bounds;
    pv.autoresizingMask = NSViewWidthSizable | NSViewHeightSizable;

    [self.view addSubview:pv];
}

@end
