//
//  LXMoreController.m
//  ImitationJianshu
//
//  Created by zhongzhi on 2017/8/30.
//  Copyright © 2017年 漫漫. All rights reserved.
//

#import "LXMoreController.h"

@interface LXMoreController ()

@end

@implementation LXMoreController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSMutableArray *array =[NSMutableArray array];
    for ( int i = 0; i< 20; i++) {
        [array addObject:@"更多"];
    }
    self.dataA = array;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
