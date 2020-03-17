//
//  ViewController.m
//  ZPHPageScrollView
//
//  Created by zph on 2020/3/17.
//  Copyright © 2020 张鹏辉. All rights reserved.
//

#import "ViewController.h"
#import "ZPHPageScrollView.h"

@interface ViewController ()
@property (nonatomic,strong) ZPHPageScrollView *pageScrollView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor yellowColor];
    
    _pageScrollView = [[ZPHPageScrollView alloc]initWithFrame:CGRectMake(0, 20, self.view.frame.size.width, 200)];
    [self.view addSubview:_pageScrollView];
}


@end
