//
//  HBView.h
//  MedicineNurse
//
//  Created by lanou3g on 15/10/7.
//  Copyright © 2015年 Adar-Li. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HBView : UIView

//表头button
@property(nonatomic,strong)UIButton * Button1;
@property(nonatomic,strong)UIButton * Button2;
@property(nonatomic,strong)UIButton * Button3;
@property(nonatomic,strong)UIButton * button4;
@property(nonatomic,strong)UIButton * button5;

- (void)drawButton;
- (void)button1Action;
- (void)button2Action;
- (void)button3Action;
- (void)button4Action;
- (void)button5Action;

@end
