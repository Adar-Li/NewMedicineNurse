//
//  CommonTableController.h
//  MedicineNurse
//
//  Created by lanou3g on 15/10/9.
//  Copyright © 2015年 Adar-Li. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommonSymptomsModel.h"

@interface CommonTableController : UITableViewController

@property (nonatomic, strong) CommonSymptomsModel *clickModel;

@property (nonatomic, strong) NSMutableArray * newsListMutArray;

@property (nonatomic, strong) NSMutableArray * drugListMutArray;

@end
