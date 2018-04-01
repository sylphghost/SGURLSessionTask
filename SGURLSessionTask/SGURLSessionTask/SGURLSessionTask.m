//
//  SGURLTask.m
//  netWorkingTestExample
//
//  Created by sylphghost on 16/9/2.
//  Copyright © 2016年 sylphghost. All rights reserved.
//

#import "SGURLSessionTask.h"
#if __has_include(<AFNetworking/AFNetworking.h>)
#import <AFNetworking/AFNetworking.h>
#else
#import "AFNetworking.h"
#endif
typedef void (^SGSucessProcessingBlock)(NSURLSessionDataTask *task , id _Nullable responseObject);
typedef void (^SGFailureProcessingBlock)(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error);

@interface SGURLSessionTask ()
@property(strong,nonatomic) AFHTTPSessionManager *afManager;
@property(weak,nonatomic) NSURLSessionDataTask * dataTask;
@end
@implementation SGURLSessionTask
#pragma mark - life cycle
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.configure=[SGURLTaskConfigure new];
        self.then(nil);
        self.catchError(nil);
    }
    return self;
}
#pragma mark - custom method
- (void)setParameterWithKey:(NSString *)key Value:(id)value{
    self.configure.parameters[key]=value;
}
- (void)deleteParameterWithKey:(NSString *)key{
    [self.configure.parameters removeObjectForKey:key];
}
- (void)setHttpHeaderWithKey:(NSString *)key Value:(id)value{
    self.configure.headerParameters[key]=value;
}
- (PMKPromise *)resumePromise{
    return [self _resume];
}
- (AFSecurityPolicy *)customSecurityPolicy{
    if (SGHttpsCerFieldName.length == 0 ) {
        return nil;
    }
    NSString *cerPath = [[NSBundle mainBundle] pathForResource:SGHttpsCerFieldName ofType:@"cer"];
    NSData *certData = [NSData dataWithContentsOfFile:cerPath];
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate];
    securityPolicy.allowInvalidCertificates = YES;
    securityPolicy.validatesDomainName = YES;
    securityPolicy.pinnedCertificates = [NSSet setWithObject:certData];;
    return securityPolicy;
}
+ (void)changeLogMsgFlag:(BOOL)flag{
    [SGURLTaskConfigure changeLogMsgFlag:flag];
}
#pragma mark - private method
- (PMKPromise *)_resume{
    __weak typeof(self) weakSelf = self;
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    NSString *mainUrl =
    [NSString stringWithFormat:@"%@%@", self.configure.mainURL,weakSelf.configure.externalURL];
    [self.configure.headerParameters enumerateKeysAndObjectsUsingBlock:^(NSString *  _Nonnull key, NSString * _Nonnull obj, BOOL * _Nonnull stop) {
        [weakSelf.afManager.requestSerializer setValue:obj forHTTPHeaderField:key];
    }];
    return  [PMKPromise promiseWithAdapter:^(PMKAdapter  _Nonnull adapter) {
        SGFailureProcessingBlock failure = ^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error){
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
            adapter(nil,error);
            [self.configure dealURLResultWithJsonDic:nil AndError:error];
        };
        SGSucessProcessingBlock success = ^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject){
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
            [self.configure dealWithJsonData:responseObject Complete:adapter];
        };
        SGProgressBlock progress = ^(NSProgress *progress){
            if (self.configure.progressBlock) {
                self.configure.progressBlock(progress);
            }
        };
        switch (weakSelf.configure.httpType) {
            case GET: {
                [weakSelf.afManager GET:mainUrl parameters:weakSelf.configure.parameters progress:progress success:success failure:failure];
                
            } break;
            case POST: {
                [weakSelf.afManager POST:mainUrl parameters:weakSelf.configure.parameters progress:progress success:success failure:failure];
            } break;
            case PUT: {
                [weakSelf.afManager PUT:mainUrl parameters:weakSelf.configure.parameters success:success failure:failure];
            } break;
            case DELETE: {
                [weakSelf.afManager DELETE:mainUrl parameters:weakSelf.configure.parameters success:success failure:failure];
            } break;
                
            default:
                break;
        }
    }];
}
#pragma mark - getters And setters
- (AFHTTPSessionManager *)afManager{
    static AFHTTPSessionManager  *manager= nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [AFHTTPSessionManager manager];
        manager.requestSerializer =
        [AFHTTPRequestSerializer serializer];
        manager.responseSerializer =
        [AFHTTPResponseSerializer serializer];
        AFSecurityPolicy *policy = [self customSecurityPolicy];
        if (policy) {
            manager.securityPolicy = policy;
        }
        
    });
    return manager;
}
- (SGResponseClassBlock)responseClass{
    return ^(Class response){
        self.configure.responseClass=response;
        return self;
    };
}
- (SGExternalAddressURLBlock)externalURL{
    return  ^(NSString *URL){
        self.configure.externalURL=URL;
        return self;
    };
}
- (SGHttpTypeBlock)httpType{
    return ^(SGHttpType type){
        self.configure.httpType=type;
        return self;
    };
}
- (SGURLParametersBlock)parameters{
    return ^(SGParamtersMakerBlock maker){
        self.configure.parameters=maker().mutableCopy;
        return self;
    };
}
- (SGURLHttpHeaderParameterBlock)headerParamters{
    return ^(SGParamtersMakerBlock maker){
        self.configure.headerParameters=maker().mutableCopy;
        return self;
    };
}

- (SGMainAddressURLBlock)mainURL{
    return ^(NSString *URL){
        self.configure.mainURL=URL;
        return self;
    };
}
- (SGChangeParametersBlock)changeParameters{
    return ^(SGParamtersMakerBlock maker){
        [self.configure changeParametersWithDic:maker()];
        return self;
    };
}
- (SGDeleteParameterBolck)removeParameter{
    return ^(NSString *key){
        [self deleteParameterWithKey:key];
        return self;
    };
}
- (SGChangeParametersBlock)changeHeaderParameter{
    return ^(SGParamtersMakerBlock maker){
        [maker() enumerateKeysAndObjectsUsingBlock:^(NSString*  _Nonnull key, NSString*  _Nonnull obj, BOOL * _Nonnull stop) {
            self.configure.headerParameters[key]=obj;
        }];
        return self;
    };
}
- (SGDataAnalysisTypeBlock)dataAnalysisType{
    return ^(SGDataAnalysisType type){
        self.configure.dataAnalysisType=type;
        return self;
    };
}
- (SGURLProgressBlock)progress{
    __weak typeof(self) weakSelf = self;
    return ^(SGProgressBlock progressBlock){
        weakSelf.configure.progressBlock = progressBlock;
        return weakSelf;
    };
}
- (SGURLResponseBlock)then{
    return ^(SGResponseBlock responseBlock){
        self.configure.responseBlock = responseBlock;
        return self;
    };
}
- (SGURLErrorBlock)catchError{
    return ^(SGErrorBlock errorBlock){
        self.configure.errorBlock = errorBlock;
        return self;
    };
}
- (SGURLResumBlock)resum{
    return ^(void){
        [self _resume].then(^(SGBaseResponse *response){
            if (self.configure.responseBlock) {
                self.configure.responseBlock(response);
            }
        }).catch(^(NSError *error){
            if (self.configure.errorBlock) {
                self.configure.errorBlock(error);
            }
        });
        return self;
    };
}
@end
