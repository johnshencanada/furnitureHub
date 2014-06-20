//
//  CameraViewController.m
//  家居商城
//
//  Created by john on 6/19/14.
//  Copyright (c) 2014 Banana Technology. All rights reserved.
//

#import "CameraViewController.h"

@interface CameraViewController ()

@end

@implementation CameraViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        UIImage *camera = [UIImage imageNamed:@"camera"];
        UITabBarItem *cameraTab = [[UITabBarItem alloc] initWithTitle:@"camera" image:camera tag:0];
        self.tabBarItem = cameraTab;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"Camera";
}



@end
