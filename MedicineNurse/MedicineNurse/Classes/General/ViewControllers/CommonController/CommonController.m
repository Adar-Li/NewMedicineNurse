//
//  CommonController.m
//  MedicineNurse
//
//  Created by lanou3g on 15/10/7.
//  Copyright © 2015年 Adar-Li. All rights reserved.
//

#import "CommonController.h"
#import "CommonClassifyController.h"
#import "CommonDetailsController.h"

@interface CommonController ()
@property (nonatomic,strong) CommonClassifyController *left;
@property (nonatomic,strong) CommonDetailsController *right;
@end

@implementation CommonController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.left = [CommonClassifyController new];
    _left.view.frame = CGRectMake(0, 64, self.view.frame.size.width/2.8, self.view.frame.size.height - 110);
    self.right = [CommonDetailsController new];
    _right.view.frame = CGRectMake(self.view.frame.size.width/3, 0, self.view.frame.size.width, self.view.frame.size.height + 5);
    
    [self.view addSubview:_right.view];
    [self.view addSubview:_left.view];
    [self addChildViewController:self.left];
    [self addChildViewController:self.right];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (CommonClassifyController *)left{
    if (nil == _left) {
        _left = [CommonClassifyController new];
    }
    return _left;
}

- (CommonDetailsController *)right{
    if (nil == _right) {
        _right = [CommonDetailsController new];
    }
    return _right;
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
