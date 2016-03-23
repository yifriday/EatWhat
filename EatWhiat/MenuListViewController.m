//
//  MenuListViewController.m
//  EatWhiat
//
//  Created by 宋奕兴 on 16/3/23.
//  Copyright © 2016年 宋奕兴. All rights reserved.
//

#import "MenuListViewController.h"

@interface MenuListViewController ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
{
    NSMutableArray * menuArray;
}
@property (nonatomic , strong)IBOutlet UITableView * tableView;
@property (nonatomic , strong)IBOutlet UITextField * textF;
@property (nonatomic , strong)IBOutlet UIButton * addBtn;
@end

@implementation MenuListViewController
-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    self.view.frame = CGRectMake(0, 0, CGRectGetWidth([UIScreen mainScreen].bounds) * Width_Float, CGRectGetHeight([UIScreen mainScreen].bounds));
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.textF resignFirstResponder];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    menuArray = [NSMutableArray arrayWithArray:[[NSUserDefaults standardUserDefaults]objectForKey:@"menu"]];
    if (!menuArray) {
        menuArray = [[NSMutableArray alloc]init];
    }
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    
    [self.addBtn addTarget:self action:@selector(addBtnClick) forControlEvents:UIControlEventTouchUpInside];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return menuArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.textLabel.text = menuArray[indexPath.row];
    return cell;
}
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleDelete;
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [menuArray removeObjectAtIndex:indexPath.row];
        [[NSUserDefaults standardUserDefaults]setObject:menuArray forKey:@"menu"];
        [[NSNotificationCenter defaultCenter]postNotificationName:@"menuListChange" object:nil];
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath, nil] withRowAnimation:UITableViewRowAnimationLeft];
    }
}
- (void)addBtnClick {
    if (self.textF.text.length) {
        [menuArray addObject:self.textF.text];
        [[NSUserDefaults standardUserDefaults]setObject:menuArray forKey:@"menu"];
        [[NSNotificationCenter defaultCenter]postNotificationName:@"menuListChange" object:nil];
        [self.tableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:menuArray.count - 1 inSection:0]] withRowAnimation:UITableViewRowAnimationRight];
        self.textF.text = nil;
    }
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if ([string isEqualToString:@"\n"]) {
        [self addBtnClick];
    }
    return YES;
}
@end
