//
//  HatenaKeywordAppDelegate.h
//  HatenaKeyword
//
//  Created by Takayama Fumio on 10/05/30.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import "TopViewController.h"
#import <UIKit/UIKit.h>

@interface HatenaKeywordAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
	TopViewController *viewController;
	UINavigationController *navController;

}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@end

