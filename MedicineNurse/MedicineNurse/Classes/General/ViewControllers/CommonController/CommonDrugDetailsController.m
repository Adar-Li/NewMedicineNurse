//
//  CommonDrugDetailsController.m
//  MedicineNurse
//
//  Created by lanou3g on 15/10/12.
//  Copyright © 2015年 Adar-Li. All rights reserved.
//

#import "CommonDrugDetailsController.h"

@interface CommonDrugDetailsController ()

@property (nonatomic, strong) UIWebView *webView;

@end

@implementation CommonDrugDetailsController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self getData];
    self.title = @"药品详情";
}

- (void)getData{

    self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, kScremWidth, kScremHeight)];
    NSURL *url = [NSURL URLWithString:KCommonDrugListURL(self.commonNDModel.drugId)];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    [self.webView loadRequest:request];
    _webView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_webView];
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
