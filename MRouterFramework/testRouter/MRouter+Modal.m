//
//   _      ________________ 
//  | | /| / / ___/ ___/ __ \
//  | |/ |/ (__  ) /__/ / / /
//  |__/|__/____/\___/_/ /_/ 
//
//  Created by micker on 2017/1/12.
//  Copyright (c) 2017年 Micker. All rights reserved.
//

#import "MRouter+Modal.h"

@implementation MRouter (Modal)

- (void) registerRouter_Modal {

    [self registerURLRouter:[MRouterInfo router:@"Modal"
                                          index:100
                                        ctrlCls:NSClassFromString(@"ViewController")
                                      regexUrls:@[@"http://micker.cn",@"wscn/login"]
                                     extentions:@{@"modal":@(YES),@"single":@(YES)}
                                     handlerCls:nil]];
    
    
    [self registerURLRouter:[MRouterInfo router:@"Modal"
                                          index:100
                                        ctrlCls:NSClassFromString(@"AViewController")
                                      regexUrls:@[@"http://micker.cna",@"wscn/login"]
                                     extentions:@{@"modal":@(YES),@"needLogin":@(YES)}
                                     handlerCls:nil]];
    
    
    [self registerURLRouter:[MRouterInfo router:@"Modal"
                                          index:100
                                        ctrlCls:NSClassFromString(@"BViewController")
                                      regexUrls:@[@"http://micker.cnb",@"wscn/login"]
                                     extentions:@{@"single":@(YES)}
                                     handlerCls:nil]];
    
    
    MRouterInfo *infor = [MRouterInfo router:@"MVIPSub"
                                       index:100
                                     ctrlCls:NULL
                                   regexUrls:@[@"https://wallstreetcn.com/member/channel/gold/privilege"]
                                  extentions:nil
                                 handleBlock:^BOOL(MRouterInfo *info, MRouterLink *link)
    {
        NSLog(@"link = %@", link.URL);
//       [[MRouter sharedRouter] handleURL:[NSURL URLWithString:@"https://wallstreetcn.com/member/gold"] userInfo:link.userInfo];
//       [[NSNotificationCenter defaultCenter] postNotificationName:@"MVIPSUBITEMNOTIFICATION" object:link.URL];
       return YES;
    }];
    
    [self registerURLRouter:infor];
    
    

}

@end
