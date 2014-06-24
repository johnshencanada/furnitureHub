//
//  PhotoCell.m
//  家居商城
//
//  Created by john on 6/19/14.
//  Copyright (c) 2014 Banana Technology. All rights reserved.
//

#import "PhotoCell.h"
#import "JSNetwork.h"

@implementation PhotoCell

- (void)setSize:(NSString *)size
{
    _size = size;
}

- (void)setPhoto:(NSDictionary *)photo
{
    _photo = photo;
    if ([self.size isEqualToString:@"thumbnail"]) {
        [JSNetwork imageForPhoto:_photo size:@"thumbnail" completion:^(UIImage *image) {
            self.imageView.image = image;
            NSLog(@"thumbnail");
        }];
    }
    
    else if ([self.size isEqualToString:@"low_resolution"]) {
        [JSNetwork imageForPhoto:_photo size:@"low_resolution" completion:^(UIImage *image) {
            self.imageView.image = image;
            NSLog(@"low");
        }];
    }
    
    else {
        [JSNetwork imageForPhoto:_photo size:@"standard_resolution" completion:^(UIImage *image) {
            self.imageView.image = image;
            NSLog(@"standard");
        }];
    }
}


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
