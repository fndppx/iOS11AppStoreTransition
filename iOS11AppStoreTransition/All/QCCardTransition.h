//
//  QCCardTransition.h
//  QingClassSaas
//
//  Created by weikeyan on 2017/10/16.
//  Copyright © 2017年 QingClass. All rights reserved.
//

#import <Foundation/Foundation.h>
/**
 *  动画过渡代理管理的是push还是pop
 */
typedef NS_ENUM(NSUInteger, QCCardTransitionType) {
    QCCardTransitionTypePush = 0,
    QCCardTransitionTypePop
};
@interface QCCardTransition : NSObject
/**
 *  初始化动画过渡代理
 */
+ (instancetype)transitionWithType:(QCCardTransitionType)type;
- (instancetype)initWithTransitionType:(QCCardTransitionType)type;

@end
