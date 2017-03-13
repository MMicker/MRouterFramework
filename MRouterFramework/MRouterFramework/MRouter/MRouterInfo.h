//
//  MRouterInfo.h
//  MRouterFramework
//
//  Created by Micker on 16/8/5.
//  Copyright © 2016年 Micker. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class MRouterInfo;
@class MRouterLink;

typedef BOOL (^URLRouterHandlerBlock)(MRouterInfo *info, MRouterLink *link);

@interface MRouterInfo : NSObject

@property (nonatomic, strong, readonly) NSString    *name;
@property (nonatomic, strong, readwrite) NSArray     *regexUrls;
@property (nonatomic, strong, readonly) NSDictionary *extentions;
@property (nonatomic, assign, readonly) NSInteger   index;
@property (nonatomic, assign, readonly) Class       handleCls;
@property (nonatomic, assign, readonly) Class       handlerCtrlCls;
@property (nonatomic, strong, readonly) URLRouterHandlerBlock block;

+ (instancetype)    router:(NSString *) name
                     index:(NSInteger) index
                   ctrlCls:(Class ) ctrlCls
                 regexUrls:(NSArray *) regexUrls
                extentions:(NSDictionary *) extentions
               handleBlock:(URLRouterHandlerBlock) block;

+ (instancetype)    router:(NSString *) name
                     index:(NSInteger) index
                   ctrlCls:(Class ) ctrlCls
                 regexUrls:(NSArray *) regexUrls
                extentions:(NSDictionary *) extentions
                handlerCls:(Class) handleCls;


- (BOOL) deleteURL:(NSString *)url;

@end
