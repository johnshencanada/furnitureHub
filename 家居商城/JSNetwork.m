//
//  JSNetwork.m
//  家居商城
//
//  Created by john on 6/22/14.
//  Copyright (c) 2014 Banana Technology. All rights reserved.
//

#import "JSNetwork.h"
#import <SAMCache/SAMCache.h>
@implementation JSNetwork

+ (void)imageForPhoto: (NSDictionary *)photo size: (NSString *)size completion:(void(^)(UIImage *image))completion
{
    
    if (photo == nil || size == nil || completion == nil) {
        return;
    }
    
    NSString *key = [[NSString alloc]initWithFormat:@"%@-standard-%@", photo[@"id"], size];
    UIImage *image = [[SAMCache sharedCache]imageForKey:key];
    if (image) {
        completion(image);
    }
    else {
        NSURLSession *session = [NSURLSession sharedSession];
        NSURL *url = [[NSURL alloc]initWithString:photo[@"images"][size][@"url"]];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        NSURLSessionDownloadTask *task = [session downloadTaskWithRequest:request completionHandler:^(NSURL *location, NSURLResponse *response, NSError *error) {
            NSData *data = [[NSData alloc]initWithContentsOfURL:location];
            UIImage *image = [[UIImage alloc]initWithData:data];
            [[SAMCache sharedCache] setImage:image forKey:key];
            dispatch_async(dispatch_get_main_queue(), ^{
                completion(image);
            });
        }];
        [task resume];
    }
}

@end
