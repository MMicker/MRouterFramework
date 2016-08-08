//
//  IRouterLink.h
//  MRouterFramework
//
//  Created by Micker on 16/8/5.
//  Copyright © 2016年 Micker. All rights reserved.
//


#ifndef IRouterLink_h
#define IRouterLink_h

@class MRouterLink;

@protocol IRouterLink <NSObject>

- (void) handleRouterLink:(MRouterLink *) link;

@end

#endif /* IRouterLink_h */
