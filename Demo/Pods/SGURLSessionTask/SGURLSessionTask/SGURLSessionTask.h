//
//  SGURLTask.h
//  netWorkingTestExample
//
//  Created by sylphghost on 16/9/2.
//  Copyright © 2016年 sylphghost. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SGURLTaskConfigure.h"
#if __has_include(<PromiseKit/Promise.h>)
#import <PromiseKit/Promise.h>
#else
#import "Promise.h"
#endif
@class SGURLSessionTask;
typedef SGURLSessionTask *(^SGHttpTypeBlock)(SGHttpType httpType);
typedef NSDictionary *(^SGParamtersMakerBlock)(void);
typedef SGURLSessionTask *(^SGURLParametersBlock)(SGParamtersMakerBlock ParamterMaker);
typedef SGURLSessionTask *(^SGURLHttpHeaderParameterBlock)(SGParamtersMakerBlock headerParameters);
typedef SGURLSessionTask *(^SGMainAddressURLBlock)(NSString *mainAddressUrl);
typedef SGURLSessionTask *(^SGExternalAddressURLBlock)(NSString *externalAddressUrl);
typedef SGURLSessionTask *(^SGDataAnalysisTypeBlock)(SGDataAnalysisType analysisType);

typedef SGURLSessionTask *(^SGChangeParametersBlock)(SGParamtersMakerBlock changeParameters);
typedef SGURLSessionTask *(^SGDeleteParameterBolck)(NSString *key);

typedef SGURLSessionTask *(^SGChangeHeaderParametersBlock)(SGParamtersMakerBlock headerParameters);
typedef SGURLSessionTask *(^SGResponseClassBlock)(Class response);

typedef SGURLSessionTask *(^SGURLProgressBlock)(SGProgressBlock progress);


typedef SGURLSessionTask *(^SGURLResponseBlock)(SGResponseBlock responseBlock);


typedef SGURLSessionTask *(^SGURLErrorBlock)(SGErrorBlock error);

typedef SGURLSessionTask *(^SGURLResumBlock)(void);

@interface SGURLSessionTask : NSObject
@property(strong,nonatomic) SGURLTaskConfigure *configure;
@property(copy,nonatomic,readonly)  SGResponseClassBlock responseClass;
@property(copy,nonatomic,readonly) SGExternalAddressURLBlock externalURL;
@property(copy,nonatomic,readonly) SGHttpTypeBlock httpType;
@property(copy,nonatomic,readonly) SGURLParametersBlock parameters;
@property(copy,nonatomic,readonly) SGURLHttpHeaderParameterBlock headerParamters;
@property(copy,nonatomic,readonly) SGMainAddressURLBlock mainURL;
@property(copy,nonatomic,readonly) SGChangeParametersBlock changeParameters;
@property(copy,nonatomic,readonly)  SGDeleteParameterBolck removeParameter;
@property(copy,nonatomic,readonly) SGChangeParametersBlock changeHeaderParameter;
@property(copy,nonatomic,readonly) SGDataAnalysisTypeBlock dataAnalysisType;
@property(nonatomic,copy,readonly) SGURLProgressBlock progress;
@property(nonatomic,copy,readonly) SGURLResponseBlock then;
@property(nonatomic,copy,readonly) SGURLErrorBlock catchError;
@property(nonatomic,copy,readonly) SGURLResumBlock resum;
- (PMKPromise *)resumePromise;
- (void)setParameterWithKey:(NSString *)key Value:(id)value;
- (void)deleteParameterWithKey:(NSString *)key;
- (void)setHttpHeaderWithKey:(NSString *)key Value:(id)value;
+ (void)changeLogMsgFlag:(BOOL)flag;
@end
