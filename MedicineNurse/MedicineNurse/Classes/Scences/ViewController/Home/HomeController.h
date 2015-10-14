//
//  HomeController.h
//  MedicineNurse
//
//  Created by lanou3g on 15/10/7.
//  Copyright © 2015年 Adar-Li. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HBView;
@interface HomeController : UIViewController
//绘制标题按钮
@property(nonatomic,strong)HBView * buttonView;
//绘制主界面scroollView
@property(nonatomic,strong)UIScrollView * mainScroll;
@property(nonatomic,strong)UITableView * tableView;



@end
