//
//  MRouter.m
//  MRouterFramework
//
//  Created by Micker on 16/8/5.
//  Copyright © 2016年 Micker. All rights reserved.
//

#import "MRouter.h"
#import <UIKit/UIKit.h>
#import <objc/runtime.h>
#import "MRouterInfo.h"
#import "MRouterInfo+Router.h"
#import "MRouterInfo+DefaultHandler.h"

static BOOL G_URL_RESOLVER_DEBUG = NO;

@interface MRouter()

@property (nonatomic, strong) NSMutableArray *resolvers;
@property (nonatomic, strong) MRouterInfo    *defaultRouter;

@end

@implementation MRouter

- (BOOL) handleURL:(NSURL *) url {
    return NO;
}

+ (instancetype) sharedRouter {
    static MRouter *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[MRouter alloc] init];
    });
    return instance;
}

- (id) init {
    self = [super init];
    if (self) {
        self.resolvers = [NSMutableArray arrayWithCapacity:20];
    }
    return self;
}

- (id) start {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self __internalStart];
    });

    return self;
}

- (id) __internalStart {
    //read from plist file
    NSString *URLRouterDataPath = [[NSBundle mainBundle]  pathForResource:@"url_resolver" ofType:@"plist"];
    NSDictionary *dictionary = [NSDictionary dictionaryWithContentsOfFile:URLRouterDataPath];
    [self registerURLRouters:dictionary];
    
    unsigned int count;
    Method *methods = class_copyMethodList([self class], &count);
    for (int i = 0; i < count; i++) {
        Method method = methods[i];
        SEL selector = method_getName(method);
        NSString *name = NSStringFromSelector(selector);
        if ([name hasPrefix:@"registerRouter_"]) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
            [self performSelector:selector withObject:nil];
#pragma clang diagnostic pop
            
        }
    }
    
    free(methods);
    return self;
}

- (id) enableDebug {
    G_URL_RESOLVER_DEBUG = YES;
    return self;
}

- (void) registerURLRouter:(MRouterInfo *) info {
    @synchronized(self) {
        static NSUInteger _index = 0;
        __block NSInteger index = -1;
        [self.resolvers enumerateObjectsUsingBlock:^( MRouterInfo *infoTmp, NSUInteger idx, BOOL * _Nonnull stop) {
        
            if (info.index > infoTmp.index ) {
                index = idx;
                *stop = YES;
            }
        }];
        if (-1 != index) {
            [self.resolvers insertObject:info atIndex:index];
        } else {
            [self.resolvers addObject:info];
        }
        if(info.isDefault) {
            self.defaultRouter = info;
        }
        if (G_URL_RESOLVER_DEBUG) {
            NSLog(@"正在注册路由 [%2lu]:%@",(unsigned long)_index++, info.name);
        }
    }
}

- (void) registerURLRouters:(NSDictionary *) resolvers {
    NSArray *object_list = resolvers[@"object_list"];
    [object_list enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSDictionary *dic = (NSDictionary *) obj;
        NSString *resolverName = dic[@"resolver"];
        NSString *controlName = dic[@"class"];
        NSString *objectName = dic[@"name"];
        NSDictionary *extentions = dic[@"ext"];
        NSInteger index = dic[@"index"] ? [dic[@"index"] integerValue]: 100;
        NSArray *regexes = nil;
        
        id object = dic[@"exact_url"];
        if ([object isKindOfClass:[NSString class]]) {
            regexes = [NSArray arrayWithObject:object];
        } else if ([object isKindOfClass:[NSArray class]]) {
            regexes = object;
        }
        
        if ([controlName hasPrefix:@"#"]) {
            resolverName = @"MRouterDefaultHandler";
            controlName = [controlName substringFromIndex:1];
        }
        MRouterInfo *info = [MRouterInfo    router:objectName
                                             index:index
                                           ctrlCls:NSClassFromString(controlName)?:NULL
                                         regexUrls:regexes
                                        extentions:extentions
                                        handlerCls:NSClassFromString(resolverName)?:NULL];
        info.defaultRouter = [info defaultRouterValue];;
        [self registerURLRouter:info];
    }];
}

- (void) unRegisterURLRouter:(NSString *) name {
    @synchronized(self){
        __block MRouterInfo *info = nil;
        [self.resolvers enumerateObjectsUsingBlock:^(MRouterInfo * infoTmp, NSUInteger idx, BOOL * _Nonnull stop) {

            if ([name isEqualToString:infoTmp.name]) {
                info = infoTmp;
                *stop = YES;
            }
        }];
        if (info) {
            [self.resolvers removeObject:info];
        }
    }
}

- (void) unRegisterURLs:(NSArray *) urls {
    @synchronized(self){

        __block MRouterInfo * info = nil;
        [urls enumerateObjectsUsingBlock:^(NSString *url, NSUInteger idx, BOOL * _Nonnull stop) {
            [self.resolvers enumerateObjectsUsingBlock:^(MRouterInfo * infoTmp, NSUInteger idx, BOOL * _Nonnull stop) {
                if ([infoTmp deleteURL:url]) {
                    info = infoTmp;
                };
            }];
        }];
    }
}

- (MRouterInfo *) resolverInfoWithName:(NSString *) name {
    @synchronized(self){
        __block MRouterInfo *info = nil;
        [self.resolvers enumerateObjectsUsingBlock:^(MRouterInfo *infoTmp , NSUInteger idx, BOOL * _Nonnull stop) {
            if ([name isEqualToString:infoTmp.name]) {
                info = infoTmp;
                *stop = YES;
            }
        }];
        return info;
    }
}

- (BOOL) handleURL:(NSURL *) url userInfo:(id) userInfo useDefault:(BOOL) flag {
    [self start];
    __block MRouterLink *link = nil;
    __block MRouterInfo *routerInfo = nil;
    NSURL *resultURL = url;
    [self.resolvers enumerateObjectsUsingBlock:^(MRouterInfo *infoTmp , NSUInteger idx, BOOL * _Nonnull stop) {
        link = [infoTmp handleURL:resultURL userInfo:userInfo direct:NO];
        routerInfo = infoTmp;
        *stop = link?YES:NO;
    }];
    
    //处理默认请求
    if (!link && flag && self.defaultRouter) {
        routerInfo = self.defaultRouter;
        resultURL = self.routerHandler ? self.routerHandler(url) : url;
        link = [routerInfo handleURL:resultURL userInfo:userInfo direct:YES];
    }
    
    if (link && G_URL_RESOLVER_DEBUG) {
        NSLog(@"Match the router with origin url :%@ || %@", url, routerInfo);
    }
    return link?YES:NO;
}

- (BOOL) handleURL:(NSURL *) url userInfo:(id) userInfo {
    return [self handleURL:url userInfo:userInfo useDefault:YES];
}

- (NSString *) description {
    return [self debugDescription];
}

- (NSString *) debugDescription {
    NSMutableString *result = [NSMutableString string];
    [self.resolvers enumerateObjectsUsingBlock:^(MRouterInfo *infoTmp, NSUInteger idx, BOOL * _Nonnull stop) {
        [result appendFormat:@"\n%@", infoTmp];
    }];
    return result;
}


@end
