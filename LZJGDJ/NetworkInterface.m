//
//  NetworkInterface.m
//  LZJGDJ
//
//  Created by Arson on 16/1/25.
//  Copyright © 2016年 Arson. All rights reserved.
//

#import "NetworkInterface.h"

@implementation NetworkInterface

+ (void) connectWithMode:(NSString *)mode baseURL:(NSString *)URLString parameters:(nullable id)parameters progress:(ProgressBlock)progress success:(SuccessBlock)success failure:(FailureBlock)failure {
    //创建AFHTTP管理器
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    if ([mode isEqualToString:@"POST"]||[mode isEqualToString:@"post"]) {
        //以post形式发送请求
        [manager POST:URLString parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
            progress(uploadProgress);
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            success(responseObject);
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            failure(error);
        }];
    }else if([mode isEqualToString:@"GET"]||[mode isEqualToString:@"get"]){
        //以get形式发送请求
        [manager GET:URLString parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
            progress(downloadProgress);
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            success(responseObject);
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            failure(error);
        }];
    
    }else if([mode isEqualToString:@"PUT"]||[mode isEqualToString:@"put"]){
        //以put形式发送请求
        [manager PUT:URLString parameters:parameters success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            success(responseObject);
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            failure(error);
        }];
    }else if([mode isEqualToString:@"DELETE"]||[mode isEqualToString:@"delete"]){
        //以delete形式发送请求
        [manager DELETE:URLString parameters:parameters success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            success(responseObject);
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            failure(error);
        }];
    }
}

@end
