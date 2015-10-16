//
//  MyCollectController.m
//  MedicineNurse
//
//  Created by lanou3g on 15/10/15.
//  Copyright © 2015年 Adar-Li. All rights reserved.
//

#import "MyCollectController.h"
#import <AFNetworking.h>
#import "HDetailModel.h"
#import "UMSocial.h"
#import "GiFHUD.h"

@interface MyCollectController ()<UIWebViewDelegate,UMSocialUIDelegate>

{
    NSInteger collectIndex;
    NSInteger index;
}

@property(nonatomic,strong)HDetailModel * detailModel;
//创建webView
@property(nonatomic,strong)UIWebView * webView;
//创建头视图
@property(nonatomic,strong)UIView * headerView;

@property(nonatomic,strong)UIButton * collectButton;

@end

@implementation MyCollectController




//界面将要消失时隐藏
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
    self.headerView.hidden = YES;
    self.tabBarController.tabBar.hidden = NO;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.headerView.hidden = NO;
    collectIndex = 0 ;
    self.tabBarController.tabBar.hidden = YES;
}


- (void)viewDidLoad {
    index = 0;
    [super viewDidLoad];
    [self analysisCellData];
    self.navigationController.navigationBarHidden = NO;
    [GiFHUD setGifWithImageName:@"mie.gif"];
    [GiFHUD show];
    
    //调用绘制表头事件
    [self drawHeader];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    // Dispose of any resources that can be recreated.
}
//解析数据
- (void)analysisCellData{
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    
    [manager GET:self.URL parameters:nil success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        [GiFHUD dismiss];
        
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
    
    _webView  = [[UIWebView alloc]initWithFrame:CGRectMake(10,64, kScremWidth -20, kScremHeight )];
    _webView.delegate = self;
    _webView .scalesPageToFit = YES;
    [_webView loadHTMLString:self.detailModel.content baseURL:nil];
    _webView.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:_webView];
    self.view.backgroundColor = [UIColor whiteColor];
}

//绘制button事件
- (void)drawHeader{
    
    self.headerView = [[UIView alloc]initWithFrame:CGRectMake(65, 0,  kScremWidth - 70 , 44)];
    self.navigationItem.title = nil;
    [self.navigationController.navigationBar addSubview:self.headerView];
    UIButton * SizeButton = [[UIButton alloc]initWithFrame:CGRectMake(kScremWidth - 165,10, 30, 30)];
    [SizeButton setImage:[UIImage imageNamed:@"Text"] forState:UIControlStateNormal];
    [SizeButton addTarget:self action:@selector(changeTextSize) forControlEvents:UIControlEventTouchUpInside];
    [self.headerView addSubview:SizeButton];

    //分享按钮
    UIButton * shareButton = [[UIButton alloc]initWithFrame:CGRectMake(kScremWidth - 120,12, 27, 27)];
    [shareButton setImage:[UIImage imageNamed:@"share"] forState:UIControlStateNormal];
    [shareButton addTarget:self action:@selector(shareAction) forControlEvents:UIControlEventTouchUpInside];
    [self.headerView addSubview:shareButton];
    
    //标题
    UILabel * titleLable = [[UILabel alloc]initWithFrame:CGRectMake(5, 5, kScremWidth - 185, 35)];
    titleLable.text = self.titleName;
    titleLable.font = [UIFont systemFontOfSize:15];
    titleLable.textAlignment = NSTextAlignmentCenter;
    [self.headerView addSubview:titleLable];
}


- (void)shareAction{
    [UMSocialSnsService presentSnsIconSheetView:self
                                         appKey:@"561c6d93e0f55a0eeb00a2b4"
                                      shareText:self.URL
                                     shareImage:[UIImage imageNamed:@"111.jpg"]                                shareToSnsNames:[NSArray arrayWithObjects:UMShareToSina,UMShareToTencent,UMShareToRenren,UMShareToDouban,UMShareToWechatSession,UMShareToFacebook,UMShareToTwitter, nil]
                                       delegate:self];
}
-(void)didFinishGetUMSocialDataInViewController:(UMSocialResponseEntity *)response
{
    //根据`responseCode`得到发送结果,如果分享成功
    if(response.responseCode == UMSResponseCodeSuccess)
    {
        
        NSLog(@"share to sns name is %@",[[response.data allKeys] objectAtIndex:0]);
    }
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





@end
