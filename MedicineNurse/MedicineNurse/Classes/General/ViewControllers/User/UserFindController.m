//
//  UserFindController.m
//  MedicineNurse
//
//  Created by lanou3g on 15/10/14.
//  Copyright © 2015年 Adar-Li. All rights reserved.
//

#import "UserFindController.h"
#import "AVUser.h"

@interface UserFindController ()
@property (weak, nonatomic) IBOutlet UITextField *textField4Email;

@end

@implementation UserFindController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)btn4Find:(id)sender {
    
    [AVUser requestPasswordResetForEmailInBackground:@"myemail@example.com" block:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            

            
        } else {

        }
    }];
    
    
}
- (IBAction)btn4Cancel:(id)sender {
    self.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
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
