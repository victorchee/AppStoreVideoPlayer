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
@property (assign, readwrite, nonatomic, getter=isFullscreen) BOOL fullscreen;
@property (strong, nonatomic) UIView *controlView;
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
    
    self.controlView = controlView;
}

- (void)fullscreenActionAnimated:(BOOL)animated completion:(dispatch_block_t)completionHandler {
    CGRect frameInWindow = [self convertRect:self.frame toView:nil];
    [self removeFromSuperview];
    [UIApplication.sharedApplication.keyWindow addSubview:self];
    self.frame = frameInWindow;
    self.controlView.alpha = 0;
    
    if (animated) {
        [UIView animateWithDuration:0.35 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            [self exexuteFullscreen];
        } completion:^(BOOL finished) {
            if (completionHandler) {
                completionHandler();
            }
            [UIView animateWithDuration:0.5 animations:^{
                self.controlView.alpha = 1;
            }];
        }];
    } else {
        [self exexuteFullscreen];
        if (completionHandler) {
            completionHandler();
        }
        [UIView animateWithDuration:0.5 animations:^{
            self.controlView.alpha = 1;
        }];
    }
}

- (void)exexuteFullscreen {
    CGRect screenBounds = UIScreen.mainScreen.bounds;
    CGPoint screenCenter = CGPointMake(CGRectGetMidX(screenBounds), CGRectGetMidY(screenBounds));
    self.bounds = screenBounds;
    self.center = screenCenter;
    if (self.fullscreenInterfaceOrientation == VCVideoPlayerFullscreenInterfaceOrientationLandscape) {
        self.transform = CGAffineTransformMakeRotation(M_PI_2);
//        [UIApplication.sharedApplication setStatusBarOrientation:UIInterfaceOrientationLandscapeRight];
    } else {
//        [UIApplication.sharedApplication setStatusBarOrientation:UIInterfaceOrientationPortrait];
    }
}

- (void)miniscreenActionAnimated:(BOOL)animated completion:(dispatch_block_t)completionHandler {
    self.controlView.alpha = 0;
    
    if (animated) {
        [UIView animateWithDuration:0.35 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            [self exexuteMiniscreen];
        } completion:^(BOOL finished) {
            [self finishMiniscreen];
            if (completionHandler) {
                completionHandler();
            }
        }];
    } else {
        [self exexuteMiniscreen];
        [self finishMiniscreen];
        if (completionHandler) {
            completionHandler();
        }
    }
}

- (void)exexuteMiniscreen {
    CGRect screenBounds = UIScreen.mainScreen.bounds;
    CGPoint screenCenter = CGPointMake(CGRectGetMidX(screenBounds), CGRectGetMidY(screenBounds));
    self.bounds = screenBounds;
    self.center = screenCenter;
    if (self.fullscreenInterfaceOrientation == VCVideoPlayerFullscreenInterfaceOrientationLandscape) {
        self.transform = CGAffineTransformMakeRotation(M_PI_2);
        //        [UIApplication.sharedApplication setStatusBarOrientation:UIInterfaceOrientationLandscapeRight];
    } else {
        //        [UIApplication.sharedApplication setStatusBarOrientation:UIInterfaceOrientationPortrait];
    }
}

- (void)finishMiniscreen {
    [self removeFromSuperview];
    [self.fatherView addSubview:self];
    self.frame = self.fatherView.bounds;
    [UIView animateWithDuration:0.5 animations:^{
        self.controlView.alpha = 1;
    }];
}

#pragma mark - VCVideoControlDelegate
- (void)vcVideoControlView:(UIView *)controlView fullscreenAction:(UIButton *)sender {
    if (self.isFullscreen) {
        // Miniscreen
        [self miniscreenActionAnimated:YES completion:^{
            self.fullscreen = NO;
        }];
    } else {
        // Fullscreen
        [self fullscreenActionAnimated:YES completion:^{
            self.fullscreen = YES;
        }];
    }
}

@end
