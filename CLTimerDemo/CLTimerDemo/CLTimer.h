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

+ (instancetype)timerWithTimeInterval:(NSTimeInterval)ti  userInfo:(id)userInfo repeats:(BOOL)yesOrNo timerBlock:(CLTimerBlock)timerBlock;



- (void)startTimerWithFutureTime:(NSTimeInterval)ti;

- (void)startTimer;

- (void)stopTimer;






@end
