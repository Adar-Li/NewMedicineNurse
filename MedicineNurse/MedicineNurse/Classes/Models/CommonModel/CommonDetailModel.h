//
//  CommonDetailModel.h
//  MedicineNurse
//
//  Created by lanou3g on 15/10/6.
//  Copyright © 2015年 Adar-Li. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CommonDetailModel : NSObject
//id
@property(nonatomic,strong)NSString * dataId;
//标题名
@property(nonatomic,strong)NSString * dataTitle;
//文本主体
@property(nonatomic,strong)NSString * content;
@end
