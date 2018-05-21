//
//  VCVideoControlView.m
//  VCVideoPlayer
//
//  Created by Victor Chee on 2018/5/21.
//  Copyright © 2018年 VictorChee. All rights reserved.
//

#import "VCVideoControlView.h"

@interface VCVideoControlView()
@property (weak, nonatomic) IBOutlet UIVisualEffectView *topControlView;

@property (weak, nonatomic) IBOutlet UIVisualEffectView *centerControlView;
@property (weak, nonatomic) IBOutlet UIButton *playButton;

@property (weak, nonatomic) IBOutlet UIVisualEffectView *bottomControlView;
@property (weak, nonatomic) IBOutlet UIButton *fullscreenButton;
@end

@implementation VCVideoControlView

- (IBAction)playButtonTapped:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(vcVideoControlView:playAction:)]) {
        [self.delegate vcVideoControlView:self playAction:sender];
    }
}

- (IBAction)fullscreenButtonTapped:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(vcVideoControlView:fullscreenAction:)]) {
        [self.delegate vcVideoControlView:self fullscreenAction:sender];
    }
}

@end
