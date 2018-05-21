//
//  VCVideoPlayerView.m
//  VCVideoPlayer
//
//  Created by Victor Chee on 2018/5/21.
//  Copyright © 2018年 VictorChee. All rights reserved.
//

#import "VCVideoPlayerView.h"
#import "VCVideoControlView.h"

@interface VCVideoPlayerView() <VCVideoControlDelegate>

@end

@implementation VCVideoPlayerView

- (void)playVideoWithURL:(NSURL * _Nonnull)url controlView:(UIView  * _Nullable)controlView {
    if (!controlView) {
        controlView = [NSBundle.mainBundle loadNibNamed:NSStringFromClass([VCVideoControlView class]) owner:nil options:nil].firstObject;
        ((VCVideoControlView *)controlView).delegate = self;
    }
    [self addSubview:controlView];
    
    controlView.translatesAutoresizingMaskIntoConstraints = NO;
    [controlView.topAnchor constraintEqualToAnchor:self.topAnchor].active = YES;
    [controlView.leftAnchor constraintEqualToAnchor:self.leftAnchor].active = YES;
    [controlView.bottomAnchor constraintEqualToAnchor:self.bottomAnchor].active = YES;
    [controlView.rightAnchor constraintEqualToAnchor:self.rightAnchor].active = YES;
}

- (void)fullscreenActionAnimated:(BOOL)animated completion:(dispatch_block_t)completionHandler {
    
}

#pragma mark - VCVideoControlDelegate
- (void)vcVideoControlView:(UIView *)controlView fullscreenAction:(UIButton *)sender {
    [self fullscreenActionAnimated:YES completion:^{ }];
}

@end
