//
//  CommonClassifyController.m
//  MedicineNurse
//
//  Created by lanou3g on 15/10/7.
//  Copyright © 2015年 Adar-Li. All rights reserved.
//

#import "CommonClassifyController.h"
#import "CommonClassifyCell.h"
#import "CommonHelper.h"

@interface CommonClassifyController ()

@end

@implementation CommonClassifyController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    //隐藏滑动条
    self.tableView.showsVerticalScrollIndicator = NO;
    
    //注册Cell
    [self.tableView registerNib:[UINib nibWithNibName:@"CommonClassifyCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    self.view.backgroundColor = [UIColor colorWithWhite:0.902 alpha:1.000];
    
    [[CommonHelper shareHelp] requestCommonList:^{
        [self.tableView reloadData];
    }];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 11;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

//点击事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    //接收点击的哪一个数组
    NSArray *array = [[CommonHelper shareHelp].commonDeArray[indexPath.row] mutableCopy];
    //创建通知
    NSDictionary *dict = @{@"array" : array};
    [[NSNotificationCenter defaultCenter] postNotificationName:@"load" object:nil userInfo:dict];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CommonClassifyCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    //科目图片
    NSArray *imageArray = @[@"Medicin",@"Surgery",@"Chinese",@"Male",@"Organs",@"Rheumatism",@"Female",@"Infect",@"hand",@"Child",@"Mentality"];
    NSString *string = imageArray[indexPath.row];
    cell.imageView4Classify.image = [UIImage imageNamed:string];
    
    CommonSymptomsModel *model = [CommonHelper shareHelp].commonArray[indexPath.row];
    cell.model = model;
    
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
