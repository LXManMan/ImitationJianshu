//
//  UIImage+ColorImage.h
//  CityListDemo
//
//  Created by zhongzhi on 2017/6/16.
//  Copyright © 2017年 zhongzhi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (ColorImage)
+ (UIImage *)imageWithColor:(UIColor*)color size:(CGSize)size;

//生成渐变色
+(UIImage*) createGradientImageWithRect:(CGRect)rect startColor:(UIColor *)startColor endColor:(UIColor *)endColor;

//防止渲染 
+ (instancetype)imageWithOriginalName:(NSString *)imageName;

@end
