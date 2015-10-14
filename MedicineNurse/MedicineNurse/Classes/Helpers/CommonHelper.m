//
//  CommonHelper.m
//  MedicineNurse
//
//  Created by lanou3g on 15/10/7.
//  Copyright © 2015年 Adar-Li. All rights reserved.
//

#import "CommonHelper.h"
#import "AFHTTPSessionManager.h"
#import "CommonSymptomsModel.h"

@interface CommonHelper ()

@property (nonatomic, strong) NSMutableArray * commonMutArray;
@property (nonatomic, strong) NSMutableArray * commonDeMutArray;

@end

@implementation CommonHelper

//单例方法
+ (CommonHelper *)shareHelp{
    static CommonHelper *helper = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        helper = [CommonHelper new];
    });
    return helper;
}

//数据解析
- (void)requestCommonList:(void(^)())result{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:KCommonListURL parameters:nil success:^(NSURLSessionDataTask *  task, id   responseObject) {
        
        NSArray *array = responseObject[@"data"][@"commonDiseaseList"];
        for (NSDictionary *dic in array) {
            CommonSymptomsModel *model = [CommonSymptomsModel new];
            [model setValuesForKeysWithDictionary:dic];
            [self.commonMutArray addObject:model];
            
            NSArray *array1 = dic[@"twoType"];
            
            //接收遍历每一次twoTyper的数组
            NSMutableArray *array = [NSMutableArray new];
            for (NSDictionary *dic1 in array1) {
                CommonSymptomsModel *model1 = [CommonSymptomsModel new];
                [model1 setValuesForKeysWithDictionary:dic1];
                
                [array addObject:model1];
                
            }
            //传给外层详细数组
            [self.commonDeMutArray addObject:array];
        }
        result();
    } failure:^(NSURLSessionDataTask *  task, NSError *  error) {
        
        NSLog(@"%@",error);
    }];
    
}

- (NSMutableArray *)commonMutArray{
    if (nil == _commonMutArray) {
        _commonMutArray = [NSMutableArray new];
    }
    return _commonMutArray;
}

- (NSArray *)commonArray{
    
    return [_commonMutArray mutableCopy];
}

- (NSMutableArray *)commonDeMutArray{
    if (nil == _commonDeMutArray) {
        _commonDeMutArray = [NSMutableArray new];
    }
    return _commonDeMutArray;
}

- (NSArray *)commonDeArray{
    
    return [_commonDeMutArray mutableCopy];
}
@end
