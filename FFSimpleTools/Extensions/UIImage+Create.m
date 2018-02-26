//
//  UIImage+Create.m
//  MeBike
//
//  Created by Yuen on 2017/6/6.
//  Copyright © 2017年 BaoJia. All rights reserved.
//

#import "UIImage+Create.h"
#define kScreenSize           [[UIScreen mainScreen] bounds].size
#define kScreenWidth          [[UIScreen mainScreen] bounds].size.width
#define kScreenHeight         [[UIScreen mainScreen] bounds].size.height


@implementation UIImage (Create)
#pragma mark -
#pragma mark _________________________ Image Creator
/**
 使用颜色创建一张此颜色的 UIImage.
 size:(1.0f, 1.0f)
 
 @param color color
 @return UIImage
 */
+ (UIImage *_Nonnull)bjmb_imageWithColor:(UIColor *_Nonnull)color
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 2.0f, 64.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}
 
@end
