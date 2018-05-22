//
//  CollectionViewController.m
//  VCVideoPlayer
//
//  Created by Victor Chee on 2018/5/21.
//  Copyright © 2018年 VictorChee. All rights reserved.
//

#import "CollectionViewController.h"
#import "CollectionViewCell.h"
#import "VCVideoPlayerView.h"

@interface CollectionViewController () <UICollectionViewDelegateFlowLayout>
@property (strong, nonatomic) VCVideoPlayerView *playerView;
@end

@implementation CollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Do any additional setup after loading the view.
    self.playerView = [[VCVideoPlayerView alloc] init];
    self.playerView.backgroundColor = [UIColor purpleColor];
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

#pragma mark <UICollectionViewDataSource>
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 10;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([CollectionViewCell class]) forIndexPath:indexPath];
    
    // Configure the cell
    __weak typeof(cell) weakCell = cell;
    __weak typeof(self) weakSelf = self;
    cell.playButtonTappedHandler = ^(UIButton *sender) {
        __strong typeof(weakCell) strongCell = weakCell;
        __strong typeof(weakSelf) strongSelf = weakSelf;
        strongSelf.playerView.fatherView = strongCell.contentView;
        
        NSURL *url = [NSURL URLWithString:@"https://link"];
        [strongSelf.playerView playVideoWithURL:url controlView:nil];
    };
    
    return cell;
}

#pragma mark <UICollectionViewDelegateFlowLayout>
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewFlowLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat width = CGRectGetWidth(collectionView.frame) - collectionViewLayout.sectionInset.left - collectionViewLayout.sectionInset.right - collectionViewLayout.minimumInteritemSpacing;
    return CGSizeMake(width, width * 9.0 / 16.0);
}

#pragma mark <UICollectionViewDelegate>

@end
