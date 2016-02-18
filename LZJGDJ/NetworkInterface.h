//
//  NetworkInterface.h
//  LZJGDJ
//
//  Created by Arson on 16/1/25.
//  Copyright © 2016年 Arson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetWorking.h"

typedef void (^ProgressBlock) (NSProgress *progress);
typedef void (^SuccessBlock) (id responseObject);
typedef void (^FailureBlock) (NSError *error);

@interface NetworkInterface : NSObject

/**
 *  网络请求接口
 *
 *  @param mode       请求的方式
 *  @param mode       请求接受参数类型
 *  @param URLString  请求地址
 *  @param parameters 请求的参数（NSDictionary
 *  @param progress   请求数据大小
 *  @param success    请求成功Block
 *  @param failure    请求失败Block
 */
+ (void) connectWithMode:(NSString *)mode baseURL:(NSString *)URLString parameters:(nullable id)parameters progress:(ProgressBlock)progress success:(SuccessBlock)success failure:(FailureBlock)failure;
@end
