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
@property (strong, nonatomic) IBOutlet UILabel *mediaLabel;
@property (strong, nonatomic) IBOutlet UILabel *followersLabel;
@property (strong, nonatomic) IBOutlet UILabel *followingLabel;
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;

@end

@implementation UserViewController

-(void)awakeFromNib
{
    UIImage *friends = [UIImage imageNamed:@"friends"];
    UITabBarItem *friendsTab = [[UITabBarItem alloc] initWithTitle:@"Users" image:friends tag:2];
    friendsTab.badgeValue = [NSString stringWithFormat:@"0"];;
    self.tabBarItem = friendsTab;
    
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
    
//            //[self setMedia:[counts valueForKey:@"media"]];
//            NSString *following = [counts valueForKey:@"follows"];
//            NSString *followers = [counts valueForKey:@"followed_by"];
//            NSArray *user_info = [responseObject valueForKey:@"user_info"];
//            NSURL *profile = [user_info valueForKey:@"image"];
//            NSString *name = [user_info valueForKey:@"name"];
//            NSString *userName = [user_info valueForKey:@"username"];
//            self.title = userName;

//            [userDefault setObject:responseObject[@"credentials"][@"token"] forKey:@"accessToken"];
//            [userDefault synchronize];
        }];
    } else {
        NSLog(@"Signed in!");
    }
    
}

@end
