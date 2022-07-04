//
//  ViewController.m
//  testRouter
//
//  Created by Micker on 16/8/11.
//  Copyright © 2016年 Micker. All rights reserved.
//

#import "ViewController.h"
#import "MRouter.h"
#import "NSString+Router_URLEncoding.h"


@implementation MArticleBottomView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self.layer addSublayer:self.shareLayer];
    }
    return self;
}

- (CALayer *) shareLayer{
    if (!_shareLayer) {
        _shareLayer = [CALayer new];
        
        _shareLayer.backgroundColor = [UIColor redColor].CGColor;
    }
    return _shareLayer;
}

- (CGFloat) configSubviews {
    NSUInteger count = self.collectButtons.count;
    CGFloat width = CGRectGetWidth(self.bounds);
    CGFloat startX = width - 100 * count - 10;
    CGFloat startY = 20;
    for (int i = 0; i < count; i++) {
        UIButton *button = [self.collectButtons objectAtIndex:i];
        [button setFrame:CGRectMake(startX, startY, 100, 35)];
    }
    
    startY += count > 0 ? (35 + 20) : 0;
    
    self.shareLayer.frame = CGRectMake((width - 140)/2, startY, 140, 30);
    
    startY += 20;
    count = self.shareButtons.count;
    startX = CGRectGetWidth(self.bounds) - 60 * count - 10;
    for (int i = 0; i < count; i++) {
        UIButton *button = [self.collectButtons objectAtIndex:i];
        [button setFrame:CGRectMake(startX, startY, 100, 35)];
    }
    return startY += 45 +20;
}
 
- (void)layoutSubviews {
    [super layoutSubviews];
    [self configSubviews];
}

- (UIButton *) configLikeButton:(NSString *) title {
    UIButton *button = [UIButton new];
    [button setTitle:title forState:UIControlStateNormal];
    return button;
}


- (UIButton *) configShareButton:(NSString *) image {
    UIButton *button = [UIButton new];
    [button setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    return button;
}

@end

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[MRouter sharedRouter] enableDebug];
    
    self.title = NSStringFromClass([self class]);
    MArticleBottomView *abView = [MArticleBottomView new];
    
    UIButton *buttonC = [abView configLikeButton:@"喜欢"];
    [buttonC addTarget:self action:@selector(collectButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *buttonL = [abView configLikeButton:@"不感兴趣"];
    [buttonL addTarget:self action:@selector(likeButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    abView.shareButtons = @[buttonC,buttonL];
    
    UIButton *buttonP = [abView configShareButton:@"nwpengyouquan"];
    buttonP.tag = 20201026;
    [buttonP addTarget:self action:@selector(shareButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *buttonW = [abView configShareButton:@"nwwechat"];
    buttonW.tag = 20201026+1;
    [buttonW addTarget:self action:@selector(shareButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *buttonS = [abView configShareButton:@"nwweibo"];
    buttonS.tag = 20201026+2;
    [buttonS addTarget:self action:@selector(shareButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    abView.shareButtons = @[buttonP,buttonW,buttonS];
    
    [[MRouter sharedRouter] start];
    NSLog(@"%@", [MRouter sharedRouter]);
    
    
    {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(100, 100, 100, 100);
        [button setTitle:@"httpsaaa://" forState:UIControlStateNormal];
        [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
    }
    {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:@"vip域名替换" forState:UIControlStateNormal];
        [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        button.frame = CGRectMake(100, 200, 100, 100);
        [button addTarget:self action:@selector(buttonAction1:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
    }
    
    {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:@"singleA" forState:UIControlStateNormal];
//        [button setTitle:@"本地域名替换" forState:UIControlStateNormal];
        [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        button.frame = CGRectMake(100, 300, 100, 100);
        [button addTarget:self action:@selector(buttonAction2:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
    }
    
    {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:@"itunes.apple.com" forState:UIControlStateNormal];
        [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        button.frame = CGRectMake(100, 400, 100, 100);
        [button addTarget:self action:@selector(buttonAction3:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
    }
    
    {
        BOOL result = [@"192.168.009.11" isIPAddress];
        
        NSLog(@"result = %@",@(result));
    }
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)buttonAction:(id)sender {
//    [[MRouter sharedRouter] handleURL:[NSURL URLWithString:@"http://micker.cn"] userInfo:nil];
    [[MRouter sharedRouter] handleURL:[NSURL URLWithString:@"httpsaaa://wallstreetcn.com/member/channel/gold/privilege?channel_type=gold-global&index=1"] userInfo:nil];
}


- (IBAction)buttonAction1:(id)sender {
//    [[MRouter sharedRouter] handleURL:[NSURL URLWithString:@"http://micker.cn"] userInfo:nil];
    [[MRouter sharedRouter] handleURL:[NSURL URLWithString:@"httpsaaa://vip.jianshiapp.com/member/channel/gold/privilege?channel_type=gold-global&index=1"] userInfo:nil];
}


- (IBAction)buttonAction2:(id)sender {
    [[MRouter sharedRouter] handleURL:[NSURL URLWithString:@""] userInfo:@{@"single":@(YES)}];
//    [[MRouter sharedRouter] handleURL:[NSURL URLWithString:@"http://micker.cna"] userInfo:@{@"single":@(YES)}];
//    [[MRouter sharedRouter] handleURL:[NSURL URLWithString:@"httpsaaa://192.168.0.111:8080/member/channel/gold/privilege?channel_type=gold-global&index=1"] userInfo:nil];
}

- (IBAction)buttonAction3:(id)sender {
//    [[MRouter sharedRouter] handleURL:[NSURL URLWithString:@"http://micker.cnb"] userInfo:nil];
//    [[MRouter sharedRouter] handleURL:[NSURL URLWithString:@"httpsaaa://192.168.0.111:8080/member/channel/gold/privilege?channel_type=gold-global&index=1"] userInfo:nil];
    
    NSString *url = @"https://itunes.apple.com/cn/app/ping-an-zi-zhu-kai-hu/id871659147?mt=8";
    [[MRouter sharedRouter] handleURL:[NSURL URLWithString:url] userInfo:@{@"single":@(YES)}];
}
@end


@implementation AViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
}
@end


@implementation BViewController

@end
