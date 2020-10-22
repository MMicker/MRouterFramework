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

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
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
        [button setTitle:@"本地域名替换" forState:UIControlStateNormal];
        [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        button.frame = CGRectMake(100, 300, 100, 100);
        [button addTarget:self action:@selector(buttonAction2:) forControlEvents:UIControlEventTouchUpInside];
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
//    [[MRouter sharedRouter] handleURL:[NSURL URLWithString:@"http://micker.cn"] userInfo:nil];
    [[MRouter sharedRouter] handleURL:[NSURL URLWithString:@"httpsaaa://192.168.0.111:8080/member/channel/gold/privilege?channel_type=gold-global&index=1"] userInfo:nil];
}
@end
