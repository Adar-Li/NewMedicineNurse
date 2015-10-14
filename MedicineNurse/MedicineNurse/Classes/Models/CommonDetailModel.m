//
//  CommonDetailModel.m
//  MedicineNurse
//
//  Created by lanou3g on 15/10/6.
//  Copyright © 2015年 Adar-Li. All rights reserved.
//

#import "CommonDetailModel.h"

@implementation CommonDetailModel

//kvc异常赋值
- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
}


//重写打印方法
- (NSString *)description
{
    return [NSString stringWithFormat:@"%@", _dataTitle];
}

@end
