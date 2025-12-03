//
//  NSDocumentBrowserViewController.h
//  VideoPlayer(MacOS)
//
//  Created by StringWeaver on 2025/12/2.
//

#import <Cocoa/Cocoa.h>
#import "NSVideoPlayerViewController.h"

@interface NSDocumentBrowserViewController : NSViewController
@property (nonatomic, strong) NSVideoPlayerViewController *playerVC;
- (void)openDocumentPicker;
@end

