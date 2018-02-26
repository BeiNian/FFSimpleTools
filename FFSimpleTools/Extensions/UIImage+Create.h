//
//  UIImage+Create.h
//  MeBike
//
//  Created by Yuen on 2017/6/6.
//  Copyright © 2017年 BaoJia. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Create)


#pragma mark -
#pragma mark _________________________ Image Creator
/**
 使用颜色创建一张此颜色的 UIImage.
 size:(1.0f, 1.0f)

 @param color color
 @return UIImage
 */
+ (UIImage *_Nonnull)bjmb_imageWithColor:(UIColor *_Nonnull)color;
 
@end
