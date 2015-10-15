//
//  UserRigisViewController.m
//  MedicineNurse
//
//  Created by lanou3g on 15/10/14.
//  Copyright © 2015年 Adar-Li. All rights reserved.
//

#import "UserRigisViewController.h"
#import "AVUser.h"

@interface UserRigisViewController ()
@property (weak, nonatomic) IBOutlet UITextField *textField4Name;
@property (weak, nonatomic) IBOutlet UITextField *textField4Password;
@property (weak, nonatomic) IBOutlet UITextField *textField4Email;

@end

@implementation UserRigisViewController

//- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
//    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
//        //去sb 中找到这个控制器
//        UserRigisViewController * user = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"userregis"];
//        self = user;
//    }
//    return self;
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)btn4Regis:(id)sender {
    AVUser *user = [AVUser user];
    user.username = _textField4Name.text;
    user.password =  _textField4Password.text;
    user.email = _textField4Email.text;
    //[user setObject:@"186-1234-0000" forKey:@"phone"];
    
    [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
         
            UIAlertController*alert = [UIAlertController alertControllerWithTitle:@"注册成功" message:@"尽情享受吧" preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction *oneAc = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                
                           }];
            
            //创建通知中心
            UIAlertAction *twoAc = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                
                [self dismissViewControllerAnimated:YES completion:nil];

                [[NSNotificationCenter defaultCenter]postNotificationName:@"Message" object:nil];
            }];
            [alert addAction:oneAc];
            [alert addAction:twoAc];
            
            [self presentViewController:alert animated:YES completion:nil];
            
        } else {
            UIAlertController*alert = [UIAlertController alertControllerWithTitle:@"注册失败" message:@"密码或者邮箱不正确" preferredStyle:UIAlertControllerStyleAlert];
            
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


//
- (void)P_saveUserInfo
{
    NSUserDefaults *userdefaults = [NSUserDefaults standardUserDefaults];
    [userdefaults setObject:_textField4Name.text forKey:@"userName"];
    [userdefaults setObject:_textField4Password.text forKey:@"Passward"];
    [userdefaults synchronize];
    
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"恭喜你注册成功" delegate:nil cancelButtonTitle:nil otherButtonTitles:nil];
    [alertView show];
    
}






- (IBAction)btn4Cancel:(id)sender {
    self.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
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
