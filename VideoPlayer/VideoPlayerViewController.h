#import <AVKit/AVKit.h>
@interface VideoPlayerViewController : AVPlayerViewController<AVPlayerViewControllerDelegate>
@property (nonatomic, strong) NSURL *currentSecurityURL;
- (void)openWithURL:(NSURL *)url ;
@end
