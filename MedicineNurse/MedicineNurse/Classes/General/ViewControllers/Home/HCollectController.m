//
//  HCollectController.m
//  MedicineNurse
//
//  Created by lanou3g on 15/10/15.
//  Copyright © 2015年 Adar-Li. All rights reserved.
//

#import "HCollectController.h"
#import "HCCell.h"
#import "RecommendModel.h"
#import "DataManager.h"
#import "HLoverModel.h"


@interface HCollectController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView * tableView;
@property(nonatomic,strong)NSMutableArray * itemArray;

@end

@implementation HCollectController
static NSString * hccCell = @"hccCellID";

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.tabBarController.tabBar.hidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //绘制tableView界面
    
    self.itemArray =  [[[DataManager shareDatamanager]selectAllDataWithTableName:kLoverTable mainKey:kLoverKey title:kLoverTitle URl:kLoverURL] mutableCopy];
    self.tabBarController.tabBar.hidden = YES;
    self.navigationItem.title = @"我收藏的文章";
    //注册自定义cell
    //    [self.tableView registerNib:[UINib nibWithNibName:@"HCCell" bundle:nil] forCellReuseIdentifier:hccCell];
    
    [self drawCollectTableView];
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//绘制tableView
- (void)drawCollectTableView{
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0,0, kScremWidth, kScremHeight) style:UITableViewStylePlain];
    [self.tableView registerNib:[UINib nibWithNibName:@"HCCell" bundle:nil] forCellReuseIdentifier:hccCell];
    [self.view addSubview:self.tableView];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
}

#pragma mark --tableView的代理事件---
//返回分区数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

//设置行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _itemArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    HLoverModel * model = self.itemArray[indexPath.row];
    
    HCCell * cell  = [tableView dequeueReusableCellWithIdentifier:hccCell forIndexPath:indexPath];
    
    RecommendModel * item = [RecommendModel new];
    item.title = model.title;
    item.cover_small = model.picUrl;
    [cell setvalueWithModel:item];
    
    
    return cell;
}

//设置cell的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 65;
}

//cell的点击事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
}



#pragma mark -- lazy loda---
- (NSMutableArray *)itemArray{
    if (_itemArray == nil) {
        _itemArray = [[NSMutableArray alloc]init];
    }
    return _itemArray;
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
