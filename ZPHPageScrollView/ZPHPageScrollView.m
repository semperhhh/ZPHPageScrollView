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

@property (nonatomic,assign) NSInteger leftIndex;
@property (nonatomic,assign) NSInteger centerIndex;
@property (nonatomic,assign) NSInteger rightIndex;
@property (nonatomic,strong) ZPHPageScrollView_Cell *leftView;
@property (nonatomic,strong) ZPHPageScrollView_Cell *centerView;
@property (nonatomic,strong) ZPHPageScrollView_Cell *rightView;
@end

@implementation ZPHPageScrollView

-(instancetype)init {
    
    if (self = [super init]) {
        
        self.backgroundColor = [UIColor redColor];
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame List:(nonnull NSArray<ZPHPageModel *> *)list {
    
    if (self = [super initWithFrame:frame]) {
        
        _list = list;
        self.backgroundColor = [UIColor greenColor];
        
        _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height)];
        _scrollView.contentSize = CGSizeMake(self.bounds.size.width * 3, self.bounds.size.height);
        _scrollView.showsHorizontalScrollIndicator = false;
        _scrollView.pagingEnabled = true;
        _scrollView.delegate = self;
        [self addSubview:_scrollView];
        
        _leftView = [[ZPHPageScrollView_Cell alloc]initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height)];
        _leftView.model = _list[0];
        [_scrollView addSubview:_leftView];
        
        _centerView = [[ZPHPageScrollView_Cell alloc]initWithFrame:CGRectMake(self.bounds.size.width, 0, self.bounds.size.width, self.bounds.size.height)];
        _centerView.model = _list[1];
        [_scrollView addSubview:_centerView];
        
        _rightView = [[ZPHPageScrollView_Cell alloc]initWithFrame:CGRectMake(self.bounds.size.width * 2, 0, self.bounds.size.width, self.bounds.size.height)];
        _rightView.model = _list[2];
        [_scrollView addSubview:_rightView];
        
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
    
    NSLog(@"timeFunc - %@", NSStringFromCGPoint(_scrollView.contentOffset));
   
    [UIView animateWithDuration:2 animations:^{
        
        self.scrollView.contentOffset = CGPointMake(self.scrollView.contentOffset.x + self.bounds.size.width, 0);
        
    } completion:^(BOOL finished) {
        [self scrollViewDidEndDecelerating:self.scrollView];
    }];
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    CGFloat screenW = self.bounds.size.width;
    
    int index = fabs(scrollView.contentOffset.x) / scrollView.bounds.size.width;
    _pageControl.currentPage = index;
    NSLog(@"scrollViewDidEndScrollingAnimation %@ %d", NSStringFromCGPoint(scrollView.contentOffset), index);
    
    CGFloat offsetX = scrollView.contentOffset.x;
    
    //图片向左滑动,展示下一张
    if (offsetX > screenW) {
        
        _leftIndex++;
        _centerIndex++;
        _rightIndex++;
        
        if (_leftIndex > _list.count - 1) {
            _leftIndex = 0;
        }
        if (_centerIndex > _list.count - 1) {
            _centerIndex = 0;
        }
        if (_rightIndex > _list.count - 1) {
            _rightIndex = 0;
        }
        
    } else if (offsetX < screenW) {//图片向右滑动,展示上一张
        
        _leftIndex--;
        _centerIndex--;
        _rightIndex--;
        
        if (_leftIndex < 0) {
            _leftIndex = _list.count -1;
        }
        if (_centerIndex < 0) {
            _centerIndex = _list.count - 1;
        }
        if (_rightIndex < 0) {
            _rightIndex = _list.count -1;
        }
    }
    
    _centerView.model = _list[_centerIndex];
    _rightView.model = _list[_rightIndex];
    _leftView.model = _list[_leftIndex];
    _scrollView.contentOffset = CGPointMake(self.bounds.size.width, 0);
}

@end

//MARK: 子view
@implementation ZPHPageScrollView_Cell

-(instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        _imgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height)];
        [self addSubview:_imgView];
        
        _subLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height)];
        _subLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_subLabel];
    }
    
    return self;
}

-(void)setModel:(ZPHPageModel *)model {
    
    self.backgroundColor = model.backColor;
    self.subLabel.text = model.text;
}

@end

@implementation ZPHPageModel

@end
