//
//  SGURLSessionTask+SGUserInfo.m
//  SGURLSessionTask
//
//  Created by sylphghost on 2018/3/28.
//  Copyright © 2018年 sylphghost. All rights reserved.
//

#import "SGURLSessionTask+SGUserInfo.h"

@implementation SGURLSessionTask (SGUserInfo)
+ (instancetype)taskForUserInfor{
    SGURLSessionTask *task = [SGURLSessionTask new];
    task.externalURL(@"/api/user/getInfo");
    return task;
}
@end
