//
//  SufferHelper.m
//  MedicineNurse
//
//  Created by lanou3g on 15/10/6.
//  Copyright © 2015年 Adar-Li. All rights reserved.
//

#import "SufferHelper.h"
#import "AFNetworking.h"
#import "SufferModel.h"

@interface SufferHelper ()
@property (nonatomic ,strong)NSMutableArray *mutArray;

@end

@implementation SufferHelper

+ (SufferHelper *)sharedSuffer
{

    static SufferHelper *help = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        help = [SufferHelper new];
    });
    return help;
    
}

//数据解析

- (void)requestAllSufferWith:(NSInteger)page Finish:(void(^)())result
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    NSString *Str = NetAndWed((long)page);
    [manager GET:Str parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        
        NSDictionary *dict = [responseObject valueForKey:@"message"];

        
        for (NSDictionary *dic in dict[@"list"]) {
            
            SufferModel *model = [SufferModel new];
            for (SufferModel *model in self.mutArray) {
                if ([dic[@"title"] isEqualToString:model.title]) {
                    return ;
                }
                
            }
            [model setValuesForKeysWithDictionary:dic];
            [self.mutArray addObject:model];

            result();
        
            
        }
        
      
        
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
     
    }];
   
}

- (SufferModel *)itemWithIndex:(NSInteger)index
{
    return self.mutArray[index];
    
}

- (NSMutableArray *)mutArray
{
    if (_mutArray == nil) {
        _mutArray = [NSMutableArray array];
    }
    return _mutArray;
}




//返回不可变数组
- (NSArray *)Allarray
{
    
    return [_mutArray mutableCopy];
  
}



@end
