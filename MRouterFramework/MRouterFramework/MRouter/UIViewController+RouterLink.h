//
//  UIViewController+RouterLink.h
//  MRouterFramework
//
//  Created by Micker on 16/8/5.
//  Copyright © 2016年 Micker. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IRouterLink.h"

@interface UIViewController (RouterLink) <IRouterLink>

@end


@interface UIViewController (MatchedURL)

/**
 匹配上的路由
 */
@property (nonatomic, copy) NSString  *matchedURL;

@end
