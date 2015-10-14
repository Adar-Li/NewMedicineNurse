//
//  SufferModel.h
//  MedicineNurse
//
//  Created by lanou3g on 15/10/6.
//  Copyright © 2015年 Adar-Li. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SufferModel : NSObject

@property (nonatomic ,strong)NSString  *title;  //标题

@property (nonatomic ,strong)NSString  *url;  //详情网址

@property (nonatomic ,strong)NSString  *descrip;  //描述

@property (nonatomic ,strong)NSString  *articleDate;  //时间

@property (nonatomic ,strong)NSString  *imgpath;  //图片

@property (nonatomic,assign)NSInteger  numOfHits;  //

@property (nonatomic ,strong)NSDictionary  *stag;

@property (nonatomic ,strong)NSString  *createTime;

@property (nonatomic ,strong)NSString  *desc; //标题
@property (nonatomic ,strong)NSString  *tagid; // 数据id
@property (nonatomic ,strong)NSString  *tagName; //
@property (nonatomic ,strong)NSString  *numOfArticle;
@property (nonatomic ,strong)NSString  *type;  //专题标签


@property (nonatomic ,strong)NSString  *data;
@property (nonatomic ,strong)NSString  *currntCity;

@property (nonatomic ,strong)NSString  *zs;
@property (nonatomic ,strong)NSString  *tipt;
@property (nonatomic ,strong)NSString  *des;
@property (nonatomic ,strong)NSString  *date;
@property (nonatomic ,strong)NSString  *weather;
@property (nonatomic ,strong)NSString  *wind;
@property (nonatomic ,strong)NSString  *temperature;







@end
