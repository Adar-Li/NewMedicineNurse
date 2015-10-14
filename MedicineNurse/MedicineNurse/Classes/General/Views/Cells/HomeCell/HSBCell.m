//
//  HSBCell.m
//  MedicineNurse
//
//  Created by lanou3g on 15/10/8.
//  Copyright © 2015年 Adar-Li. All rights reserved.
//

#import "HSBCell.h"
#import <UIImageView+WebCache.h>



@implementation HSBCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
//赋值的方法
- (void)setvalueWithModel:(HSubjectModel*)item{
    self.lable4Title.text  = item.name;
//    self.lable4Intro.text = item.
    self.lable4Title.numberOfLines = 0 ;
    self.lable4Title.font = [UIFont systemFontOfSize:13];
    NSString * imgURL = item.cover_small;
    [self.imgView4Image sd_setImageWithURL:[NSURL URLWithString:imgURL] ];
    self.lable4Intro.text = item.desc;
    self.lable4Intro.numberOfLines = 0 ;
    self.lable4Intro.font = [UIFont systemFontOfSize:12];
    
}





@end
