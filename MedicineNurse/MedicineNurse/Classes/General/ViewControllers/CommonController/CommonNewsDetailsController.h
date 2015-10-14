//
//  CommonNewsDetailsController.h
//  MedicineNurse
//
//  Created by lanou3g on 15/10/11.
//  Copyright © 2015年 Adar-Li. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DrugAndnewsListModel.h"

@interface CommonNewsDetailsController : UIViewController

@property (nonatomic, strong) DrugAndnewsListModel * commonNDModel;

//详情
@property (nonatomic, strong) NSString * newsDetail;

@end
