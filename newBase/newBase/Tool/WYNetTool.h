//
//  WYNetTool.h
//  HeartCool
//
//  Created by lwy1218 on 16/6/2.
//  Copyright © 2016年 lwy1218. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger , WYResponseStyle) {
    WYResponseStyleJSON,
    WYResponseStyleXML,
    WYResponseStyleData,
};


/*! 定义请求成功的block */
typedef void( ^ WYResponseSuccess)(id responseObject);
/*! 定义请求失败的block */
typedef void( ^ WYResponseFail)(id error);
/*! 定义下载进度block */
typedef void( ^ WYDownloadProgress)(int64_t bytesProgress,
                                    int64_t totalBytesProgress);

/*! 定义上传进度block */
typedef void( ^ WYUploadProgress)(int64_t bytesProgress,
                                  int64_t totalBytesProgress);
@interface WYNetTool : NSObject

/**
 *  GET请求
 *
 *  @param url     URL
 *  @param params  参数
 *  @param style   请求数据格式 JSON XML Data
 *  @param success 请求成功的回调 responseObject
 *  @param fail    失败的回调 Error
 *
 *  @return
 */
+ (id)GET_Urlstring:(NSString *)urlString
      parameters:(NSDictionary *)params
         success:(WYResponseSuccess)success
            fail:(WYResponseFail)fail;

/**
 *  POST请求
 *
 *  @param url     URL
 *  @param params  参数
 *  @param style   请求数据格式 JSON XML Data
 *  @param success 请求成功的回调 responseObject
 *  @param fail    失败的回调 Error
 *
 *  @return
 */
+ (id)POST_Urlstring:(NSString *)url
       parameters:(NSDictionary *)params
          success:(WYResponseSuccess)success
             fail:(WYResponseFail)fail;
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
+ (NSURLSessionTask *)downLoadFileWithOperations:(NSDictionary *)operations withSavaPath:(NSString *)savePath withUrlString:(NSString *)urlString withSuccessBlock:(WYResponseSuccess)successBlock withFailureBlock:(WYResponseFail)failureBlock withDownLoadProgress:(WYDownloadProgress)progress;


+(void)startMultiPartUploadTaskWithURL:(NSString *)url
                           imagesArray:(NSArray *)images
                     parameterOfimages:(NSString *)parameter
                        parametersDict:(NSDictionary *)parameters
                      compressionRatio:(float)ratio
                          succeedBlock:(void (^)(id task, id responseObject))succeedBlock
                           failedBlock:(void (^)(id task, NSError *error))failedBlock
                   uploadProgressBlock:(void (^)(float percent, long long totalBytesWritten , long long totalBytesExpectedToWrite))uploadProgressBlock;

/**取消网络请求*/
+ (void)cancelNetwork;
@end
