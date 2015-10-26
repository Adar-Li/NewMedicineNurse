//
//  UserManager.m
//  WQNews
//
//  Created by lanou3g on 15/9/30.
//  Copyright (c) 2015年 齐伟强. All rights reserved.
//

#import "UserManager.h"

@implementation UserManager

+ (UserManager *)shareUserManager{
    static UserManager * manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [UserManager new];
    });
       return manager;
}
//同步
- (void)synchronize{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
         [[NSUserDefaults standardUserDefaults]synchronize];
    });
   
}
//设置登录状态
- (void)setLoginState:(BOOL) isLogin{
    [[NSUserDefaults standardUserDefaults] setBool:isLogin forKey:kLoginState];
    
}

- (void)setUserName:(NSString *)userName{
    [[NSUserDefaults standardUserDefaults] setValue:userName forKey:kUserName];
}
-(void)setUserPassWorld:(NSString *)pwd{
        [[NSUserDefaults standardUserDefaults] setObject:pwd forKey:kUserPwd];
}
- (void)setUserEmailAddress:(NSString  *)emailAddress{
        [[NSUserDefaults standardUserDefaults] setValue:emailAddress forKey:kUserEmailAddress];
    
}
//获取用户信息
- (BOOL)loginState{
    
    return [[NSUserDefaults standardUserDefaults]boolForKey:kLoginState];
}

- (NSString *)userName{
    return [[NSUserDefaults standardUserDefaults]valueForKey:kUserName];
}
- (NSString *)userPassworld{
        return [[NSUserDefaults standardUserDefaults]valueForKey:kUserPwd];
}
- (NSString *)userEmailAdrress{
            return [[NSUserDefaults standardUserDefaults]valueForKey:kUserEmailAddress];
}



@end
