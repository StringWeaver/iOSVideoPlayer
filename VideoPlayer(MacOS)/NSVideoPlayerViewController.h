//
//  VideoPlayerViewController.h
//  VideoPlayer
//
//  Created by StringWeaver on 2025/12/3.
//
#import <Cocoa/Cocoa.h>
#import <AVKit/AVKit.h>
#import "PlayerModel.h"

@interface NSVideoPlayerViewController : NSViewController

@property (nonatomic, strong) PlayerModel* playerModel;
- (void)openWithURL:(NSURL *)url;

@end

