//
//  PlayerModel.m
//  VideoPlayer
//
//  Created by StringWeaver on 2025/12/2.
//

#import "PlayerModel.h"
#import <TargetConditionals.h>

@interface PlayerModel ()

// 私有成员
@property (nonatomic, strong, nullable) id timeObserver;
@property (nonatomic, strong, nullable) NSURL *securityURL;

@end

@implementation PlayerModel

#pragma mark - Utility

static NSString *trimLeadingNonDigits(NSString *input) {
    NSCharacterSet *digits = [NSCharacterSet decimalDigitCharacterSet];
    NSRange r = [input rangeOfCharacterFromSet:digits];
    if (r.location == NSNotFound) {
        return @""; // 若需返回原字符串，改为: return input;
    }
    return [input substringFromIndex:r.location];
}
#pragma mark - LifeSpan
- (instancetype)init {
    self = [super init];
    if (self) {
        _player = nil;
        _ready = NO;
        _title = @"";
        _filename = @"";
        _timeObserver = nil;
        _securityURL = nil;
    }
    return self;
}

- (void)loadURL:(NSURL *)url {
    // 尝试开启 security-scoped resource（若可用）
    if ([url respondsToSelector:@selector(startAccessingSecurityScopedResource)]) {
        BOOL ok = [url startAccessingSecurityScopedResource];
        if (ok) {
            self.securityURL = url;
        } else {
            self.securityURL = nil;
        }
    } else {
        self.securityURL = nil;
    }

    self.filename = url.lastPathComponent ?: @"";
    self.title = trimLeadingNonDigits(self.filename);

    AVPlayerItem *item = [[AVPlayerItem alloc] initWithURL:url];

    // 与 Swift 的 #if !os(macOS) 行为对应：在非 macOS 平台设置 metadata
    #if !TARGET_OS_OSX
    AVMutableMetadataItem *titleItem = [AVMutableMetadataItem new];
    titleItem.keySpace = AVMetadataKeySpaceCommon;
    titleItem.key = AVMetadataCommonKeyTitle;
    titleItem.value = self.title;
    item.externalMetadata = @[titleItem];
    #endif

    self.player = [[AVPlayer alloc] initWithPlayerItem:item];

    double seconds = [[NSUserDefaults standardUserDefaults] doubleForKey:self.filename];
    CMTime twoSec = CMTimeMake(2, 1); // 2 seconds

    if (seconds > 0) {
        CMTime t = CMTimeMakeWithSeconds(seconds, 1);
        [self.player seekToTime:t toleranceBefore:twoSec toleranceAfter:twoSec];
    }

    __weak typeof(self) weakSelf = self;
    self.timeObserver = [self.player addPeriodicTimeObserverForInterval:twoSec
                                                                 queue:dispatch_get_main_queue()
                                                            usingBlock:^(CMTime time) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        if (!strongSelf) return;
        [strongSelf saveProgressWithTime:time filename:strongSelf.filename];
    }];

    [self.player play];
    self.ready = YES;
}

#pragma mark - Helpers

- (void)saveProgressWithTime:(CMTime)time filename:(NSString *)filename {
    double sec = CMTimeGetSeconds(time);
    if (sec > 0 && filename.length > 0) {
        [[NSUserDefaults standardUserDefaults] setDouble:sec forKey:filename];
    }
}

#pragma mark - Cleanup

- (void)cleanup {
    if (self.player && self.timeObserver) {
        @try {
            [self.player removeTimeObserver:self.timeObserver];
        } @catch (NSException *exception) {
            // ignore potential exception if already removed
        }
    }
    self.timeObserver = nil;

    [self.player pause];
    self.player = nil;

    if (self.securityURL) {
        if ([self.securityURL respondsToSelector:@selector(stopAccessingSecurityScopedResource)]) {
            [self.securityURL stopAccessingSecurityScopedResource];
        }
        self.securityURL = nil;
    }

    self.ready = NO;
}

- (void)dealloc {
    [self cleanup];
}



@end
