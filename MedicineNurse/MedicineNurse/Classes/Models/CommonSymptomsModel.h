//
//  CommonSymptomsModel.h
//  MedicineNurse
//
//  Created by lanou3g on 15/10/6.
//  Copyright (c) 2015年 Adar-Li. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CommonSymptomsModel : NSObject

@property(nonatomic,strong)NSString * dataId;

@property(nonatomic,strong)NSString * dataName;

@property(nonatomic,strong)NSString * Pic;
//列表信息数组
@property(nonatomic,strong)NSArray * twoType;

//常见病症列表细分下增加的属性
@property(nonatomic,strong)NSString * dataType;
@property(nonatomic,strong)NSString * isWeiHu;




@end
