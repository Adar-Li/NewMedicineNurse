//
//  SufferViewController.m
//  
//
//  Created by lanou3g on 15/10/8.
//
//

#import "SufferViewController.h"
#import "SufferTableViewCell.h"
#import "SufferModel.h"
#import "SufferHelper.h"
#import "SufferTableViewController.h"
#import "ViewController.h"
#import "AFNetworking.h"
#import "SufferDeTableViewController.h"
#import "WeathViewController.h"
#import "GiFHUD.h"

#define KWith self.view.frame.size.width
#define Kheight self.view.frame.size.height
@interface SufferViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic ,strong)UILabel  *cityLabel;
@property (nonatomic ,strong)UILabel  *Weatherlabel;
@property (nonatomic ,strong)UILabel  *datalabel;
@property (nonatomic ,strong)UILabel  *label1;
@property (nonatomic ,strong)UILabel  *labelwind;
@property (nonatomic ,strong)UILabel  *Deslabel;
@property (nonatomic ,strong)UITableView  *table;
@property (nonatomic ,strong)UIImageView  *Img;

@end

@implementation SufferViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        UIImage *image = [UIImage imageNamed:@"suffer.jpg"];
        image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        self.tabBarItem.image = image;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [GiFHUD setGifWithImageName:@"mie.gif"];
    [GiFHUD show];
    
    //添加图片
    _Img = [[UIImageView alloc]initWithFrame:CGRectMake(0, 60, KWith, Kheight/3.7)];
    _Img.backgroundColor = [UIColor redColor];
    [_Img setImage:[UIImage imageNamed:@"image.jpg"]];
    _Img.userInteractionEnabled = YES;
 
        //添加手势
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(TapChange)];
    tap.numberOfTapsRequired = 1;
    [_Img addGestureRecognizer:tap];
    [self.view addSubview:_Img];
    
    self.navigationItem.title = @"用药助手";
    
      //label布局
    _cityLabel= [[UILabel alloc]init];
    _cityLabel.frame = CGRectMake(10, 65,self.view.frame.size.width/2,Kheight/16);
    _cityLabel.textColor = [UIColor redColor];
    [self.view addSubview:_cityLabel];
    
    _Weatherlabel = [[UILabel alloc]init];
    _Weatherlabel.frame = CGRectMake(CGRectGetMaxX(_cityLabel.frame), 65, self.view.frame.size.width/3.5, Kheight/16);
    [self.view addSubview:_Weatherlabel];
    
    _datalabel = [[UILabel alloc]initWithFrame:CGRectMake(10,CGRectGetMaxY(_cityLabel.frame) - 10, KWith , Kheight/19)];
   // _datalabel.backgroundColor = [UIColor redColor];
    [self.view addSubview:_datalabel];
    
    _label1 = [[UILabel alloc]initWithFrame:CGRectMake(10,CGRectGetMaxY(_datalabel.frame)+3, KWith/2, Kheight / 21)];
    _label1.textColor = [UIColor cyanColor];
    [self.view addSubview:_label1];
    
    _labelwind = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_label1.frame), CGRectGetMaxY(_datalabel.frame)+3, KWith/3, Kheight / 21)];
    [self.view addSubview:_labelwind];
    
    _Deslabel = [[UILabel alloc]initWithFrame:CGRectMake(3, CGRectGetMaxY(_label1.frame), KWith - 6, Kheight/13)];
    _Deslabel.textColor = [UIColor orangeColor];
    _Deslabel.numberOfLines = 0;
    _Deslabel.font = [UIFont systemFontOfSize:13];
    [self.view addSubview:_Deslabel];
 
    _table = [[UITableView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_Deslabel.frame)+2,KWith,(Kheight - CGRectGetMaxY(_Deslabel.frame)) - 49) style:UITableViewStylePlain];
    [self.view addSubview:_table];
    
    UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(0, 69, KWith, Kheight - CGRectGetMaxY(_table.frame))];
    image.image = [UIImage imageNamed:@"3"];
    [self.view addSubview:image];
    
        //代理方法
    self.table.delegate = self;
    self.table.dataSource = self;
    [self.table registerClass:[SufferTableViewCell class] forCellReuseIdentifier:@"cell"];
    
    [self.table setScrollEnabled:NO];
    [self addFooterButton];
    [[SufferHelper sharedSuffer]requestAllSufferWith:0 Finish:^{
        [self.table reloadData];
        [GiFHUD dismiss];
    }];
    [self Set_weatherView];
}
    //天气数据
- (void)Set_weatherView
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:WeatherNet parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
       
        NSArray *array = responseObject[@"results"];
        self.cityLabel.text = array[0][@"currentCity"];
        for (NSDictionary *dic in array) {
            NSDictionary *dict = [dic[@"index"]firstObject];
            self.Deslabel.text = dict[@"des"];
            NSDictionary *dic2 = [dic[@"weather_data"]firstObject];
            self.datalabel.text = dic2[@"date"];
            self.Weatherlabel.text = dic2[@"weather"];
            self.label1.text = dic2[@"wind"];
            self.labelwind.text = dic2[@"temperature"];
        }
     
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
    }];
   
}

  //添加表头
- (void)addFooterButton
{
    UILabel *label = [[UILabel alloc]init];
    
    label.frame = CGRectMake(5, 10, self.view.frame.size.width - 10, 30);
    label.text = @"用药经验";
    label.textColor = [UIColor redColor];
    label.font = [UIFont systemFontOfSize:19];
    self.table.tableHeaderView = label;
    
         //初始化button
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    
      //设置文字和文字颜色
    [button setTitle:@"<<了解更多" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blueColor] forState:UIControlStateHighlighted];
    
      //设置圆角
    button.layer.cornerRadius = 3;
    button.layer.masksToBounds = YES;
    
    [button addTarget:self action:@selector(JumpMore) forControlEvents:UIControlEventTouchUpInside];
     //设置大小
  button.frame = CGRectMake(-50, -10,self.view.frame.size.width - 20 , 30);
    self.table.tableFooterView = button;
}


  //tableFooterView的button事件
- (void)JumpMore
{
    SufferTableViewController *suff = [[SufferTableViewController alloc]init];
    [SufferHelper sharedSuffer].Allarray =nil;
    [self.navigationController pushViewController:suff animated:YES];
}
    //cell
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
      //返回四个cell
    if (self.view.frame.size.height >= 667 ) {
      return  [SufferHelper sharedSuffer].Allarray.count - 16;
    }else if (self.view.frame.size.height >= 568 &&self.view.frame.size.height <= 667)   {
        
    return [SufferHelper sharedSuffer].Allarray.count - 17;
    }else{
        
        return [SufferHelper sharedSuffer].Allarray.count - 18;
        
    }
    
 }


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SufferModel *model = [[SufferHelper sharedSuffer]itemWithIndex:indexPath.row];
    
    SufferTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.data = model;

    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
       //判断返回
    if (self.view.frame.size.height >= 667 ) {
         return self.table.frame.size.height/4 - 20;
    }else if (self.view.frame.size.height >= 568 &&self.view.frame.size.height < 667) {
        return self.table.frame.size.height/3 - 20;
    }else
    {
        return self.table.frame.size.height/2 - 30;
    }
}

   //页面跳转
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
        UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:nil action:nil];
        self.navigationItem.backBarButtonItem = barButtonItem;
        [self.navigationController pushViewController:sufferde animated:YES];
        
    }
}

//手势的事件
- (void)TapChange
{
   
    [self.navigationController pushViewController:[WeathViewController new] animated:YES];
  
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
