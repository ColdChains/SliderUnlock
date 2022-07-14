//
//  LCSliderUnlockView.h
//  LCSliderUnlock
//
//  Created by lax on 2022/6/21.
//

#import <UIKit/UIKit.h>
#import "LCSliderView.h"

NS_ASSUME_NONNULL_BEGIN

@interface LCSliderUnlockView : UIView

@property (nonatomic, copy) LCSliderUnlockBlock confirmBlock;

// 内边距
@property (nonatomic) UIEdgeInsets edgInsets;

// 滑块
@property (nonatomic, strong, readonly) LCSliderView *sliderView;

// 显示
- (void)showInView:(UIView *)view animated:(BOOL)animated;

// 隐藏
- (void)hideWithAnimated:(BOOL)animated;

@end

NS_ASSUME_NONNULL_END
