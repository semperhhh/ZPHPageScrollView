//
//  ZPHPageScrollView.m
//  ZPHPageScrollView
//
//  Created by zph on 2020/3/17.
//  Copyright © 2020 张鹏辉. All rights reserved.
//

#import "ZPHPageScrollView.h"
#import <SDWebImage/SDWebImage.h>

@interface ZPHPageScrollView ()<UIScrollViewDelegate>

@property (nonatomic,strong) UIScrollView *scrollView;
/// 指示器
@property (nonatomic,strong) ZPHPageControl *pageControl;
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

-(instancetype)initWithFrame:(CGRect)frame List:(nonnull NSArray<ZPHPageModel *> *)list {
    
    if (self = [super initWithFrame:frame]) {
        
        NSAssert(list.count > 1, @"数组要大于1个才可以");
        //默认
        _timeInterval = 3;
        _timeOnceScroll = 0.25;
        
        _list = list;
        
        _leftIndex = list.count - 1;
        _centerIndex = 0;
        _rightIndex = 1;
        
        self.backgroundColor = [UIColor whiteColor];
        
        _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height)];
        _scrollView.contentSize = CGSizeMake(self.bounds.size.width * 3, self.bounds.size.height);
        _scrollView.showsHorizontalScrollIndicator = false;
        _scrollView.contentOffset = CGPointMake(self.bounds.size.width, 0);
        _scrollView.pagingEnabled = true;
        _scrollView.delegate = self;
        [self addSubview:_scrollView];
        
        _leftView = [[ZPHPageScrollView_Cell alloc]initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height)];
        _leftView.model = _list[_leftIndex];
        [_scrollView addSubview:_leftView];
        
        _centerView = [[ZPHPageScrollView_Cell alloc]initWithFrame:CGRectMake(self.bounds.size.width, 0, self.bounds.size.width, self.bounds.size.height)];
        _centerView.model = _list[_centerIndex];
        [_scrollView addSubview:_centerView];
        
        _rightView = [[ZPHPageScrollView_Cell alloc]initWithFrame:CGRectMake(self.bounds.size.width * 2, 0, self.bounds.size.width, self.bounds.size.height)];
        _rightView.model = _list[_rightIndex];
        [_scrollView addSubview:_rightView];
        
        self.pageControl = [[ZPHPageControl alloc]initWithFrame:CGRectMake(0, self.bounds.size.height - 20, self.bounds.size.width, 20)];
        self.pageControl.numberOfPages = _list.count;
        self.pageControl.currentPage = 0;
        self.pageControl.hidesForSinglePage = true;//总页数为1时隐藏
        self.pageControl.pageIndicatorTintColor = [UIColor colorWithWhite:1.0 alpha:0.5];
        self.pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
        [self addSubview:self.pageControl];
        
    }
    return self;
}

/// 开始滚动
-(void)scrollStart {
    
    if (!_timer) {
        
        _timer = [NSTimer scheduledTimerWithTimeInterval:_timeInterval target:self selector:@selector(timerFunc:) userInfo:nil repeats:true];
        [[NSRunLoop currentRunLoop]addTimer:_timer forMode:NSRunLoopCommonModes];
    }
}

/// 释放定时器
-(void)timeInvalidate {
    
    [self.timer invalidate];
}

-(void)timerFunc:(NSTimer *)timer {
    
    NSLog(@"timeFunc - %@", NSStringFromCGPoint(_scrollView.contentOffset));
   
    [UIView animateWithDuration:_timeOnceScroll animations:^{
        
        self.scrollView.contentOffset = CGPointMake(self.scrollView.contentOffset.x + self.bounds.size.width, 0);
        
    } completion:^(BOOL finished) {
        [self scrollViewDidEndDecelerating:self.scrollView];
    }];
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    
    NSLog(@"scrollViewWillBeginDragging");
    [self.timer setFireDate:[NSDate distantFuture]];
}

-(void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {
    
    NSLog(@"scrollViewWillEndDragging");
    [self.timer setFireDate:[NSDate dateWithTimeIntervalSinceNow:_timeInterval]];
}

/// 滑动停止
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    CGFloat screenW = self.bounds.size.width;
    
    int index = fabs(scrollView.contentOffset.x) / scrollView.bounds.size.width;
    _pageControl.currentPage = index;
    NSLog(@"scrollViewDidEndDecelerating %@ %d", NSStringFromCGPoint(scrollView.contentOffset), index);
    
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
    
    //指示器
    _pageControl.currentPage = _centerIndex;
}

@end

//MARK: 子view
@implementation ZPHPageScrollView_Cell

-(instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        _imgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height)];
        _imgView.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:_imgView];
        
        _subLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height)];
        _subLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_subLabel];
    }
    
    return self;
}

-(void)setModel:(ZPHPageModel *)model {
    
    if (model.backColor) {
        self.backgroundColor = model.backColor;
    }
    
    if (model.text) {
        self.subLabel.text = model.text;
    }
    
    if (model.pictureUrlString) {
        [self.imgView sd_setImageWithURL:[NSURL URLWithString: model.pictureUrlString]];
    } else if (model.pictureName) {
        self.imgView.image = [UIImage imageNamed: model.pictureName];
    }
}

@end

// MARK: - 数据
@implementation ZPHPageModel

@end

// MARK: - 自定义指示器
@implementation ZPHPageControl

-(void)setCurrentPage:(NSInteger)currentPage {
    
    [super setCurrentPage:currentPage];
    
    for (NSUInteger subviewIndex = 0; subviewIndex < self.subviews.count; subviewIndex ++) {
        if (subviewIndex == currentPage) {
            UIImageView *subview = [self.subviews objectAtIndex:subviewIndex];
            CGSize size;
            size.width = 10;
            [subview setFrame:CGRectMake(subview.frame.origin.x, subview.frame.origin.y, size.width, subview.frame.size.height)];
        }
    }
}

@end
