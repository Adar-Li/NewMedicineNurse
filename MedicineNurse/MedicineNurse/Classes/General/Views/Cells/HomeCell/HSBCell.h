//
//  HSBCell.h
//  MedicineNurse
//
//  Created by lanou3g on 15/10/8.
//  Copyright © 2015年 Adar-Li. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HSubjectModel.h"

@interface HSBCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imgView4Image;
@property (weak, nonatomic) IBOutlet UILabel *lable4Intro;

@property (weak, nonatomic) IBOutlet UILabel *lable4Title;

- (void)setvalueWithModel:(HSubjectModel*)item;


@end
