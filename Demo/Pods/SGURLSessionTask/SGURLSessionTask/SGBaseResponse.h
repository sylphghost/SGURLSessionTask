//
//  SGBaseReponse.h
//  netWorkingTestExample
//
//  Created by sylphghost on 16/9/2.
//  Copyright © 2016年 sylphghost. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface SGBaseResponse : NSObject
@property (nonatomic, copy) NSString *message;
@property (nonatomic, copy) NSString *errCode;
@end
