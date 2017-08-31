
//
//  UIImage+ColorImage.m
//  CityListDemo
//
//  Created by zhongzhi on 2017/6/16.
//  Copyright © 2017年 zhongzhi. All rights reserved.
//

#import "UIImage+ColorImage.h"

@implementation UIImage (ColorImage)

// 设置图片为不渲染模式
+ (instancetype)imageWithOriginalName:(NSString *)imageName {
    UIImage *image = [UIImage imageNamed:imageName];
    return [image imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)];
}

+(UIImage *)imageWithColor:(UIColor*)color size:(CGSize)size{
    
    CGRect rect =CGRectMake(0,0, size.width, size.height);
    
    UIGraphicsBeginImageContext(rect.size);
    
    CGContextRef context =UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    
    CGContextFillRect(context, rect);
    
    UIImage *image =UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return image;
    
}
+(UIImage*) createGradientImageWithRect:(CGRect)rect startColor:(UIColor *)startColor endColor:(UIColor *)endColor;
{
    
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    
    drawLinearGradient(context, rect, startColor.CGColor, endColor.CGColor);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    return image;
}
void drawLinearGradient(CGContextRef context, CGRect rect, CGColorRef startColor, CGColorRef endColor)
{
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGFloat locations[] = { 0.0, 1.0 };
    
    NSArray *colors = @[(__bridge id) startColor, (__bridge id) endColor];
    
    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (__bridge CFArrayRef) colors, locations);
    CGPoint startPoint = CGPointMake(CGRectGetMinX(rect), CGRectGetMinY(rect));
    CGPoint endPoint = CGPointMake(CGRectGetMaxX(rect), CGRectGetMaxY(rect));
    
    CGContextSaveGState(context);
    CGContextAddRect(context, rect);
    CGContextClip(context);
    CGContextDrawLinearGradient(context, gradient, startPoint, endPoint, 0);
    
    CGContextRestoreGState(context);
    
    CGGradientRelease(gradient);
    CGColorSpaceRelease(colorSpace);
    // More coming...
}

@end
