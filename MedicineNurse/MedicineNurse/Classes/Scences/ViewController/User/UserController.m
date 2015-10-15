//
//  UserController.m
//  MedicineNurse
//
//  Created by lanou3g on 15/10/14.
//  Copyright © 2015年 Adar-Li. All rights reserved.
//

#import "UserController.h"
#import "AVUser.h"
#import "HomeController.h"

@interface UserController ()
@property (weak, nonatomic) IBOutlet UITextField *textField4Name;
@property (weak, nonatomic) IBOutlet UITextField *textField4Password;

@end

@implementation UserController

- (void)viewWillDisappear:(BOOL)animated{
    
    self.tabBarController.tabBar.hidden = NO;
}

- (void)viewWillAppear:(BOOL)animated{
    
        self.tabBarController.tabBar.hidden = YES;
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        //去sb 中找到这个控制器
        UserController * user = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"user"];
        self = user;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    

    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)btn4Login:(id)sender {
    [AVUser logInWithUsernameInBackground:_textField4Name.text password:_textField4Password.text block:^(AVUser *user, NSError *error) {
        if (user != nil) {
            NSLog(@"成功");
        } else {
            NSLog(@"失败");
        }
    }];
}
- (IBAction)btn4Regis:(id)sender {

}
- (IBAction)btn4Find:(id)sender {
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
