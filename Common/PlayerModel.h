//
//  PlayerModel.h
//  VideoPlayer
//
//  Created by StringWeaver on 2025/12/2.
//
#import <Foundation/Foundation.h>
#import <AVKit/AVKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PlayerModel : NSObject

@property (nonatomic, strong, nullable) AVPlayer *player;
@property (nonatomic, assign) BOOL ready;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *filename;

- (void)loadURL:(NSURL *)url;
- (void)cleanup;

@end

NS_ASSUME_NONNULL_END
