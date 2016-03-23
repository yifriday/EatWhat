//
//  ViewController.m
//  EatWhiat
//
//  Created by 宋奕兴 on 16/3/23.
//  Copyright © 2016年 宋奕兴. All rights reserved.
//

#import "ViewController.h"
#import "MainViewController.h"
#import "MenuListViewController.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self becomeFirstResponder];
    // Do any additional setup after loading the view, typically from a nib.
    self.centerController = [[MainViewController alloc]init];
    self.leftController = [[MenuListViewController alloc]init];
    self.leftSize = CGRectGetWidth([UIScreen mainScreen].bounds)  * (1 - Width_Float);
    self.centerhiddenInteractivity = IIViewDeckCenterHiddenNotUserInteractiveWithTapToClose;
    self.elastic = NO;
}
-(BOOL)canBecomeFirstResponder
{
    return YES;
}
#pragma mark - 摇一摇相关方法
// 摇一摇开始摇动
- (void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event {
    NSLog(@"开始摇动");
    return;
}

// 摇一摇取消摇动
- (void)motionCancelled:(UIEventSubtype)motion withEvent:(UIEvent *)event {
    NSLog(@"取消摇动");
    return;
}

// 摇一摇摇动结束
- (void) motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event

{
    
    //摇动结束
    
    if (event.subtype == UIEventSubtypeMotionShake) {
        
        [[NSNotificationCenter defaultCenter]postNotificationName:@"shake" object:nil];
    }
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
