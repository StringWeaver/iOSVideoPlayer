#import <AVKit/AVKit.h>
#import "PlayerModel.h"
@interface VideoPlayerViewController : AVPlayerViewController<AVPlayerViewControllerDelegate>
@property (nonatomic, strong) PlayerModel* playerModel;
- (void)openWithURL:(NSURL *)url ;
@end
