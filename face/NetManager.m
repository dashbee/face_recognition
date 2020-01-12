//
//  NetManager.m
//  face
//
//  Created by 刘洋 on 2018/8/2.
//  Copyright © 2018年 刘洋. All rights reserved.
//

#import "NetManager.h"

@implementation NetManager

+ (void)getDataWithString:(NSString *)string body:(NSDictionary *)parameters block:(AFNData)block
{
    AFNetworkReachabilityManager *netWorkManager = [AFNetworkReachabilityManager sharedManager];
    
    NSString *url_string = [NSString stringWithFormat:@"%@",string];
    url_string = [url_string stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain",@"text/json",@"application/json",@"text/javascript",@"text/html",nil];
    
    [manager POST:url_string parameters:parameters success:^(NSURLSessionTask *task, id responseObject)  {
        
        [netWorkManager stopMonitoring];
        
        block(responseObject);
        
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        
        NSLog(@"失败 === %@",error);
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            NSLog(@"Error: %@", error);
        });
    }];
}



@end
