
//
//  LXNavController.m
//  ImitationJianshu
//
//  Created by zhongzhi on 2017/8/30.
//  Copyright © 2017年 漫漫. All rights reserved.
//

#import "LXNavController.h"

@interface LXNavController ()

@end

@implementation LXNavController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    //    NSLog(@"%s, %@",__func__,viewController);
    // 左上角的返回键
    // 注意：第一个控制器不需要返回键
    // if不是第一个push进来的子控制器{
    if (self.childViewControllers.count >= 1) {
        // 左上角的返回按钮
        //        UIButton *backButton = [UIButton buttonWithType:UIButtonTypeSystem];
        //
        //        [backButton setImage:[UIImage imageNamed:@"return"] forState:UIControlStateNormal];
        ////        [backButton setImage:[UIImage imageNamed:@"return"] forState:UIControlStateHighlighted];
        ////        [backButton setTitle:@"返回" forState:UIControlStateNormal];
        ////        backButton.titleLabel.font = Font(16);
        ////        [backButton sizeToFit];
        //        [backButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        //
        //        backButton.contentEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 0); // 这里微调返回键的位置
        //        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
        viewController.navigationItem.leftBarButtonItem =[[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"icon_fanhui"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(back)];
        viewController.hidesBottomBarWhenPushed = YES; // 隐藏底部的工具条
    }
    // super的push方法一定要写到最后面
    // 一旦调用super的pushViewController方法,就会创建子控制器viewController的view
    // 也就会调用viewController的viewDidLoad方法
    
    [super pushViewController:viewController animated:animated];
    
}

- (void)back
{
    [self popViewControllerAnimated:YES];// 这里不用写self.navigationController，因为它自己就是导航控制器
}



@end
