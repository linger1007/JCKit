//
//  LJCStarRatingView.m
//  LJCStarRatingView
//
//  Created by 林锦超 on 2019/3/5.
//  Copyright © 2019 林锦超. All rights reserved.
//

#import "LJCStarRatingView.h"

static const NSUInteger kNumberOfStars = 5;

@interface LJCStarRatingView()
@property (nonatomic, copy) NSArray<UIImageView *> *stars;
@property (nonatomic, copy) UIImageView *halfStar;
@property (nonatomic, assign) CGSize starSize;
@end

@implementation LJCStarRatingView

#pragma mark - LifeCycle
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self _commonSetup];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        [self _commonSetup];
    }
    return self;
}

- (void)_commonSetup
{
    _rating = 0.f;
    _starSpacing = 5.f;
    _floatable = YES;
    _touchable = YES;
    
    // stars
    NSMutableArray<UIImageView *> *stars = [NSMutableArray arrayWithCapacity:kNumberOfStars];
    for (NSUInteger idx = 0; idx < kNumberOfStars; idx++) {
        UIImageView *starImageView = [UIImageView new];
        [self addSubview:starImageView];
        [stars addObject:starImageView];
    }
    _stars = [stars copy];
    
    // halfStar
    _halfStar = [UIImageView new];
    _halfStar.contentMode = UIViewContentModeTopLeft;
    _halfStar.clipsToBounds = YES;
    _halfStar.hidden = YES;
    [self addSubview:_halfStar];
}

#pragma mark - Layout
//- (CGSize)sizeThatFits:(CGSize)size
//{
//    return [self _selfSize];
//}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self _redrawStars];
}

- (void)_redrawStars
{
    CGFloat width = self.starSize.width;
    CGFloat height = self.starSize.height;
    CGFloat xOffset = (self.bounds.size.width - [self _selfSize].width) / 2;
    CGFloat yOffset = (self.bounds.size.height - height) / 2;
    
    __weak typeof(self) weakSelf = self;
    [self.stars enumerateObjectsUsingBlock:^(UIImageView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (idx < (NSUInteger)weakSelf.rating) {
            obj.image = weakSelf.ratedImage;
        }
        else {
            obj.image = weakSelf.placeholderImage;
        }
        
        obj.frame = CGRectMake(xOffset + (width + weakSelf.starSpacing) * idx, yOffset, width, height);
    }];
    
    // half star
    CGFloat factor = _rating - (int)_rating;
    if (self.isFloatable && factor > 0.f) {
        _halfStar.hidden = NO;
        
        CGRect frame = self.stars[(NSUInteger)_rating].frame;
        _halfStar.frame = CGRectMake(frame.origin.x, frame.origin.y, frame.size.width * factor, frame.size.height);
        _halfStar.image = self.ratedImage;
    }
    else {
        _halfStar.hidden = YES;
        _halfStar.image = nil;
    }
}

- (CGSize)_selfSize
{
    CGFloat width = self.starSize.width;
    width *= kNumberOfStars;
    width += _starSpacing * (kNumberOfStars - 1);
    return CGSizeMake(width, self.starSize.height);
}

#pragma mark - Touch
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if (!self.isTouchable) {
        return;
    }
    
    UITouch *touch = [touches anyObject];
    [self _updateStarRatingWithTouchPoint:[touch locationInView:self]];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if (!self.isTouchable) {
        return;
    }
    
    UITouch *touch = [touches anyObject];
    [self _updateStarRatingWithTouchPoint:[touch locationInView:self]];
}

- (void)_updateStarRatingWithTouchPoint:(CGPoint)point
{
    CGSize size = [self _selfSize];
    CGFloat xOffset = (self.bounds.size.width - size.width) / 2;
    CGFloat percentage = MAX(0, MIN(1, (point.x - xOffset) / size.width));
    
    BOOL isUpdate = NO;
    if (self.isFloatable) {
        isUpdate = (self.rating != percentage * kNumberOfStars);
        self.rating = percentage * kNumberOfStars;
    }
    else {
        isUpdate = (self.rating != ceil(percentage * kNumberOfStars));
        self.rating = ceil(percentage * kNumberOfStars);
    }
    
    if (isUpdate && self.rateChangedBlock) {
        self.rateChangedBlock(self.rating);
    }
}

#pragma mark - Getter
- (CGSize)starSize
{
    CGFloat width = MIN(_placeholderImage.size.width, _ratedImage.size.width);
    CGFloat height = MIN(_placeholderImage.size.height, _ratedImage.size.height);
    return CGSizeMake(width, height);
}

#pragma mark - Setter
- (void)setRating:(CGFloat)rating
{
    NSParameterAssert(rating >= 0.f && rating <= 5.f);
    rating = MAX(0, MIN(rating, 5));
    
    if (_rating != rating) {
        _rating = rating;
        
        [self setNeedsLayout];
    }
}

- (void)setStarSpacing:(CGFloat)starSpacing
{
    if (_starSpacing != starSpacing) {
        _starSpacing = starSpacing;
        
        [self setNeedsLayout];
    }
}

- (void)setRatedImage:(UIImage *)ratedImage
{
    if (_ratedImage != ratedImage) {
        _ratedImage = ratedImage;
        
        [self setNeedsLayout];
    }
}

- (void)setPlaceholderImage:(UIImage *)placeholderImage
{
    if (_placeholderImage != placeholderImage) {
        _placeholderImage = placeholderImage;
        
        [self setNeedsLayout];
    }
}

- (void)setFloatable:(BOOL)floatable
{
    _floatable = floatable;
    
    if (!floatable) {
        if (self.rating != ceil(self.rating)) {
            self.rating = ceil(self.rating);
            
            if (self.rateChangedBlock) {
                self.rateChangedBlock(self.rating);
            }
        }
    }
}

@end
