//
//  LJCPerformanceCell.m
//  LJCStarRatingView
//
//  Created by 林锦超 on 2019/3/12.
//  Copyright © 2019 林锦超. All rights reserved.
//

#import "LJCPerformanceCell.h"
#import "LJCStarRatingView.h"

@interface LJCPerformanceCell()
@property (nonatomic, strong) LJCStarRatingView *ratingView;
@end
@implementation LJCPerformanceCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.ratingView];
    }
    return self;
}

#pragma mark -
- (LJCStarRatingView *)ratingView
{
    if (!_ratingView) {
        _ratingView = [[LJCStarRatingView alloc] initWithFrame:CGRectMake(0, 0, 200, 44)];
        _ratingView.rating = 3.3;
        _ratingView.backgroundColor = [UIColor lightGrayColor];
        _ratingView.placeholderImage = [UIImage imageNamed:@"star_bg"];
        _ratingView.ratedImage = [UIImage imageNamed:@"star_press"];
    }
    return _ratingView;
}

@end
