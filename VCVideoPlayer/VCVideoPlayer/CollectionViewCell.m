//
//  CollectionViewCell.m
//  VCVideoPlayer
//
//  Created by Victor Chee on 2018/5/21.
//  Copyright © 2018年 VictorChee. All rights reserved.
//

#import "CollectionViewCell.h"

@interface CollectionViewCell()
@property (weak, nonatomic) IBOutlet UIImageView *coverImageView;

@property (strong, nonatomic) UIButton *playButton;
@end

@implementation CollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.playButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.playButton setTitle:@"PLAY" forState:UIControlStateNormal];
    [self.playButton setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [self.playButton addTarget:self action:@selector(playButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:self.playButton];
    
    self.playButton.translatesAutoresizingMaskIntoConstraints = NO;
    [self.playButton.centerXAnchor constraintEqualToAnchor:self.contentView.centerXAnchor].active = YES;
    [self.playButton.centerYAnchor constraintEqualToAnchor:self.contentView.centerYAnchor   ].active = YES;
}

- (void)playButtonTapped:(UIButton *)sender {
    if (self.playButtonTappedHandler) {
        self.playButtonTappedHandler(sender);
    }
}

@end
