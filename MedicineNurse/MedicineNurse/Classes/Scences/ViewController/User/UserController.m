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
            
            UIAlertController*alert = [UIAlertController alertControllerWithTitle:@"登陆成功" message:@"尽情享受吧" preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction *oneAc = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                
            }];
            
            UIAlertAction *twoAc = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            }];
            
            [alert addAction:oneAc];
            [alert addAction:twoAc];
            [self dismissViewControllerAnimated:YES completion:nil];
            
        } else {
            UIAlertController*alert = [UIAlertController alertControllerWithTitle:@"登陆失败" message:@"账户或者密码不正确" preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction *oneAc = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                
                [self dismissViewControllerAnimated:YES completion:nil];
            }];
            
            UIAlertAction *twoAc = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            }];
            
            [alert addAction:oneAc];
            [alert addAction:twoAc];
            
            [self presentViewController:alert animated:YES completion:nil];
        }
    }];
}
- (IBAction)btn4Regis:(id)sender {
    
}
- (IBAction)btn4Find:(id)sender {
}
- (IBAction)btn4Back:(id)sender {
    self.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self dismissViewControllerAnimated:YES completion:nil];
}
//撤销键盘
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
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
