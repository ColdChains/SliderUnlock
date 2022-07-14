//
//  LCSliderUnlockView.m
//  LCSliderUnlock
//
//  Created by lax on 2022/6/21.
//

#import "LCSliderUnlockView.h"
#import <Masonry/Masonry.h>

@interface LCSliderUnlockView ()

@property (nonatomic, strong) LCSliderView *sliderView;

@end

@implementation LCSliderUnlockView

- (LCSliderView *)sliderView {
    if (!_sliderView) {
        _sliderView = [[LCSliderView alloc] init];
        _sliderView.backgroundColor = [UIColor whiteColor];
        __weak typeof(self) weakSelf = self;
        _sliderView.confirmBlock = ^{
            [weakSelf hideWithAnimated:YES];
            if (weakSelf.confirmBlock) {
                weakSelf.confirmBlock();
            }
        };
    }
    return _sliderView;
}

- (void)setEdgInsets:(UIEdgeInsets)edgInsets {
    _edgInsets = edgInsets;
    [self.sliderView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(edgInsets.left);
        make.right.mas_equalTo(-edgInsets.right);
        make.top.mas_equalTo(edgInsets.top);
        make.bottom.mas_equalTo(-edgInsets.bottom);
    }];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
        _edgInsets = UIEdgeInsetsMake(16, 16, 16, 16);
        [self initView];
    }
    return self;
}

- (void)initView {
    [self addSubview:self.sliderView];
    [self.sliderView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.edgInsets.left);
        make.right.mas_equalTo(-self.edgInsets.right);
        make.top.mas_equalTo(self.edgInsets.top);
        make.bottom.mas_equalTo(-self.edgInsets.bottom);
    }];
}

// 显示
- (void)showInView:(UIView *)view animated:(BOOL)animated {
    self.alpha = 0;
    
    [view addSubview:self];
    [self mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.mas_equalTo(0);
    }];
    [view layoutIfNeeded];
    
    [UIView animateWithDuration:animated ? 0.25 : 0 animations:^{
        self.alpha = 1;
    } completion:^(BOOL finished) {
    }];
    
}

// 隐藏
- (void)hideWithAnimated:(BOOL)animated {
    [UIView animateWithDuration:animated ? 0.25 : 0 animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

@end
