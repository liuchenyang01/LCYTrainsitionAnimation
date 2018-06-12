//
//  LCYCustomTransition.h
//  LCYTrainsitionAnimation
//
//  Created by 刘晨阳 on 2018/6/12.
//  Copyright © 2018年 changba-mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
typedef NS_ENUM(NSUInteger, TransitionType){
    TransitionTypePush,
    TransitionTypePop,
};

@interface LCYCustomTransition : NSObject<UIViewControllerAnimatedTransitioning>

+ (instancetype)transitionWithType:(TransitionType)type;

@end
