//
//  SufferHelper.h
//  MedicineNurse
//
//  Created by lanou3g on 15/10/6.
//  Copyright © 2015年 Adar-Li. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SufferModel.h"
@interface SufferHelper : NSObject

//数组保存所有数据
@property (nonatomic ,strong)NSArray  *Allarray;


//单例方法
+ (SufferHelper *)sharedSuffer;


//数据解析
- (void)requestAllSufferWith:(NSInteger)page Finish:(void(^)())result;

/**
 *  根据一个index返回一个model
 *
 */

- (SufferModel *)itemWithIndex:(NSInteger)index;


@end
