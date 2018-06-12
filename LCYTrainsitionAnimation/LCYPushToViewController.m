//
//  LCYPushToViewController.m
//  LCYTrainsitionAnimation
//
//  Created by 刘晨阳 on 2018/6/12.
//  Copyright © 2018年 changba-mac. All rights reserved.
//

#import "LCYPushToViewController.h"
#import "LCYCustomTransition.h"
#import "LCYCustomInteractiveTransition.h"

@interface LCYPushToViewController ()

@property (nonatomic, strong)LCYCustomInteractiveTransition *interactive;
@end

@implementation LCYPushToViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _interactive = [[LCYCustomInteractiveTransition alloc] init];
    [_interactive addPanGestureForViewController:self];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (nullable id <UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController
                                   interactionControllerForAnimationController:(id <UIViewControllerAnimatedTransitioning>) animationController
{
    //这里再没有手势时应该穿入nil，否则无法通过点击naigaitonbar左边的item正常退出；
    return _interactive.isInteration ? _interactive : nil;
}

- (nullable id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                            animationControllerForOperation:(UINavigationControllerOperation)operation
                                                         fromViewController:(UIViewController *)fromVC
                                                           toViewController:(UIViewController *)toVC
{
    return [LCYCustomTransition transitionWithType:operation == UINavigationControllerOperationPush?TransitionTypePush:TransitionTypePop];
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
