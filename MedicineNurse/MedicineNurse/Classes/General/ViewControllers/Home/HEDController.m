//
//  HEDController.m
//  MedicineNurse
//
//  Created by lanou3g on 15/10/12.
//  Copyright © 2015年 Adar-Li. All rights reserved.
//

#import "HEDController.h"
#import <AFNetworking.h>
#import "HDetailModel.h"
#import "HEDCell.h"

@interface HEDController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)NSMutableArray * editMutArray;

@property(nonatomic,strong)UITableView * tableView;
//确定按钮
@property(nonatomic,strong)UIButton * button;
@property(nonatomic,strong)NSMutableArray * likingArray;

@end

@implementation HEDController
static NSString * hedCell = @"hedcell";
- (void)viewDidLoad {
    [super viewDidLoad];
    
    //注册通知
    [[NSNotificationCenter  defaultCenter]addObserver:self selector:@selector(chooseAction:) name:kChoose object:nil];
    
    [self drawTableView];
    [self drawButton];
    self.view.backgroundColor = [UIColor whiteColor];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//确定button
- (void)drawButton{
    _button = [UIButton buttonWithType:UIButtonTypeSystem];
    _button.frame =CGRectMake(kScremWidth -60, 0, 50, 40);
    [_button setTitle:@"确定" forState:UIControlStateNormal];
    [self.view addSubview:_button];
    [_button addTarget:self action:@selector(buttonAction) forControlEvents:UIControlEventTouchUpInside];
    
}

//
- (void)buttonAction{
    if (self.likingArray.count == 0) {
  
            UIAlertController * alertVC = [UIAlertController alertControllerWithTitle:@"您什么都没选" message:@"您需要选一个展示" preferredStyle:UIAlertControllerStyleAlert];
            
            [self presentViewController:alertVC animated:YES completion:nil];
            UIAlertAction * alertAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
            
            [alertVC addAction:alertAction];
            

    }else{
    
        //发出通知
        [[NSNotificationCenter defaultCenter]postNotificationName:kBackChoose object:nil userInfo:@{@"array":self.likingArray}];
    UIAlertController * alertController = [UIAlertController alertControllerWithTitle:@"编辑成功" message:@"已经编辑成功\n可以返回查看" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction * alerAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [self dismissViewControllerAnimated:YES completion:nil];
    }] ;
    
    [alertController addAction:alerAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
    }
    
}

//解析数据
- (void)analysisData{
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    
    [manager GET:kHomeEditeURL parameters:nil success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSArray * array = responseObject[@"data"][@"items"];
        for (NSDictionary * dict in array) {
            
            HDetailModel * model = [HDetailModel new];
            [model setValuesForKeysWithDictionary:dict];
            
            [self.editMutArray addObject:model];

        }
        
        [self.tableView reloadData];
        
    } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
}

- (void)drawTableView{
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 40, kScremWidth, kScremHeight) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    //注册自定义cell
    [self.tableView registerNib:[UINib nibWithNibName:@"HEDCell" bundle:nil] forCellReuseIdentifier:hedCell];
    [self analysisData];
    [self.view addSubview:self.tableView];
}


#pragma mark --tableview的代理事件---
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.editMutArray.count;
    
}

//返回cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    HEDCell *cell = [tableView dequeueReusableCellWithIdentifier:hedCell forIndexPath:indexPath];
    HDetailModel * item = self.editMutArray[indexPath.row];
    
    cell.lable4title.text = item.name;
    cell.tag = 1000+ indexPath.row;
    
    for (NSString * str in self.likingArray) {
        if ([item.name isEqualToString:str]) {
            cell.lable4Cancel.text = @"取消";
            [self.likingArray removeAllObjects];
            
            [self.likingArray addObject:item];
            return cell;
        }
    }
    cell.lable4Cancel.text = @"订阅";
    return cell;
}

//设置cell的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}

//cell的点击事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    HDetailModel * model = self.editMutArray[indexPath.row];
    
    HEDCell * cell = (HEDCell*)[self.view viewWithTag:(1000 + indexPath.row) ];
    
    if ([cell.lable4Cancel.text isEqualToString:@"订阅"]) {
        cell.lable4Cancel.text = @"取消";
        if (self.likingArray.count > 0) {
            UIAlertController * alertVC = [UIAlertController alertControllerWithTitle:@"选得太多了" message:@"您只能选择一条展示\n多余的将不能展示" preferredStyle:UIAlertControllerStyleAlert];
        
            [self presentViewController:alertVC animated:YES completion:nil];
            UIAlertAction * alertAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
            [alertVC addAction:alertAction];
        }
        [self.likingArray addObject:model];
    }else{
        
        cell.lable4Cancel.text = @"订阅";
        for (int i = 0; i < self.likingArray.count; i ++) {
            HDetailModel * item = self.likingArray[i];
            if ([model.name isEqualToString:item.name]) {
                [self.likingArray removeObjectAtIndex:i];
            }
        }
    }
}




#pragma mark --通知---
//通知选择事件
- (void)chooseAction:(NSNotification*)notice{
    [self.likingArray removeAllObjects];
    NSString * titleStr = notice.userInfo[@"name"];
    
    [self.likingArray addObject:titleStr];
    
}



#pragma mark --lazy load---
- (NSMutableArray *)editMutArray{
    if (_editMutArray == nil) {
        _editMutArray = [[NSMutableArray alloc]initWithCapacity:10];
    }
    
    return _editMutArray;
}

//订阅的数组
- (NSMutableArray *)likingArray{
    if (_likingArray == nil) {
        _likingArray = [[NSMutableArray alloc]initWithCapacity:8];
    }
    return _likingArray;
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
