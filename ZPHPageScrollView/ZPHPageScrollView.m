//
//  ZPHPageScrollView.m
//  ZPHPageScrollView
//
//  Created by zph on 2020/3/17.
//  Copyright © 2020 张鹏辉. All rights reserved.
//

#import "ZPHPageScrollView.h"

@interface ZPHPageScrollView ()<UIScrollViewDelegate>

@property (nonatomic,strong) UIScrollView *scrollView;
/// 指示器
@property (nonatomic,strong) UIPageControl *pageControl;
/// 定时器
@property (nonatomic,strong) NSTimer *timer;
/// 数据
@property (nonatomic,strong) NSMutableArray *list;
@end

@implementation ZPHPageScrollView

-(instancetype)init {
    
    if (self = [super init]) {
        
        self.backgroundColor = [UIColor redColor];
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor greenColor];
        
        _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height)];
        _scrollView.contentSize = CGSizeMake(self.bounds.size.width * 3, self.bounds.size.height);
        _scrollView.showsHorizontalScrollIndicator = false;
        _scrollView.pagingEnabled = true;
        _scrollView.delegate = self;
        [self addSubview:_scrollView];
        
        UIView *view1 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height)];
        view1.backgroundColor = [UIColor redColor];
        [_scrollView addSubview:view1];
        
        UIView *view2 = [[UIView alloc]initWithFrame:CGRectMake(self.bounds.size.width, 0, self.bounds.size.width, self.bounds.size.height)];
        view2.backgroundColor = [UIColor blueColor];
        [_scrollView addSubview:view2];
        
        UIView *view3 = [[UIView alloc]initWithFrame:CGRectMake(self.bounds.size.width * 2, 0, self.bounds.size.width, self.bounds.size.height)];
        view3.backgroundColor = [UIColor purpleColor];
        [_scrollView addSubview:view3];
        
        _pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(0, 0, 100, 20)];
        _pageControl.numberOfPages = 3;
        _pageControl.currentPage = 0;
        _pageControl.hidesForSinglePage = true;//总页数为1时隐藏
        _pageControl.pageIndicatorTintColor = [UIColor colorWithWhite:1.0 alpha:0.5];
        _pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
        [self addSubview:_pageControl];
        
        _timer = [NSTimer scheduledTimerWithTimeInterval:3.0 target:self selector:@selector(timerFunc:) userInfo:nil repeats:true];
        [[NSRunLoop currentRunLoop]addTimer:_timer forMode:NSRunLoopCommonModes];
    }
    return self;
}

-(void)timerFunc:(NSTimer *)timer {
    
    NSLog(@"timeFunc");
    
}


-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    int index = fabs(scrollView.contentOffset.x) / scrollView.bounds.size.width;
    _pageControl.currentPage = index;
    NSLog(@"scrollViewDidEndDecelerating %@ %d", NSStringFromCGPoint(scrollView.contentOffset), index);
}

-(NSMutableArray *)list {
    if (!_list) {
        _list = [NSMutableArray arrayWithArray:@[@"1", @"2", @"3"]];
    }
    return _list;
}

@end
