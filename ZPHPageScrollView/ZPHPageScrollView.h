//
//  ZPHPageScrollView.h
//  ZPHPageScrollView
//
//  Created by zph on 2020/3/17.
//  Copyright © 2020 张鹏辉. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/*
 自定义
 */
//MARK: 数据模型
@interface ZPHPageModel : NSObject

/// 文字
@property (nonatomic,strong) NSString *text;
/// 背景颜色
@property (nonatomic,strong) UIColor *backColor;
/// 网络图片地址
@property (nonatomic,strong) NSString *pictureUrlString;
/// 本地图片名字
@property (nonatomic,strong) NSString *pictureName;

@end


//MARK: 滚动view
@interface ZPHPageScrollView : UIView
/// 数据
@property (nonatomic,strong) NSArray <ZPHPageModel *> *list;

/// 无限滚动
@property (nonatomic,assign) BOOL isInfiniteScroll;
/// 滚动间隔
@property (nonatomic,assign) NSInteger timeInterval;
/// 滚动一次的时间
@property (nonatomic,assign) double timeOnceScroll;

/// 初始化
/// @param list 数据
-(instancetype)initWithFrame:(CGRect)frame List:(NSArray <ZPHPageModel *> *)list;

/// 开始滚动
-(void)scrollStart;
/// 释放定时器
-(void)timeInvalidate;
@end


/*
  自定义
 */
//MARK: 自定义view
@interface ZPHPageScrollView_Cell : UIView
/// 标题
@property (nonatomic,strong) UILabel *subLabel;
/// 图片
@property (nonatomic,strong) UIImageView *imgView;
/// 模型
@property (nonatomic,strong) ZPHPageModel *model;
@end

// MARK: 自定义指示器
@interface ZPHPageControl : UIPageControl

@end

NS_ASSUME_NONNULL_END
