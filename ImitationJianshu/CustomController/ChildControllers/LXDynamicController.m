//
//  LXDynamicController.m
//  ImitationJianshu
//
//  Created by zhongzhi on 2017/8/30.
//  Copyright © 2017年 漫漫. All rights reserved.
//

#import "LXDynamicController.h"

@interface LXDynamicController ()
@end

@implementation LXDynamicController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSMutableArray *array =[NSMutableArray array];
    for ( int i = 0; i< 20; i++) {
        [array addObject:@"动态"];
    }
    self.dataA = array;
}




@end
