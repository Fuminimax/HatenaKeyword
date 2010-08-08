//
//  TopViewController.h
//  HatenaKeyword
//
//  Created by Takayama Fumio on 10/05/30.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "myParser.h"
#import "CheckInternetConnection.h"

@class KeywordViewController;

@interface TopViewController : UIViewController <UISearchBarDelegate, UITableViewDelegate, UITableViewDataSource> {
	UISearchBar *searchBar;
	UITableView *topTableView;
	UINavigationController *navController;
	
	NSMutableArray *HotkeywordData;
	myParser *rssParser;
	
}

@property (nonatomic, retain) NSMutableArray *HotkeywordData;
@property (nonatomic, retain) UITableView *topTableView;

@end
