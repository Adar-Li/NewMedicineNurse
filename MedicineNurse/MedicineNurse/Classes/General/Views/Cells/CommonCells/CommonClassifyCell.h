//
//  CommonClassifyCell.h
//  MedicineNurse
//
//  Created by lanou3g on 15/10/7.
//  Copyright © 2015年 Adar-Li. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommonSymptomsModel.h"

@interface CommonClassifyCell : UITableViewCell

@property (nonatomic, strong) CommonSymptomsModel *model;

@property (weak, nonatomic) IBOutlet UILabel *label4Classify;
@property (weak, nonatomic) IBOutlet UIImageView *imageView4Classify;

@end
