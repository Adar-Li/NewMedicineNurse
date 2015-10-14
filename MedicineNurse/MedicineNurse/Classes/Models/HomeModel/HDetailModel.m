//
//  HDetailModel.m
//  MedicineNurse
//
//  Created by lanou3g on 15/10/9.
//  Copyright © 2015年 Adar-Li. All rights reserved.
//

#import "HDetailModel.h"

@implementation HDetailModel
//chong
- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"id"]) {
        
        _ID = value;
    }
}
//
- (NSString *)description
{
    return [NSString stringWithFormat:@"%@,%@", _title,_name];
}

@end
