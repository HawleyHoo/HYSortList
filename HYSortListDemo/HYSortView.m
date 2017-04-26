//
//  HYSortView.m
//  HYSortListDemo
//
//  Created by 胡杨 on 2017/1/6.
//  Copyright © 2017年 net.fitcome.www. All rights reserved.
//

#import "HYSortView.h"

@implementation HYSortView

- (void)updateHeight:(float)height {
    CGRect rect = self.frame;
    rect.size.height = height;
    self.frame = rect;
    
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat height = self.frame.size.height;
    
    UIView *superView = self.superview;
    CGFloat hh = superView.frame.size.height;
    CGFloat hue = height / hh;
    
//    NSLog(@"%f %f %f", height, hh, hue);
    UIColor *color = [UIColor colorWithHue:hue saturation:1 brightness:1 alpha:1];
    self.backgroundColor = color;
    
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
