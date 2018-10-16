//
//  MRouterLink+UserInfo.h
//  MRouterFramework
//
//  Created by Micker on 16/8/22.
//  Copyright © 2016年 Micker. All rights reserved.
//

#import "MRouterLink.h"

@interface MRouterLink (UserInfo)

/**
 附带的用户信息
 */
@property (nonatomic, strong) id userInfo;


/**
 匹配上的路由
 */
@property (nonatomic, copy) NSString  *matchedURL;

@end
