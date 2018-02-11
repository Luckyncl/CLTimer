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


@end

@implementation SecondController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor yellowColor];

    self.timer = [CLTimer timerWithTimeInterval:1.f userInfo:nil repeats:YES timerBlock:^(NSTimer *timer) {
        NSLog(@"定时器----");
    }];
    [self.timer startTimer];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.navigationController popToRootViewControllerAnimated:YES];
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
