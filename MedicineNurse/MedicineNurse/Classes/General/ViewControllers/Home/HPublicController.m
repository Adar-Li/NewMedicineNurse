//
//  HPublicController.m
//  MedicineNurse
//
//  Created by lanou3g on 15/10/10.
//  Copyright © 2015年 Adar-Li. All rights reserved.
//

#import "HPublicController.h"
#import <AFNetworking.h>
#import "HCCell.h"
#import "HSBCell.h"
#import "HomeCell.h"
#import "HSBDetailController.h"
#import "HDetailController.h"
#import <SVPullToRefresh.h>

@interface HPublicController ()
{
    NSInteger pageIndex;
}
//可变数组
@property(nonatomic,strong)NSMutableArray * mutArray;
@end

@implementation HPublicController
static NSString * homeCell = @"homeCell";
static NSString * hcCCell = @"hccCellID";
- (void)viewDidLoad {
    [super viewDidLoad];
    pageIndex = 1;
    //注册自定义cell
    [self.tableView registerNib:[UINib nibWithNibName:@"HCCell" bundle:nil] forCellReuseIdentifier:hcCCell];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"HomeCell" bundle:nil] forCellReuseIdentifier:homeCell];
    //绘制UI界面
    [self analysisdata];
    
    __weak HPublicController * weakSelf = self;
    //刷新
    [weakSelf.tableView addPullToRefreshWithActionHandler:^{
        [weakSelf analysisdata];
    }];
    //加载
    [weakSelf.tableView addInfiniteScrollingWithActionHandler:^{
        [weakSelf pullFromThebutton];
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark --上拉刷新下拉加载的方法--
- (void)pullFromThebutton{
    pageIndex ++;
     __weak HPublicController * weakSelf = self;
    
    NSString * pageStr = [NSString stringWithFormat:@"page_index=%ld",pageIndex];
    NSString * URL = [weakSelf.URLStr stringByReplacingOccurrencesOfString:@"page_index=1" withString:pageStr];
    AFHTTPRequestOperationManager * manager =[AFHTTPRequestOperationManager manager];
    
    [manager GET:URL parameters:nil success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSArray * array = responseObject[@"data"][@"items"];
        for (NSDictionary * dict in array) {
            RecommendModel * detailModel = [RecommendModel new];
            [detailModel setValuesForKeysWithDictionary:dict];
            [weakSelf.mutArray addObject:detailModel];
            // 下载完重新加载
            [weakSelf.tableView reloadData];
            [weakSelf.tableView.infiniteScrollingView stopAnimating];
        }
        
    } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
        
    }];

    
}


//解析数据的方法
- (void)analysisdata{
    __weak HPublicController * weakSelf = self;
    AFHTTPRequestOperationManager * manager =[AFHTTPRequestOperationManager manager];
   
    [manager GET:weakSelf.URLStr parameters:nil success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        [weakSelf.mutArray removeAllObjects];
        NSArray * array = responseObject[@"data"][@"items"];
        for (NSDictionary * dict in array) {
            RecommendModel * detailModel = [RecommendModel new];
            [detailModel setValuesForKeysWithDictionary:dict];
            [weakSelf.mutArray addObject:detailModel];
           // 下载完重新加载
            [weakSelf.tableView reloadData];
            [weakSelf.tableView.pullToRefreshView stopAnimating];
        }
        
    } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
        
    }];

}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.mutArray.count;
}

//返回cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
     RecommendModel * item = self.mutArray[indexPath.row];
    
    if (item.special_id && item.special_name) {
       HomeCell  * cell = [tableView dequeueReusableCellWithIdentifier:homeCell forIndexPath:indexPath];
        [cell setvalueWithModel:item];
        return cell;
    }else{
    HCCell  *cell = [tableView dequeueReusableCellWithIdentifier:hcCCell forIndexPath:indexPath];
        [cell setvalueWithModel:item];
        return cell;
    }
}
//设置cell的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70;
}

//cell的点击事件

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    RecommendModel * item = self.mutArray[indexPath.row];
    
    if (item.special_id && item.special_name) {
        NSDictionary * dict = @{@"name":item.special_name,@"ID":item.special_id,@"desc":item.title};
        HSBDetailController * detailVC = [HSBDetailController new];
        
        HSubjectModel * model = [HSubjectModel new];
        
        [model setValuesForKeysWithDictionary:dict];
        detailVC.model = model;
        
        [self.navigationController pushViewController:detailVC animated:YES];
    }else{
        HDetailController * detaiVC = [HDetailController new];
        detaiVC.ID = item.ID;
        detaiVC.titleName = item.title;
        [self.navigationController pushViewController:detaiVC animated:YES];
        
    }

    
}




#pragma mark --lazy load --
- (NSMutableArray *)mutArray{
    if (_mutArray == nil) {
        _mutArray = [[NSMutableArray alloc]initWithCapacity:20];
    }
    return _mutArray;
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
