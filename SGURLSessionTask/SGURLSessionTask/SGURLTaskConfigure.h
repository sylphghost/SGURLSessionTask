//
//  SGUrlTaskConfigure.h
//  netWorkingTestExample
//
//  Created by sylphghost on 16/9/2.
//  Copyright © 2016年 sylphghost. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SGBaseResponse.h"
#if __has_include(<PromiseKit/Promise.h>)
#import <PromiseKit/Promise.h>
#else
#import "Promise.h"
#endif

//make changes according to the server configuration.
static NSString * const SGErrorCodeKey = @"errCode";
static NSString * const SGErrorMsgKey = @"message";
#warning Please enter your server IP
static NSString * const SGDefaultMainURL = @"";
static NSString * const SGHttpsCerFieldName = @"";


static NSString * const SGDefaultNetErrorTitle = @"Server internal error";
static const NSInteger SGDefaultNetErrorCode = 500;
typedef void(^SGProgressBlock)(NSProgress  *progress);
typedef void (^SGErrorBlock)(NSError *error);
typedef void(^SGResponseBlock)(SGBaseResponse *response);
typedef NS_ENUM(NSInteger,SGHttpType){
    GET = 0,
    POST,
    PUT,
    DELETE,
};
typedef NS_ENUM(NSInteger,SGDataAnalysisType){
    SGDataAnalysisTypeJson
};
@interface SGURLTaskConfigure: NSObject
@property(assign,nonatomic) SGHttpType httpType;
@property(copy,nonatomic)  NSString *mainURL;
@property(copy,nonatomic)  NSString *externalURL;
@property(assign,nonatomic) Class responseClass;
@property(strong,nonatomic) NSMutableDictionary *parameters;
@property(strong,nonatomic) NSMutableDictionary *headerParameters;
@property(assign,nonatomic) SGDataAnalysisType dataAnalysisType;
@property(nonatomic,copy) SGProgressBlock progressBlock;
@property(nonatomic,copy) SGResponseBlock responseBlock;
@property(nonatomic,copy) SGErrorBlock errorBlock;
- (void)changeParametersWithDic:(NSDictionary *)dataDic;
- (id)responseFromJsonDic:(NSDictionary *)jsonDic;
- (void)dealWithJsonData:(NSData *)jsonData Complete:(PMKAdapter) complete;
- (void)dealURLResultWithJsonDic:(NSDictionary *)jsonDic AndError:(NSError *)error;
+ (void)changeLogMsgFlag:(BOOL)flag;
@end
UIKIT_EXTERN NSString * const SGURLSessionTaskErrorNotifaction;
