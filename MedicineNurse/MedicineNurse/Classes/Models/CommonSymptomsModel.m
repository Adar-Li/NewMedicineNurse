//
//  CommonSymptomsModel.m
//  MedicineNurse
//
//  Created by lanou3g on 15/10/6.
//  Copyright (c) 2015年 Adar-Li. All rights reserved.
//

#import "CommonSymptomsModel.h"

@implementation CommonSymptomsModel
//kvc
- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
    
}

//重写打印方法

- (NSString *)description
{
    return [NSString stringWithFormat:@"%@", _dataName];
}



@end
