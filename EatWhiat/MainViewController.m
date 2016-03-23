//
//  MainViewController.m
//  EatWhiat
//
//  Created by 宋奕兴 on 16/3/23.
//  Copyright © 2016年 宋奕兴. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()
{
    NSArray * menuArray;
}
@property (nonatomic , strong)IBOutlet UILabel * label;
@end

@implementation MainViewController
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(getShake) name:@"shake" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(getMenuArray) name:@"menuListChange" object:nil];
    [self getMenuArray];
    self.label.text = @"摇一摇";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIColor *) randomColor
{
    CGFloat hue = ( arc4random() % 256 / 256.0 ); //0.0 to 1.0
    CGFloat saturation = ( arc4random() % 128 / 256.0 ) + 0.5; // 0.5 to 1.0,away from white
    CGFloat brightness = ( arc4random() % 128 / 256.0 ) + 0.5; //0.5 to 1.0,away from black
    return [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
}
- (void)getShake {
    self.view.backgroundColor = [self randomColor];
    int x = arc4random() % menuArray.count;
    self.label.text = menuArray[x];
    if (!self.label.text.length) {
        self.label.text = @"摇一摇";
    }
}
- (void)getMenuArray {
    menuArray = [[NSUserDefaults standardUserDefaults]objectForKey:@"menu"];
}
@end
