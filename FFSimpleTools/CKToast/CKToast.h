//
//  CKToast.h
//  CKToast
//
//  Created by cts on 2018/1/9.
//  Copyright © 2018年 cts. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CKToast : NSObject

// 显示时长
@property(assign, nonatomic) NSTimeInterval duration;
// 是否自动隐藏
@property(assign, nonatomic) BOOL autoDismiss;

// 消失动画是否启用
@property(assign, nonatomic) BOOL dismissToastAnimated;
// 显示动画是否启用
@property(assign, nonatomic) BOOL presentToastAnimated;

- (instancetype)initCentreToastWithView:(UIView *)customToastView
                            autoDismiss:(BOOL)autoDismiss
                               duration:(NSTimeInterval)duration;

- (void)show;

@end
