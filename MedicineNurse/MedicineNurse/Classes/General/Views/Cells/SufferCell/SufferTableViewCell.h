//
//  SufferTableViewCell.h
//  MedicineNurse
//
//  Created by lanou3g on 15/10/6.
//  Copyright © 2015年 Adar-Li. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SufferModel.h"

@interface SufferTableViewCell : UITableViewCell
@property (nonatomic ,strong)UILabel  *titlelabel;
@property (nonatomic ,strong)UILabel  *desLabel;
@property (nonatomic ,strong)UIImageView  *image;
@property (nonatomic ,strong)UILabel  *ArticleLabel;


@property (nonatomic ,strong)SufferModel  *data;

@end
