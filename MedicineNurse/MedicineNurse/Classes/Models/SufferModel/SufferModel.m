//
//  SufferModel.m
//  MedicineNurse
//
//  Created by lanou3g on 15/10/6.
//  Copyright © 2015年 Adar-Li. All rights reserved.
//

#import "SufferModel.h"

@implementation SufferModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"description"]) {
        self.descrip = value;
    }
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"%@,%@,%@,%@,%@", _title,_descrip,_url,_articleDate,_imgpath];
}



@end
