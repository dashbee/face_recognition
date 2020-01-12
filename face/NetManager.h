//
//  NetManager.h
//  face
//
//  Created by 刘洋 on 2018/8/2.
//  Copyright © 2018年 刘洋. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

typedef void(^AFNData)(id block);

@interface NetManager : NSObject
+(void)getDataWithString:(NSString *)string body:(NSDictionary *)parameters block:(AFNData)block;
@end
