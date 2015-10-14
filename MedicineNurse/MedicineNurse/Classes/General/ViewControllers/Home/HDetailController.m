//
//  HDetailController.m
//  MedicineNurse
//
//  Created by lanou3g on 15/10/9.
//  Copyright © 2015年 Adar-Li. All rights reserved.
//

#import "HDetailController.h"
#import <AFNetworking.h>
#import "HDetailModel.h"
#import "UMSocial.h"

@interface HDetailController ()<UIWebViewDelegate>
{
    NSInteger index;
}

@property(nonatomic,strong)HDetailModel * detailModel;
//创建webView
@property(nonatomic,strong)UIWebView * webView;
//创建头视图
@property(nonatomic,strong)UIView * headerView;

@end

@implementation HDetailController

//界面将要消失时隐藏
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
    self.headerView.hidden = YES;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.headerView.hidden = NO;
    
}


- (void)viewDidLoad {
    
    index = 0;
    [super viewDidLoad];
    [self analysisCellData];
    self.navigationController.navigationBarHidden = NO;
    //调用绘制表头事件
    [self drawHeader];
    [self drawbutton];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    // Dispose of any resources that can be recreated.
}
//解析数据
- (void)analysisCellData{
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    
    [manager GET:kHomeCellURL(self.ID) parameters:nil success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        
        NSArray * array = responseObject[@"data"][@"items"];
        NSDictionary * dict = [array firstObject];
        _detailModel = [HDetailModel new];
        [_detailModel setValuesForKeysWithDictionary:dict];
        [self drawUI];
    } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
        
    }];
}
#pragma mark -- 绘制界面事件---
//绘制webView
- (void)drawUI{
    
    _webView  = [[UIWebView alloc]initWithFrame:CGRectMake(10,0, kScremWidth -20, kScremHeight )];
    _webView.delegate = self;
    _webView .scalesPageToFit = YES;
    [_webView loadHTMLString:self.detailModel.content baseURL:nil];
    _webView.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:_webView];
    self.view.backgroundColor = [UIColor whiteColor];
}

//绘制button事件
- (void)drawHeader{
    
    self.headerView = [[UIView alloc]initWithFrame:CGRectMake(90, 0,  kScremWidth -90 , 44)];
    [self.navigationController.navigationBar addSubview:self.headerView];
    UIButton * SizeButton = [[UIButton alloc]initWithFrame:CGRectMake(kScremWidth - 180, 0, 35, 35)];
    [SizeButton setImage:[UIImage imageNamed:@"Text"] forState:UIControlStateNormal];
    [SizeButton addTarget:self action:@selector(changeTextSize) forControlEvents:UIControlEventTouchUpInside];
    [self.headerView addSubview:SizeButton];
    
    //标题
    UILabel * titleLable = [[UILabel alloc]initWithFrame:CGRectMake(5, 9, kScremWidth - 190, 35)];
    titleLable.text = self.titleName;
    titleLable.font = [UIFont systemFontOfSize:15];
    titleLable.textAlignment = NSTextAlignmentCenter;
    [self.headerView addSubview:titleLable];
    
}

- (void)drawbutton{
    
    UIButton * SizeButton = [[UIButton alloc]initWithFrame:CGRectMake(kScremWidth - 140, 0, 32, 32)];
    [SizeButton setImage:[UIImage imageNamed:@"share"] forState:UIControlStateNormal];
    [SizeButton addTarget:self action:@selector(shareAction) forControlEvents:UIControlEventTouchUpInside];
    [self.headerView addSubview:SizeButton];
}

- (void)shareAction{

    [UMSocialSnsService presentSnsIconSheetView:self
                                         appKey:@"561c6d93e0f55a0eeb00a2b4"
                                      shareText:kHomeCellURL(self.ID)
                                     shareImage:[UIImage imageNamed:@"111.jpg"]                                shareToSnsNames:[NSArray arrayWithObjects:UMShareToSina,UMShareToTencent,UMShareToRenren,UMShareToQQ,UMShareToQzone,UMShareToDouban,UMShareToWechatSession, nil]
                                       delegate:nil];
}

#pragma mark -- webView的代理事件---
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    
    
    [webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByTagName('body')[0].style.webkitTextSizeAdjust= '250%'"];
}
//改变字体大小
- (void)changeTextSize{
    index ++;
    if (index == 1) {
        [_webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByTagName('body')[0].style.webkitTextSizeAdjust= '350%'"];
    }else if (index == 2){
        [_webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByTagName('body')[0].style.webkitTextSizeAdjust= '200%'"];
    }else if (index == 3){
        index = 0;
        [_webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByTagName('body')[0].style.webkitTextSizeAdjust= '250%'"];
    }
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
