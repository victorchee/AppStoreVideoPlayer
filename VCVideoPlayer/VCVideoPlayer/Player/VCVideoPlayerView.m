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

- (void)setFatherView:(UIView *)fatherView {
    _fatherView = fatherView;
    
    if (self.superview) {
        [fatherView removeFromSuperview];
    }
    
    [fatherView addSubview:self];
    self.translatesAutoresizingMaskIntoConstraints = NO;
    [fatherView.topAnchor constraintEqualToAnchor:self.topAnchor].active = YES;
    [fatherView.leftAnchor constraintEqualToAnchor:self.leftAnchor].active = YES;
    [fatherView.bottomAnchor constraintEqualToAnchor:self.bottomAnchor].active = YES;
    [fatherView.rightAnchor constraintEqualToAnchor:self.rightAnchor].active = YES;
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

- (void)fullscreenActionAnimated:(BOOL)animated completion:(dispatch_block_t)completionHandler {
    UIWindow *window = UIApplication.sharedApplication.keyWindow;
    CGRect frameInWindow = [self convertRect:self.frame toView:nil];
    [self removeFromSuperview];
    [window addSubview:self];
    self.frame = frameInWindow;
    self.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *topConstraint = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:window attribute:NSLayoutAttributeTop multiplier:1 constant:CGRectGetMinY(frameInWindow)];
    NSLayoutConstraint *leftConstraint = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:window attribute:NSLayoutAttributeLeft multiplier:1 constant:CGRectGetMinX(frameInWindow)];
    NSLayoutConstraint *bottomConstraint = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:window attribute:NSLayoutAttributeBottom multiplier:1 constant: CGRectGetHeight(window.bounds) - CGRectGetMaxY(frameInWindow)];
    NSLayoutConstraint *rightConstraint = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:window attribute:NSLayoutAttributeRight multiplier:1 constant: CGRectGetWidth(window.bounds) - CGRectGetMaxX(frameInWindow)];
    [window addConstraints:@[topConstraint, leftConstraint, bottomConstraint, rightConstraint]];
    self.controlView.alpha = 0;
    
    dispatch_block_t executeFullscreen = ^() {
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
    };
    
    if (animated) {
        topConstraint.constant = 0;
        leftConstraint.constant = 0;
        bottomConstraint.constant = 0;
        rightConstraint.constant = 0;
        [UIView animateWithDuration:0.35 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            [window layoutIfNeeded];
            self.transform = CGAffineTransformMakeRotation(M_PI_2);
        } completion:^(BOOL finished) {
            if (completionHandler) {
                completionHandler();
            }
            [UIView animateWithDuration:0.5 animations:^{
                self.controlView.alpha = 1;
            }];
        }];
    } else {
        executeFullscreen();
        if (completionHandler) {
            completionHandler();
        }
        [UIView animateWithDuration:0.5 animations:^{
            self.controlView.alpha = 1;
        }];
    }
}

- (void)miniscreenActionAnimated:(BOOL)animated completion:(dispatch_block_t)completionHandler {
    self.controlView.alpha = 0;
    
    if (animated) {
        [UIView animateWithDuration:0.35 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            [self executeMiniscreen];
        } completion:^(BOOL finished) {
            [self finishMiniscreen];
            if (completionHandler) {
                completionHandler();
            }
        }];
    } else {
        [self executeMiniscreen];
        [self finishMiniscreen];
        if (completionHandler) {
            completionHandler();
        }
    }
}

- (void)executeMiniscreen {
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
