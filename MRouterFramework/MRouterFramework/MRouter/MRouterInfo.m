//
//  MRouterInfo.m
//  MRouterFramework
//
//  Created by Micker on 16/8/5.
//  Copyright © 2016年 Micker. All rights reserved.
//

#import "MRouterInfo.h"

@interface MRouterInfo()

@property (nonatomic, strong) NSString    *name;
@property (nonatomic, strong) NSArray     *regexUrls;
@property (nonatomic, strong) NSDictionary *extentions;
@property (nonatomic, assign) NSInteger   index;
@property (nonatomic, assign) Class       handleCls;
@property (nonatomic, assign) Class       handlerCtrlCls;
@property (nonatomic, strong) URLRouterHandlerBlock block;

@end

@implementation MRouterInfo

- (id) initWithName:(NSString *) name
              index:(NSInteger) index
            ctrlCls:(Class ) ctrlCls
          regexUrls:(NSArray *) regexUrls
         extentions:(NSDictionary *) extentions
              block:(URLRouterHandlerBlock) block handleCls:(Class) handleCls {
    
    self = [super init];
    if (self) {
        self.name = name;
        self.regexUrls = regexUrls;
        self.block = [block copy];
        self.handlerCtrlCls = ctrlCls;
        self.index = index;
        self.extentions = extentions;
        [self setValue:((handleCls) ?
                        handleCls :  NSClassFromString(@"MRouterDefaultHandler")) forKey:@"handleCls"];
    }
    return self;
}

+ (instancetype)    router:(NSString *) name
                     index:(NSInteger) index
                   ctrlCls:(Class ) ctrlCls
                 regexUrls:(NSArray *) regexUrls
                extentions:(NSDictionary *) extentions
               handleBlock:(URLRouterHandlerBlock) block {
    
    return [[self alloc] initWithName:name
                                index:index
                              ctrlCls:ctrlCls
                            regexUrls:regexUrls
                           extentions:extentions
                                block:block
                            handleCls:nil];
}

+ (instancetype)    router:(NSString *) name
                     index:(NSInteger) index
                   ctrlCls:(Class ) ctrlCls
                 regexUrls:(NSArray *) regexUrls
                extentions:(NSDictionary *) extentions
                handlerCls:(Class) handleCls {
    
    return [[self alloc] initWithName:name
                                index:index
                              ctrlCls:ctrlCls
                            regexUrls:regexUrls
                           extentions:extentions
                                block:nil
                            handleCls:handleCls];
}

- (NSString *) description {
    return [self debugDescription];
}

- (NSString *) debugDescription {
    return [NSString stringWithFormat:@"名称：%@, 索引：%@, URL: %@;", self.name, @(self.index), self.regexUrls];
}

@end
