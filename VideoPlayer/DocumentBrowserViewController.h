//
//  ViewController.h
//  VideoPlayer
//
//  Created by StringWeaver on 2025-11-21.
//

#import <UIKit/UIKit.h>
#import <AVKit/AVKit.h>
#import "VideoPlayerViewController.h"


@interface DocumentBrowserViewController : UIDocumentBrowserViewController<UIDocumentBrowserViewControllerDelegate>
@property (nonatomic, strong) VideoPlayerViewController* playerVC;
@end


