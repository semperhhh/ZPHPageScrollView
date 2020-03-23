//
//  ZPHPageScrollView.h
//  ZPHPageScrollView
//
//  Created by zph on 2020/3/17.
//  Copyright © 2020 张鹏辉. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

//MARK: 数据模型
@interface ZPHPageModel : NSObject

@property (nonatomic,copy) NSString *text;
@property (nonatomic,copy) UIColor *backColor;
@property (nonatomic,copy) NSString *pictureUrlString;

@end

//MARK: 滚动view
@interface ZPHPageScrollView : UIView
/// 数据
@property (nonatomic,strong) NSArray <ZPHPageModel *> *list;

/// 初始化
/// @param list 数据
-(instancetype)initWithFrame:(CGRect)frame List:(NSArray <ZPHPageModel *> *)list;

@end


//MARK: 子view
@interface ZPHPageScrollView_Cell : UIView
/// 标题
@property (nonatomic,strong) UILabel *subLabel;
/// 图片
@property (nonatomic,strong) UIImageView *imgView;
/// 模型
@property (nonatomic,strong) ZPHPageModel *model;
@end


NS_ASSUME_NONNULL_END
