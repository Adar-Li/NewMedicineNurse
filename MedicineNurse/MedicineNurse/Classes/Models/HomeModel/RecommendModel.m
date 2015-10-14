//
//  RecommendModel.m
//  MedicineNurse
//
//  Created by lanou3g on 15/10/6.
//  Copyright © 2015年 Adar-Li. All rights reserved.
//

#import "RecommendModel.h"

@implementation RecommendModel
//防止KVC出错
- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"id"]) {
        _ID = value;
    }
}

//重写打印方法
- (NSString *)description
{
    return [NSString stringWithFormat:@"%@", _title];
}


@end
