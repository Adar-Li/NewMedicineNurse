//
//  ViewController.m
//  MedicineNurse
//
//  Created by lanou3g on 15/10/8.
//  Copyright © 2015年 Adar-Li. All rights reserved.
//

#import "ViewController.h"
#import "GiFHUD.h"
#import "UMSocial.h"

@interface ViewController ()<UIWebViewDelegate,UMSocialUIDelegate>
{
    NSInteger index;
}
@property(nonatomic,strong)UIWebView *web;
//创建头视图
@property(nonatomic,strong)UIView * headerView;

@end

@implementation ViewController

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
    [super viewDidLoad];
    index = 0;
    [GiFHUD setGifWithImageName:@"mie.gif"];
    [GiFHUD show];
    
    [self drawWebView];
    //调用绘制表头事件
    [self drawHeader];
    [self drawbutton];

}

- (void)drawWebView{
    
    _web = [[UIWebView alloc]initWithFrame:CGRectMake(0, -49, self.view.frame.size.width, self.view.frame.size.height +49)];
     _web.delegate = self;
    _web.scalesPageToFit = YES;
    _web.scrollView.contentSize = CGSizeMake(self.view.frame.size.width, self.view.frame.size.height + 49);
    
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.str]];
    
    [self.view addSubview:_web];
    [_web loadRequest:request];
    [GiFHUD dismiss];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    
//    执行事先写好的js代码
    
     [webView stringByEvaluatingJavaScriptFromString:@"document.documentElement.getElementsByClassName('m_nav_bar')[0].style.display = 'none'"];
    
    [webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByClassName('med_time')[0].style.display = 'none'"];
    [webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByTagName('a')[59].style.display = 'none'"];
    
    [webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByClassName('source')[0].style.display = 'none'"];
    
}

//绘制button事件
- (void)drawHeader{
    
    self.headerView = [[UIView alloc]initWithFrame:CGRectMake(90, 0,  kScremWidth -90 , 44)];
    [self.navigationController.navigationBar addSubview:self.headerView];
    UIButton * SizeButton = [[UIButton alloc]initWithFrame:CGRectMake(kScremWidth - 180, 0, 35, 35)];
    [SizeButton setImage:[UIImage imageNamed:@"Text"] forState:UIControlStateNormal];
    [SizeButton addTarget:self action:@selector(changeTextSize) forControlEvents:UIControlEventTouchUpInside];
    [self.headerView addSubview:SizeButton];
    
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
                                      shareText:self.str
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

#pragma mark -- webView的代理事件---

//改变字体大小
- (void)changeTextSize{
    index ++;
    if (index == 1) {
        [_web stringByEvaluatingJavaScriptFromString:@"document.getElementsByTagName('body')[0].style.webkitTextSizeAdjust= '130%'"];
    }else if (index == 2){
        [_web stringByEvaluatingJavaScriptFromString:@"document.getElementsByTagName('body')[0].style.webkitTextSizeAdjust= '160%'"];
    }else if (index == 3){
        index = 0;
        [_web stringByEvaluatingJavaScriptFromString:@"document.getElementsByTagName('body')[0].style.webkitTextSizeAdjust= '100%'"];
    }
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
