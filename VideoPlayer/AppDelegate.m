//
//  AppDelegate.m
//  VideoPlayer
//
//  Created by StringWeaver on 2025-11-21.
//

#import "AppDelegate.h"
#import <AVFoundation/AVFoundation.h>
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    NSError *error = nil;
    AVAudioSession *session = [AVAudioSession sharedInstance];
    if ([session respondsToSelector:@selector(setCategory:mode:options:error:)]) {
        [session setCategory:AVAudioSessionCategoryPlayback
                       mode:AVAudioSessionModeDefault
                     options:0
                       error:&error];
    } else {
        [session setCategory:AVAudioSessionCategoryPlayback error:&error];
    }

    if (error) {
        NSLog(@"设置 AVAudioSession 出错: %@", error);
    } else {
        [session setActive:YES error:&error];
        if (error) {
            NSLog(@"激活 AVAudioSession 出错: %@", error);
        }
    }
    return YES;
}


#pragma mark - UISceneSession lifecycle


- (UISceneConfiguration *)application:(UIApplication *)application configurationForConnectingSceneSession:(UISceneSession *)connectingSceneSession options:(UISceneConnectionOptions *)options {
    // Called when a new scene session is being created.
    // Use this method to select a configuration to create the new scene with.
    return [[UISceneConfiguration alloc] initWithName:@"Default Configuration" sessionRole:connectingSceneSession.role];
}


- (void)application:(UIApplication *)application didDiscardSceneSessions:(NSSet<UISceneSession *> *)sceneSessions {
    // Called when the user discards a scene session.
    // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
    // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
}


@end
