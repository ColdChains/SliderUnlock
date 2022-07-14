//
//  LCSliderUnlockView.m
//  LCSliderUnlock
//
//  Created by lax on 2022/6/21.
//

#import "LCSliderView.h"
#import <Masonry/Masonry.h>

@interface LCSliderView ()

@property (nonatomic, strong) UIView *contentView;

@property (nonatomic, strong) UIView *progressView;

@property (nonatomic, strong) UIImageView *imageView;

@property (nonatomic, strong) UILabel *descriptionLabel;
           
@end

@implementation LCSliderView

- (UIView *)contentView {
    if (!_contentView) {
        _contentView = [[UIView alloc] init];
        _contentView.backgroundColor = [UIColor grayColor];
    }
    return _contentView;
}

- (UIView *)progressView {
    if (!_progressView) {
        _progressView = [[UIView alloc] init];
        _progressView.backgroundColor = [UIColor greenColor];
    }
    return _progressView;
}

- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc] initWithImage:self.normalImage];
        _imageView.userInteractionEnabled = YES;
        _imageView.contentMode = UIViewContentModeCenter;
        _imageView.backgroundColor = [UIColor redColor];
    }
    return _imageView;
}
    
- (UILabel *)descriptionLabel {
    if (!_descriptionLabel) {
        _descriptionLabel = [[UILabel alloc] init];
        _descriptionLabel.font = [UIFont systemFontOfSize:12];
    }
    return _descriptionLabel;
}

- (void)setEdgInsets:(UIEdgeInsets)edgInsets {
    _edgInsets = edgInsets;
    [self.contentView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(edgInsets);
    }];
}

- (void)setImageViewWidth:(CGFloat)imageViewWidth {
    _imageViewWidth = imageViewWidth;
    [self.imageView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(imageViewWidth);
    }];
    [self.progressView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.imageView).offset(-imageViewWidth / 2);
    }];
    [self.descriptionLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(imageViewWidth / 2);
    }];
}

- (void)setNormalImage:(UIImage *)normalImage {
    _normalImage = normalImage;
    self.imageView.image = normalImage;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _edgInsets = UIEdgeInsetsMake(16, 16, 16, 16);
        _imageViewWidth = 44;
        _normalImage = [UIImage imageNamed:@"tool_slider_arrow"];
        _finishImage = [UIImage imageNamed:@"tool_slider_ok"];
        
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panAction:)];
        [self.contentView addGestureRecognizer:pan];
        
        [self initView];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.contentView.layer.cornerRadius = 20;
    self.progressView.layer.cornerRadius = 20;
    self.imageView.layer.cornerRadius = 20;
}

- (void)initView {
    [self addSubview:self.contentView];
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
    
    [self.contentView addSubview:self.descriptionLabel];
    [self.contentView addSubview:self.progressView];
    [self.contentView addSubview:self.imageView];
    
    [self.descriptionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.imageViewWidth / 2);
        make.centerY.mas_equalTo(0);
    }];
    [self.progressView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.mas_equalTo(0);
        make.right.mas_equalTo(self.imageView).offset(-self.imageViewWidth / 2);
    }];
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.mas_equalTo(0);
        make.width.mas_equalTo(self.imageViewWidth);
    }];
}

- (void)panAction:(UIPanGestureRecognizer *)sender {
    if (sender.state == UIGestureRecognizerStateBegan) {
        
    } else if (sender.state == UIGestureRecognizerStateChanged) {
        
        CGPoint translation = [sender translationInView:self];
        CGFloat left = translation.x;
        left = MAX(left, 0);
        left = MIN(left, self.contentView.frame.size.width - self.imageView.frame.size.width);
        [self.imageView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(left);
        }];
        
        self.imageView.image = CGRectGetMaxX(self.imageView.frame) >= self.contentView.frame.size.width ? self.finishImage : self.normalImage;
        
    } else if (sender.state == UIGestureRecognizerStateEnded) {
        
        if (CGRectGetMaxX(self.imageView.frame) >= self.contentView.frame.size.width) {
            if (self.confirmBlock) {
                self.confirmBlock();
            }
        } else {
            [UIView animateWithDuration:0.25 animations:^{
                [self.imageView mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.left.mas_equalTo(0);
                }];
                [self layoutIfNeeded];
            }];
        }
        
    }
}

@end
