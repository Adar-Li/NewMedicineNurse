//
//  RecommendModel.h
//  MedicineNurse
//
//  Created by lanou3g on 15/10/6.
//  Copyright © 2015年 Adar-Li. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RecommendModel : NSObject
//轮播图图片标题
@property (nonatomic,strong)NSString *name;
//轮播图图片地址
@property (nonatomic,strong)NSString *cover;
//链接的地址
@property(nonatomic,strong)NSString * url;
@property(nonatomic,strong)NSString * vc_min;

//cell相对于上面多出来的
//cell标题
//id
@property(nonatomic,strong)NSString * ID;
@property (nonatomic,strong)NSString *title;
//cell上的小图片
@property (nonatomic,strong)NSString *cover_small;
//专题cell特有的
@property(nonatomic,strong)NSString * special_id;


@property(nonatomic,strong)NSString * author_id;
@property(nonatomic,strong)NSString * author;
@property(nonatomic,strong)NSString * author_url;
@property(nonatomic,strong)NSString * author_avatar;
@property(nonatomic,strong)NSString * author_remarks;
@property(nonatomic,strong)NSString * special_name;
@property(nonatomic,strong)NSString * publish_time;

//下拉刷新的数据同上




@end
