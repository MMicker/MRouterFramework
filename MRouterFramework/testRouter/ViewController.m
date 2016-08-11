//
//  ViewController.m
//  testRouter
//
//  Created by Micker on 16/8/11.
//  Copyright © 2016年 Micker. All rights reserved.
//

#import "ViewController.h"
#import "MRouter.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[MRouter sharedRouter] start];
    NSLog(@"%@", [MRouter sharedRouter]);
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
