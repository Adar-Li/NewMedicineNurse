//
//  ViewController.m
//  MedicineNurse
//
//  Created by lanou3g on 15/10/8.
//  Copyright © 2015年 Adar-Li. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UIWebViewDelegate>
@property(nonatomic,strong)UIWebView *web;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self drawWebView];

}

- (void)drawWebView{
    
    _web = [[UIWebView alloc]initWithFrame:CGRectMake(0, -49, self.view.frame.size.width, self.view.frame.size.height +49)];
     _web.delegate = self;
    _web.scalesPageToFit = YES;
    _web.scrollView.contentSize = CGSizeMake(self.view.frame.size.width, self.view.frame.size.height + 49);
    
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.str]];
    
    [self.view addSubview:_web];
    [_web loadRequest:request];

}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    
//    执行事先写好的js代码
    
     [webView stringByEvaluatingJavaScriptFromString:@"document.documentElement.getElementsByClassName('m_nav_bar')[0].style.display = 'none'"];
    
    [webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByClassName('med_time')[0].style.display = 'none'"];
    
    [webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByTagName('a')[59].style.display = 'none'"];
    
    [webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByClassName('source')[0].style.display = 'none'"];
    
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
