//
//  CheckInternetConnection.m
//  HatenaKeyword
//
//  Created by Takayama Fumio on 10/08/02.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//


#import <sys/socket.h>
#import <netinet/in.h>
#import <netinet6/in6.h>
#import <arpa/inet.h>
#import <ifaddrs.h>

#import "CheckInternetConnection.h"

@implementation CheckInternetConnection

-(SCNetworkReachabilityFlags)connectedToNetwork{
	struct sockaddr_in zeroAddress;
	bzero(&zeroAddress, sizeof(zeroAddress));
	zeroAddress.sin_len = sizeof(zeroAddress);
	zeroAddress.sin_family = AF_INET;
	
	SCNetworkReachabilityRef routeReachability = SCNetworkReachabilityCreateWithName(NULL, [@"d.hatena.ne.jp" UTF8String]);
	SCNetworkReachabilityFlags flags;
	
	SCNetworkReachabilityGetFlags(routeReachability, &flags);
	
	return flags;
}

@end
