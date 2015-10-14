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

@interface CommonNewsDetailsController ()
{
    NSInteger index;
}

@property (nonatomic, strong) UIWebView *webView;
//创建头视图
@property(nonatomic,strong)UIView * headerView;

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
    [self drawHeader];
    [self drawbutton];
}

- (void)requestNewsDetail{
    
    NSString *url = KCommonNewsListURL(self.commonNDModel.infoId);
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:url parameters:nil success:^(NSURLSessionDataTask *  task, id   responseObject) {
        
        self.newsDetail = responseObject[@"data"][@"newsInfo"][@"content"];
        //标题
        self.navigationItem.title = responseObject[@"data"][@"newsInfo"][@"dataTitle"];
        
        //webView
        self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 64, kScremWidth, kScremHeight-50)];
        [self.webView loadHTMLString:self.newsDetail baseURL:nil];
        _webView.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:_webView];
        [GiFHUD dismiss];
    } failure:^(NSURLSessionDataTask *  task, NSError *  error) {
        
    }];
}

//绘制button事件
- (void)drawHeader{
    
    self.headerView = [[UIView alloc]initWithFrame:CGRectMake(kScremWidth /1.2, 0, 2 * kScremWidth /3, 44)];
    [self.navigationController.navigationBar addSubview:self.headerView];
    UIButton * SizeButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 35, 35)];
    [SizeButton setImage:[UIImage imageNamed:@"Text"] forState:UIControlStateNormal];
    [SizeButton addTarget:self action:@selector(changeTextSize) forControlEvents:UIControlEventTouchUpInside];
    [self.headerView addSubview:SizeButton];
    
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

- (void)drawbutton{
    
    UIButton * SizeButton = [[UIButton alloc]initWithFrame:CGRectMake(30, 0, 35, 35)];
    [SizeButton setImage:[UIImage imageNamed:@"share"] forState:UIControlStateNormal];
    [SizeButton addTarget:self action:@selector(shareAction) forControlEvents:UIControlEventTouchUpInside];
    [self.headerView addSubview:SizeButton];
}

- (void)shareAction{
    
    [UMSocialSnsService presentSnsIconSheetView:self
                                         appKey:@"561c6d93e0f55a0eeb00a2b4"
                                      shareText:KCommonNewsListURL(self.commonNDModel.infoId)
                                     shareImage:[UIImage imageNamed:@"111.jpg"]                                shareToSnsNames:[NSArray arrayWithObjects:UMShareToSina,UMShareToTencent,UMShareToRenren,UMShareToQQ,UMShareToQzone,UMShareToDouban,UMShareToWechatSession, nil]
                                       delegate:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
