//
//  HSubjectModel.m
//  MedicineNurse
//
//  Created by lanou3g on 15/10/8.
//  Copyright © 2015年 Adar-Li. All rights reserved.
//

#import "HSubjectModel.h"

@implementation HSubjectModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"id"]) {
        _ID = value;
    }
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"%@", _name];
}

@end
