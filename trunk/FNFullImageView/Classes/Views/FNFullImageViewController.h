//
//  FNFullImageViewController.h
//  FNMerchant
//
//  Created by medita on 16/7/1.
//  Copyright © 2016年 FeiNiu. All rights reserved.
//

#import "UIKit/UIkit.h"
#import "FNBaseAnimatedTransitioning.h"

typedef NS_ENUM(NSInteger,FNFullImageType)
{
    FNFullImageTypeUrl   ,//参数都是图片imageUrlString(NSString类型)
    FNFullImageTypeFullImage , //参数是FNFullScreenImage类型
    FNFullImageTypeNormalImage  //参数是UIImage类型
};

typedef NS_ENUM(NSInteger,FNPageType)
{
    FNPageTypeNo,      //没有显示页
    FNPageTypeLabel,   //数字显示页
    FNPageTypeControl, //原点显示页
};

typedef NS_ENUM(NSInteger,FNTapType)
{
    FNTapTypeHide ,//点击隐藏大图
    FNTapTypeShow  //点击显示导航栏
};

typedef NS_ENUM(NSInteger,FNPlaceType)
{
    FNPlaceNone,
    FNPlaceLeftTop,
    FNPlaceLeftBottom,
    FNPlaceRightTop,
    FNPlaceRightBpttom,
    FNPlaceAll
};

#define kScreenWidth CGRectGetWidth([UIScreen mainScreen].bounds)
#define kScreenHeight CGRectGetHeight([UIScreen mainScreen].bounds)
#define WS(weakSelf)  __weak __typeof(&*self)weakSelf = self;

@interface FNFullScreenImage : NSObject

@property (nonatomic, strong) UIImage *image;
@property (nonatomic, strong) NSString *imageURLString;
@property (nonatomic, strong) UIImageView *originalImageView;

// 新增属性(评论)
@property (nonatomic, copy) NSString *commentatorName;
@property (nonatomic, copy) NSString *commentContent;
@property (nonatomic, copy) NSString *currentPage;
@property (nonatomic, copy) NSString *iconUrl;

@end



@interface FNFullImageViewController : UIViewController

//设置动画
@property (nonatomic,strong) id animation;
//
@property (nonatomic,assign) FNPageType pageType;
//大图点击图片类型
@property (nonatomic,assign) FNTapType tapType;
//图片下方展示类型
@property (nonatomic,assign) FNPlaceType placeType;
//大图加载占位图
@property (nonatomic,strong) UIImage *placeHolderImage;
//自定义视图
@property (nonatomic,strong) UIView *customView;

@property (nonatomic,assign)   BOOL isEndAnimation;

@property (nonatomic,assign) BOOL isDisAppearIntoMiddleOfAnimation;

@property (nonatomic,  copy) void(^disMissAtIndex)(NSInteger disMissIndex);
/**
    初始化
     FNFullImageViewController *fullVc = [[FNFullImageViewController alloc]initWithFullScreenImageArray:self.photoArray currentIndex:0];
 
 
 
    [fullVc push];
    初始化动画
 
    Present动画设置 ,默认为放大缩小,设置之后用设置的动画
    fullVc.animation = animation;
    [fullVc show];
 
    消失
    [fullVc disappear];
 **/


/**
    modal显示图片浏览器
    默认动画为放大缩小
 */
- (void)show:(BOOL)animated;

/**
 *  push显示图片浏览器
    默认动画为系统push
 */
- (void)push;
/**
 *  隐藏浏览器
 */
- (void)disappear;

/**
 *  实例化对象  兼容图片url数组,UIImage数组,FNFullImage数组
 *
 *  @param imageArray   图片数组
 *  @param imageType    图片数组里面的类型
 *  @param currentIndex 当前图片索引
 *
 *  @return 图片浏览器对象
 */
- (instancetype)initWithImageArray:(NSArray *)imageArray
                            currentIndex:(NSInteger)currentIndex;
/**
 *  实例化具体配置  针对有指定原图位移
 *
 *  @param fullScreenImageArray 图片数组
 *  @param currentIndex         当前索引
 *  @param tapType              点击大图类型     defalt FNTapTypeHide
 *  @param pageType             数字label和圆点  defalt FNPageTypeLabel
 *  @return 图片浏览器对象
 */
- (instancetype)initWithFullScreenImageArray:(NSArray<FNFullScreenImage *> *)fullScreenImageArray currentIndex:(NSInteger)currentIndex tapType:(FNTapType)tapType
                                    pageType:(FNPageType)pageType;

@end
