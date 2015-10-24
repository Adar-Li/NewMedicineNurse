//
//  UserManager.h
//  WQNews
//  Created by lanou3g on 15/9/30.
//  Copyright (c) 2015年 齐伟强. All rights reserved.
//

#import <Foundation/Foundation.h>

@class UserManager;
@interface UserManager : NSObject

+ (UserManager *)shareUserManager;
//同步
- (void)synchronize;
//设置登录状态
- (void)setLoginState:(BOOL) isLogin;
- (void)setUserName:(NSString *)userName;
-(void)setUserPassWorld:(NSString *)pwd;
-(void)setUserEmailAddress:(NSString  *)emailAddress;
//获取用户信息
- (BOOL)loginState;
- (NSString *)userName;
- (NSString *)userPassworld;
- (NSString *)userEmailAdrress;
    


@end
