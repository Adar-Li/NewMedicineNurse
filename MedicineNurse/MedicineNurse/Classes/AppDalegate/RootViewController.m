//
//  RootViewController.m
//  MedicineNurse
//
//  Created by lanou3g on 15/10/9.
//  Copyright © 2015年 Adar-Li. All rights reserved.
//

#import "RootViewController.h"
#import "CommonController.h"
#import "HomeController.h"
#import "SufferViewController.h"
#import "UserListController.h"



@interface RootViewController ()

@end

@implementation RootViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    
    
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    //添加视图控制器
    [self p_setupControllers];
}

- (void)p_setupControllers
{
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.tabBar.backgroundColor = [UIColor whiteColor];
    //四个模块：首页、常见病症、医药资讯、我
    
    UINavigationController * homeNC = [[UINavigationController alloc] initWithRootViewController:[HomeController new]];
    homeNC.tabBarItem.title = @"首页";
    homeNC.navigationBar.backgroundColor = [UIColor colorWithRed:0.957 green:1.000 blue:0.091 alpha:1.000];
    
    UINavigationController *common = [[UINavigationController alloc]initWithRootViewController:[CommonController new]];
    common.tabBarItem.title = @"常见病症";
    common.navigationBar.backgroundColor = [UIColor colorWithWhite:0.600 alpha:1.000];
    
    UINavigationController *suffer = [[UINavigationController alloc]initWithRootViewController:[SufferViewController new]];
    suffer.tabBarItem.title = @"用药助手";
    suffer.navigationBar.backgroundColor = [UIColor colorWithRed:0.000 green:0.502 blue:1.000 alpha:1.000];
    
    UINavigationController *User = [[UINavigationController alloc]initWithRootViewController:[UserListController new]];
    User.tabBarItem.title = @"用户";
    User.navigationBar.backgroundColor = [UIColor colorWithRed:0.957 green:1.000 blue:0.091 alpha:1.000];
    
    self.viewControllers = @[homeNC,common,suffer,User];

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
