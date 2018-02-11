//
//  ViewController.m
//  CLTimerDemo
//
//  Created by Apple on 2018/2/11.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import "ViewController.h"
#import "SecondController.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor redColor];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    SecondController *vc = [[SecondController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
