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
#import "DataManager.h"
#import "GiFHUD.h"
#import "AVUser.h"
#import "UserController.h"
@interface HDetailController ()<UIWebViewDelegate,UMSocialUIDelegate>
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

@implementation HDetailController

//界面将要消失时隐藏
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
    self.headerView.hidden = YES;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.headerView.hidden = NO;
    collectIndex = 0 ;
    
}


- (void)viewDidLoad {

    index = 0;
    [super viewDidLoad];
    [self analysisCellData];
    self.navigationController.navigationBarHidden = NO;
    //调用绘制表头事件
    [self drawHeader];
    
    [GiFHUD setGifWithImageName:@"mie.gif"];
    [GiFHUD show];
 
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    // Dispose of any resources that can be recreated.
}
//解析数据
- (void)analysisCellData{
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    
    [manager GET:kHomeCellURL(self.ID) parameters:nil success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
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
    
    self.headerView = [[UIView alloc]initWithFrame:CGRectMake(65, 0,  kScremWidth - 70 , 44)];
    [self.navigationController.navigationBar addSubview:self.headerView];
    UIButton * SizeButton = [[UIButton alloc]initWithFrame:CGRectMake(kScremWidth - 180,10, 30, 30)];
    [SizeButton setImage:[UIImage imageNamed:@"Text"] forState:UIControlStateNormal];
    [SizeButton addTarget:self action:@selector(changeTextSize) forControlEvents:UIControlEventTouchUpInside];
    [self.headerView addSubview:SizeButton];
    //绘制保存按钮
    _collectButton = [UIButton buttonWithType:UIButtonTypeSystem];
    _collectButton.frame = CGRectMake(kScremWidth - 145,10, 30, 30);
    [_collectButton addTarget:self action:@selector(collectAction) forControlEvents:UIControlEventTouchUpInside];
    [_collectButton setImage:[UIImage imageNamed:@"lovew"] forState:UIControlStateNormal];
    
    [self.headerView addSubview:_collectButton];
    //分享按钮
    UIButton * shareButton = [[UIButton alloc]initWithFrame:CGRectMake(kScremWidth - 110,12, 27, 27)];
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
                                      shareText:kHomeCellURL(self.ID)
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


#pragma mark -- 收藏事件---
- (void)collectAction{
    AVUser *currentUser = [AVUser currentUser];
    if (currentUser != nil) {
    } else {
        UserController *userLogin = [UserController new];
        //        [self popoverPresentationController];
        [self.navigationController pushViewController:userLogin animated:YES];
        
    }

    collectIndex ++;
    if (collectIndex <= 1) {
        collectIndex = 2;
        [self.collectButton setImage:[UIImage imageNamed:@"Collected"] forState:UIControlStateNormal];
        
        [[DataManager shareDatamanager]creatTableWithTableName:kLoverTable mainKey:kLoverKey title:kLoverTitle URl:kLoverURL type:kLoverType];
         [[DataManager shareDatamanager]InsertIntoTableName:kLoverTable WithMainKey:kHomeCellURL(self.ID) title:self.titleName URL:self.picUrl type:@"1"];
    }else{
        collectIndex = 0;
        [self.collectButton setImage:[UIImage imageNamed:@"lovew"] forState:UIControlStateNormal];
         [[DataManager shareDatamanager]clearTableCollectWithTableName:kLoverTable collectID:kHomeCellURL(self.ID)];
//        UIAlertController * allertVC = [UIAlertController alertControllerWithTitle:@"您已收藏过" message:@"您已经收藏成功\n可以到我的界面\n查看我的收藏" preferredStyle:UIAlertControllerStyleAlert];
//        
//        [self presentViewController:allertVC animated:YES completion:nil];
//        UIAlertAction * alertAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
//        
//        [allertVC addAction:alertAction];
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






/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
