//
//  ViewController.m
//  VCVideoPlayer
//
//  Created by Victor Chee on 2018/5/23.
//  Copyright © 2018年 VictorChee. All rights reserved.
//

#import "ViewController.h"
#import "VCVideoPlayerView.h"

@interface ViewController () {
    CGRect originalFrame;
    CGRect frameInWindow;
}
@property (strong, nonatomic) IBOutlet UIView *contentView;
@property (strong, nonatomic) VCVideoPlayerView *playerView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    self.playerView = [[VCVideoPlayerView alloc] init];
//    self.playerView.backgroundColor = [UIColor purpleColor];
//    self.playerView.fatherView = self.contentView;
//    NSURL *url = [NSURL URLWithString:@"https://link"];
//    [self.playerView playVideoWithURL:url controlView:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)fullscreenButtonTapped:(UIButton *)sender {
    UIWindow *window = UIApplication.sharedApplication.keyWindow;
    if (sender.isSelected) {
        // Miniscreen
    } else {
        // Fullscreen
        originalFrame = self.contentView.frame;
        frameInWindow = [self.view convertRect:self.contentView.frame toView:nil];
        self.contentView.frame = frameInWindow;
        [window addSubview:self.contentView];
        [UIView animateWithDuration:0.35 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            self.contentView.transform = CGAffineTransformMakeRotation(M_PI_2);
            self.contentView.bounds = CGRectMake(0, 0, CGRectGetHeight(self.contentView.superview.bounds), CGRectGetWidth(self.contentView.superview.bounds));
            self.contentView.center = CGPointMake(CGRectGetMidX(self.contentView.superview.bounds), CGRectGetMidY(self.contentView.superview.bounds));
        } completion:^(BOOL finished) {
            [UIApplication.sharedApplication setStatusBarHidden:YES withAnimation:UIStatusBarAnimationFade];
            self.contentView.frame = self.contentView.superview.bounds;
            sender.selected = YES;
        }];
        //        [UIDevice.currentDevice setValue:@(UIInterfaceOrientationLandscapeRight) forKey:@"orientation"];
        [UIApplication.sharedApplication setStatusBarOrientation:UIInterfaceOrientationLandscapeRight animated:YES];
    }
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
