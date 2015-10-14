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
    
    //五个模块：首页、常见病症、医药资讯、附近、我
    
    UINavigationController * homeNC = [[UINavigationController alloc] initWithRootViewController:[HomeController new]];
//    HomeController *homeNC = [HomeController new];
    homeNC.tabBarItem.title = @"首页";
    
    UINavigationController *common = [[UINavigationController alloc]initWithRootViewController:[CommonController new]];
    common.tabBarItem.title = @"常见病症";
    
//    UINavigationController *suffer = [[UINavigationController alloc]initWithRootViewController:[SufferViewController new]];
//    suffer.tabBarItem.title = @"用药咨询";
    
//    UINavigationController *Nearby = [[UINavigationController alloc]initWithRootViewController:[NearbyViewController new]];
//    Nearby.tabBarItem.title = @"附近";
    
//    UINavigationController *User = [[UINavigationController alloc]initWithRootViewController:[UserListController new]];
//    User.tabBarItem.title = @"用户";
    
    
    [self parentViewController];
    
    self.viewControllers = @[homeNC,common ];

    
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
