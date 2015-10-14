//
//  HomeController.m
//  MedicineNurse
//
//  Created by lanou3g on 15/10/7.
//  Copyright © 2015年 Adar-Li. All rights reserved.
//
#import "HomeController.h"
#import "HBView.h"
#import "HomeHelper.h"
#import "HomeCell.h"
#import "HCCell.h"
#import "RecommendModel.h"
#import "IanScrollView.h"
#import "HomeSBController.h"
#import "HDetailController.h"
#import "HSBDetailController.h"
#import "HPublicController.h"
#import <AFNetworking.h>
#import "HEDController.h"
#import "HDetailModel.h"
#import <SVPullToRefresh.h>

@interface HomeController ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>
{
    NSInteger  pageIndex;
}

//轮播图标题数组
@property(nonatomic,strong) NSMutableArray * titleArray;
@property(nonatomic,assign)NSInteger currentIndex;
//轮播图标题
@property(nonatomic,strong)UILabel * titleLable;

//返回的选择数组
@property(nonatomic,strong)NSMutableArray * likingArray;

//存储点击轮播图数组
@property(nonatomic,strong)NSMutableArray * SCMutArray;

@end

@implementation HomeController

static NSString * homeCell = @"homeCell";
static NSString * hccCell = @"hccCellID";

- (void)viewWillDisappear:(BOOL)animated{
    self.navigationController.navigationBarHidden = NO;
}


//界面将要出现时执行的方法
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //图像将要出现时让navigation的表头隐藏
    self.navigationController.navigationBarHidden = YES;
    
}

- (void)viewDidLoad {
    pageIndex = 1;
    self.currentIndex = 0 ;
    //隐藏navigation标题栏
    self.navigationController.navigationBarHidden = YES;
    [super viewDidLoad];
    [self drawMainScrollview];
    
    //调用请求数据与绘制界面的方法
    [self analysisDataAndDrawUI];
      //绘制表头
    self.buttonView = [[HBView alloc]initWithFrame:CGRectMake(0, 0, kScremWidth, 60)];
    self.buttonView.backgroundColor = [UIColor colorWithRed:0.655 green:1.000 blue:0.701 alpha:1.000];
    [self.view addSubview:self.buttonView];
    //给button添加事件
    [self buttonAddAction];
    
    //注册通知
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(haveChooseAction:) name:kBackChoose object:nil];
}

//解析数据

- (void)analysisDataAndDrawUI{
    __weak HomeController * weakSelf = self;
    //解析完数据绘制UI界面
    [[HomeHelper shareHomeHelper]analysisDataWithURL:kHomeTJURL :^{
        [weakSelf drawTableView];
        [weakSelf.tableView.pullToRefreshView stopAnimating];
        [weakSelf.tableView.infiniteScrollingView stopAnimating];
    }];

    
}

//绘制大的背景scrollView
- (void)drawMainScrollview{
    
    self.mainScroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 60, kScremWidth, kScremHeight - 49)];
    self.mainScroll.contentSize = CGSizeMake(kScremWidth * 5, 0);
    self.mainScroll.backgroundColor = [UIColor whiteColor];
    self.mainScroll.bounces = NO;
    self.mainScroll.showsVerticalScrollIndicator = NO;
    self.mainScroll.delegate = self;
    self.mainScroll.pagingEnabled = YES;
    self.mainScroll.delaysContentTouches = NO;
    //加上这句代码,可以解决手势冲突问题,布局不再默认加20 了
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.view addSubview:self.mainScroll];
}

//绘制主界面tableView
- (void)drawTableView{
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0,0, kScremWidth, kScremHeight - 108) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    //注册自定义cell
    [self.tableView registerNib:[UINib nibWithNibName:@"HomeCell" bundle:nil] forCellReuseIdentifier:homeCell];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"HCCell" bundle:nil] forCellReuseIdentifier:hccCell];
    
    [self drawScrollViewForHeader];
    [self.mainScroll addSubview:self.tableView];
    
    __weak HomeController * weakSelf = self;
    [self.tableView addPullToRefreshWithActionHandler:^{
        
        [weakSelf.tableView removeFromSuperview];
        [weakSelf analysisDataAndDrawUI];
        
    }];
    
    [self.tableView addInfiniteScrollingWithActionHandler:^{
        [weakSelf pullFromtheButton];
    }];
    
    
}
#pragma mark --上拉刷新下拉加载事件
- (void)pullFromtheButton{
    pageIndex ++;
    NSString * URL = [NSString stringWithFormat:@"http://dxy.com/app/i/columns/article/recommend?ac=1d6c96d5-9a53-4fe1-9537-85a33de916f1&items_per_page=10&mc=df4e09ce2cf802df592ff64773dbb40156b4d58d&page_index=%ld&vc=4.0.5",pageIndex];
    
   [[HomeHelper shareHomeHelper]analysisMoreDataWithURL:URL :^{
       [self.tableView removeFromSuperview];
       [self drawTableView];
       self.tableView.contentOffset = CGPointMake(0, kScremWidth *pageIndex);
   }];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark -- ScrollView的代理事件--


- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    //偏移一个页面执行的方法
    if (scrollView.contentOffset.x == kScremWidth ) {
        
        HomeSBController * SBVC = [[HomeSBController alloc]init];
        SBVC.view.frame = CGRectMake(kScremWidth,0, kScremWidth, kScremHeight - 108 );
        [self addChildViewController:SBVC];
        [self.mainScroll addSubview:SBVC.view];
        [self.buttonView button2Action];
        //偏移两个页面执行的方法
    }else if (scrollView.contentOffset.x == kScremWidth * 2){
        HPublicController * publicVC = [[HPublicController alloc]init];
        publicVC.URLStr = kHomeTURL;
        publicVC.view.frame = CGRectMake(kScremWidth *2, 0, kScremWidth, kScremHeight - 108);
        [self addChildViewController:publicVC];
        [self.mainScroll addSubview:publicVC.view];
        [self.buttonView button3Action];
    }else if (scrollView.contentOffset.x == kScremWidth * 3){
        if (self.likingArray.count == 0) {
            HPublicController * publicVC = [[HPublicController alloc]init];
            publicVC.URLStr = kHomeTumorURL(@"10");
            publicVC.view.frame = CGRectMake(kScremWidth *3, 0, kScremWidth, kScremHeight - 108);
            [self addChildViewController:publicVC];
            [self.mainScroll addSubview:publicVC.view];
            [self.buttonView button4Action];
        }else if (self.likingArray.count != 0){
            HPublicController * publicVC = [[HPublicController alloc]init];
            HDetailModel * item = self.likingArray[0];
            NSString * ID = item.ID;
            publicVC.URLStr = kHomeTumorURL(ID);
            publicVC.view.frame = CGRectMake(kScremWidth *3, 0, kScremWidth, kScremHeight - 108);
            [self addChildViewController:publicVC];
            [self.mainScroll addSubview:publicVC.view];
            [self.buttonView button4Action];
        }
        
    }else if (scrollView.contentOffset.x == kScremWidth * 4){
        
        HEDController * editeVC = [[HEDController alloc]init];
        editeVC.view.frame = CGRectMake(kScremWidth *4, 0, kScremWidth, kScremHeight - 108);
        [self addChildViewController:editeVC];
        [self.mainScroll addSubview:editeVC.view];
        [self.buttonView button5Action];
        
        //发出通知
        [[NSNotificationCenter defaultCenter]postNotificationName:kChoose object:nil userInfo:@{@"name":self.buttonView.button4.titleLabel.text}];
        
        
    }else if (scrollView.contentOffset.x == kScremWidth * 0){
        [self.buttonView button1Action];
        
    }
    
}


//scrollView停止减速时的方法
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    [self scrollViewDidEndScrollingAnimation:scrollView];
}




#pragma mark --tableView的代理事件---
//分区个数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
//行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [HomeHelper shareHomeHelper].itemArray.count;
}
//返回cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSArray * itemArray = [[HomeHelper shareHomeHelper].itemArray mutableCopy];
    RecommendModel  * item = itemArray[indexPath.row];
    if (item.special_id) {
        HomeCell * cell = [tableView dequeueReusableCellWithIdentifier:homeCell forIndexPath:indexPath];
        [cell setvalueWithModel:item];
        return cell;
    }else{
        HCCell * cell  = [tableView dequeueReusableCellWithIdentifier:hccCell forIndexPath:indexPath];
        [cell setvalueWithModel:item];
        return cell;
    }
}


//设置cell的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70;
}

#pragma mark --绘制轮播图点击事件---
- (void)drawScrollViewForHeader{
    
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    
    [self.SCMutArray removeAllObjects];
    [manager GET:kHomeSBURL parameters:nil success:^(AFHTTPRequestOperation * operation, id   responseObject) {
        NSArray * array =  responseObject[@"data"][@"items"];
        for (NSDictionary * dict in array) {
            HSubjectModel * model = [HSubjectModel new];
            [model setValuesForKeysWithDictionary:dict];
            [self.SCMutArray addObject:model];
        }
        [self drawHeaderSCView];
    } failure:^(AFHTTPRequestOperation * operation, NSError * error) {
    }];
}

- (void)drawHeaderSCView{
    
    IanScrollView * scrorllView = [[IanScrollView alloc]initWithFrame:CGRectMake(0, 0, kScremWidth, 208)];
    NSMutableArray * urlArray = [[NSMutableArray alloc]initWithCapacity:8];
    NSMutableArray * modelArray = [[NSMutableArray alloc]initWithCapacity:8];
    self.titleArray = [[NSMutableArray alloc]initWithCapacity:8];
    for (int i = 0; i < 4; i ++) {
        HSubjectModel * item = self.SCMutArray[i];
        [urlArray addObject:item.cover];
        
        [self.titleArray addObject:item.name];
        [modelArray addObject:item];
    }
    scrorllView.slideImagesArray = [urlArray mutableCopy];
    scrorllView.withoutAutoScroll = YES;
    //绘制lable
    [self drawLable];
    
    self.tableView.tableHeaderView = scrorllView ;
    scrorllView.ianCurrentIndex = ^(NSInteger index) {
        self.currentIndex = index;
        
        [self.titleLable removeFromSuperview];
        [self drawLable];
    };
    //轮播图点击时执行
    scrorllView.ianEcrollViewSelectAction = ^(NSInteger  i){
        HSubjectModel * model = self.SCMutArray[i];
        HSBDetailController * SCDetailVC = [HSBDetailController new];
        SCDetailVC.model = model;
        [self.navigationController pushViewController:SCDetailVC animated:YES];
    };
    [scrorllView startLoading];
    
}




//cell的点击事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSArray * itemArray = [[HomeHelper shareHomeHelper].itemArray mutableCopy];
    RecommendModel  * item = itemArray[indexPath.row];
    //判断是否专题
    if (item.special_id) {
        //跳转到专题列表
        HSBDetailController * SBDetailVC = [[HSBDetailController alloc]init];
        NSDictionary * dict = @{@"ID":item.special_id,@"name":@"贴心小护士",@"desc":item.title};
        HSubjectModel * model = [HSubjectModel new];
        [model setValuesForKeysWithDictionary:dict];
        SBDetailVC.model = model;
        
        [self.navigationController pushViewController:SBDetailVC animated:YES];
        
    }else{
        HDetailController * detailVC = [[HDetailController alloc]init];
        detailVC.ID = item.ID;
        detailVC.titleName = item.title;
        [self.navigationController pushViewController:detailVC animated:YES];
    }
}
#define mark ---通知事件---
- (void)haveChooseAction:(NSNotification*)notice{
    NSArray * array = notice.userInfo[@"array"];
    [self.likingArray removeAllObjects];
    self.likingArray = [array mutableCopy];
    [self button4Action];
}

#pragma mark --绘制表头lable---
- (void)drawLable{
    self.titleLable = [[UILabel alloc]initWithFrame:CGRectMake(20, 158, kScremWidth - 150, 40)];
    self.titleLable.numberOfLines = 3 ;
    self.titleLable.font =[UIFont systemFontOfSize:15];
    self.titleLable.textColor = [UIColor blackColor];
    //    self.titleLable.textAlignment = nste
    self.titleLable.text = self.titleArray[_currentIndex];
    [self.tableView addSubview:self.titleLable];
}

#pragma mark -- button的点击事件---
- (void)button1Action{
    
    [self.mainScroll setContentOffset:CGPointMake(0, 0)];
    [self scrollViewDidEndScrollingAnimation:self.mainScroll];
    
    [self.buttonView button1Action];
}

- (void)button2Action{
    [self.mainScroll setContentOffset:CGPointMake(kScremWidth, 0)];
    [self scrollViewDidEndScrollingAnimation:self.mainScroll];
    
    [self.buttonView button2Action];
    
}

- (void)button3Action{
    [self.mainScroll setContentOffset:CGPointMake(kScremWidth * 2, 0)];
    [self scrollViewDidEndScrollingAnimation:self.mainScroll];
    [self.buttonView button3Action];
}

- (void)button4Action{
    [self.mainScroll setContentOffset:CGPointMake(kScremWidth * 3, 0)];
    [self scrollViewDidEndScrollingAnimation:self.mainScroll];
    [self.buttonView button4Action];
    if (self.likingArray.count != 0) {
        
        HDetailModel * item = self.likingArray[0];
        [self.buttonView.button4 setTitle:item.name forState:UIControlStateNormal];
    }
}

- (void)button5Action{
    [self.mainScroll setContentOffset:CGPointMake(kScremWidth * 4, 0)];
    [self scrollViewDidEndScrollingAnimation:self.mainScroll];
    [self.buttonView button5Action];
}

#pragma mark ---给button添加事件--
- (void)buttonAddAction{
    [self.buttonView.Button1 addTarget:self action:@selector(button1Action) forControlEvents:UIControlEventTouchUpInside];
    
    [self.buttonView.Button2 addTarget:self action:@selector(button2Action) forControlEvents:UIControlEventTouchUpInside];
    
    [self.buttonView.Button3 addTarget:self action:@selector(button3Action) forControlEvents:UIControlEventTouchUpInside];
    [self.buttonView.button4 addTarget:self action:@selector(button4Action) forControlEvents:UIControlEventTouchUpInside];
    
    [self.buttonView.button5 addTarget:self action:@selector(button5Action) forControlEvents:UIControlEventTouchUpInside];
    
}

#pragma mark --lazy load---
- (NSMutableArray *)likingArray{
    if (_likingArray == nil) {
        _likingArray = [[NSMutableArray alloc]initWithCapacity:8];
    }
    return _likingArray;
}


- (NSMutableArray *)SCMutArray{
    if (_SCMutArray == nil) {
        _SCMutArray = [[NSMutableArray alloc]initWithCapacity:20];
    }
    return _SCMutArray;
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
