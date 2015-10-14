//
//  HSBDetailController.m
//  MedicineNurse
//
//  Created by lanou3g on 15/10/10.
//  Copyright © 2015年 Adar-Li. All rights reserved.
//

#import "HSBDetailController.h"
#import <AFNetworking.h>
#import "HCCell.h"
#import "RecommendModel.h"
#import "HDetailController.h"
#import <SVPullToRefresh.h>

@interface HSBDetailController ()
{
    NSInteger pageIndex;
}
//可变数组
@property(nonatomic,strong)NSMutableArray * mutArray;

@end

@implementation HSBDetailController
static  NSString * hccCell = @"hcccellID";



//视图将要出现时
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
}
//视图将要消失的时候
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    pageIndex = 1 ;
    //解析数据
    [self analysisdata];

    //注册自定义cell
    [self.tableView registerNib:[UINib nibWithNibName:@"HCCell" bundle:nil] forCellReuseIdentifier:hccCell];
    //绘制头界面
    [self drawHeader];
    //上拉刷新
    __weak HSBDetailController * weakself = self;
    [weakself.tableView addPullToRefreshWithActionHandler:^{
        
        [weakself analysisdata];
    }];
    //下拉加载
    [weakself.tableView addInfiniteScrollingWithActionHandler:^{
        [weakself pullFromTheButton];
        
    }];
    
}

//绘制表头
-(void)drawHeader{
    UIView * headerView  = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScremWidth , 70)];
    headerView.backgroundColor = [UIColor colorWithRed:0.899 green:0.912 blue:0.907 alpha:1.000]
    ;
    UILabel * titleLable = [[UILabel alloc]initWithFrame:CGRectMake(10, 5, kScremWidth - 20, 25)];
    titleLable.font = [UIFont systemFontOfSize:16];
    titleLable.text = self.model.name;
    titleLable.textAlignment = NSTextAlignmentCenter;
    [headerView addSubview:titleLable];
    UILabel * instroLable = [[UILabel alloc]initWithFrame:CGRectMake(10, 30, kScremWidth -20, 40)];
    instroLable.numberOfLines = 0 ;
    instroLable.text = self.model.desc;
    instroLable.font =[UIFont systemFontOfSize:12];
    [headerView addSubview:instroLable];
    instroLable.textColor = [UIColor colorWithRed:0.333 green:0.323 blue:0.305 alpha:1.000];
    
    self.tableView.tableHeaderView = headerView;
}

#pragma mark --下拉加载的方法--
- (void)pullFromTheButton{
    pageIndex ++;
    __weak HSBDetailController * weakself = self;
    AFHTTPRequestOperationManager * manager =[AFHTTPRequestOperationManager manager];
    NSString * URL = [NSString stringWithFormat:@"http://dxy.com/app/i/columns/article/list?ac=1d6c96d5-9a53-4fe1-9537-85a33de916f1&items_per_page=10&mc=df4e09ce2cf802df592ff64773dbb40156b4d58d&order=publishTime&page_index=%ld&special_id=%@&vc=4.0.5",pageIndex,self.model.ID];
    
    [manager GET:URL parameters:nil success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSArray * array = responseObject[@"data"][@"items"];
        for (NSDictionary * dict in array) {
            RecommendModel * detailModel = [RecommendModel new];
            [detailModel setValuesForKeysWithDictionary:dict];
            [weakself.mutArray addObject:detailModel];
            //下载完重新加载
            [weakself.tableView reloadData];
            
        }
        [weakself.tableView.infiniteScrollingView stopAnimating];
        
    } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
        
    }];

    
}


//解析数据方法
- (void)analysisdata{
    AFHTTPRequestOperationManager * manager =[AFHTTPRequestOperationManager manager];
    NSString * URLStr = kHomeSBDetailURL(self.model.ID);
    [manager GET:URLStr parameters:nil success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
       NSArray * array = responseObject[@"data"][@"items"];
        for (NSDictionary * dict in array) {
            RecommendModel * detailModel = [RecommendModel new];
            [detailModel setValuesForKeysWithDictionary:dict];
            [self.mutArray addObject:detailModel];
            //下载完重新加载
            [self.tableView reloadData];
        }
        
    } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.mutArray.count;
}

//设置cell的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70;
}
//返回cell的事件
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HCCell *cell = [tableView dequeueReusableCellWithIdentifier:hccCell forIndexPath:indexPath];
    RecommendModel * model = self.mutArray[indexPath.row];
    [cell setvalueWithModel:model];
    
    return cell;
}

//tableView的点击事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    RecommendModel * model = self.mutArray[indexPath.row];
    HDetailController * detailVC = [[HDetailController alloc]init];
    detailVC.ID = model.ID;
    detailVC.titleName = model.title;
    [self.navigationController pushViewController:detailVC animated:YES];
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
