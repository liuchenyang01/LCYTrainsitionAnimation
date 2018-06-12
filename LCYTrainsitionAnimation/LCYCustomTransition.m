//
//  LCYCustomTransition.m
//  LCYTrainsitionAnimation
//
//  Created by 刘晨阳 on 2018/6/12.
//  Copyright © 2018年 changba-mac. All rights reserved.
//

#import "LCYCustomTransition.h"
#import "ViewController.h"
#import "LCYPushToViewController.h"
#import "LCYCustomCollectionViewCell.h"
@interface LCYCustomTransition()
@property (nonatomic ,assign) TransitionType type;

@end

@implementation LCYCustomTransition
+ (instancetype)transitionWithType:(TransitionType)type
{
    return [[self alloc] initTransitionWithType:type];
}

- (instancetype)initTransitionWithType:(TransitionType)type
{
    if (self = [super init]) {
        _type = type;
    }
    return self;
}

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return 0.5;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    switch (_type) {
        case TransitionTypePush:
            [self doPushAnimation:transitionContext];
            break;
        case TransitionTypePop:
            [self doPopAnimation:transitionContext];
            break;
        default:
            break;
    }
}

- (void)doPushAnimation:(id<UIViewControllerContextTransitioning>)transitionContext
{
    //根据key拿到两个参与转场的VC；
    ViewController *fromVC = (ViewController *)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    LCYPushToViewController *toVC = (LCYPushToViewController *)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    //拿到主要用于做动画的containerView；
    UIView *containerView = [transitionContext containerView];
    
    LCYCustomCollectionViewCell *cell = (LCYCustomCollectionViewCell *)[fromVC.collectionView cellForItemAtIndexPath:fromVC.currentIndexPath];
    //截图用于做过渡
    UIView *tempView = [cell.imageView snapshotViewAfterScreenUpdates:NO];
    tempView.frame = [cell.imageView convertRect:cell.imageView.bounds toView:containerView];
    //动画前各个视图的状态
    cell.imageView.hidden = YES;
    toVC.view.alpha = 0;
    toVC.imageView.hidden = YES;
    //将两个view添加到containerview上
    [containerView addSubview:toVC.view];
    [containerView addSubview:tempView];
    //开始动画
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        tempView.frame = [toVC.imageView convertRect:toVC.imageView.bounds toView:containerView];
        toVC.view.alpha = 1;
    } completion:^(BOOL finished) {
        tempView.hidden = YES;
        toVC.imageView.hidden = NO;
        //注意，动画完成之后一定要加上这句，因为完成转场后需要push或者pop掉参与转场的controller，以此来作为标准；
        [transitionContext completeTransition:YES];
    }];
}

- (void)doPopAnimation:(id<UIViewControllerContextTransitioning>)transitionContext
{
    ViewController *toVC = (ViewController *)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    LCYPushToViewController *fromVC = (LCYPushToViewController *)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    //拿到主要用于做动画的containerView；
    UIView *containerView = [transitionContext containerView];
    
    LCYCustomCollectionViewCell *cell = (LCYCustomCollectionViewCell *)[toVC.collectionView cellForItemAtIndexPath:toVC.currentIndexPath];
    //截图用于做过渡
    UIView *tempView = containerView.subviews.lastObject;
    //动画前各个视图的状态
    cell.imageView.hidden = YES;
    tempView.hidden = NO;
    fromVC.imageView.hidden = YES;
    //将两个view添加到containerview上
    [containerView insertSubview:toVC.view atIndex:0];
    //开始动画
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        tempView.frame = [cell.imageView convertRect:cell.imageView.bounds toView:containerView];
        fromVC.view.alpha = 0;
    } completion:^(BOOL finished) {
        //由于加入了手势所以必须判断手势是取消了还是完成了；
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
        if ([transitionContext transitionWasCancelled]) {
            tempView.hidden = YES;
            fromVC.imageView.hidden = NO;
            //fromVC.view.alpha = 1.0;
        }else{
            cell.imageView.hidden = NO;
            [tempView removeFromSuperview];
            //注意，动画完成之后一定要加上这句，因为完成转场后需要push或者pop掉参与转场的controller，以此来作为标准；
            [transitionContext completeTransition:YES];
        }
    }];
}

@end
