//
//  LJCPerformanceViewController.m
//  LJCStarRatingView
//
//  Created by 林锦超 on 2019/3/12.
//  Copyright © 2019 林锦超. All rights reserved.
//

#import "LJCPerformanceViewController.h"
#import "LJCPerformanceCell.h"

@interface LJCPerformanceViewController ()

@end

@implementation LJCPerformanceViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self.tableView registerClass:[LJCPerformanceCell class] forCellReuseIdentifier:@"cell"];
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
}

@end
