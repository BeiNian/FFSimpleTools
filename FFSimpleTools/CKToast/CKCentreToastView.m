//
//  CKCentreToastView.m
//  CKToast
//
//  Created by cts on 2018/1/9.
//  Copyright © 2018年 cts. All rights reserved.
//

#import "CKCentreToastView.h"

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
#define STATUSBAR_HEIGHT [[UIApplication sharedApplication] statusBarFrame].size.height


#define HORIZONTAL_SPACE_TO_SCREEN 100.f
#define HORIZONTAL_SPACE_TO_TOASTVIEW 10.f
#define TOP_SPACE_TO_TOASTVIEW 10.f
#define ICON_IMG_SIZE CGSizeMake(35.f, 35.f)
#define DISMISS_BTN_IMG_SIZE CGSizeMake(20.f, 20.f)

@interface CKCentreToastView ()

// 是否是自定义View
@property (nonatomic, assign) BOOL isCustomToastView;
// 真正展示内容的View
@property(strong,nonatomic) UIView *toastView;

@property (assign, nonatomic) CGRect toastViewFrame;

@end

@implementation CKCentreToastView

static NSMutableArray* toastArray = nil;

- (instancetype)initCentreToastWithView:(UIView *)customToastView
{
    if (!toastArray) {
        toastArray = [NSMutableArray new];
    }
    
    self.isCustomToastView = YES;
    
    self.toastView = [[UIView alloc]init];
    self.toastView = customToastView;
    
    return [self init];
}

-(instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        if(_isCustomToastView == YES){
             [self addSubview:self.toastView];
        }
      
    }
    
    return self;
}


- (void)layoutToastView {
    
    self.toastViewFrame = [self toastViewFrame];
    
    self.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    
    //设置动画起始Frame
    CGFloat toastViewW = _toastViewFrame.size.width/2;
    CGFloat toastViewH = _toastViewFrame.size.height/2;
    CGFloat toastViewX = (self.frame.size.width - toastViewW)/2;
    CGFloat toastViewY = (self.frame.size.height - toastViewH)/2;
    self.toastView.frame = CGRectMake(toastViewX, toastViewY, toastViewW, toastViewH);
    
    self.toastView.alpha = 0.f;
    self.alpha = 0.f;
}

/**
 计算ToastView的frame
 
 @return ToastView的frame
 */
-(CGRect)toastViewFrame{
    
    CGFloat toastViewW = 0;
    CGFloat toastViewH = 0;
    CGFloat toastViewX = 0;
    CGFloat toastViewY = 0;
    
    if(_isCustomToastView == YES) {
        toastViewW = _toastView.frame.size.width;
        toastViewH = _toastView.frame.size.height;
        toastViewX = (SCREEN_WIDTH - toastViewW)/2;
        toastViewY = (SCREEN_HEIGHT - toastViewH)/2;
    }
    
    return CGRectMake(toastViewX, toastViewY, toastViewW, toastViewH);
    
}

/**
 显示一个Toast
 */
- (void)show {
    
    [self layoutToastView];
    
    //显示之前先把之前的移除
    if ([toastArray count] != 0) {
        [self performSelectorOnMainThread:@selector(dismiss) withObject:nil waitUntilDone:YES];
    }
    
    @synchronized (toastArray) {
        
        UIWindow *windowView = [UIApplication sharedApplication].keyWindow;
        [windowView addSubview:self];
        
        if (self.presentToastAnimated == YES) {
            
            [UIView animateWithDuration:0.5f
                                  delay:0.f
                 usingSpringWithDamping:0.7f
                  initialSpringVelocity:0.5f
                                options:UIViewAnimationOptionCurveEaseIn
                             animations:^{
                                 
                                 self.toastView.frame = _toastViewFrame;
                                 self.toastView.alpha = 1.0f;
                                 
                                 self.alpha = 1.0f;
                                 self.backgroundColor = [UIColor colorWithRed:104/255.0 green:104/255.0 blue:104/255.0 alpha:0.3];
                                 
                             } completion:^(BOOL finished) {
                                 
                             }];
        } else {
            
            self.toastView.frame = _toastViewFrame;
            self.toastView.alpha = 1.0f;
            
            self.alpha = 1.0f;
            self.backgroundColor = [UIColor colorWithRed:104/255.0 green:104/255.0 blue:104/255.0 alpha:0.3];
        }
        
        [toastArray addObject:self];
        
        if(_autoDismiss == YES){
            [self performSelector:@selector(dismiss) withObject:nil afterDelay:_duration];
        }
    }
}
/**
 隐藏一个Toast
 */
-(void)dismiss{
    
    if (toastArray && [toastArray count] > 0) {
        @synchronized (toastArray) {
            
            CKCentreToastView* toast = toastArray[0];
            [NSRunLoop cancelPreviousPerformRequestsWithTarget:toast];
            [toastArray removeObject:toast];
            
            if (self.dismissToastAnimated == YES) {
                
                [UIView animateWithDuration:0.2f animations:^{
                    
                     CGFloat toastViewW = _toastViewFrame.size.width/2;
                     CGFloat toastViewH = _toastViewFrame.size.height/2;
                     CGFloat toastViewX = (self.frame.size.width - toastViewW)/2;
                     CGFloat toastViewY = (self.frame.size.height - toastViewH)/2;
                     self.toastView.frame = CGRectMake(toastViewX, toastViewY, toastViewW, toastViewH);
                    
                     self.toastView.alpha = 0.f;
                     self.alpha = 0.f;
                    
                 } completion:^(BOOL finished) {
                     [toast removeFromSuperview];
                 }];
                
            }else{
                
                [UIView animateWithDuration:0.f animations:^{
                    
                     self.toastView.alpha = 0.f;
                     self.alpha = 0.f;
                    
                 } completion:^(BOOL finished) {
                     [toast removeFromSuperview];
                 }];
                
            }
            
        }
    }
    
}

@end
