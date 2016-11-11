//
//  FNCommentDetailInfoView.m
//  Pods
//
//  Created by Wang on 16/8/30.
//
//

#import "FNCommentDetailInfoView.h"
#import "UIImageView+WebCache.h"
#import "FNFullImageViewController.h"

@interface FNCommentDetailInfoView ()

@property (nonatomic,strong) UIImageView *headerImageView;
@property (nonatomic,strong) UILabel *nickLabel;
@property (nonatomic,strong) UILabel *pageLabel;
@property (nonatomic,strong) UILabel *contentLabel;
@property (nonatomic,strong) UITextView *commentContent;

@property (copy,   nonatomic)  FNFullScreenImage *imageModel;

@property (nonatomic,assign) NSInteger isFold;

@end

@implementation FNCommentDetailInfoView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self builtUI];
        [self settings];
    }
    return self;
}

- (void)builtUI
{
    self.backgroundColor = [UIColor blackColor];
    self.alpha = .8;
    _headerImageView = [[UIImageView alloc] initWithFrame:CGRectMake(20., 10., 25., 25.)];
    _headerImageView.layer.cornerRadius = 12.5;
    _headerImageView.layer.masksToBounds = YES;
    [self addSubview:_headerImageView];
    
    _nickLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_headerImageView.frame) + 10., CGRectGetMinY(_headerImageView.frame), 100., 25.)];
    _nickLabel.font = [UIFont systemFontOfSize:14];
    _nickLabel.textColor = [UIColor whiteColor];
    [self addSubview:_nickLabel];
    
    _pageLabel = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth - 100., 10., 88.,25.)];
    _pageLabel.font = [UIFont systemFontOfSize:14];
    _pageLabel.textAlignment = NSTextAlignmentRight;
    _pageLabel.textColor = [UIColor whiteColor];
    [self addSubview:_pageLabel];
    
    _commentContent = [[UITextView alloc] initWithFrame:CGRectMake(15., CGRectGetMaxY(_headerImageView.frame) + 10, kScreenWidth - 33, 0.)];
    _commentContent.editable = NO;
    _commentContent.selectable = NO;
    _commentContent.font = [UIFont systemFontOfSize:14];
    _commentContent.backgroundColor = [UIColor clearColor];
    _commentContent.indicatorStyle = UIScrollViewIndicatorStyleWhite;
    _commentContent.textContainerInset = UIEdgeInsetsMake(0, 0, 0, 0);
    [self addSubview:_commentContent];
    
    self.frame = CGRectMake(0, 0, kScreenWidth, CGRectGetMaxY(_commentContent.frame));
}

- (void)settings
{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapDo:)];
    [self addGestureRecognizer:tap];
    UISwipeGestureRecognizer *upSwipe = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(bottomToTop:)];
    upSwipe.direction = UISwipeGestureRecognizerDirectionUp;
    [self addGestureRecognizer:upSwipe];
    UISwipeGestureRecognizer *downSwipe = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(topToBottom:)];
    downSwipe.direction = UISwipeGestureRecognizerDirectionDown;
    [self addGestureRecognizer:downSwipe];
}

- (void)tapDo:(UITapGestureRecognizer *)sender
{
    self.isFold = !self.isFold;
    [self updateCommentTextViewHeight:YES];
}
- (void)bottomToTop:(id)sender
{
    self.isFold = NO;
    [self updateCommentTextViewHeight:YES];
}
- (void)topToBottom:(id)sender
{
    self.isFold = YES;
    [self updateCommentTextViewHeight:YES];
}

- (void)setImageModel:(FNFullScreenImage *)imageModel isAnimation:(BOOL)isAnimation
{
    _imageModel = imageModel;
    [_nickLabel setText:imageModel.commentatorName];
    [_pageLabel setText:imageModel.currentPage];
    [_commentContent setAttributedText:[[NSAttributedString alloc] initWithString:imageModel.commentContent attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12], NSForegroundColorAttributeName:[UIColor whiteColor]}]];
    [_headerImageView sd_setImageWithURL:[NSURL URLWithString:imageModel.iconUrl]];
    self.isFold = YES;
    [self updateCommentTextViewHeight:isAnimation];
}

- (void)updateImageUrl:(NSString *)imageUrl nickName:(NSString *)nickName pageIndex:(NSString *)pageIndex content:(NSString *)content
{
    [_headerImageView sd_setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:[UIImage imageNamed:@""]];
    _nickLabel.text = nickName;
    _pageLabel.text = pageIndex;
    _contentLabel.text = content;
    
    CGSize size = [_contentLabel sizeThatFits:CGSizeMake(kScreenWidth - 24., 200.)];
    CGRect contentRect = _contentLabel.frame;
    contentRect.size.height = size.height;
    _contentLabel.frame = contentRect;
    CGRect selfRect = self.frame;
    selfRect.size.height += size.height;
    self.frame = selfRect;
}

- (void)updateCommentTextViewHeight:(BOOL)animated
{
    _commentContent.userInteractionEnabled = NO;
    CGRect rect = _commentContent.frame;
    if (_isFold) { //收起状态
        rect.size.height = 30.;
        [_commentContent setContentOffset:CGPointZero];
        [self reLayoutForCommentContentRect:rect animated:animated];
    }else{
        if (self.commentContent.contentSize.height > kScreenHeight/2-57) {
            self.commentContent.userInteractionEnabled = YES;
            rect.size.height = kScreenHeight/2-57;
            [self reLayoutForCommentContentRect:rect animated:animated];
        } else {
            CGFloat textViewH  = self.commentContent.contentSize.height<30?30:self.commentContent.contentSize.height;
            rect.size.height = textViewH;
            [self reLayoutForCommentContentRect:rect animated:animated];
        }
    }
}
- (void)reLayoutForCommentContentRect:(CGRect)rect animated:(BOOL)animated{
    if (animated) {
        [UIView animateWithDuration:0.3 animations:^{
            self.commentContent.frame = rect;
            self.frame = CGRectMake(0, kScreenHeight - CGRectGetMaxY(_commentContent.frame) - 22, kScreenWidth, CGRectGetMaxY(_commentContent.frame)+22.);
        }];
    }else{
        self.commentContent.frame = rect;
        self.frame = CGRectMake(0, kScreenHeight - CGRectGetMaxY(_commentContent.frame) - 22, kScreenWidth, CGRectGetMaxY(_commentContent.frame)+22.);
    }
}



@end
