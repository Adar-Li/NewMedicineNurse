//
//  CommonTableController.m
//  MedicineNurse
//
//  Created by lanou3g on 15/10/9.
//  Copyright © 2015年 Adar-Li. All rights reserved.
//

#import "CommonTableController.h"
#import "CommonClickCell.h"
#import "AFHTTPSessionManager.h"
#import "DrugAndnewsListModel.h"
#import "UIImageView+WebCache.h"
#import "CommonNewsDetailsController.h"
#import "CommonDrugDetailsController.h"

@interface CommonTableController ()

@property (nonatomic, strong) NSDictionary *deseaseInfoDic;

@end

@implementation CommonTableController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    //注册Cell
    [self.tableView registerNib:[UINib nibWithNibName:@"CommonClickCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    
    [self requestCommonDetail];
    
}

//解析点击列表
- (void)requestCommonDetail{
    NSString *url = KCommonClickURL(self.clickModel.dataId);
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:url parameters:nil success:^(NSURLSessionDataTask *  task, id   responseObject) {
        //表头
        self.deseaseInfoDic = responseObject[@"data"][@"deseaseInfo"];
        [self drawHeader1];
        
        //详情
        NSArray *array = responseObject[@"data"][@"newsList"];
        for (NSDictionary *dic in array) {
            DrugAndnewsListModel *model = [DrugAndnewsListModel new];
            [model setValuesForKeysWithDictionary:dic];
            [self.newsListMutArray addObject:model];
            }
        
        //相关用药
        NSArray *drugArray = responseObject[@"data"][@"drugList"];
        for (NSDictionary *dic in drugArray) {
            DrugAndnewsListModel *model = [DrugAndnewsListModel new];
            [model setValuesForKeysWithDictionary:dic];
            [self.drugListMutArray addObject:model];
        }
        [self.tableView reloadData];
        
    } failure:^(NSURLSessionDataTask *  task, NSError *  error) {
        
    }];
}

#pragma mark - 表头
//表头1
- (void)drawHeader1{
    
    UIView *view1 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 74)];
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, self.view.frame.size.width - 20, 64)];
    UIView *view2 = [[UIView alloc]initWithFrame:CGRectMake(0,64 , self.view.frame.size.width, 10)];
    view2.backgroundColor = [UIColor lightGrayColor];
    label.text = self.deseaseInfoDic[@"content"];
    label.font = [UIFont systemFontOfSize:13];
    label.numberOfLines = 2;
    [view1 addSubview:label];
    [view1 addSubview:view2];
    
    self.tableView.tableHeaderView = view1;
}

//表头2
//- (void)drawHeder2{
//    
//    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, kScremWidth, 32)];
//    label.text = @"相关用药";
//    
//    self.tableView.tableHeaderView = label;
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

//曲头
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    
    if (section == 1) {
        return @"相关用药";
    }else{
        return nil;
    }
    
}

//曲头
//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
//    
//    UIView *view1 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 74)];
//    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, self.view.frame.size.width - 20, 64)];
//    UIView *view2 = [[UIView alloc]initWithFrame:CGRectMake(0,64 , self.view.frame.size.width, 10)];
//    view2.backgroundColor = [UIColor lightGrayColor];
//    label.text = self.deseaseInfoDic[@"content"];
//    label.font = [UIFont systemFontOfSize:13];
//    label.numberOfLines = 2;
//    [view1 addSubview:label];
//    [view1 addSubview:view2];
//    
//    UILabel *DragLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, kScremWidth, 32)];
//    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScremWidth, 32)];
//    [view addSubview:DragLabel];
//    label.text = @"相关用药";
//    
//    if (section == 0) {
//        return view1;
//    }
//        return view;
//    
//}


//曲头高度
//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
//    return 30;
//}


//分区个数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 2;
}

//Cell个数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return self.newsListMutArray.count;
    }
    
    return self.drugListMutArray.count;
    
}
//行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
        return 75;
}
//点击事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        
        //newsList
        CommonNewsDetailsController *commonNDC = [CommonNewsDetailsController new];
        DrugAndnewsListModel *newsListModel = self.newsListMutArray[indexPath.row];
        commonNDC.commonNDModel = newsListModel;
        [self.navigationController pushViewController:commonNDC animated:YES];
    }else if(indexPath.section == 1){
    //drugList
    CommonDrugDetailsController *commonDDC = [CommonDrugDetailsController new];
    DrugAndnewsListModel *drugListModel = self.drugListMutArray[indexPath.row];
    commonDDC.commonNDModel = drugListModel;
    [self.navigationController pushViewController:commonDDC animated:YES];
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
//        [self drawHeader1];
        CommonClickCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
        DrugAndnewsListModel *model = self.newsListMutArray[indexPath.row];
        cell.label4InfoTitle.text = model.infoTitle;
        [cell.img4InfoLogo sd_setImageWithURL:[NSURL URLWithString:model.infoLogo]];
        cell.label4InfoContent.text = model.infoContent;
        return cell;
    }else{
//        [self drawHeder2];
    CommonClickCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    DrugAndnewsListModel *model = self.drugListMutArray[indexPath.row];
    cell.label4InfoTitle.text = model.drugName;
    [cell.img4InfoLogo sd_setImageWithURL:[NSURL URLWithString:model.drugPic]];
    cell.label4InfoContent.text = model.promotionInfo;
    return cell;
    }
}


#pragma mark - lazy load
- (NSDictionary *)deseaseInfoDic{
    if (nil == _deseaseInfoDic) {
        _deseaseInfoDic = [NSDictionary new];
    }
    return _deseaseInfoDic;
}

- (NSMutableArray *)newsListMutArray{
    if (nil == _newsListMutArray) {
        _newsListMutArray = [NSMutableArray new];
    }
    return _newsListMutArray;
}

- (NSMutableArray *)drugListMutArray{
    if (nil == _drugListMutArray) {
        _drugListMutArray = [NSMutableArray new];
    }
    return _drugListMutArray;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
