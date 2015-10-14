//
//  HCCell.h
//  MedicineNurse
//
//  Created by lanou3g on 15/10/7.
//  Copyright © 2015年 Adar-Li. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RecommendModel.h"

@interface HCCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imgView4Image;

@property (weak, nonatomic) IBOutlet UILabel *lable4Title;

- (void)setvalueWithModel:(RecommendModel *)item;


@end
