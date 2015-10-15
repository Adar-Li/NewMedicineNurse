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
        lableIndex = lableIndex + 8;
        UIImageView *imageview = [[UIImageView alloc]initWithFrame:CGRectMake(self.view.frame.size.width*i, 0, self.view.frame.size.width, self.view.frame.size.height)];
        [imageview setImage:[UIImage imageNamed:@"regist.jpg"]];
        arguments:
        imageview.userInteractionEnabled = YES;
        imageview.tag = 1000 + i;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(pageChange)];
        [imageview addGestureRecognizer:tap];
        [_Scroller addSubview:imageview];
        [self.view addSubview:_Scroller];
        //
        _currentCity = [[UILabel alloc]initWithFrame:CGRectMake(10+(KWith*i),70, self.view.frame.size.width/3,30)];
         //_currentCity.backgroundColor = [UIColor redColor];
        [self.Scroller addSubview:_currentCity];
        _currentCity.tag = 1000 + lableIndex+1;
        
        //
        _weath = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_currentCity.frame),70, KWith/3, 30)];
        //_weath.backgroundColor = [UIColor greenColor];
        [self.Scroller addSubview: _weath];
        _weath.tag = 1000 + lableIndex + 2;
        //
        _temperature = [[UILabel alloc]initWithFrame:CGRectMake(10 + (KWith *i), CGRectGetMaxY(_weath.frame)+20, KWith/3,30)];
         //_temperature.backgroundColor = [UIColor orangeColor];
        [self.Scroller addSubview: _temperature];
        _temperature.tag = 1000 + lableIndex + 3;
        //
        _winds = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_temperature.frame),CGRectGetMaxY(_weath.frame)+20, KWith/3, 30)];
       // _winds.backgroundColor = [UIColor blackColor];
        [self.Scroller addSubview:_winds];
        _winds.tag = 1000 + lableIndex+4;
        
        //
        _titlelabel = [[UILabel alloc]initWithFrame:CGRectMake(10+(KWith*i),CGRectGetMaxY(_winds.frame)+20,KWith/3, 30)];
        //_titlelabel.backgroundColor = [UIColor blueColor];
        [self.Scroller addSubview: _titlelabel];
        
        _titlelabel.tag = 1000 + lableIndex+5;
        //
        _zs = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_titlelabel.frame), CGRectGetMaxY(_winds.frame)+20, KWith/3, 30)];
        //_zs.backgroundColor = [UIColor brownColor];
        [self.Scroller addSubview:_zs];
        _zs.tag = 1000 + lableIndex+6;
        
        //
        _tipt = [[UILabel alloc]initWithFrame:CGRectMake(10+(KWith*i), CGRectGetMaxY(_zs.frame)+30, KWith/3, 30)];
        //_tipt.backgroundColor = [UIColor purpleColor];
        [self.Scroller addSubview:_tipt];
        _tipt.tag = 1000 + lableIndex+7;
        
        //
        _des = [[UILabel alloc]initWithFrame:CGRectMake(10+(KWith*i),CGRectGetMaxY(_tipt.frame)+20, KWith - 20, Kheight/7)];
        //_des.backgroundColor = [UIColor whiteColor];
        _des.numberOfLines = 0;
        
        [self.Scroller addSubview:_des];
        _des.tag = 1000 + lableIndex+8;
        
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        [manager GET:WeatherNet parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
            
            
           
            NSArray *array = responseObject[@"results"];
            _currentCity.text = array[0][@"currentCity"];
            for (int i = 1; i < 5; i ++) {
                UILabel * cityLable = (UILabel *)[self.view viewWithTag:(1000 +1+i * 8)];
                cityLable.text = _currentCity.text;
                for (NSDictionary *dic in array) {
                    
                    NSDictionary *dic2 = [dic[@"weather_data"]firstObject];
                    for (int i = 1; i < 5; i++) {
                        UILabel *weather = (UILabel *)[self.view viewWithTag:1000+2+i*8];
                      _weath.text = dic2[@"weather"];
                        weather.text = _weath.text;
                        
                        UILabel *wind = (UILabel *)[self.view viewWithTag:1000+3+i*8];
                        _winds.text = dic2[@"wind"];
                        wind.text = _winds.text;
                        
                        UILabel *temper = (UILabel *)[self.view viewWithTag:1000+4+i*8];
                        _temperature.text = dic2[@"temperature"];
                        temper.text = _temperature.text;
                        
                    }
                    
                    NSDictionary *dict = [dic[@"index"]firstObject];
                    for (int i = 1; i < 5; i++) {
                        UILabel *label = (UILabel *)[self.view viewWithTag:1000 + 8 + i*8];
                        self.des.text = dict[@"des"];
                        label.text = _des.text;
                        UILabel *tipt = (UILabel *)[self.view viewWithTag:1000 + 7 + i*8];
                        self.tipt.text = dict[@"tipt"];
                        tipt.text = _tipt.text;
                        
                        UILabel *title = (UILabel *)[self.view viewWithTag:1000 + 5 + i*8];
                         self.titlelabel.text = dict[@"tipt"];
                        title.text = _titlelabel.text;
                        UILabel *zs = (UILabel *)[self.view viewWithTag:1000 + 6 + i*8];
                        _zs.text = dict[@"zs"];
                        zs.text = _zs.text;
                       
                    }
                  
                    
                }
               
            }
        } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
           
        }];
      
}
  
}
//解析
- (void)setUp_View
{
    
    
    
    
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
