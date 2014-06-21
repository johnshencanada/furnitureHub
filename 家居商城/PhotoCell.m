//
//  PhotoCell.m
//  家居商城
//
//  Created by john on 6/19/14.
//  Copyright (c) 2014 Banana Technology. All rights reserved.
//

#import "PhotoCell.h"
#import <SAMCache/SAMCache.h>

@implementation PhotoCell


- (void)setPhoto:(NSDictionary *)photo
{
    _photo = photo;
    NSURL *url = [[NSURL alloc]initWithString:_photo[@"images"][@"standard_resolution"][@"url"]];
    [self downloadPhotoWithURL:url];
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

- (void)downloadPhotoWithURL:(NSURL *)url
{
    NSString *key = [[NSString alloc]initWithFormat:@"%@-standard", self.photo[@"id"]];
    UIImage *photo = [[SAMCache sharedCache]imageForKey:key];
    if (photo) {
        self.imageView.image = photo;
    }
    else {
        NSURLSession *session = [NSURLSession sharedSession];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        NSURLSessionDownloadTask *task = [session downloadTaskWithRequest:request completionHandler:^(NSURL *location, NSURLResponse *response, NSError *error) {
            NSData *data = [[NSData alloc]initWithContentsOfURL:location];
            UIImage *image = [[UIImage alloc]initWithData:data];
            [[SAMCache sharedCache] setImage:image forKey:key];
            dispatch_async(dispatch_get_main_queue(), ^{
                self.imageView.image = image;
            });
        }];
        [task resume];
    }
}

@end
