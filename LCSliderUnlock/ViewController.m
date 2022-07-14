//
//  ViewController.m
//  LCSliderUnlock
//
//  Created by lax on 2022/6/21.
//

#import "ViewController.h"
#import "LCSliderUnlockView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self touchesEnded:[NSSet set] withEvent:nil];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    LCSliderUnlockView *sliderUnlockView = [[LCSliderUnlockView alloc] init];
    
    sliderUnlockView.confirmBlock = ^{
        NSLog(@"成功啦");
    };
    
    // 自定义样式
    sliderUnlockView.edgInsets = UIEdgeInsetsMake((UIScreen.mainScreen.bounds.size.height - 104) / 2 , 44, (UIScreen.mainScreen.bounds.size.height - 104) / 2, 44);
    sliderUnlockView.sliderView.layer.cornerRadius = 16;
    sliderUnlockView.sliderView.edgInsets = UIEdgeInsetsMake(32, 24, 32, 24);
    sliderUnlockView.sliderView.contentView.backgroundColor = [UIColor grayColor];
    sliderUnlockView.sliderView.maskView.backgroundColor = [UIColor greenColor];
    sliderUnlockView.sliderView.imageView.backgroundColor = [UIColor redColor];
    sliderUnlockView.sliderView.imageViewWidth = 58;
    sliderUnlockView.sliderView.descriptionLabel.textColor = [UIColor greenColor];
    sliderUnlockView.sliderView.descriptionLabel.font = [UIFont systemFontOfSize:12];
    sliderUnlockView.sliderView.descriptionLabel.text = @"请向右滑动验证";
    
    [sliderUnlockView showInView:self.view animated:YES];
    
}

@end
