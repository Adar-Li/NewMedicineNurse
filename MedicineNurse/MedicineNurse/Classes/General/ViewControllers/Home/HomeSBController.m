//
//  HomeSBController.m
//  MedicineNurse
//
//  Created by lanou3g on 15/10/8.
//  Copyright © 2015年 Adar-Li. All rights reserved.
//

#import "HomeSBController.h"
#import "HSBCell.h"
#import <UIImageView+WebCache.h>
#import <AFNetworking.h>
#import "HSubjectModel.h"
#import "HSBDetailController.h"
#import <SVPullToRefresh.h>

@interface HomeSBController ()
{
    NSInteger pageIndex;
}

@property(nonatomic,strong)NSMutableArray * SBMutArray;

@end

@implementation HomeSBController
static NSString * hsbcell = @"hsbcell";


- (void)viewDidLoad {
    pageIndex = 1;
    [super viewDidLoad];
    [self analysisData];
    
    
    //注册自定义cell
    [self.tableView registerNib:[UINib nibWithNibName:@"HSBCell" bundle:nil] forCellReuseIdentifier:hsbcell];
    
    __weak HomeSBController * weakSelf = self;
    [self.tableView addPullToRefreshWithActionHandler:^{
        [weakSelf analysisData];
    }];
    [self.tableView addInfiniteScrollingWithActionHandler:^{
        
        [weakSelf pullFromTheButton];
    }];
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark ---上拉刷新下拉加载--

- (void)pullFromTheButton{
    pageIndex ++;
    __weak HomeSBController * weakSelf = self;
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    NSString * URL = [NSString stringWithFormat:@"http://dxy.com/app/i/columns/special/list?ac=1d6c96d5-9a53-4fe1-9537-85a33de916f1&items_per_page=10&mc=df4e09ce2cf802df592ff64773dbb40156b4d58d&page_index=%ld&vc=4.0.5",pageIndex];
    
    [manager GET:URL parameters:nil success:^(AFHTTPRequestOperation * operation, id   responseObject) {
        NSArray * array =  responseObject[@"data"][@"items"];
        for (NSDictionary * dict in array) {
            HSubjectModel * model = [HSubjectModel new];
            [model setValuesForKeysWithDictionary:dict];
            [weakSelf.SBMutArray addObject:model];
        }
    
        [weakSelf.tableView reloadData];
        
        [weakSelf.tableView.infiniteScrollingView stopAnimating];

    } failure:^(AFHTTPRequestOperation * operation, NSError * error) {
        
    }];

    
}



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.SBMutArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HSubjectModel *model = self.SBMutArray[indexPath.row];
    
    HSBCell * cell = [tableView dequeueReusableCellWithIdentifier:hsbcell forIndexPath:indexPath];
    [cell setvalueWithModel:model];
    return cell;
}

//解析主体数据
- (void)analysisData{
    __weak HomeSBController * weakSelf = self;
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    [manager GET:kHomeSBURL parameters:nil success:^(AFHTTPRequestOperation * operation, id   responseObject) {
         [weakSelf.SBMutArray removeAllObjects];
       NSArray * array =  responseObject[@"data"][@"items"];
        for (NSDictionary * dict in array) {
            HSubjectModel * model = [HSubjectModel new];
            [model setValuesForKeysWithDictionary:dict];
            [weakSelf.SBMutArray addObject:model];
        }
        [weakSelf.tableView reloadData];
        [weakSelf.tableView.pullToRefreshView stopAnimating];
    } failure:^(AFHTTPRequestOperation * operation, NSError * error) {
        
    }];
}

//设置cell的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 90;
}

#pragma mark --lazy load --
- (NSMutableArray *)SBMutArray{
    if (_SBMutArray == nil) {
        _SBMutArray = [[NSMutableArray alloc]init];
    }
    return _SBMutArray;
}

//cell的点击的事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    HSBDetailController * detailVC = [HSBDetailController new];
    
    detailVC.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
      HSubjectModel *model = self.SBMutArray[indexPath.row];
    
    detailVC.model = model;
    
    [self.navigationController pushViewController:detailVC animated:YES];
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
