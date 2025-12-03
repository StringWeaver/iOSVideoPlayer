//
//  PlayerViewController.m
//  VideoPlayer
//
//  Created by StringWeaver on 2025-11-21.
//
#import "VideoPlayerViewController.h"
@interface VideoPlayerViewController()
@end


@implementation VideoPlayerViewController


- (void)EmptyPanAction:(UIPanGestureRecognizer *)pan {

}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.delegate = self;
    self.allowsPictureInPicturePlayback = NO;
    UIPanGestureRecognizer *panBlocker = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(EmptyPanAction:)];
        [self.view addGestureRecognizer:panBlocker];
}



- (void)presentationControllerDidDismiss:(UIPresentationController *)presentationController {
    _playerModel = nil;
}


- (void)openWithURL:(NSURL *)url {
    NSAssert([NSThread isMainThread], @"this method must be execute on main thread!");
    // 清理上一个
    _playerModel = [[PlayerModel alloc] init];
    [_playerModel loadURL:url];

    

    UIWindowScene *scene = self.view.window.windowScene;
    scene.title = self.playerModel.title;
    self.view.layer.magnificationFilter = kCAFilterNearest;
    
    self.player = _playerModel.player;
    
   
}


@end
