//
//  AppDelegate.m
//  家居商城
//
//  Created by john on 6/19/14.
//  Copyright (c) 2014 Banana Technology. All rights reserved.
//

#import "AppDelegate.h"
#import "NavController.h"
#import "CameraViewController.h"
#import "PhotosViewController.h"
#import "UserViewController.h"
#import <SimpleAuth/SimpleAuth.h>

@interface AppDelegate ()
            

@end

@implementation AppDelegate
            

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    SimpleAuth.configuration[@"instagram"] = @{
       @"client_id" : @"d69504e7817041f2a665dd30c39bc387",
       SimpleAuthRedirectURIKey : @"photobombers://auth/instagram"
       };
    

    UITabBarController *tabBarController = [[UITabBarController alloc]init];
    
    CameraViewController * cameraVC = [[CameraViewController alloc]init];
    NavController *cameraNavController = [[NavController alloc]initWithRootViewController:cameraVC];
    PhotosViewController *photosVC = [[PhotosViewController alloc]init];
    NavController *photosNavController = [[NavController alloc]initWithRootViewController:photosVC];
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"b" bundle:nil];
    UserViewController * usersVC = [sb instantiateViewControllerWithIdentifier:@"SignInView"];
    NavController *usersNavController = [[NavController alloc]initWithRootViewController:usersVC];

    NSArray *controllers = [NSArray arrayWithObjects:cameraNavController, photosNavController, usersNavController, nil];
    tabBarController.viewControllers = controllers;

    self.window.rootViewController = tabBarController;
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
