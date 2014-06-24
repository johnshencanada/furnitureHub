//
//  DetailViewController.m
//  家居商城
//
//  Created by john on 6/22/14.
//  Copyright (c) 2014 Banana Technology. All rights reserved.
//

#import "JSNetwork.h"
#import "DetailViewController.h"

@interface DetailViewController ()
@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property (nonatomic) UIScrollView *scrollView;
@property (nonatomic) UIDynamicAnimator *animator;
@end

@implementation DetailViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.view.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.95];
    [JSNetwork imageForPhoto:self.photo size:@"standard_resolution" completion:^(UIImage *image) {
        self.imageView.image = image;
    }];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.scrollView = [[UIScrollView alloc]initWithFrame:self.view.frame];
    self.scrollView.contentSize = self.imageView? self.imageView.image.size : CGSizeZero;
    self.imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0.0, -320.0, 320.0f, 320.0f)];
    [self.scrollView addSubview:self.imageView];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(close)];
    tap.numberOfTapsRequired = 1;
    [self.scrollView addGestureRecognizer:tap];
    [self.view addSubview:self.scrollView];
    self.animator = [[UIDynamicAnimator alloc]initWithReferenceView:self.view];
    UISnapBehavior *snap = [[UISnapBehavior alloc]initWithItem:self.imageView snapToPoint:self.view.center];
    [self.animator addBehavior:snap];
}

- (void)close
{
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
