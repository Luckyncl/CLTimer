//
//  TimerTest.h
//  AudioToolboxTest
//
//  Created by Apple on 2018/2/11.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^CLTimerBlock)(NSTimer *timer);


@interface CLTimer : NSObject


/**
   NSTimer 类型定时器
 */
+ (instancetype)timerWithTimeInterval:(NSTimeInterval)ti  userInfo:(id)userInfo repeats:(BOOL)yesOrNo timerBlock:(CLTimerBlock)timerBlock;


/*
 CADisplayLink 类型定时器
 */
+ (instancetype)displayLinkWithDisplayBlock:(void(^)(void))displayBlock;


/*
    延时执行定时器  只针对 NSTimer 类型使用(注意)
 */
- (void)startTimerWithDelayTime:(NSTimeInterval)ti;

/*
    开始 执行定时器
 */
- (void)startTimer;

/*
     停止 定时器
 */
- (void)stopTimer;

@end
