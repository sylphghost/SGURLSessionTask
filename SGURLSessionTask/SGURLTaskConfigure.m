//
//  SGUrlTaskConfigure.m
//  netWorkingTestExample
//
//  Created by sylphghost on 16/9/2.
//  Copyright © 2016年 sylphghost. All rights reserved.
//

#import "SGURLTaskConfigure.h"
#if __has_include(<YYModel/YYModel.h>)
#import <YYModel/YYModel.h>
#else
#import "YYModel.h"
#endif
static BOOL logAccessible=YES;
@implementation SGURLTaskConfigure
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self _intialization];
    }
    return self;
}

- (void)changeParametersWithDic:(NSDictionary *)dataDic{
    [dataDic enumerateKeysAndObjectsUsingBlock:^(NSString *  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        self.parameters[key]=obj;
    }];
    
}
//you can deal the error whole situtation
- (void)dealWithJsonData:(NSData *)jsonData Complete:(PMKAdapter) complete{
    NSError *error = nil;
    NSData *data = jsonData;
    NSDictionary *dataDic =
    [NSJSONSerialization JSONObjectWithData:data
                                    options:NSJSONReadingMutableContainers
                                      error:&error];
    if (error) {
        complete(nil,error);
        [self dealURLResultWithJsonDic:nil AndError:error];
    } else {
        if (dataDic) {
            if (![dataDic[SGErrorCodeKey] isMemberOfClass:[NSNull class]] &&![dataDic[SGErrorCodeKey] boolValue]) {
                id response =[self responseFromJsonDic:dataDic];
                [self dealURLResultWithJsonDic:dataDic AndError:nil];
                dispatch_async(dispatch_get_main_queue(), ^{
                    complete(response,nil);
                });
            }else{
                NSInteger errorCode =[dataDic[SGErrorCodeKey] integerValue];
                NSString *errorMsg = dataDic[SGErrorMsgKey];
                NSError *detailError = [NSError errorWithDomain:NSURLErrorDomain code:errorCode userInfo:@{NSLocalizedDescriptionKey:errorMsg}];
                [self dealURLResultWithJsonDic:dataDic AndError:error];
                dispatch_async(dispatch_get_main_queue(), ^{
                    complete(nil,detailError);
                });
            }
        } else {
            NSError *error=[NSError errorWithDomain:NSURLErrorDomain code:SGDefaultNetErrorCode userInfo:@{NSLocalizedDescriptionKey:SGDefaultNetErrorTitle}];
            [self dealURLResultWithJsonDic:nil AndError:error];
            dispatch_async(dispatch_get_main_queue(), ^{
                complete(nil,error);
            });
            
        }
    }
    
}
- (void)dealURLResultWithJsonDic:(NSDictionary *)jsonDic AndError:(NSError *)error{
    if (!logAccessible) {
        return;
    }
    NSString *title = @"\n---SGURLSessiongTaskLog:";
    NSString *urlPathStr = [NSString stringWithFormat:@"URLPath: %@%@",self.mainURL,self.externalURL];
    NSString *headerParametersStr = [NSString stringWithFormat:@"URLHeaders: %@",self.headerParameters];
    NSString *paramtersStr = [NSString stringWithFormat:@"URLParameters: %@",self.parameters];
    NSString *resultStr = @"";
    if (error) {
        resultStr = [NSString stringWithFormat:@"---ResultState:Fail\nError: %@\n---Servicer Result:\n%@",error,jsonDic];
        dispatch_async(dispatch_get_main_queue(), ^{
            [[NSNotificationCenter defaultCenter] postNotificationName:SGURLSessionTaskErrorNotifaction object:error];
        });
        
    }else{
        resultStr = [NSString stringWithFormat:@"---ResultState:Sucess\n---Servicer Result:\n%@",jsonDic];
    }
    NSLog(@"%@\n%@\n%@\n%@\n%@\n---SGURLSessiongTaskLogEnd",title,urlPathStr,headerParametersStr,paramtersStr,resultStr);
    
}
- (id)responseFromJsonDic:(NSDictionary *)jsonDic{
    return [self.responseClass yy_modelWithDictionary:jsonDic];
}
+ (void)changeLogMsgFlag:(BOOL)flag{
    logAccessible = flag;
}
#pragma mark private method
- (void)_intialization{
    self.mainURL = SGDefaultMainURL;
    self.externalURL=@"";
    self.responseClass=[SGBaseResponse class];
    self.responseBlock = nil;
    self.errorBlock = nil;
    self.headerParameters = @{}.mutableCopy;
    self.parameters=@{}.mutableCopy;
}

@end
NSString * const SGURLSessionTaskErrorNotifaction=@"kSGURLTaskConfigurePostErrorNotifaction";
