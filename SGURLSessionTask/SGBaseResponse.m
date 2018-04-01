//
//  SGBaseReponse.m
//  netWorkingTestExample
//
//  Created by sylphghost on 16/9/2.
//  Copyright © 2016年 sylphghost. All rights reserved.
//

#import "SGBaseResponse.h"

@implementation SGBaseResponse
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
             @"ID":@"id",
             @"desc":@"description"
             };
}
@end
