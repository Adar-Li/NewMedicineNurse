//
//  DrugAndnewsListModel.h
//  MedicineNurse
//
//  Created by lanou3g on 15/10/6.
//  Copyright © 2015年 Adar-Li. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DrugAndnewsListModel : NSObject
//druglist
//id
@property(nonatomic,strong)NSString * drugId;
//相关药物名字
@property(nonatomic,strong)NSString * drugName;
//图片网址
@property(nonatomic,strong)NSString * drugPic;
//在cell中显示的简介
@property(nonatomic,strong)NSString * promotionInfo;

//newsList
//id
@property(nonatomic,strong)NSString * infoId;
//标题
@property(nonatomic,strong)NSString * infoTitle;
//图片网址
@property(nonatomic,strong)NSString * infoLogo;
//详情
@property(nonatomic, strong)NSString * infoContent;










@end
