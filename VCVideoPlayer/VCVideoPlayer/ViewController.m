//
//  ViewController.m
//  VCVideoPlayer
//
//  Created by Victor Chee on 2018/5/23.
//  Copyright © 2018年 VictorChee. All rights reserved.
//

#import "ViewController.h"
#import "VCVideoPlayerView.h"

@interface ViewController ()
@property (strong, nonatomic) IBOutlet UIView *contentView;
@property (strong, nonatomic) VCVideoPlayerView *playerView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.playerView = [[VCVideoPlayerView alloc] init];
    self.playerView.backgroundColor = [UIColor purpleColor];
    self.playerView.fatherView = self.contentView;
    NSURL *url = [NSURL URLWithString:@"https://link"];
    [self.playerView playVideoWithURL:url controlView:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
