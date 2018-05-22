//
//  VCVideoPlayerView.m
//  VCVideoPlayer
//
//  Created by Victor Chee on 2018/5/21.
//  Copyright © 2018年 VictorChee. All rights reserved.
//

#import "VCVideoPlayerView.h"
#import "VCVideoControlView.h"

@interface VCVideoPlayerView() <VCVideoControlDelegate> {
    CGRect originalFrame;
}
@property (assign, readwrite, nonatomic, getter=isFullscreen) BOOL fullscreen;
@property (strong, nonatomic) UIView *controlView;
@end

@implementation VCVideoPlayerView

- (void)setFatherView:(UIView *)fatherView {
    _fatherView = fatherView;
    
    if (self.superview) {
        [self removeFromSuperview];
    }
    
    [fatherView addSubview:self];
    self.translatesAutoresizingMaskIntoConstraints = NO;
    [self.topAnchor constraintEqualToAnchor:fatherView.topAnchor].active = YES;
    [self.leftAnchor constraintEqualToAnchor:fatherView.leftAnchor].active = YES;
    [self.bottomAnchor constraintEqualToAnchor:fatherView.bottomAnchor].active = YES;
    [self.rightAnchor constraintEqualToAnchor:fatherView.rightAnchor].active = YES;
}

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
    
    self.controlView = controlView;
}

#pragma mark - VCVideoControlDelegate
- (void)vcVideoControlView:(UIView *)controlView fullscreenAction:(UIButton *)sender {
    UIWindow *window = UIApplication.sharedApplication.keyWindow;
    if (self.isFullscreen) {
        // Miniscreen
                [self.fatherView addSubview:self];
        self.controlView.alpha = 0;
        [UIView animateWithDuration:0.35 animations:^{
            self.transform = CGAffineTransformIdentity;
            self.frame = self->originalFrame;
        } completion:^(BOOL finished) {
//            self.fatherView = self.fatherView;
//            [self.fatherView addSubview:self];
            self.frame = self.fatherView.bounds;
            [UIView animateWithDuration:0.5 animations:^{
                self.controlView.alpha = 1;
            }];
            self.fullscreen = NO;
        }];
    } else {
        // Fullscreen
        originalFrame = [self convertRect:self.frame toView:nil];
        [window addSubview:self];
        //        self.frame = originalFrame;
        self.controlView.alpha = 0;
        [UIView animateWithDuration:0.35 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            self.transform = CGAffineTransformMakeRotation(M_PI_2);
            self.frame = UIScreen.mainScreen.bounds;
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.5 animations:^{
                self.controlView.alpha = 1;
            }];
            self.fullscreen = YES;
        }];
    }
}

@end
