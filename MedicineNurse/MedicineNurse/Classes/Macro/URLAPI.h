
//
//  URLAPI.h
//  MedicineNurse
//
//  Created by lanou3g on 15/10/7.
//  Copyright © 2015年 Adar-Li. All rights reserved.
//

#ifndef URLAPI_h
#define URLAPI_h

//主界面的网址
//丁香推荐页面cell的网址
#define kHomeTJURL @"http://dxy.com/app/i/columns/article/recommend?ac=1d6c96d5-9a53-4fe1-9537-85a33de916f1&items_per_page=10&mc=df4e09ce2cf802df592ff64773dbb40156b4d58d&page_index=1&vc=4.0.5"
//丁香界面点击cell进去的网址,替换id就可以了
#define kHomeCellURL(p) [NSString stringWithFormat:@"http://dxy.com/app/i/columns/article/single?ac=1d6c96d5-9a53-4fe1-9537-85a33de916f1&id=%@&mc=df4e09ce2cf802df592ff64773dbb40156b4d58d&vc=4.0.5",p]


  //center用药咨询
#define NetAndWed(page) [NSString stringWithFormat:@"http://www.dxy.cn/webservices/article/list/tags?ac=4124c5f1-1029-4fda-b06f-a87ac5ad8d9f&limit=20&mc=df4e09ce2cf802df592ff64773dbb40156b4d58dudidfor7&pge=%ld&tags=53114",page]
//cell中专题网址
#define detail(tab) [NSString stringWithFormat:@"http://www.dxy.cn/webservices/article/list/tags?ac=4124c5f1-1029-4fda-b06f-a87ac5ad8d9f&limit=20&mc=df4e09ce2cf802df592ff64773dbb40156b4d58dudidfor7&pge=1&tags=%@&token=TGT-154773-cafT3zxC4UWhQIDjQOLnkNB07AE0iHCpYH7-50&u=Adar410",tab];




//推荐界面轮播图
#define kHomeTJSCURL @"http://dxy.com/app/i/feed/list?ac=1d6c96d5-9a53-4fe1-9537-85a33de916f1&mc=df4e09ce2cf802df592ff64773dbb40156b4d58d&vc=4.0.5"
//专题界面
#define kHomeSBURL @"http://dxy.com/app/i/columns/special/list?ac=1d6c96d5-9a53-4fe1-9537-85a33de916f1&items_per_page=10&mc=df4e09ce2cf802df592ff64773dbb40156b4d58d&page_index=1&vc=4.0.5"
//真相接口
#define kHomeTURL @"http://dxy.com/app/i/columns/truth/article/list?ac=1d6c96d5-9a53-4fe1-9537-85a33de916f1&items_per_page=10&mc=df4e09ce2cf802df592ff64773dbb40156b4d58d&page_index=1&vc=4.0.5"
//肿瘤接口
#define kHomeTumorURL(p) [NSString stringWithFormat:@"http://dxy.com/app/i/columns/article/list?ac=1d6c96d5-9a53-4fe1-9537-85a33de916f1&channel_id=%@&items_per_page=10&mc=df4e09ce2cf802df592ff64773dbb40156b4d58d&order=publishTime&page_index=1&vc=4.0.5",p]


//常见病症网址
//常见病症列表网址
#define KCommonListURL @"http://api.lkhealth.net/index.php?r=drug/getcommondisease&uid="
//列表点击进去
#define KCommonClickURL(dataId) [NSString stringWithFormat:@"http://api.lkhealth.net/index.php?r=drug/diseaseown&diseaseId=%@&uid=&lat=40.036326&lng=116.350313",dataId]
//资讯
#define KCommonNewsListURL(infold) [NSString stringWithFormat:@"http://api.lkhealth.net/index.php?r=news/newsdetail&dataId=%@&dataType=0&isAlbum=0",infold]
//药品
#define KCommonDrugListURL(drugld) [NSString stringWithFormat:@"http://phone.lkhealth.net/ydzx/business/apppage/druginfo.html?&drugid=%@",drugld]


#endif /* URLAPI_h */
