//
//  SufferDeTableViewController.m
//  MedicineNurse
//
//  Created by lanou3g on 15/10/9.
//  Copyright © 2015年 Adar-Li. All rights reserved.
//

#import "SufferDeTableViewController.h"
#import "SufferTableViewCell.h"
#import "SufferModel.h"
#import "ViewController.h"
#import "UIImageView+WebCache.h"
#import "SufferHelper.h"
#import "GiFHUD.h"

@interface SufferDeTableViewController ()
@property (nonatomic ,strong)NSMutableArray *dataArray;

@end

@implementation SufferDeTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [GiFHUD setGifWithImageName:@"mie.gif"];
    [GiFHUD show];
    
    [self.tableView registerClass:[SufferTableViewCell class] forCellReuseIdentifier:@"cell"];
    
    self.dataArray = [NSMutableArray array];
    
    [self set_up];

}

// 解析数据
- (void)set_up
{
    NSString * urlStr = detail(self.tail);
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlStr ]];
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *  response, NSData *  data, NSError *  connectionError) {
        
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        
        for (NSDictionary *dic in dict[@"message"][@"list"]) {
            SufferModel *data = [SufferModel new];
            [data setValuesForKeysWithDictionary:dic];
            [self.dataArray addObject:data];
       
        }
        [self.tableView reloadData];
        [GiFHUD dismiss];
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
    return self.dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    SufferModel *model = _dataArray[indexPath.row];
    
    SufferTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.data = model;
 
    cell.ArticleLabel.text = [model.articleDate substringToIndex:10];
    
    
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return  self.tableView.frame.size.height/5;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ViewController *suff = [ViewController new];
    suff.str = [_dataArray[indexPath.row]url];
    [self.navigationController pushViewController:suff animated:YES];
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
