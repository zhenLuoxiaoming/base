//
//  WYNetTool.m
//  HeartCool
//
//  Created by lwy1218 on 16/6/2.
//  Copyright © 2016年 lwy1218. All rights reserved.
//

#import "WYNetTool.h"
#import "AFNetworking.h"
static NSMutableArray *tasks;

@implementation WYNetTool
+ (NSMutableArray *)tasks{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        tasks = [[NSMutableArray alloc] init];
    });
    return tasks;
}
/**取消网络请求*/
+ (void)cancelNetwork
{
    [[[self shareAFManager] operationQueue] cancelAllOperations];
//    [[[AFURLSessionManager manger]operationQueue] cancelAllOperations];
}
+ (id)GET_Urlstring:(NSString *)urlString parameters:(NSDictionary *)params success:(WYResponseSuccess)success fail:(WYResponseFail)fail
{
    if (urlString == nil)
    {
        return nil;
    }
    
    /*! 检查地址中是否有中文 */
    NSString *URLString = [NSURL URLWithString:urlString] ? urlString : [self strUTF8Encoding:urlString];
    
    NSURLSessionTask *sessionTask = nil;
    
    sessionTask = [[self shareAFManager] GET:URLString parameters:params  progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        /****************************************************/
        // 如果请求成功 , 回调请求到的数据 , 同时 在这里 做本地缓存
//        NSString *path = [NSString stringWithFormat:@"%ld.plist", (unsigned long)[URLString hash]];
//        // 存储的沙盒路径
//        NSString *path_doc = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
//        // 归档
//        [NSKeyedArchiver archiveRootObject:responseObject toFile:[path_doc stringByAppendingPathComponent:path]];

        NSData *data = responseObject;
        NSDictionary *responseObjectDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        
        if (success)
        {
            success(responseObjectDict);
        }else{
            fail(responseObjectDict);
        }
        
        [[self tasks] removeObject:sessionTask];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (fail)
        {
            fail(error);
        }
        [[self tasks] removeObject:sessionTask];
        
    }];
    
    if (sessionTask)
    {
        [[self tasks] addObject:sessionTask];
    }
    
    return sessionTask;
}
+ (AFHTTPSessionManager *)shareAFManager
{
    static AFHTTPSessionManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [AFHTTPSessionManager manager];
        /*! 设置请求超时时间 */
  
        manager.requestSerializer = [AFHTTPRequestSerializer serializer];// 请求
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];//响应
        manager.requestSerializer.timeoutInterval = 10;
        /*! 设置响应数据的基本了类型 */
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/css",@"text/xml",@"text/plain", @"application/javascript", nil];
        /*! 设置相应的缓存策略 */
        manager.requestSerializer.cachePolicy = NSURLRequestReloadIgnoringLocalCacheData;
        
        //! 设置返回数据为json, 分别设置请求以及相应的序列化器
        //        manager.responseSerializer = [AFJSONResponseSerializer serializer];
        /*! 设置apikey ------类似于自己应用中的tokken---此处仅仅作为测试使用*/
        //        [manager.requestSerializer setValue:@"a7c46f4afec0b612886ce63c7a0b5301" forHTTPHeaderField:@"token"];
        AFJSONResponseSerializer * response = [AFJSONResponseSerializer serializer];
        response.removesKeysWithNullValues = YES;
        // https  参数配置
        AFSecurityPolicy *securityPolicy = [AFSecurityPolicy defaultPolicy];
        securityPolicy.allowInvalidCertificates = YES;
        securityPolicy.validatesDomainName = NO;
        manager.securityPolicy = securityPolicy;
    });
    return manager;
}
+ (NSString *)strUTF8Encoding:(NSString *)str
{
    /*! ios9适配的话 打开第一个 */
    return [str stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLPathAllowedCharacterSet]];
//    return [str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}
+ (NSURLSessionTask *)POST_Urlstring:(NSString *)url parameters:(NSDictionary *)params success:(WYResponseSuccess)success fail:(WYResponseFail)fail
{
    
    if (url == nil)
    {
        return nil;
    }
    
    /*! 检查地址中是否有中文 */
    NSString *URLString = [NSURL URLWithString:url] ? url : [self strUTF8Encoding:url];
    
    NSURLSessionTask *sessionTask = nil;
    
    
    sessionTask = [[self shareAFManager] POST:URLString parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        /* ************************************************** */
        // 如果请求成功 , 回调请求到的数据 , 同时 在这里 做本地缓存
//        NSString *path = [NSString stringWithFormat:@"%ld.plist", (unsigned long)[URLString hash]];
//        // 存储的沙盒路径
//        NSString *path_doc = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
//        // 归档
//        [NSKeyedArchiver archiveRootObject:responseObject toFile:[path_doc stringByAppendingPathComponent:path]];
        NSData *data = responseObject;
        NSDictionary *responseObjectDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        if (success)
        {
            success(responseObjectDict);
        }
        [[self tasks] removeObject:sessionTask];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (fail)
        {
            fail(error);
        }
        [[self tasks] removeObject:sessionTask];
        
    }];
    if (sessionTask)
    {
        [[self tasks] addObject:sessionTask];
    }
    return sessionTask;
}

#pragma mark - ***** 文件下载
/*!
 *  文件下载
 *
 *  @param operations   文件下载预留参数---视具体情况而定 可移除
 *  @param savePath     下载文件保存路径
 *  @param urlString        请求的url
 *  @param successBlock 下载文件成功的回调
 *  @param failureBlock 下载文件失败的回调
 *  @param progress     下载文件的进度显示
 */
+ (NSURLSessionTask *)downLoadFileWithOperations:(NSDictionary *)operations withSavaPath:(NSString *)savePath withUrlString:(NSString *)urlString withSuccessBlock:(WYResponseSuccess)successBlock withFailureBlock:(WYResponseFail)failureBlock withDownLoadProgress:(WYDownloadProgress)progress
{
    if (urlString == nil)
    {
        return nil;
    }
    
    NSURLRequest *downloadRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    
    NSURLSessionTask *sessionTask = nil;
    
    sessionTask = [[self shareAFManager] downloadTaskWithRequest:downloadRequest progress:^(NSProgress * _Nonnull downloadProgress) {
        /*! 回到主线程刷新UI */
        dispatch_async(dispatch_get_main_queue(), ^{
            if (progress)
            {
                progress(downloadProgress.completedUnitCount, downloadProgress.totalUnitCount);
            }
            
        });
        
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        
        if (!savePath)
        {
            NSURL *downloadURL = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
            return [downloadURL URLByAppendingPathComponent:[response suggestedFilename]];
        }
        else
        {
            return [NSURL fileURLWithPath:savePath];
        }
        
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        [[self tasks] removeObject:sessionTask];
        if (error == nil)
        {
            if (successBlock)
            {
                /*! 返回完整路径 */
                successBlock([filePath path]);
            }
            else
            {
                if (failureBlock)
                {
                    failureBlock(error);
                }
            }
        }
    }];
    
    /*! 开始启动任务 */
    [sessionTask resume];
    
    if (sessionTask)
    {
        [[self tasks] addObject:sessionTask];
    }
    return sessionTask;
    
}

+(void)startMultiPartUploadTaskWithURL:(NSString *)url
                           imagesArray:(NSArray *)images
                     parameterOfimages:(NSString *)parameter
                        parametersDict:(NSDictionary *)parameters
                      compressionRatio:(float)ratio
                          succeedBlock:(void (^)(id task, id responseObject))succeedBlock
                           failedBlock:(void (^)(id task, NSError *))failedBlock
                   uploadProgressBlock:(void (^)(float percent, long long totalBytesWritten, long long totalBytesExpectedToWrite))uploadProgressBlock{
    
    if (images.count == 0) {
        //商家必须至少添加一张图片
//        [Apputil showError:@"亲~请在活动描述中至少添加一张图片哦~"];
        return;
    }
    for (int i = 0; i < images.count; i++) {
        if (![images[i] isKindOfClass:[UIImage class]]) {
            return;
        }
    }
    
    NSURLSessionTask *task = [[self shareAFManager] POST:url parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        int i = 0;
        //根据当前系统时间生成图片名称
        NSDate *date = [NSDate date];
        NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
        [formatter setDateFormat:@"yyyy年MM月dd日"];
        NSString *dateString = [formatter stringFromDate:date];
        
        
        for (UIImage *image in images) {
            NSString *fileName = [NSString stringWithFormat:@"%@%d.png",dateString,i];
            i++;
            NSData *imageData;
            if (ratio > 0.0f && ratio < 1.0f) {
                imageData = UIImageJPEGRepresentation(image, ratio);
            }else{
                imageData = UIImageJPEGRepresentation(image, 1.0f);
            }
            [formData appendPartWithFileData:imageData name:parameter fileName:fileName mimeType:@"image/jpg/png/jpeg"];
        }
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        succeedBlock(task,responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failedBlock(task,error);
    }];
    [task resume];
    
  
}



@end
