//
//  KeywordViewController.h
//  HatenaKeyword
//
//  Created by Takayama Fumio on 10/07/05.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class myParser;

@interface KeywordViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>{
	NSString *selectedKeyword;
	
	UITableView *keywordTableView;
	UIToolbar *toolBar;
	
	myParser *bloglistParser;
}

@property (nonatomic, retain) NSString *selectedKeyword;

//-(void) showKeywordDetail;

@end
