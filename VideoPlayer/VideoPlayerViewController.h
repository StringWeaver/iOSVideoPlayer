#import <AVKit/AVKit.h>
@interface VideoPlayerViewController : AVPlayerViewController<AVPlayerViewControllerDelegate>
@property (nonatomic, strong) NSURL *currentSecurityURL;
@property (nonatomic, strong) id timeObserver;
- (void)openWithURL:(NSURL *)url ;
@end
