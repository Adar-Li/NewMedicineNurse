//
//  CommonNewsDetailsController.m
//  MedicineNurse
//
//  Created by lanou3g on 15/10/11.
//  Copyright © 2015年 Adar-Li. All rights reserved.
//

#import "CommonNewsDetailsController.h"
#import "AFHTTPSessionManager.h"
#import "GiFHUD.h"
#import "UMSocial.h"
#import "DataManager.h"

@interface CommonNewsDetailsController () <UMSocialUIDelegate>
{
    NSInteger collectIndex;
    NSInteger index;
    NSString *titleName;
}

@property (nonatomic, strong) UIWebView *webView;
//创建头视图
@property(nonatomic,strong)UIView * headerView;
@property (nonatomic, strong)UIButton * collectButton;

@end

@implementation CommonNewsDetailsController

- (void)viewWillDisappear:(BOOL)animated{
    
    self.tabBarController.tabBar.hidden = NO;
    [self.headerView removeFromSuperview];

}

- (void)viewWillAppear:(BOOL)animated{
    
    self.tabBarController.tabBar.hidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [GiFHUD setGifWithImageName:@"mie.gif"];
    [GiFHUD show];
    
    index = 0;
    [self requestNewsDetail];
    //调用绘制表头事件
//    [self drawHeader];
//    [self drawbutton];
}

- (void)requestNewsDetail{
    
    NSString *url = KCommonNewsListURL(self.commonNDModel.infoId);
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:url parameters:nil success:^(NSURLSessionDataTask *  task, id   responseObject) {
        
        self.newsDetail = responseObject[@"data"][@"newsInfo"][@"content"];
        //标题
        titleName = responseObject[@"data"][@"newsInfo"][@"dataTitle"];
        
        //webView
        self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 64, kScremWidth, kScremHeight-50)];
        [self.webView loadHTMLString:self.newsDetail baseURL:nil];
        _webView.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:_webView];
        [GiFHUD dismiss];
        [self drawHeader];
    } failure:^(NSURLSessionDataTask *  task, NSError *  error) {
        
    }];
}

////绘制button事件
//- (void)drawHeader{
//    
//    self.headerView = [[UIView alloc]initWithFrame:CGRectMake(kScremWidth /1.2, 0, 2 * kScremWidth /3, 44)];
//    [self.navigationController.navigationBar addSubview:self.headerView];
//    UIButton * SizeButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 35, 35)];
//    [SizeButton setImage:[UIImage imageNamed:@"Text"] forState:UIControlStateNormal];
//    [SizeButton addTarget:self action:@selector(changeTextSize) forControlEvents:UIControlEventTouchUpInside];
//    [self.headerView addSubview:SizeButton];
//}
////
//绘制button事件
- (void)drawHeader{
    
    self.headerView = [[UIView alloc]initWithFrame:CGRectMake(65, 0,  kScremWidth - 70 , 44)];
    [self.navigationController.navigationBar addSubview:self.headerView];
    UIButton * SizeButton = [[UIButton alloc]initWithFrame:CGRectMake(kScremWidth - 180,10, 30, 30)];
    [SizeButton setImage:[UIImage imageNamed:@"Text"] forState:UIControlStateNormal];
    [SizeButton addTarget:self action:@selector(changeTextSize) forControlEvents:UIControlEventTouchUpInside];
    [self.headerView addSubview:SizeButton];
    //绘制保存按钮
    self.collectButton = [UIButton buttonWithType:UIButtonTypeSystem];
    _collectButton.frame = CGRectMake(kScremWidth - 145,10, 30, 30);
    [self.collectButton addTarget:self action:@selector(collectAction) forControlEvents:UIControlEventTouchUpInside];
    [self.collectButton setImage:[UIImage imageNamed:@"lovew"] forState:UIControlStateNormal];
    [self.headerView addSubview:_collectButton];
    //分享按钮
    UIButton * shareButton = [[UIButton alloc]initWithFrame:CGRectMake(kScremWidth - 110,12, 27, 27)];
    [shareButton setImage:[UIImage imageNamed:@"share"] forState:UIControlStateNormal];
    [shareButton addTarget:self action:@selector(shareAction) forControlEvents:UIControlEventTouchUpInside];
    [self.headerView addSubview:shareButton];
    
    //标题
    UILabel * titleLable = [[UILabel alloc]initWithFrame:CGRectMake(5, 5, kScremWidth - 185, 35)];
    titleLable.text = titleName;
    titleLable.font = [UIFont systemFontOfSize:15];
    titleLable.textAlignment = NSTextAlignmentCenter;
    [self.headerView addSubview:titleLable];
}



//改变字体大小
- (void)changeTextSize{
    index ++;
    if (index == 1) {
        [_webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByTagName('body')[0].style.webkitTextSizeAdjust= '130%'"];
    }else if (index == 2){
        [_webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByTagName('body')[0].style.webkitTextSizeAdjust= '160%'"];
    }else if (index == 3){
        index = 0;
        [_webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByTagName('body')[0].style.webkitTextSizeAdjust= '100%'"];
    }
}
//
//- (void)drawbutton{
//    
//    UIButton * SizeButton = [[UIButton alloc]initWithFrame:CGRectMake(30, 0, 35, 35)];
//    [SizeButton setImage:[UIImage imageNamed:@"share"] forState:UIControlStateNormal];
//    [SizeButton addTarget:self action:@selector(shareAction) forControlEvents:UIControlEventTouchUpInside];
//    [self.headerView addSubview:SizeButton];
//}

- (void)shareAction{
    
    [UMSocialSnsService presentSnsIconSheetView:self
                                         appKey:@"561c6d93e0f55a0eeb00a2b4"
                                      shareText:KCommonNewsListURL(self.commonNDModel.infoId)
                                     shareImage:[UIImage imageNamed:@"111.jpg"]                                shareToSnsNames:[NSArray arrayWithObjects:UMShareToSina,UMShareToTencent,UMShareToRenren,UMShareToQQ,UMShareToQzone,UMShareToDouban,UMShareToWechatSession, nil]
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

////收藏
//- (void)loveButton{
//    
//    UIButton * SizeButton = [[UIButton alloc]initWithFrame:CGRectMake(30, 0, 35, 35)];
//    [SizeButton setImage:[UIImage imageNamed:@"share"] forState:UIControlStateNormal];
//    [SizeButton addTarget:self action:@selector(shareAction) forControlEvents:UIControlEventTouchUpInside];
//    [self.headerView addSubview:SizeButton];
//}

#pragma mark -- 收藏事件---
- (void)collectAction{
    collectIndex ++;
    if (collectIndex <= 1) {
        collectIndex = 2;
        
        [self.collectButton setImage:[UIImage imageNamed:@"Collected"] forState:UIControlStateNormal];
        
        [[DataManager shareDatamanager]creatTableWithTableName:kLoverTable mainKey:kLoverKey title:kLoverTitle URl:kLoverURL type:kLoverType];
        
        [[DataManager shareDatamanager]InsertIntoTableName:kLoverTable WithMainKey:KCommonNewsListURL(self.commonNDModel.infoId) title:self.commonNDModel.infoTitle URL:self.commonNDModel.infoLogo type:@"2"];

  
    }else{
        collectIndex = 0;
        [self.collectButton setImage:[UIImage imageNamed:@"lovew"] forState:UIControlStateNormal];
        [[DataManager shareDatamanager]clearTableCollectWithTableName:kLoverTable collectID:KCommonNewsListURL(self.commonNDModel.infoId)];
        
//        UIAlertController * allertVC = [UIAlertController alertControllerWithTitle:@"您已收藏过" message:@"您已经收藏成功\n可以到我的界面\n查看我的收藏" preferredStyle:UIAlertControllerStyleAlert];
//        
//        [self presentViewController:allertVC animated:YES completion:nil];
//        UIAlertAction * alertAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
//        
//        [allertVC addAction:alertAction];
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
