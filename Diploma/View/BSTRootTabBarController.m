//
//  BSTRootTabBarController.m
//  Copyright (c) 2015 Maria. All rights reserved.
//

#import "BSTRootTabBarController.h"

#define IS_WIDESCREEN ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )568 ) < DBL_EPSILON )
//#define IS_IPHONE5  ([[UIScreen mainScreen] bounds].size.height == 568)?YES:NO

#define IS_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define IS_RETINA ([[UIScreen mainScreen] scale] >= 2.0)

#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)
#define SCREEN_MAX_LENGTH (MAX(SCREEN_WIDTH, SCREEN_HEIGHT))
#define SCREEN_MIN_LENGTH (MIN(SCREEN_WIDTH, SCREEN_HEIGHT))

#define IS_IPHONE_4_OR_LESS (IS_IPHONE && SCREEN_MAX_LENGTH < 568.0)
#define IS_IPHONE_5 (IS_IPHONE && SCREEN_MAX_LENGTH == 568.0)
#define IS_IPHONE_6 (IS_IPHONE && SCREEN_MAX_LENGTH == 667.0)
#define IS_IPHONE_6P (IS_IPHONE && SCREEN_MAX_LENGTH == 736.0)

@interface BSTRootTabBarController ()

@end


@implementation UIImage (Size)

+ (UIImage *)sizedImageWithName:(NSString *)name {
	UIImage *image;
	if (IS_IPHONE_5) {
		image = [UIImage imageNamed:[NSString stringWithFormat:@"%@-568h",name]];
		if (!image) {
			image = [UIImage imageNamed:name];
		}
	}
	else if (IS_IPHONE_6) {
		image = [UIImage imageNamed:[NSString stringWithFormat:@"%@-750w",name]];
	}
	else {
		image = [UIImage imageNamed:name];
	}
	return image;
}

@end

@implementation BSTRootTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
	
	
	UITabBar *tabBar = self.tabBar;
	UITabBarItem *item0 = tabBar.items[0];
	UITabBarItem *item1 = tabBar.items[1];
	UITabBarItem *item2 = tabBar.items[2];
	UITabBarItem *item3 = tabBar.items[3];
	UITabBarItem *item4 = tabBar.items[4];
	
	[item0 setImage:[[UIImage sizedImageWithName:@"Profile"]  imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
	[item0 setSelectedImage:[[UIImage sizedImageWithName:@"ProfileSelected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
	item0.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0);
	
	[item1 setImage:[[UIImage sizedImageWithName:@"Category"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
	[item1 setSelectedImage:[[UIImage sizedImageWithName:@"CategorySelected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
	item1.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0);
	
	[item2 setImage:[[UIImage sizedImageWithName:@"AddAim"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
	[item2 setSelectedImage:[[UIImage sizedImageWithName:@"AddAimSelected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
	item2.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0);
	
	[item3 setImage:[[UIImage sizedImageWithName:@"Aims"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
	[item3 setSelectedImage:[[UIImage sizedImageWithName:@"AimsSelected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
	item3.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0);
	
	[item4 setImage:[[UIImage sizedImageWithName:@"Achieve"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
	[item4 setSelectedImage:[[UIImage sizedImageWithName:@"AchieveSelected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
	item4.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0);
}

@end
