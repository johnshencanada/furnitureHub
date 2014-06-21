//
//  UserViewController.m
//  家居商城
//
//  Created by john on 6/19/14.
//  Copyright (c) 2014 Banana Technology. All rights reserved.
//

#import "UserViewController.h"
#import <SimpleAuth/SimpleAuth.h>

@interface UserViewController()

@property (nonatomic) NSString *accessToken;
@property (strong, nonatomic) IBOutlet UIImageView *profilePicture;
@property (nonatomic) NSString *profileURL;
@property (strong, nonatomic) IBOutlet UIButton *mediaButton;
@property (strong, nonatomic) NSString  *media;
@property (strong, nonatomic) IBOutlet UIButton *followersButton;
@property (strong, nonatomic) NSString  *followers;
@property (strong, nonatomic) IBOutlet UIButton *followingButton;
@property (strong, nonatomic) NSString  *following;
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) NSString  *name;

@end

@implementation UserViewController

-(void)awakeFromNib
{
    UIImage *friends = [UIImage imageNamed:@"friends"];
    UITabBarItem *friendsTab = [[UITabBarItem alloc] initWithTitle:@"Users" image:friends tag:2];
    friendsTab.badgeValue = [NSString stringWithFormat:@"0"];;
    self.tabBarItem = friendsTab;
    
}

- (void)setMedia:(NSString *)media
{
    _media = media;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"Users";
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    self.accessToken = [userDefault objectForKey:@"accessToken"];

    if (self.accessToken == nil) {

        [SimpleAuth authorize:@"instagram" completion:^(NSDictionary *responseObject, NSError *error) {
            
            NSArray *rawInfo = [responseObject valueForKey:@"raw_info"];
            NSArray *data = [rawInfo valueForKey:@"data"];
            NSArray *counts = [data valueForKey:@"counts"];
    
            [self setMedia:[counts valueForKey:@"media"]];
            [userDefault setObject:responseObject[@"credentials"][@"token"] forKey:@"accessToken"];
            [userDefault synchronize];

            NSArray *user_info = [responseObject valueForKey:@"user_info"];
            NSString *userName = [user_info valueForKey:@"username"];
            self.title = userName;
            
            self.profileURL = [NSString stringWithFormat:@"%@",[user_info valueForKey:@"image"]];
            self.following = [counts valueForKey:@"follows"];
            self.followers = [counts valueForKey:@"followed_by"];
            self.name = [user_info valueForKey:@"name"];
        }];
        
        /* download profile picture */
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 100, 100)];
        imageView.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:self.profileURL]]];
        
    } else {
        NSLog(@"Signed in!");
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 100, 100)];
        imageView.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:self.profileURL]]];
        [self.view addSubview:imageView];


    }
}

@end
