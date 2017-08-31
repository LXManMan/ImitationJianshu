//
//  MBProgressHUD+Add.h
//  QCC_Enterprise
//
//  Created by  ldmac on 16/3/14.
//  Copyright © 2016年  ldmac. All rights reserved.
//

#import "MBProgressHUD.h"

@interface MBProgressHUD (Add)
+ (void)showLoadinginView:(UIView *)view;//占位图
+ (void)showError:(NSString *)error toView:(UIView *)view;
+ (void)showSuccess:(NSString *)success toView:(UIView *)view;

+ (MBProgressHUD *)showMessag:(NSString *)message toView:(UIView *)view;
@end
