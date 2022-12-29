//
//  ViewController.m
//  screen-share-ios
//
//  Created by summerxx on 2022/12/28.
//

#import "ViewController.h"
#import <ReplayKit/ReplayKit.h>
#import "FIAgoraClientBufferSocketManager.h"

@interface ViewController ()
@property (nonatomic, strong) RPSystemBroadcastPickerView *broadcastPickerView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupSocket];
    [self setupViews];
}

- (void)setupSocket {
    [[FIAgoraClientBufferSocketManager sharedManager] setupSocket];

    UILabel *label = [UILabel new];
    label.backgroundColor = UIColor.cyanColor;
    label.frame = CGRectMake(0, 100, [UIScreen mainScreen].bounds.size.width, 30);
    label.textColor = [UIColor blackColor];
    [self.view addSubview:label];

    [FIAgoraClientBufferSocketManager sharedManager].testBlock = ^(NSString * testText, CMSampleBufferRef sampleBuffer) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [label setText:testText];
        });
    };
}

- (void)setupViews {

    self.view.backgroundColor = [UIColor orangeColor];

    // 兼容 iOS12 或更高的版本
    if (@available(iOS 12.0, *)) {
        self.broadcastPickerView = [[RPSystemBroadcastPickerView alloc] initWithFrame:CGRectMake(50, 200, 100, 100)];
        self.broadcastPickerView.preferredExtension = @"summerxx.com.screen-share-ios.broadcast-extension";
        self.broadcastPickerView.backgroundColor = UIColor.cyanColor;
        [self.view addSubview:self.broadcastPickerView];
    }
}

@end
