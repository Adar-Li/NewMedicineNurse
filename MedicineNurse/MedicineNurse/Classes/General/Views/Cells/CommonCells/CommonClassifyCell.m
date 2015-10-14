//
//  CommonClassifyCell.m
//  MedicineNurse
//
//  Created by lanou3g on 15/10/7.
//  Copyright © 2015年 Adar-Li. All rights reserved.
//

#import "CommonClassifyCell.h"

@implementation CommonClassifyCell

- (void)setModel:(CommonSymptomsModel *)model{
    
    self.label4Classify.text = model.dataName;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
