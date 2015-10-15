//
//  DataManager.m
//  MedicineNurse
//
//  Created by lanou3g on 15/10/15.
//  Copyright © 2015年 Adar-Li. All rights reserved.
//

#import "DataManager.h"
#import "HLoverModel.h"

@implementation DataManager
static  FMDatabase * db = nil;

+ (DataManager *)shareDatamanager{
    static  DataManager * manager =nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        manager = [[DataManager alloc]init];
        //创建数据库
        db = [FMDatabase databaseWithPath:kDataPath];
    });
    return  manager;
}

- (BOOL)creatTableWithTableName:(NSString *)tableName mainKey:(NSString *)mainKey title:(NSString *)title URl:(NSString *)url{
    BOOL state = NO;
    if (![db open]) {
        return NO;
    }
    if (![self isTableExistWithTableName:tableName]) {
        
        NSString * sqlString = [NSString stringWithFormat:@"CREATE TABLE %@ (%@ TEXT PRIMARY KEY, %@ TEXT DEAFAULT '', %@ TEXT DEAFAULT '')",tableName,mainKey,title,url];
        state = [db executeStatements:sqlString];
    }
    [db close];
    return state;
}

//判断表是否存在
- (BOOL)isTableExistWithTableName:(NSString * )tableName{
    if (![ db open]) {
        return  NO;
    }
    FMResultSet * set = [db executeQuery:@"select count(*) as count from sqlite_master where type = 'table' and name = ?",tableName];
    if ([set next]) {
        NSInteger count = [set intForColumn:@"count"];
        if (count == 0) {
            return NO;
        }
        return YES;
    }
    return NO;
}

//向表中插入数据
- (void)InsertIntoTableName:(NSString *)tableName WithMainKey:(NSString *)mainKey title:(NSString *)title URL:(NSString *)url{
    
    if (![db open]) {
        return ;
    }
    NSString *sqlInsert = [NSString stringWithFormat:@"insert into %@ (%@,%@,%@) values('%@','%@','%@')",tableName,kLoverKey,kLoverTitle,kLoverURL,mainKey,title,url];
    
    BOOL isSuc = [db executeUpdate:sqlInsert];
    if (isSuc) {
        NSLog(@"suc");
    }else{
        NSLog(@"fail");
    }
    [db close];
}

//查询所有数据
- (NSMutableArray *)selectAllDataWithTableName:(NSString *)tableName mainKey:(NSString *)mainKey title:(NSString *)title URl:(NSString *)url{
    if (![db open]) {
        return nil;
    }
    NSMutableArray * mutArray = [NSMutableArray array];
    
    NSString *sql = [NSString stringWithFormat:@"SELECT * FROM %@" ,tableName];
    FMResultSet *resultSet = [db executeQuery:sql];
    while ([resultSet next]) {
        HLoverModel * model = [HLoverModel new];
        model.title = [resultSet stringForColumn:title];
        model.picUrl = [resultSet stringForColumn:url];
        model.ID =  [resultSet stringForColumn:mainKey];
        [mutArray addObject:model];
    }
    [db close];
    return mutArray;
}

//
//清楚表
- (void)clearTableWithTableName:(NSString *)tableName{
    [db open];
    NSString * clearStr = [NSString stringWithFormat:@"DELETE FROM %@",tableName];
    if ([db executeUpdate:clearStr]) {
        NSLog(@"清理表成功");
    }else{
        NSLog(@"清理表失败");
    }
    [db close];
    
}





@end
