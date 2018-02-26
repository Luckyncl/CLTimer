//
//  TimerTest.m
//  AudioToolboxTest
//
//  Created by Apple on 2018/2/11.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import "CLTimer.h"


@interface CLTimerTarget : NSProxy
@property (nonatomic, weak)id trueTarget;
- (instancetype)initWithTarget:(id)trueTarget;

@end



@interface CLTimer ()

@property (nonatomic, strong) NSTimer *timer;

@property (nonatomic, copy)CLTimerBlock timerBlock;


@end


@implementation CLTimer

+ (instancetype)timerWithTimeInterval:(NSTimeInterval)ti  userInfo:(id)userInfo repeats:(BOOL)yesOrNo timerBlock:(CLTimerBlock)timerBlock
{
    return [[self alloc] initWithTimeInterval:ti userInfo:userInfo repeats:yesOrNo timerBlock:timerBlock];
}



- (instancetype)initWithTimeInterval:(NSTimeInterval)ti  userInfo:( id)userInfo repeats:(BOOL)yesOrNo timerBlock:(void(^)(NSTimer *timer))timerBlock
{
    self = [super init];
    if (self) {
        self.timer = [NSTimer timerWithTimeInterval:ti target:[[CLTimerTarget alloc] initWithTarget:self] selector:@selector(timerAction:) userInfo:userInfo repeats:yesOrNo];
        [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
        [self setTimerBlock:timerBlock];
        [self stopTimer];
    }
    return self;
}


- (void)timerAction:(NSTimer *)timer
{
    if (self.timerBlock) {
        self.timerBlock(timer);
    }
}



- (void)dealloc{
    [self.timer invalidate];
    _timer = nil;
}



- (void)startTimerWithFutureTime:(NSTimeInterval)ti
{
    if (self.timer) {
        [self.timer setFireDate:[NSDate dateWithTimeIntervalSinceNow:ti]];
    }
}


- (void)startTimer
{
    if (self.timer) {
        [self.timer setFireDate:[NSDate distantPast]];
    }
}



- (void)stopTimer
{
    if (self.timer) {
        [self.timer setFireDate:[NSDate distantFuture]];
    }
}


@end



@implementation CLTimerTarget

- (instancetype)initWithTarget:(id)trueTarget
{
    _trueTarget = trueTarget;
    return self;
}

/*  返回方法签名 */
- (NSMethodSignature *)methodSignatureForSelector:(SEL)sel
{
    return [_trueTarget methodSignatureForSelector:sel];
}

/* 设置消息接收对象 */
- (void)forwardInvocation:(NSInvocation *)invocation {
    if (_trueTarget && [_trueTarget respondsToSelector:invocation.selector]) {
        [invocation setTarget:_trueTarget];
        [invocation invoke];
    }
}


@end

