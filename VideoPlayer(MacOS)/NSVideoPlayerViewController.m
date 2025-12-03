//
//  VideoPlayerViewController.m
//  VideoPlayer
//
//  Created by StringWeaver on 2025/12/3.
//

#import "NSVideoPlayerViewController.h"

@interface NSVideoPlayerViewController ()
@property (nonatomic, strong) AVPlayerView *playerView;
@end

@implementation NSVideoPlayerViewController




- (void)loadView {
    self.view = [[NSView alloc] initWithFrame:NSMakeRect(0, 0, 800, 600)];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.playerView = [[AVPlayerView alloc] initWithFrame:self.view.bounds];
    self.playerView.controlsStyle = AVPlayerViewControlsStyleInline;
    self.playerView.autoresizingMask = NSViewWidthSizable | NSViewHeightSizable;
    self.playerView.allowsPictureInPicturePlayback = NO;
    self.playerView.layer.magnificationFilter = kCAFilterNearest;
    _playerView.showsFullScreenToggleButton = YES;
    [self.view addSubview:self.playerView];
}

#pragma mark - KeybaordEvent



- (void)viewDidAppear {
    [super viewDidAppear];
}

// 监听 ESC
- (void)keyDown:(NSEvent *)event {
    if (event.keyCode == 53) {   // 53 = Escape
        [self exitPlayer];
    } else {
        [super keyDown:event];
    }
}

- (void)exitPlayer {
    self.playerModel = nil;

    [self.view removeFromSuperview];
    [self removeFromParentViewController];
}

#pragma mark - 加载 URL

- (void)openWithURL:(NSURL *)url {
    NSAssert([NSThread isMainThread], @"this method must be called on main thread");

    self.playerModel = [[PlayerModel alloc] init];
    [self.playerModel loadURL:url];


    NSWindow *window = self.view.window;
    if (window) {
        window.title = self.playerModel.title;
    }

    self.playerView.player = self.playerModel.player;
}

@end
