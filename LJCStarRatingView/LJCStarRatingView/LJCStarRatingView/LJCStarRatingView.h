//
//  LJCStarRatingView.h
//  LJCStarRatingView
//
//  Created by 林锦超 on 2019/3/5.
//  Copyright © 2019 林锦超. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^LJCStarRatingViewRateDidChangedHandler)(CGFloat rate);

@interface LJCStarRatingView : UIView

// 0~5.0，default 0.0
@property (nonatomic, assign) CGFloat rating;

// h-spacing between stars, default 5.0
@property (nonatomic, assign) CGFloat starSpacing;

//
@property (nonatomic, strong) UIImage *ratedImage;
@property (nonatomic, strong) UIImage *placeholderImage;

// floatable, default YES
@property (nonatomic, assign, getter=isFloatable) BOOL floatable;

// touchable, default YES
@property (nonatomic, assign, getter=isTouchable) BOOL touchable;

// rate changed block
@property (nonatomic, copy) LJCStarRatingViewRateDidChangedHandler rateChangedBlock;

@end

NS_ASSUME_NONNULL_END
