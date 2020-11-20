//
//  ViewController.h
//  testRouter
//
//  Created by Micker on 16/8/11.
//  Copyright © 2016年 Micker. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MArticleBottomView : UIView

@property (nonatomic, strong) NSArray *collectButtons;
@property (nonatomic, strong) CALayer *shareLayer;
@property (nonatomic, strong) NSArray *shareButtons;

- (CGFloat) configSubviews;

@end


@interface ViewController : UIViewController


@end

