//
//  CheckInternetConnection.h
//  HatenaKeyword
//
//  Created by Takayama Fumio on 10/08/02.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SystemConfiguration/SystemConfiguration.h>

@interface CheckInternetConnection : NSObject {
	
}

-(SCNetworkReachabilityFlags) connectedToNetwork;

@end
