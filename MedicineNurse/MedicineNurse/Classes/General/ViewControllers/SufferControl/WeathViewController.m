//
//  WeathViewController.m
//  MedicineNurse
//
//  Created by lanou3g on 15/10/14.
//  Copyright © 2015年 Adar-Li. All rights reserved.
//

#import "WeathViewController.h"
#import "AFNetworkActivityIndicatorManager.h"
#import "AFNetworking.h"
#import "UIImageView+WebCache.h"

#define KWith self.view.frame.size.width
#define Kheight self.view.frame.size.height
@interface WeathViewController ()<UIScrollViewDelegate>
{
    NSInteger lableIndex;
}
@property (nonatomic ,strong)UIScrollView  *Scroller;
@property (nonatomic ,strong)UIPageControl  *page;


//天气
@property (nonatomic ,strong)UILabel  *currentCity;
@property (nonatomic ,strong)UILabel  *titlelabel;
@property (nonatomic ,strong)UILabel  *zs;
@property (nonatomic ,strong)UILabel  *tipt;
@property (nonatomic ,strong)UILabel  *des;

@property (nonatomic ,strong)UILabel  *data;
@property (nonatomic ,strong)UIImageView  *dayPic;
@property (nonatomic ,strong)UIImageView  *nightpic;
@property (nonatomic ,strong)UILabel  *weath;
@property (nonatomic ,strong)UILabel  *winds

;
@property (nonatomic ,strong)UILabel  *temperature;
@property (nonatomic ,strong)UILabel  *name;


@end

@implementation WeathViewController

- (void)viewWillDisappear:(BOOL)animated{
    
    self.tabBarController.tabBar.hidden = NO;
    
}

- (void)viewWillAppear:(BOOL)animated{
    
    self.tabBarController.tabBar.hidden = YES;
}

- (void)viewDidLoad {
    lableIndex = 0;
    [super viewDidLoad];
 
    _Scroller = [[UIScrollView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    _Scroller.backgroundColor = [UIColor cyanColor];
    
    _Scroller.pagingEnabled = YES;
    _Scroller.showsHorizontalScrollIndicator = NO;
    _Scroller.showsVerticalScrollIndicator = NO;
    _Scroller.bounces = NO;
    _Scroller.delegate = self;
    _Scroller.contentSize = CGSizeMake(KWith*4, Kheight- 118);
    
    
    for (int i = 0; i <5; i++) {
        lableIndex = lableIndex + 9;
        UIImageView *imageview = [[UIImageView alloc]initWithFrame:CGRectMake(self.view.frame.size.width*i, 0, self.view.frame.size.width, self.view.frame.size.height)];
        [imageview setImage:[UIImage imageNamed:@"regist.jpg"]];
        arguments:
        imageview.userInteractionEnabled = YES;
        imageview.tag = 1000 + i;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(pageChange)];
        [imageview addGestureRecognizer:tap];
        [_Scroller addSubview:imageview];
        [self.view addSubview:_Scroller];
        
        //当前城市
        _currentCity = [[UILabel alloc]initWithFrame:CGRectMake(10+(KWith*i),70, KWith/3,30)];
         _currentCity.textColor = [UIColor redColor];
        [self.Scroller addSubview:_currentCity];
        _currentCity.tag = 1000 + lableIndex+1;
        
        //天气
        _weath = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_currentCity.frame),70, KWith/3, 30)];
        //_weath.backgroundColor = [UIColor greenColor];
        [self.Scroller addSubview: _weath];
        _weath.tag = 1000 + lableIndex + 2;
        
        //温度
        _temperature = [[UILabel alloc]initWithFrame:CGRectMake(10 + (KWith *i), CGRectGetMaxY(_weath.frame)+20, KWith/3,30)];
         //_temperature.backgroundColor = [UIColor orangeColor];
        [self.Scroller addSubview: _temperature];
        _temperature.tag = 1000 + lableIndex + 3;
        
        //风力
        _winds = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_temperature.frame),CGRectGetMaxY(_weath.frame)+20, KWith/3, 30)];
       // _winds.backgroundColor = [UIColor blackColor];
        [self.Scroller addSubview:_winds];
        _winds.tag = 1000 + lableIndex+4;
        
        //标题
        _titlelabel = [[UILabel alloc]initWithFrame:CGRectMake(10+(KWith*i),CGRectGetMaxY(_winds.frame)+20,KWith/3, 30)];
        //_titlelabel.backgroundColor = [UIColor blueColor];
        [self.Scroller addSubview: _titlelabel];
        _titlelabel.tag = 1000 + lableIndex+5;
        
        //状况
        _zs = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_titlelabel.frame), CGRectGetMaxY(_winds.frame)+20, KWith/3, 30)];
        //_zs.backgroundColor = [UIColor brownColor];
        [self.Scroller addSubview:_zs];
        _zs.tag = 1000 + lableIndex+6;
        
        //穿衣指数
        _tipt = [[UILabel alloc]initWithFrame:CGRectMake(10+(KWith*i), CGRectGetMaxY(_zs.frame)+30, KWith/3, 30)];
        //_tipt.backgroundColor = [UIColor purpleColor];
        [self.Scroller addSubview:_tipt];
        _tipt.tag = 1000 + lableIndex+7;
        
        //描述
        _des = [[UILabel alloc]initWithFrame:CGRectMake(10+(KWith*i),CGRectGetMaxY(_tipt.frame)+20, KWith - 20, Kheight/7)];
        //_des.backgroundColor = [UIColor whiteColor];
        _des.numberOfLines = 0;
        [self.Scroller addSubview:_des];
        _des.tag = 1000 + lableIndex+8;
        
        
        //时间
        _data = [[UILabel alloc]initWithFrame:CGRectMake(10+(KWith*i),30, self.view.frame.size.width - 20,30)];
        _data.textColor = [UIColor orangeColor];
        [self.Scroller addSubview:_data];
        _data.tag = 1000 + lableIndex + 9;
        
        
        
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        [manager GET:WeatherNet parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        
            NSArray *array = responseObject[@"results"];
            
                     for (int i = 1; i < 5; i ++) {
                        UILabel * cityLable = (UILabel *)[self.view viewWithTag:(1000 +1+i * 9)];
                       cityLable.text = _currentCity.text;

            _currentCity.text = array[0][@"currentCity"];
            
            NSDictionary * resultDict = [array firstObject];
            NSArray * weatherArray = resultDict[@"weather_data"];
            for (int i = 1; i < 5; i ++) {
                NSDictionary * dict = weatherArray[i - 1];
                
                UILabel *weather = (UILabel *)[self.view viewWithTag:1000+2+i*9];
                weather.text = dict[@"weather"];
                
                UILabel *wind = (UILabel *)[self.view viewWithTag:1000+3+i*9];
                wind.text = dict[@"wind"];
                
                UILabel *temper = (UILabel *)[self.view viewWithTag:1000+4+i*9];
                temper.text = dict[@"temperature"];
                
                UILabel *datalael = (UILabel *)[self.view viewWithTag:1000+9+i*9];
                datalael.text = dict[@"date"];
                
                NSArray *array1 = resultDict[@"index"];
                NSDictionary *dict1 = array1[i - 1];
                
                
                UILabel *label = (UILabel *)[self.view viewWithTag:1000 + 8 + i*9];
                self.des.text = dict1[@"des"];
                label.text = _des.text;
                
                UILabel *tipt = (UILabel *)[self.view viewWithTag:1000 + 7 + i*9];
                self.tipt.text = dict1[@"tipt"];
                tipt.text = _tipt.text;
                
                UILabel *title = (UILabel *)[self.view viewWithTag:1000 + 5 + i*9];
                self.titlelabel.text = dict1[@"title"];
                title.text = _titlelabel.text;
                UILabel *zs = (UILabel *)[self.view viewWithTag:1000 + 6 + i*9];
                _zs.text = dict1[@"zs"];
                zs.text = _zs.text;
                
            }
            
        }
            

        } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
           
        }];
      
    }
}

- (void)pageChange
{
    
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
