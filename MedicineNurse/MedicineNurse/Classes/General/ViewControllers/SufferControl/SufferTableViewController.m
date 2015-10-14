//
//  SufferTableViewController.m
//  MedicineNurse
//
//  Created by lanou3g on 15/10/6.
//  Copyright © 2015年 Adar-Li. All rights reserved.
//

#import "SufferTableViewController.h"
#import "SufferTableViewCell.h"
#import "SufferModel.h"
#import "SufferHelper.h"
#import "ViewController.h"
#import "SVPullToRefresh.h"
#import "SufferDeTableViewController.h"


@interface SufferTableViewController ()
@property (nonatomic ,assign)NSInteger page;

@end

@implementation SufferTableViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.page = 1;
    
    self.navigationItem.title = @"用药咨询";
 
    //注册cell
    [self.tableView registerClass:[SufferTableViewCell class] forCellReuseIdentifier:@"cell"];
   
    
        //刷新View视图
    

    [[SufferHelper sharedSuffer]requestAllSufferWith:0 Finish:^{
        
        [self.tableView reloadData];
    }];
    
   
    __weak typeof(self) weakself = self;
    
    [self.tableView addPullToRefreshWithActionHandler:^{
      
        [[SufferHelper sharedSuffer]requestAllSufferWith:1 Finish:^{
            
            [weakself.tableView.pullToRefreshView stopAnimating];
            
        }];
        
        
    }];
    
    [self.tableView addInfiniteScrollingWithActionHandler:^{
       
        weakself.page++;
        
        [[SufferHelper sharedSuffer]requestAllSufferWith:weakself.page Finish:^{
            [weakself.tableView reloadData];
            
            [weakself.tableView.infiniteScrollingView stopAnimating];
   
        }];
   
    }];
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return [SufferHelper sharedSuffer].Allarray.count;

}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    SufferModel *item = [[SufferHelper sharedSuffer]itemWithIndex:indexPath.row];
 
    SufferTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
   
    cell.data = item;
    
    return cell;
}


//cell的高度

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return self.view.frame.size.height/5;
 
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ViewController *Suffer = [[ViewController alloc]init];
    
    
   SufferModel *model = [[SufferHelper sharedSuffer]itemWithIndex:indexPath.row];
    
    
    if (model.stag == nil) {
        
        Suffer.str = model.url;
        [self.navigationController pushViewController:Suffer animated:YES];
        
    }else
    {
        
        SufferDeTableViewController *sufferde = [[SufferDeTableViewController alloc]init];
        
        sufferde.tail = [model.stag valueForKey:@"tagid"];
        
        NSLog(@"===================%@",sufferde.tail);
        
        [self.navigationController pushViewController:sufferde animated:YES];
       
    }
    
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
