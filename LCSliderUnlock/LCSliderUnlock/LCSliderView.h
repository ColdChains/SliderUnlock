//
//  LCSliderUnlockView.h
//  LCSliderUnlock
//
//  Created by lax on 2022/6/21.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void (^LCSliderUnlockBlock) (void);

@interface LCSliderView : UIView

@property (nonatomic, copy) LCSliderUnlockBlock confirmBlock;

// 内边距 默认16
@property (nonatomic) UIEdgeInsets edgInsets;

@property (nonatomic) UIEdgeInsets titleLabelEdgInsets;

// 滑块宽度 默认44
@property (nonatomic) CGFloat imageViewWidth;

// 正常状态的图片
@property (nonatomic, strong) UIImage *normalImage;

// 滑到最右侧的图片
@property (nonatomic, strong) UIImage *finishImage;

// 容器
@property (nonatomic, strong, readonly) UIView *contentView;

// 滑块左侧的进度条
@property (nonatomic, strong, readonly) UIView *progressView;

// 滑块
@property (nonatomic, strong, readonly) UIImageView *imageView;

// 滑块右侧的文字
@property (nonatomic, strong, readonly) UILabel *descriptionLabel;

@end

NS_ASSUME_NONNULL_END
