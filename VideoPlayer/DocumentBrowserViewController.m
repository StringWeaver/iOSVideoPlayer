// VideoDocumentBrowserViewController.m

#import "DocumentBrowserViewController.h"

@implementation DocumentBrowserViewController


- (void) viewDidLoad{
    [super viewDidLoad];
    [self commonInit];
}

- (void)commonInit {
    self.delegate = self;
    self.allowsPickingMultipleItems = YES;
    self.allowsDocumentCreation = NO;
    self.playerVC = [[VideoPlayerViewController alloc] init];
    // 视需要可以设置其他 UI 配置
}



#pragma mark - Document Browser Delegate

- (void)documentBrowser:(UIDocumentBrowserViewController *)controller didPickDocumentsAtURLs:(NSArray<NSURL *> *)urls {
    NSURL *url = urls.firstObject;
    if (!url) return;

    [self presentViewController:self.playerVC animated:YES completion:^{
        [self.playerVC openWithURL:url];
    }];
}

@end
