//
//  ExploreCollectionViewController.m
//  家居商城
//
//  Created by john on 6/20/14.
//  Copyright (c) 2014 Banana Technology. All rights reserved.
//

#import "ExploreCollectionViewController.h"
#import "PhotoCell.h"
#import <SimpleAuth/SimpleAuth.h>

@interface ExploreCollectionViewController ()
@property (nonatomic) NSString *accessToken;
@property (nonatomic) NSArray *photos;
@end

@implementation ExploreCollectionViewController

static NSString * const reuseIdentifier = @"Cell";

- (instancetype)init
{

    UIImage *photo = [UIImage imageNamed:@"explore"];
    UITabBarItem *photoTab = [[UITabBarItem alloc] initWithTitle:@"Explore" image:photo tag:0];
    self.tabBarItem = photoTab;
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.itemSize = CGSizeMake(106, 106);
    layout.minimumInteritemSpacing = 1.0;
    layout.minimumLineSpacing = 1.0;
    self = [super initWithCollectionViewLayout:layout];
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"Explore";
    
    [self.collectionView registerClass:[PhotoCell class] forCellWithReuseIdentifier:@"photo"];
    self.collectionView.backgroundColor = [UIColor blackColor];
    
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    self.accessToken = [userDefault objectForKey:@"accessToken"];
    
    if (self.accessToken == nil) {
        NSLog(@"nil access token");
        
    } else {
        [self refresh];
    }
}

- (void) refresh
{
    NSLog(@"Signed in!");
    NSURLSession *session = [NSURLSession sharedSession];
    NSString *urlString = [[NSString alloc]initWithFormat:@"https://api.instagram.com/v1/tags/livingroom/media/recent?access_token=%@",self.accessToken];
    NSURL *url = [[NSURL alloc]initWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSURLSessionDownloadTask *task = [session downloadTaskWithRequest:request completionHandler:^(NSURL *location, NSURLResponse *response, NSError *error) {
        
        NSData *data = [[NSData alloc]initWithContentsOfURL:location];
        NSDictionary *responseDictionary = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
        self.photos = [responseDictionary valueForKeyPath:@"data"];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.collectionView reloadData];
        });
    }];
    [task resume];
}


#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.photos count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    PhotoCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"photo" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    [cell setSize:@"thumbnail"];
    [cell setPhoto:self.photos[indexPath.row]];
    return cell;
}

#pragma mark <UICollectionViewDelegate>

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath
{
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath
{
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender
{
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender
{
	
}
*/

@end
