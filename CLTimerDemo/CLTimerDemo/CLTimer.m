//
//  TimerTest.m
//  AudioToolboxTest
//
//  Created by Apple on 2018/2/11.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import "CLTimer.h"
#import <AVFoundation/AVFoundation.h>
#import <UIKit/UIKit.h>

@interface CLTimerTarget : NSProxy
@property (nonatomic, weak)id trueTarget;
- (instancetype)initWithTarget:(id)trueTarget;

@end

@interface CLTimer ()

@property (nonatomic, strong) NSTimer *timer;

@property (nonatomic, copy)CLTimerBlock timerBlock;

@property (nonatomic, strong) CADisplayLink *timeLink;

@property (nonatomic, copy)void(^displayBlock)(void);

@end


@implementation CLTimer

+ (instancetype)timerWithTimeInterval:(NSTimeInterval)ti  userInfo:(id)userInfo repeats:(BOOL)yesOrNo timerBlock:(CLTimerBlock)timerBlock
{
    return [[self alloc] initWithTimeInterval:ti userInfo:userInfo repeats:yesOrNo timerBlock:timerBlock];
}



+ (instancetype)displayLinkWithDisplayBlock:(void(^)(void))displayBlock
{
    return [[self alloc] initWithDisplayBlock:displayBlock];
}


- (instancetype)initWithDisplayBlock:(void(^)(void))displayBlock
{
    self = [super init];
    if (self) {
        CADisplayLink *timeLink = [CADisplayLink displayLinkWithTarget:[[CLTimerTarget alloc] initWithTarget:self] selector:@selector(timerAction:)];
        self.timeLink = timeLink;
        self.timeLink.paused = YES;
        [self.timeLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];

        [self setDisplayBlock:displayBlock];
    }
    return self;
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

    if (self.displayBlock) {
        self.displayBlock();
    }
}



- (void)dealloc{
    if (self.timer) {
        [self.timer invalidate];
        _timer = nil;
    }

    if (self.timeLink) {
        [self.timeLink invalidate];
        self.timeLink = nil;
    }
}



- (void)startTimerWithDelayTime:(NSTimeInterval)ti;
{
    if (self.timer) {
        [self.timer setFireDate:[NSDate dateWithTimeIntervalSinceNow:ti]];
    }
    if (self.timeLink) {
        [self startTimer];
    }
}


- (void)startTimer
{
    if (self.timer) {
        [self.timer setFireDate:[NSDate distantPast]];
    }
    if (self.timeLink) {
        self.timeLink.paused = NO;
    }
}

- (void)stopTimer
{
    if (self.timer) {
        [self.timer setFireDate:[NSDate distantFuture]];
    }
    if (self.timeLink) {
        self.timeLink.paused = YES;
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

