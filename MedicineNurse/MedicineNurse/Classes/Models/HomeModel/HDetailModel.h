//
//  HDetailModel.h
//  MedicineNurse
//
//  Created by lanou3g on 15/10/9.
//  Copyright © 2015年 Adar-Li. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HDetailModel : NSObject

@property(nonatomic,strong)NSString * ID;
//标题
@property(nonatomic,strong)NSString * title;
//主体文本
@property(nonatomic,strong)NSString * content;
//编辑页面再重复利用这个model时用到的
@property(nonatomic,strong)NSString * name;

@end
