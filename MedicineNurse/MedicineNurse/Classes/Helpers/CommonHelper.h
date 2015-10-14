//
//  CommonHelper.h
//  MedicineNurse
//
//  Created by lanou3g on 15/10/7.
//  Copyright © 2015年 Adar-Li. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CommonHelper : NSObject

//保存科
@property (nonatomic, strong) NSArray * commonArray;
//保存详细分类
@property (nonatomic, strong) NSArray * commonDeArray;

//单例方法
+ (CommonHelper *)shareHelp;

//数据解析
- (void)requestCommonList:(void(^)())result;

@end
