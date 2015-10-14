//
//  HomeCell.m
//  MedicineNurse
//
//  Created by lanou3g on 15/10/7.
//  Copyright © 2015年 Adar-Li. All rights reserved.
//

#import "HomeCell.h"
#import "UIImageView+WebCache.h"

@implementation HomeCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setvalueWithModel:(RecommendModel *)item{
    self.lable4Title.text  = item.title;
    self.lable4Title.numberOfLines = 0 ;
    [self.imgView4Image sd_setImageWithURL:[NSURL URLWithString: item.cover_small] ];
    
}




@end
