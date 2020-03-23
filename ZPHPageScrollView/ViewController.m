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
    
    ZPHPageModel *model1 = [[ZPHPageModel alloc]init];
    model1.backColor = [UIColor yellowColor];
    model1.text = @"1";
    
    ZPHPageModel *model2 = [[ZPHPageModel alloc]init];
    model2.backColor = [UIColor redColor];
    model2.text = @"2";
    
    ZPHPageModel *model3 = [[ZPHPageModel alloc]init];
    model3.backColor = [UIColor blueColor];
    model3.text = @"3";
    
    _pageScrollView = [[ZPHPageScrollView alloc]initWithFrame:CGRectMake(0, 20, self.view.frame.size.width, 200) List:@[model1, model2, model3]];
    [self.view addSubview:_pageScrollView];
}


@end
