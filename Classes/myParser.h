//
//  myParser.h
//  HatenaKeyword
//
//  Created by Takayama Fumio on 10/06/01.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface myParser : NSObject <NSXMLParserDelegate>{
	NSXMLParser				*rssParser;
	NSMutableArray			*keywordData;
	NSMutableDictionary		*item;
	
	NSString				*currentElement;
	NSMutableString			*currentTitle, *currentSummary, *currentLink, *currentDate, *currentAuthor, *keywordDetail;	
}

@property (nonatomic, retain) NSMutableDictionary *item;
@property (nonatomic, retain) NSString *currentElement;
@property (nonatomic, retain) NSMutableString *currentTitle, *currentSummary, *currentLink, *currentDate, *currentAuthor, *keywordDetail;
@property (nonatomic, retain) NSMutableArray *keywordData;

-(void)parseXMLFileAtURL:(NSString *)URL;

@end
