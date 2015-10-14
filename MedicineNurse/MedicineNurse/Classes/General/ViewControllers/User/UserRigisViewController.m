//
//  UserRigisViewController.m
//  MedicineNurse
//
//  Created by lanou3g on 15/10/14.
//  Copyright © 2015年 Adar-Li. All rights reserved.
//

#import "UserRigisViewController.h"

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
}
- (IBAction)btn4Cancel:(id)sender {
    self.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self dismissViewControllerAnimated:YES completion:nil];
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
