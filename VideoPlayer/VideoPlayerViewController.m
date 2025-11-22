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

- (void)cleanupPlayer {

    [self.player pause];
    if (self.timeObserver) {
        [self.player removeTimeObserver:self.timeObserver];
        self.timeObserver = nil;
    }
    self.player = nil;
    if (self.currentSecurityURL) {
        [self.currentSecurityURL stopAccessingSecurityScopedResource];
        self.currentSecurityURL = nil;
    }
    
}
- (void)dealloc {
    [self cleanupPlayer];
}
- (void)presentationControllerDidDismiss:(UIPresentationController *)presentationController {
    [self cleanupPlayer];
}

NSString *TrimLeadingNonDigits(NSString *input) {
    NSCharacterSet *digits = [NSCharacterSet decimalDigitCharacterSet];
    NSRange r = [input rangeOfCharacterFromSet:digits];
    if (r.location == NSNotFound) {
        return @""; // 若需返回原字符串，改为: return input;
    }
    return [input substringFromIndex:r.location];
}

- (void)openWithURL:(NSURL *)url {
    // 清理上一个
    [self cleanupPlayer];

    // 尝试启动 security-scoped 访问（来自 Files.app 的外部文件通常需要）
    if ([url startAccessingSecurityScopedResource]) {
        self.currentSecurityURL = url;
    } else {
        self.currentSecurityURL = nil;
    }
    
    AVPlayerItem *item = [AVPlayerItem playerItemWithURL:url];
    NSString *filename = url.lastPathComponent;
    NSString *title = TrimLeadingNonDigits(filename);
    AVMutableMetadataItem *titleItem = [[AVMutableMetadataItem alloc] init];
    titleItem.keySpace = AVMetadataKeySpaceCommon;
    titleItem.key = AVMetadataCommonKeyTitle;
    titleItem.value = title;
    item.externalMetadata = @[titleItem];

    UIWindowScene *scene = self.view.window.windowScene;
    scene.title = title;

    
    self.player = [AVPlayer playerWithPlayerItem:item];
    
    self.showsPlaybackControls = YES;
    
    [self.player play];
    [self.player seekToTime:[self loadProgressForFilename:filename] toleranceBefore:kCMTimeZero toleranceAfter:kCMTimeZero];
    __weak typeof(self) weakSelf = self;
    self.timeObserver =
        [self.player addPeriodicTimeObserverForInterval:CMTimeMake(2, 1)
            queue:dispatch_get_main_queue()
            usingBlock:^(CMTime time) {
                [weakSelf saveProgress:time filename:filename];
            }
        ];
}

- (void)saveProgress:(CMTime)time filename:(NSString *)filename {
    Float64 seconds = CMTimeGetSeconds(time);
    if (seconds > 0) {
        [[NSUserDefaults standardUserDefaults] setDouble:seconds forKey:filename];
    }
}
- (CMTime)loadProgressForFilename:(NSString *)filename {
    Float64 seconds = [[NSUserDefaults standardUserDefaults] doubleForKey:filename];
    return CMTimeMakeWithSeconds(seconds, 1);
}

@end
