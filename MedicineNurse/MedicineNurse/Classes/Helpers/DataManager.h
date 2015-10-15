//
//  DataManager.h
//  MedicineNurse
//
//  Created by lanou3g on 15/10/15.
//  Copyright © 2015年 Adar-Li. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <FMDB.h>

@class DataManager;

@interface DataManager : NSObject

+ (DataManager *)shareDatamanager;

//创建图表
- (BOOL)creatTableWithTableName:(NSString *)tableName mainKey:(NSString *)mainKey title:(NSString *)title URl:(NSString *)url;

//向表中插入数据
- (void)InsertIntoTableName:(NSString *)tableName WithMainKey:(NSString *)mainKey title:(NSString *)title URL:(NSString *)url;

//查询所有数据
- (NSMutableArray *)selectAllDataWithTableName:(NSString *)tableName mainKey:(NSString *)mainKey title:(NSString *)title URl:(NSString *)url;
//清楚表
- (void)clearTableWithTableName:(NSString *)tableName;



@end
