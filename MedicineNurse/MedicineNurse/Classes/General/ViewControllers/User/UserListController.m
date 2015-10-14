//
//  UserListController.m
//  MedicineNurse
//
//  Created by lanou3g on 15/10/14.
//  Copyright © 2015年 Adar-Li. All rights reserved.
//

#import "UserListController.h"
#import "RKCardView.h"
#import "WZFlashButton.h"
#define BUFFERX 20
#define BUFFERY 66

@interface UserListController ()

@property (nonatomic ,strong ) RKCardView* cardView;

@end

@implementation UserListController

- (instancetype)init
{
    self = [super init];
    if (self) {
        UIImage *image = [UIImage imageNamed:@"user.jpg"];
        image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        self.tabBarItem.image = image;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithRed:0.90 green:0.90 blue:0.90 alpha:1];
    
    self.navigationItem.title = @"用户";
    
    self.cardView= [[RKCardView alloc]initWithFrame:CGRectMake(BUFFERX, BUFFERY, self.view.frame.size.width-2*BUFFERX, self.view.frame.size.height-2*BUFFERY)];
    
    self.cardView.coverImageView.image = [UIImage imageNamed:@"111.jpg"];
    self.cardView.profileImageView.image = [UIImage imageNamed:@"111.jpg"];
    [self.cardView addBlur]; // comment this out if you don't want blur
    [self.cardView addShadow]; // comment this out if you don't want a shadow
    [self.view addSubview:self.cardView];

    WZFlashButton *outerRoundFlashButton = [[WZFlashButton alloc] initWithFrame:CGRectMake(50, 300, 50, 50)];
    outerRoundFlashButton.buttonType = WZFlashButtonTypeOuter;
    outerRoundFlashButton.layer.cornerRadius = 25;
    outerRoundFlashButton.flashColor = [UIColor colorWithRed:240/255.f green:159/255.f blue:10/255.f alpha:1];
    outerRoundFlashButton.backgroundColor = [UIColor colorWithRed:0 green:152.0f/255.0f blue:203.0f/255.0f alpha:1.0f];
    outerRoundFlashButton.clickBlock = ^(void) {
        NSLog(@"测试");
    };
    
    [self.cardView addSubview:outerRoundFlashButton];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
