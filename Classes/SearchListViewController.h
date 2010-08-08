//
//  SearchListViewController.h
//  HatenaKeyword
//
//  Created by Takayama Fumio on 10/07/18.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "myParser.h"

@interface SearchListViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>{
	
	NSString *searchWord;
	
	UITableView *searchListTableView;
	
	myParser *searchListParser;
}

-(void) modSearchCell:(UITableViewCell *)aCell withTitle:(NSString *)title withSummary:(NSString *)summary;

@property (nonatomic, retain) NSString *searchWord;

@end
