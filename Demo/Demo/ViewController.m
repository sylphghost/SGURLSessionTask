//
//  ViewController.m
//  Demo
//
//  Created by sylphghost on 2018/4/1.
//  Copyright © 2018年 sylphghost. All rights reserved.
//

#import "ViewController.h"
#import "SGURLSessionTask+SGUserInfo.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    SGURLSessionTask *task = [SGURLSessionTask taskForUserInfor];
    task.progress(^(NSProgress *progress) {
        //do somethind
        NSLog(@"total:%lld,complete:%lld",progress.completedUnitCount,progress.totalUnitCount);
    }).then(^(SGBaseResponse *response) {
        //do something...
    }).catchError(^(NSError *error) {
        //do something...
    }).resum();
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
