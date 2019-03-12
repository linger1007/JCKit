//
//  LJCViewController.m
//  LJCStarRatingView
//
//  Created by 林锦超 on 2019/3/5.
//  Copyright © 2019 林锦超. All rights reserved.
//

#import "LJCViewController.h"
#import "LJCStarRatingView.h"
#import "LJCPerformanceViewController.h"

@interface LJCViewController ()
@property (nonatomic, strong) LJCStarRatingView *ratingView;
@property (nonatomic, strong) UILabel *ratePrompt;
@property (nonatomic, strong) UITextField *rateTextField;
@property (nonatomic, strong) UILabel *spacePrompt;
@property (nonatomic, strong) UISlider *spaceSlider;
@property (nonatomic, strong) UILabel *floatablePrompt;
@property (nonatomic, strong) UISwitch *floatableSwitch;
@property (nonatomic, strong) UILabel *touchablePrompt;
@property (nonatomic, strong) UISwitch *touchableSwitch;
@property (nonatomic, strong) UIButton *performanceButton;
@end

@implementation LJCViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.ratingView];
    [self.view addSubview:self.ratePrompt];
    [self.view addSubview:self.rateTextField];
    [self.view addSubview:self.spacePrompt];
    [self.view addSubview:self.spaceSlider];
    [self.view addSubview:self.floatablePrompt];
    [self.view addSubview:self.floatableSwitch];
    [self.view addSubview:self.touchablePrompt];
    [self.view addSubview:self.touchableSwitch];
    [self.view addSubview:self.performanceButton];
}

#pragma mark - Getter
- (LJCStarRatingView *)ratingView
{
    if (!_ratingView) {
        _ratingView = [[LJCStarRatingView alloc] initWithFrame:CGRectMake(0, 100, self.view.frame.size.width, 50)];
        _ratingView.rating = 0.f;
        _ratingView.backgroundColor = [UIColor lightGrayColor];
        _ratingView.placeholderImage = [UIImage imageNamed:@"star_bg"];
        _ratingView.ratedImage = [UIImage imageNamed:@"star_press"];
        
        __weak __typeof(self) weakSelf = self;
        _ratingView.rateChangedBlock = ^(CGFloat rate) {
            weakSelf.rateTextField.text = [NSString stringWithFormat:@"%.1lf", rate];
        };
    }
    return _ratingView;
}

- (UILabel *)ratePrompt
{
    if (!_ratePrompt) {
        CGFloat width = 100;
        _ratePrompt = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(self.rateTextField.frame) - width - 10, CGRectGetMinY(self.rateTextField.frame), width, 30)];
        _ratePrompt.text = @"rate";
        _ratePrompt.textAlignment = NSTextAlignmentRight;
    }
    return _ratePrompt;
}

- (UITextField *)rateTextField
{
    if (!_rateTextField) {
        CGFloat width = 100;
        CGFloat xOffset = (self.view.frame.size.width - width) / 2 + 20;
        _rateTextField = [[UITextField alloc] initWithFrame:CGRectMake(xOffset, CGRectGetMaxY(self.ratingView.frame) + 20, width, 30)];
        _rateTextField.layer.borderColor = [UIColor blackColor].CGColor;
        _rateTextField.layer.borderWidth = 1;
        _rateTextField.textAlignment = NSTextAlignmentCenter;
        _rateTextField.text = @"0";
        _rateTextField.userInteractionEnabled = NO;
    }
    return _rateTextField;
}

- (UILabel *)spacePrompt
{
    if (!_spacePrompt) {
        CGFloat width = 100;
        _spacePrompt = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(self.ratePrompt.frame), CGRectGetMaxY(self.ratePrompt.frame) + 30, width, 30)];
        _spacePrompt.text = @"space";
        _spacePrompt.textAlignment = NSTextAlignmentRight;
    }
    return _spacePrompt;
}

- (UISlider *)spaceSlider
{
    if (!_spaceSlider) {
        _spaceSlider = [[UISlider alloc] initWithFrame:CGRectMake(CGRectGetMinX(self.rateTextField.frame), CGRectGetMinY(self.spacePrompt.frame), 160, 30)];
        _spaceSlider.minimumValue = 0.0;
        _spaceSlider.maximumValue = 50;
        _spaceSlider.value = self.ratingView.starSpacing;
        _spaceSlider.continuous = YES;
        [_spaceSlider addTarget:self action:@selector(handleSliderValueChanged:) forControlEvents:UIControlEventValueChanged];
    }
    return _spaceSlider;
}

- (UILabel *)floatablePrompt
{
    if (!_floatablePrompt) {
        CGFloat width = 100;
        _floatablePrompt = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(self.spacePrompt.frame), CGRectGetMaxY(self.spacePrompt.frame) + 30, width, 30)];
        _floatablePrompt.text = @"floatable";
        _floatablePrompt.textAlignment = NSTextAlignmentRight;
    }
    return _floatablePrompt;
}

- (UISwitch *)floatableSwitch
{
    if (!_floatableSwitch) {
        _floatableSwitch = [[UISwitch alloc] initWithFrame:CGRectMake(CGRectGetMinX(self.spaceSlider.frame), CGRectGetMinY(self.floatablePrompt.frame), 100, 30)];
        _floatableSwitch.on = YES;
        [_floatableSwitch addTarget:self action:@selector(handleFloatableSwitchChanged:) forControlEvents:UIControlEventValueChanged];
    }
    return _floatableSwitch;
}

- (UILabel *)touchablePrompt
{
    if (!_touchablePrompt) {
        CGFloat width = 100;
        _touchablePrompt = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(self.floatablePrompt.frame), CGRectGetMaxY(self.floatablePrompt.frame) + 30, width, 30)];
        _touchablePrompt.text = @"touchable";
        _touchablePrompt.textAlignment = NSTextAlignmentRight;
    }
    return _touchablePrompt;
}

- (UISwitch *)touchableSwitch
{
    if (!_touchableSwitch) {
        _touchableSwitch = [[UISwitch alloc] initWithFrame:CGRectMake(CGRectGetMinX(self.floatableSwitch.frame), CGRectGetMinY(self.touchablePrompt.frame), 100, 30)];
        _touchableSwitch.on = YES;
        [_touchableSwitch addTarget:self action:@selector(handleTouchableSwitchChanged:) forControlEvents:UIControlEventValueChanged];
    }
    return _touchableSwitch;
}

- (UIButton *)performanceButton
{
    if (!_performanceButton) {
        CGFloat width = 150;
        _performanceButton = [[UIButton alloc] initWithFrame:CGRectMake((CGRectGetWidth(self.view.frame) - width) / 2, CGRectGetMinY(self.touchableSwitch.frame) + 50, width, 50)];
        [_performanceButton setTitle:@"performance" forState:UIControlStateNormal];
        [_performanceButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_performanceButton addTarget:self action:@selector(handleButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _performanceButton;
}

#pragma mark - Action
- (IBAction)handleSliderValueChanged:(UISlider *)sender
{
    self.ratingView.starSpacing = sender.value;
}

- (IBAction)handleFloatableSwitchChanged:(UISwitch *)sender
{
    self.ratingView.floatable = sender.on;
}

- (IBAction)handleTouchableSwitchChanged:(UISwitch *)sender
{
    self.ratingView.touchable = sender.on;
}

- (IBAction)handleButtonPressed:(id)sender
{
    [self.navigationController pushViewController:[LJCPerformanceViewController new] animated:YES];
}
@end
