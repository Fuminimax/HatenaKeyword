//
//  WebViewController.h
//  HatenaKeyword
//
//  Created by Takayama Fumio on 10/07/18.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface WebViewController : UIViewController {
	NSString	*hatenaUrl;
	UIWebView	*webView;
}

@property (nonatomic, retain) UIWebView *webView;
@property (nonatomic, retain) NSString	*hatenaUrl;

@end
