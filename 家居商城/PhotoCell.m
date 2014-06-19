//
//  PhotoCell.m
//  家居商城
//
//  Created by john on 6/19/14.
//  Copyright (c) 2014 Banana Technology. All rights reserved.
//

#import "PhotoCell.h"

@implementation PhotoCell

- (instancetype)initWithFrame:(CGRect)frameRect
{
    self = [super initWithFrame:frameRect];
    if (self) {
        self.imageView = [[UIImageView alloc]init];
        [self.contentView addSubview:self.imageView];
        self.imageView.image = [UIImage imageNamed:@"House"];
    }
    return self;
}

- (void) layoutSubviews
{
    [super layoutSubviews];
    self.imageView.frame = self.contentView.bounds;
    
}

@end
