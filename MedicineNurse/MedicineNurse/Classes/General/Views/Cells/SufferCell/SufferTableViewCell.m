//
//  SufferTableViewCell.m
//  MedicineNurse
//
//  Created by lanou3g on 15/10/6.
//  Copyright © 2015年 Adar-Li. All rights reserved.
//

#import "SufferTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "SufferHelper.h"

@implementation SufferTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
      
        
        [self setUp];
        
        
    }
    
    return self;
}


- (void)setUp
{
       //标题
    _titlelabel = [[UILabel alloc]init];
    _titlelabel.frame = CGRectMake(5, 5, self.frame.size.width - 10, self.frame.size.height/4);
    _titlelabel.numberOfLines = 0;
    _titlelabel.font = [UIFont systemFontOfSize:16];
    //_titlelabel.alpha = 1;
    //_titlelabel.backgroundColor = [UIColor orangeColor];
    [self.contentView addSubview:_titlelabel];
    
         //图片
    _image = [[UIImageView alloc]init];
    _image.frame = CGRectMake(5, CGRectGetHeight(_titlelabel.frame)-5, self.frame.size.width / 3.5, self.frame.size.height - CGRectGetHeight(_titlelabel.frame) - 10 );
    //_image.backgroundColor = [UIColor redColor];
    
    [self.contentView addSubview:_image];
  
    
    
    
       //描述语言
    _desLabel = [[UILabel alloc]init];
    _desLabel.frame = CGRectMake(CGRectGetMaxX(_image.frame) - 10 , CGRectGetMaxY(_titlelabel.frame)+10, self.frame.size.width - CGRectGetWidth(_image.frame) - 15,self.frame.size.height - CGRectGetHeight(_titlelabel.frame) - 35);
    _desLabel.numberOfLines = 0;
    _desLabel.alpha = 0.8;
    _desLabel.font = [UIFont systemFontOfSize:12.5];
    //_desLabel.backgroundColor = [UIColor greenColor];
    [self.contentView addSubview:_desLabel];
    
    
        //时间
    _ArticleLabel = [[UILabel alloc]init];
    _ArticleLabel.frame = CGRectMake(-self.frame.size.width/3, self.frame.size.height - CGRectGetHeight(_desLabel.frame)+5 , self.frame.size.width/3, self.frame.size.height - CGRectGetMaxY(_desLabel.frame)-5);
    _ArticleLabel.font = [UIFont systemFontOfSize:12.5];
    _ArticleLabel.alpha = 0.8;
   // _ArticleLabel.backgroundColor = [UIColor redColor];
    [self.contentView addSubview:_ArticleLabel];
    
}

//cell布局约束
- (void)layoutSubviews
{
    [super layoutSubviews];
    
        //标题
    _titlelabel.frame = CGRectMake(5, 5, self.frame.size.width - 10, self.frame.size.height/4);
    
    
       //图片
    _image.frame = CGRectMake(5, CGRectGetMaxY(_titlelabel.frame), self.frame.size.width / 3.5, self.frame.size.height - CGRectGetHeight(_titlelabel.frame) - 10 );
    
        //描述
    _desLabel.frame = CGRectMake(CGRectGetMaxX(_image.frame) +5 , CGRectGetMaxY(_titlelabel.frame)+5, self.frame.size.width - CGRectGetWidth(_image.frame) - 15,self.frame.size.height - CGRectGetHeight(_titlelabel.frame) - 35);
    
    
       //时间
    _ArticleLabel.frame = CGRectMake(self.frame.size.width/1.34,CGRectGetMaxY(_desLabel.frame)+5 , self.frame.size.width/3, self.frame.size.height - CGRectGetMaxY(_desLabel.frame)-5);
}

//向cell中添加数据
- (void)setData:(SufferModel *)data
{
    [self.image sd_setImageWithURL:[NSURL URLWithString:data.imgpath]];
    
    self.titlelabel.text = data.title;
    self.desLabel.text = data.descrip;
    
    if ([data.stag  valueForKey:@"type"] == nil ) {
        NSString * str = [data.articleDate substringToIndex:10];
        self.ArticleLabel.text = str;
    
    }else
    {
         //判断是不是专题标签
        self.ArticleLabel.text = [[data.stag valueForKey:@"type"] substringToIndex:2];
        self.ArticleLabel.textAlignment = NSTextAlignmentNatural;
        self.ArticleLabel.textColor = [UIColor redColor];
    
    }
  
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
