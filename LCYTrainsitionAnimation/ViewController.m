//
//  ViewController.m
//  LCYTrainsitionAnimation
//
//  Created by 刘晨阳 on 2018/6/12.
//  Copyright © 2018年 changba-mac. All rights reserved.
//

#import "ViewController.h"
#import "LCYCustomCollectionViewCell.h"
#import "LCYPushToViewController.h"

@interface ViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>


@property (nonatomic, strong) UICollectionViewFlowLayout *layout;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.title = @"Animation";
    _layout = [[UICollectionViewFlowLayout alloc] init];
    _layout.minimumLineSpacing = 10;
    _layout.minimumInteritemSpacing = 20;
    _layout.sectionInset = UIEdgeInsetsMake(10, 10, 0, 10);
    CGRect screenframe = [UIScreen mainScreen].bounds;
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, screenframe.size.width, screenframe.size.height) collectionViewLayout:_layout];
    _collectionView.showsVerticalScrollIndicator = NO;
    _collectionView.showsHorizontalScrollIndicator = NO;
    _collectionView.translatesAutoresizingMaskIntoConstraints = NO;
    [_collectionView setBackgroundColor:[UIColor whiteColor]];
    [_collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([LCYCustomCollectionViewCell class]) bundle:nil] forCellWithReuseIdentifier:NSStringFromClass([LCYCustomCollectionViewCell class])];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    [self.view addSubview:_collectionView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 12;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath;
{
    LCYCustomCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([LCYCustomCollectionViewCell class]) forIndexPath:indexPath];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(100, 100);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    LCYPushToViewController *con = [[LCYPushToViewController alloc] init];
    _currentIndexPath = indexPath;
    self.navigationController.delegate = con;
    [self.navigationController pushViewController:con animated:YES];
}
@end
