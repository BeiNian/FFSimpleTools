
//
//  CKToast.m
//  CKToast
//
//  Created by cts on 2018/1/9.
//  Copyright © 2018年 cts. All rights reserved.
//

#import "CKToast.h"
#import "CKCentreToastView.h"

@interface CKToast ()
// 是否是自定义View
@property (nonatomic, assign) BOOL isCustomToastView;
@property (nonatomic, strong) UIView *customToastView;

@property (nonatomic, strong) CKCentreToastView *centerToastView;

@end

@implementation CKToast


- (instancetype)initCentreToastWithView:(UIView *)customToastView
                            autoDismiss:(BOOL)autoDismiss
                               duration:(NSTimeInterval)duration
{
    self.isCustomToastView = YES;
    
    self = [self init];
    if (self) {
        self.customToastView = customToastView;
        self.autoDismiss = autoDismiss;
    }
  
    return self;
}

/**
 Toast显示
 */
- (void)show {
    
    if (self.isCustomToastView == YES) {
        // 在屏幕中间展示自定一的View
        self.centerToastView = [[CKCentreToastView alloc]initCentreToastWithView:self.customToastView];
        
        _centerToastView.duration = self.duration;
        _centerToastView.autoDismiss = self.autoDismiss;
        _centerToastView.dismissToastAnimated = self.dismissToastAnimated;
        _centerToastView.presentToastAnimated = self.presentToastAnimated;
        
        [_centerToastView show];
    }else {
        
    }
}

- (instancetype)init
{
    self = [super init];
    if (self) {
         [self initToastConfig];
    }
    return self;
}

/**
 初始化Toast基本配置 
 */
-(void)initToastConfig{
    
    self.autoDismiss          = NO;
    self.presentToastAnimated = YES;
    self.dismissToastAnimated = YES;
    
    // 默认显示3s
    if (self.duration == 0) {
        self.duration = 3.0f;
    }
    
}
@end
