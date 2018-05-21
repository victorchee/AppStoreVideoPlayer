//
//  VCVideoControlView.h
//  VCVideoPlayer
//
//  Created by Victor Chee on 2018/5/21.
//  Copyright © 2018年 VictorChee. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol VCVideoControlDelegate;

@interface VCVideoControlView : UIView
@property (weak, nonatomic) id<VCVideoControlDelegate> delegate;
@end



@protocol VCVideoControlDelegate <NSObject>

@optional
- (void)vcVideoControlView:(UIView *)controlView backAction:(UIButton *)sender;
- (void)vcVideoControlView:(UIView *)controlView playAction:(UIButton *)sender;
- (void)vcVideoControlView:(UIView *)controlView fullscreenAction:(UIButton *)sender;


@end
