//
//  JSNetwork.h
//  家居商城
//
//  Created by john on 6/22/14.
//  Copyright (c) 2014 Banana Technology. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface JSNetwork : NSObject

+ (void)imageForPhoto: (NSDictionary *)photo size: (NSString *)size completion:(void(^)(UIImage *image))completion;

@end

