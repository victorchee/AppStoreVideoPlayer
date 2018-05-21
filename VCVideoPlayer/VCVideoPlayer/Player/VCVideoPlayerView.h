//
//  VCVideoPlayerView.h
//  VCVideoPlayer
//
//  Created by Victor Chee on 2018/5/21.
//  Copyright © 2018年 VictorChee. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, VCVideoPlayerFullscreenInterfaceOrientation) {
    VCVideoPlayerFullscreenInterfaceOrientationLandscape,
    VCVideoPlayerFullscreenInterfaceOrientationPortrait,
};

@interface VCVideoPlayerView : UIView

@property (assign, nonatomic) VCVideoPlayerFullscreenInterfaceOrientation fullscreenInterfaceOrientation;
@property (assign, readonly, nonatomic, getter=isFullscreen) BOOL fullscreen;
@property (strong, nonatomic) UIView *fatherView;

- (void)playVideoWithURL:(NSURL * _Nonnull)url controlView:(UIView  * _Nullable)controlView;

@end
