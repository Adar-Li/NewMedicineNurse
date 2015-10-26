//
//  UserListController.m
//  MedicineNurse
//
//  Created by lanou3g on 15/10/14.
//  Copyright © 2015年 Adar-Li. All rights reserved.
//

#import "UserListController.h"
#import "RKCardView.h"
#import "WZFlashButton.h"
#import "UserController.h"
#import "UIImageView+WebCache.h"
#import "UMSocial.h"
#import "DataManager.h"
#import "HCollectController.h"
#import "AVUser.h"
#import "UserManager.h"

#define BUFFERX 20
#define BUFFERY 66

@interface UserListController ()

@property(nonatomic,strong)NSString *imageURL;
@property (nonatomic ,strong ) RKCardView* cardView;
@property(nonatomic,strong)WZFlashButton * loginButton;

@end

@implementation UserListController

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        UIImage *image = [UIImage imageNamed:@"user.jpg"];
        image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        self.tabBarItem.image = image;
    }
    return self;
}
- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    //注册通知
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(loginAction:) name:@"loginAction" object:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.view.backgroundColor = [UIColor colorWithRed:0.90 green:0.90 blue:0.90 alpha:1];
    self.navigationItem.title = @"用户";
    
    self.cardView= [[RKCardView alloc]initWithFrame:CGRectMake(BUFFERX, BUFFERY, self.view.frame.size.width-2*BUFFERX, self.view.frame.size.height-2*BUFFERY)];
    self.cardView.coverImageView.image = [UIImage imageNamed:@"111.jpg"];
    self.cardView.profileImageView.image = [UIImage imageNamed:@"111.jpg"];
    [self.cardView addBlur]; // comment this out if you don't want blur
    [self.cardView addShadow]; // comment this out if you don't want a shadow
    [self.view addSubview:self.cardView];
    
    WZFlashButton *outerRoundFlashButton = [[WZFlashButton alloc] initWithFrame:CGRectMake(0, kScremHeight / 2 - BUFFERY, kScremWidth -2*BUFFERX, 45)];
    outerRoundFlashButton.buttonType = WZFlashButtonTypeOuter;
    outerRoundFlashButton.textLabel.text = @"微博登陆";
    outerRoundFlashButton.flashColor = [UIColor colorWithRed:240/255.f green:159/255.f blue:10/255.f alpha:1];
    outerRoundFlashButton.backgroundColor = [UIColor colorWithRed:0 green:152.0f/255.0f blue:203.0f/255.0f alpha:1.0f];
    outerRoundFlashButton.clickBlock = ^(void) {
        // 使用Sina微博账号登录
        UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToSina];
        snsPlatform.loginClickHandler(self, [UMSocialControllerService defaultControllerService], YES, ^(UMSocialResponseEntity *response) {
            //            NSLog(@"response is %@", response);
            // 如果是授权到新浪微博，SSO之后如果想获取用户的昵称、头像等需要再获取一次账户信息
            [[UMSocialDataService defaultDataService]requestSocialAccountWithCompletion:^(UMSocialResponseEntity *response) {
                
                self.cardView.titleLabel.text = [[[response.data objectForKey:@"accounts"]objectForKey:UMShareToSina] objectForKey:@"username"];
                
                self.imageURL = [NSString new];
                self.imageURL=[[[response.data objectForKey:@"accounts"]objectForKey:UMShareToSina] objectForKey:@"icon"];
                
                [self.cardView.coverImageView sd_setImageWithURL:[NSURL URLWithString:self.imageURL]];
                [self.cardView.profileImageView sd_setImageWithURL:[NSURL URLWithString:self.imageURL]];
            }];
        });
    };
    
    [self.cardView addSubview:outerRoundFlashButton];
    [self drawMyButton];
    [self LikeMyButton];
    [self ClearMyButton];
}

- (void)drawMyButton{
    
    __weak UserListController * weakSelf = self;
    _loginButton = [[WZFlashButton alloc] initWithFrame:CGRectMake(0, kScremHeight / 2 - BUFFERY + 50, kScremWidth -2*BUFFERX, 45)];
    _loginButton.buttonType = WZFlashButtonTypeInner;
    _loginButton.textLabel.text = @"登陆/注册";
    _loginButton.flashColor = [UIColor colorWithRed:240/255.f green:159/255.f blue:10/255.f alpha:1];
    _loginButton.backgroundColor = [UIColor colorWithRed:0 green:152.0f/255.0f blue:203.0f/255.0f alpha:1.0f];
    AVUser *currentUser = [AVUser currentUser];
    //判断是否登陆
    if (currentUser != nil)
   {
       _loginButton.textLabel.text = [UserManager shareUserManager].userName;
    }
    
    //登陆点击事件
    _loginButton.clickBlock = ^(void) {
        if ([weakSelf.loginButton.textLabel.text isEqualToString:@"登陆/注册"]) {
            
            UserController *user = [UserController new];
            user.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
            [weakSelf presentViewController:user animated:YES completion:nil];
        }else{
                        
            UIAlertController * alertVC = [UIAlertController alertControllerWithTitle:@"退出登录" message:@"你确定退出登陆吗?'" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction * realyAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
                
                [AVUser logOut];
                weakSelf.loginButton.textLabel.text = @"登陆/注册";
                [weakSelf dismissViewControllerAnimated:YES completion:nil];
            }];
            
        UIAlertAction * cancleAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *  action) {
                
            }];
            [weakSelf presentViewController:alertVC animated:YES completion:nil];
            [alertVC addAction:realyAction];
            [alertVC addAction:cancleAction];
        }
    };
    
    [self.cardView addSubview:_loginButton];
}

- (void)LikeMyButton{
    WZFlashButton *outerRoundFlashButton = [[WZFlashButton alloc] initWithFrame:CGRectMake(0, kScremHeight / 2 - BUFFERY + 100, kScremWidth -2*BUFFERX, 45)];
    outerRoundFlashButton.buttonType = WZFlashButtonTypeOuter;
    outerRoundFlashButton.textLabel.text = @"收藏";
    outerRoundFlashButton.flashColor = [UIColor colorWithRed:240/255.f green:159/255.f blue:10/255.f alpha:1];
    outerRoundFlashButton.backgroundColor = [UIColor colorWithRed:0 green:152.0f/255.0f blue:203.0f/255.0f alpha:1.0f];
    //点击按钮时的事件
    outerRoundFlashButton.clickBlock = ^(void) {
        
        [self collectAction];
    };
    
    [self.cardView addSubview:outerRoundFlashButton];
}

- (void)ClearMyButton{
    WZFlashButton *outerRoundFlashButton = [[WZFlashButton alloc] initWithFrame:CGRectMake(0, kScremHeight / 2 - BUFFERY + 150, kScremWidth -2*BUFFERX, 45)];
    outerRoundFlashButton.buttonType = WZFlashButtonTypeInner;
    outerRoundFlashButton.textLabel.text = @"清理缓存";
    outerRoundFlashButton.flashColor = [UIColor colorWithRed:240/255.f green:159/255.f blue:10/255.f alpha:1];
    outerRoundFlashButton.backgroundColor = [UIColor colorWithRed:0 green:152.0f/255.0f blue:203.0f/255.0f alpha:1.0f];
    outerRoundFlashButton.clickBlock = ^(void) {
        
        [self clearAction];
    };
    
    [self.cardView addSubview:outerRoundFlashButton];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark ---收藏,清理缓存事件----
//收藏事件
- (void)collectAction{
    
    HCollectController * collectVC = [HCollectController new];
    [self.navigationController pushViewController:collectVC animated:YES];
}
//清理缓存事件
- (void)clearAction{
    
    [[DataManager shareDatamanager]clearTableWithTableName:kLoverTable];
    UIAlertController * allertVC = [UIAlertController alertControllerWithTitle:@"清理缓存成功" message:@"清理缓存成功" preferredStyle:UIAlertControllerStyleAlert];
    
    [self presentViewController:allertVC animated:YES completion:nil];
    UIAlertAction * alertAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
    [allertVC addAction:alertAction];
}

//通知事件
- (void)loginAction:(NSNotification *)notice{
    
    self.loginButton.textLabel.text = notice.userInfo[@"name"];
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
