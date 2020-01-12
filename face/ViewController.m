//
//  ViewController.m
//  face
//
//  Created by 刘洋 on 2018/7/30.
//  Copyright © 2018年 刘洋. All rights reserved.
//

#import "ViewController.h"
#import "AFNetworking.h"

#define AppID 11607828
#define APIKey @"Fu82FazazvOtnL5SqafNj51e"
#define SecretKey @"lKsSjoBb5CfRzsnKZl0rCMrWuoGtAuKB"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self addBtn];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)addBtn{
    UIButton *btn = [[UIButton alloc]init];
    btn.frame = CGRectMake(0, 300, 200, 50);
    CGFloat btnCenterX = self.view.center.x;
    CGFloat btnCenterY = btn.frame.origin.y + btn.frame.size.height * 0.5;
    CGPoint btnCenter = CGPointMake(btnCenterX, btnCenterY);
    btn.center = btnCenter;
    btn.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:btn];
    [btn setTitle:@"点我获取Token" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(didClickBtn) forControlEvents:UIControlEventTouchUpInside];
}

- (void)didClickBtn{
    [self getAccessToken];
}

- (void)getAccessToken{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //一但用了这个返回的那个responseObject就是NSData，如果不用就是简单的
    //manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    //manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html",@"image/jpeg",@"text/plain", nil];
    NSDictionary *dict = @{
                           @"grant_type":@"client_credentials",
                           @"client_id":APIKey,
                           @"client_secret":SecretKey
                           };
    [manager POST:@"https://aip.baidubce.com/oauth/2.0/token" parameters:dict progress:nil success:
     ^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
         /*
          if ([responseObject isKindOfClass:[NSData class]]) {
          NSError *error;
          id object = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:&error];
          NSLog(@"%@",object);
          }
          if (![responseObject isKindOfClass:[NSDictionary class]]) {
          NSLog(@"不是想要的结果，应该是哪里出错了，请注意检查！");
          NSLog(@"responseObject = %@",responseObject);
          return;
          }
          */
         NSDictionary *dict = (NSDictionary *)responseObject;
         
         NSString *accessToken = dict[@"access_token"];
         accessToken = dict[@"access_token"];
         NSLog(@"%@",accessToken);
         
         //调用判定二维码的接口
//         [self getResultOfQRImageWithAFN1];
         //[self getResultOfQRImageWithAFN2];
         //[self getResultOfQRImageWithNSURLSession];
         
     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
         NSLog(@"请求失败--%@",error);
     }];
}




@end
