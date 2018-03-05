//
//  SecondController.m
//  CLTimerDemo
//
//  Created by Apple on 2018/2/11.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import "SecondController.h"
#import "CLTimer.h"

@interface SecondController ()

@property (nonatomic, strong) CLTimer *timer;

@property (nonatomic, strong) CLTimer *displayTimer;

@end

@implementation SecondController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor yellowColor];

    __weak typeof(self) weakSelf = self;
    self.timer = [CLTimer timerWithTimeInterval:10.f userInfo:nil repeats:YES timerBlock:^(NSTimer *timer) {
        NSLog(@"[========%@======]",weakSelf);
    }];
    [self.timer startTimer];



    self.displayTimer = [CLTimer displayLinkWithDisplayBlock:^{
        NSLog(@"ssdfdfdeeererere");
    }];

    [self.displayTimer startTimer];



}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}




@end
