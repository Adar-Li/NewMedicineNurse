//
//  HSubjectModel.h
//  MedicineNurse
//
//  Created by lanou3g on 15/10/8.
//  Copyright © 2015年 Adar-Li. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HSubjectModel : NSObject

//id
@property(nonatomic,strong)NSString * ID;
//标题名
@property(nonatomic,strong)NSString * name;
//简短介绍
@property(nonatomic,strong)NSString * desc;
//小图
@property(nonatomic,strong)NSString * cover_small;

//大图
@property(nonatomic,strong)NSString * cover;

@property(nonatomic,strong)NSString * type;
@property(nonatomic,strong)NSString * create_time;
@property(nonatomic,strong)NSString * modify_time;

//点击专题进去的第一层多的属性
//标题
//@property(nonatomic,strong)NSString * title;
//@property(nonatomic,strong)NSString * author_id;
//@property(nonatomic,strong)NSString * author;
//@property(nonatomic,strong)NSString * author_url;
//@property(nonatomic,strong)NSString * author_avatar;
//@property(nonatomic,strong)NSString * author_remarks;
//@property(nonatomic,strong)NSString * special_id;
//@property(nonatomic,strong)NSString * special_name;
//@property(nonatomic,strong)NSString * publish_time;

@end
