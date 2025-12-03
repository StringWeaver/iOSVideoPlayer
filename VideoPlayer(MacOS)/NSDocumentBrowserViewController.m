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
    self.playerVC = [[NSVideoPlayerViewController alloc] init];
    NSButton *openButton = [NSButton buttonWithTitle:@"Open File"
                                                 target:self
                                                 action:@selector(openDocumentPicker)];
    openButton.bezelStyle = NSBezelStyleRounded;
    openButton.frame = NSMakeRect(0, 0, 120, 40);
    openButton.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:openButton];


    [NSLayoutConstraint activateConstraints:@[
       [openButton.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor],
       [openButton.centerYAnchor constraintEqualToAnchor:self.view.centerYAnchor]
    ]];
}

- (void)viewDidAppear {
    
    [self openDocumentPicker];
    
}



- (void)openDocumentPicker {
    NSOpenPanel *panel = [NSOpenPanel openPanel];

    panel.allowsMultipleSelection = YES;
    panel.allowedContentTypes = @[UTTypeMovie ,UTTypeVideo, UTTypeAudio];

    if ([panel runModal] == NSModalResponseOK) {
        NSURL *url = panel.URLs.firstObject;
        if (url) [self presentPlayerWithURL:url];
    }
    
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
