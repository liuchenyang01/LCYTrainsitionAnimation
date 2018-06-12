//
//  LCYCustomInteractiveTransition.h
//  LCYTrainsitionAnimation
//
//  Created by 刘晨阳 on 2018/6/12.
//  Copyright © 2018年 changba-mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LCYCustomInteractiveTransition : UIPercentDrivenInteractiveTransition
@property (nonatomic, assign)BOOL isInteration;
- (void)addPanGestureForViewController:(UIViewController *)viewController;

@end
