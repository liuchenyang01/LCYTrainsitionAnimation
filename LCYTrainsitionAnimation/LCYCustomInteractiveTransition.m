//
//  LCYCustomInteractiveTransition.m
//  LCYTrainsitionAnimation
//
//  Created by 刘晨阳 on 2018/6/12.
//  Copyright © 2018年 changba-mac. All rights reserved.
//

#import "LCYCustomInteractiveTransition.h"

@interface LCYCustomInteractiveTransition()
@property (nonatomic, weak) UIViewController *vc;

@end

@implementation LCYCustomInteractiveTransition


- (void)addPanGestureForViewController:(UIViewController *)viewController{
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handleGesture:)];
    self.vc = viewController;
    [viewController.view addGestureRecognizer:pan];
}

- (void)handleGesture:(UIPanGestureRecognizer *)panGesture
{
    CGFloat transitionX = [panGesture translationInView:panGesture.view].x;
    CGFloat persent = transitionX / panGesture.view.frame.size.width;
    
    switch (panGesture.state) {
        case UIGestureRecognizerStateBegan:
            _isInteration = YES;
            [self start];
            break;
        case UIGestureRecognizerStateChanged:
            [self updateInteractiveTransition:persent];
            break;
        case UIGestureRecognizerStateEnded:
            _isInteration = NO;
            if (persent > 0.5) {
                [self finishInteractiveTransition];
            }else{
                [self cancelInteractiveTransition];
            }
            break;
        default:
            break;
    }
}

- (void)start
{
    [self.vc.navigationController popViewControllerAnimated:YES];
}
@end
