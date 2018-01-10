//
//  HomeSegmentView.m
//  YSTNewGreatWallMedium
//
//  Created by 曾勇 on 2017/11/27.
//  Copyright © 2017年 zhubiao. All rights reserved.
//

#import "XTSegmentControl.h"
#import "UIColor+TL.h"
#define XTSegmentControlItemFont (17)//字号
#define XTFont (2)

#define XTSegmentControlHspace (10)//左右2边的间隔

#define XTSegmentControlLineHeight (2)//选择条的高度

#define XTSegmentControlAnimationTime (0.5)//动画效果

//#define fontcolor        0xdf2135//红色
//#define blackcolor        0xdf272727//黑色

@interface XTSegmentControlItem : UIView

@property (nonatomic , strong) UILabel *titleLabel;

@end

@implementation XTSegmentControlItem

- (id)initWithFrame:(CGRect)frame title:(NSString *)title
{
    if (self = [super initWithFrame:frame]) {
        _titleLabel = ({
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(XTSegmentControlHspace, 0, CGRectGetWidth(self.bounds) - 2 * XTSegmentControlHspace, CGRectGetHeight(self.bounds))];
            label.font = [UIFont systemFontOfSize:XTSegmentControlItemFont-XTFont];
            label.text = title;
            label.backgroundColor = [UIColor clearColor];
//            label.textColor = [UIColor lightGrayColor];
//            label.textColor = [UIColor blackColor];
     
            label;
        });
        [self addSubview:_titleLabel];
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

@end

@interface XTSegmentControl ()<UIScrollViewDelegate>

@property (nonatomic , strong) UIScrollView *contentView;

@property (nonatomic , strong) UIView *leftShadowView;

@property (nonatomic , strong) UIView *rightShadowView;

@property (nonatomic , strong) UIView *lineView;

@property (nonatomic , strong) NSMutableArray *itemFrames;

@property (nonatomic , strong) NSMutableArray *items;

@property (nonatomic , strong) NSArray *itemarr;

@property (nonatomic , assign) NSInteger indexno;

@property (nonatomic) NSInteger currentIndex;

@property (nonatomic , weak) id <XTSegmentControlDelegate> delegate;

@property (nonatomic , copy) XTSegmentControlBlock block;

@end

@implementation XTSegmentControl

- (id)initWithFrame:(CGRect)frame Items:(NSArray *)titleItem
{
    if (self = [super initWithFrame:frame]) {
        
        _indexno = 0;
        _itemarr = titleItem;
        
        _contentView = ({
            UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
            scrollView.backgroundColor = [UIColor clearColor];
            scrollView.delegate = self;
            scrollView.showsHorizontalScrollIndicator = NO;
            [self addSubview:scrollView];
            scrollView.scrollsToTop = NO;
            _contentView.scrollsToTop = NO;

            UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doTap:)];
            [scrollView addGestureRecognizer:tapGes];
            [tapGes requireGestureRecognizerToFail:scrollView.panGestureRecognizer];
            scrollView;
        });
   
        
        [self initItemsWithTitleArray:titleItem];
        
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame Items:(NSArray *)titleItem delegate:(id<XTSegmentControlDelegate>)delegate
{
    if (self = [self initWithFrame:frame Items:titleItem]) {
        self.delegate = delegate;
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame Items:(NSArray *)titleItem selectedBlock:(XTSegmentControlBlock)selectedHandle
{
    if (self = [self initWithFrame:frame Items:titleItem]) {
        self.block = selectedHandle;
    }
    return self;
}


- (void)doTap:(UITapGestureRecognizer *)sender
{
    CGPoint point = [sender locationInView:sender.view];
    
    __weak typeof(self) weakSelf = self;
    
    [_itemFrames enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        
        CGRect rect = [obj CGRectValue];
        
        if (CGRectContainsPoint(rect, point)) {
            
            [weakSelf selectIndex:idx];
            
            [weakSelf transformAction:idx];
            
            *stop = YES;
        }
    }];
}

- (void)transformAction:(NSInteger)index
{
    if (self.delegate && [self.delegate conformsToProtocol:@protocol(XTSegmentControlDelegate)] && [self.delegate respondsToSelector:@selector(segmentControl:selectedIndex:)]) {
        
        [self.delegate segmentControl:self selectedIndex:index];
        
    }else if (self.block) {
        
        self.block(index);
    }
}

- (void)initItemsWithTitleArray:(NSArray *)titleArray
{
    
    _itemFrames = @[].mutableCopy;
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont systemFontOfSize:XTSegmentControlItemFont]};
    for (int i = 0; i < titleArray.count; i++) {
        NSString *title = titleArray[i];
        CGSize size = [title sizeWithAttributes:attributes];
        float x = i > 0 ? CGRectGetMaxX([_itemFrames[i-1] CGRectValue]) : 0;
        float y = 0;
        float width = 2 * XTSegmentControlHspace + size.width;
        float height = CGRectGetHeight(self.bounds);
        CGRect rect = CGRectMake(x, y, width, height);
        [_itemFrames addObject:[NSValue valueWithCGRect:rect]];
    }
    
    for (int i = 0; i < titleArray.count; i++) {
        
        CGRect rect = [_itemFrames[i] CGRectValue];
        NSString *title = titleArray[i];
        
        XTSegmentControlItem *item = [[XTSegmentControlItem alloc] initWithFrame:rect title:title];
        item.tag = 100+i;
        [_contentView addSubview:item];
       
    }

    [_contentView setContentSize:CGSizeMake(CGRectGetMaxX([[_itemFrames lastObject] CGRectValue]), CGRectGetHeight(self.bounds))];
    self.currentIndex = 0;
    [self selectIndex:0];
    
    [self resetShadowView:_contentView];
}

- (void)addRedLine
{
    if (!_lineView) {
        CGRect rect = [_itemFrames[0] CGRectValue];
        _lineView = [[UIView alloc] initWithFrame:CGRectMake(XTSegmentControlHspace, CGRectGetHeight(rect) - XTSegmentControlLineHeight, CGRectGetWidth(rect) - 2 * XTSegmentControlHspace, XTSegmentControlLineHeight)];
//        _lineView.backgroundColor = _lineBackground;
        [_contentView addSubview:_lineView];
    }
}

- (void)selectIndex:(NSInteger)index
{
    [self addRedLine];
    
    if (index != _currentIndex) {
        
        CGRect rect = [_itemFrames[index] CGRectValue];
        CGRect lineRect = CGRectMake(CGRectGetMinX(rect) + XTSegmentControlHspace, CGRectGetHeight(rect) - XTSegmentControlLineHeight, CGRectGetWidth(rect) - 2 * XTSegmentControlHspace, XTSegmentControlLineHeight);
        [UIView animateWithDuration:XTSegmentControlAnimationTime animations:^{
            _lineView.frame = lineRect;
        }];
        
        _currentIndex = index;
        
    }
    [self setScrollOffset:index];
}

- (void)moveIndexWithProgress:(float)progress
{
    
    
    
    float delta = progress - _currentIndex;

    CGRect origionRect = [_itemFrames[_currentIndex] CGRectValue];;
    
    CGRect origionLineRect = CGRectMake(CGRectGetMinX(origionRect) + XTSegmentControlHspace, CGRectGetHeight(origionRect) - XTSegmentControlLineHeight, CGRectGetWidth(origionRect) - 2 * XTSegmentControlHspace, XTSegmentControlLineHeight);
    
    CGRect rect;
    
    if (delta > 0) {
        
        if (_currentIndex == _itemFrames.count - 1) {
            return;
        }
        
        rect = [_itemFrames[_currentIndex + 1] CGRectValue];
        
        CGRect lineRect = CGRectMake(CGRectGetMinX(rect) + XTSegmentControlHspace, CGRectGetHeight(rect) - XTSegmentControlLineHeight, CGRectGetWidth(rect) - 2 * XTSegmentControlHspace, XTSegmentControlLineHeight);
        
        CGRect moveRect = CGRectZero;
        
        moveRect.size = CGSizeMake(CGRectGetWidth(origionLineRect) + delta * (CGRectGetWidth(lineRect) - CGRectGetWidth(origionLineRect)), CGRectGetHeight(lineRect));
        
        _lineView.frame = moveRect;
        
        _lineView.center = CGPointMake(CGRectGetMidX(origionLineRect) + delta * (CGRectGetMidX(lineRect) - CGRectGetMidX(origionLineRect)), CGRectGetMidY(origionLineRect));
        
        if (delta > 1) {
            
            _currentIndex ++;
        }
        
        
    }else if (delta < 0){
        
        if (_currentIndex == 0) {
            return;
        }
        
        rect = [_itemFrames[_currentIndex - 1] CGRectValue];
        
        CGRect lineRect = CGRectMake(CGRectGetMinX(rect) + XTSegmentControlHspace, CGRectGetHeight(rect) - XTSegmentControlLineHeight, CGRectGetWidth(rect) - 2 * XTSegmentControlHspace, XTSegmentControlLineHeight);
        
        CGRect moveRect = CGRectZero;
        
        moveRect.size = CGSizeMake(CGRectGetWidth(origionLineRect) - delta * (CGRectGetWidth(lineRect) - CGRectGetWidth(origionLineRect)), CGRectGetHeight(lineRect));
        
        _lineView.frame = moveRect;
        
        _lineView.center = CGPointMake(CGRectGetMidX(origionLineRect) - delta * (CGRectGetMidX(lineRect) - CGRectGetMidX(origionLineRect)), CGRectGetMidY(origionLineRect));

        if (delta < -1) {
            
            _currentIndex --;
        }
        


    }
    

    

}

- (void)endMoveIndex:(NSInteger)index
{
    [self selectIndex:index];
}

//改变选择器的时候的方法
- (void)setScrollOffset:(NSInteger)index
{
    CGRect rect = [_itemFrames[index] CGRectValue];

    float midX = CGRectGetMidX(rect);
    
    float offset = 0;
    
    float contentWidth = _contentView.contentSize.width;
    
    float halfWidth = CGRectGetWidth(self.bounds) / 2.0;
    
    if (midX < halfWidth) {
        offset = 0;
    }else if (midX > contentWidth - halfWidth){
        offset = contentWidth - 2 * halfWidth;
    }else{
        offset = midX - halfWidth;
    }
    
    [UIView animateWithDuration:XTSegmentControlAnimationTime animations:^{
        if (_contentView.contentSize.width >kScreenWidth-40) {
            
            [_contentView setContentOffset:CGPointMake(offset, 0) animated:NO];
        }
    }];
    
    
//    自己加的方法，是为了添加选中的标签。然后在选中之后修改选中的标签的字体颜色
    NSInteger i = index;


//    如果选的标签和上一个一样。就不改变
    if (i == _indexno) {
        
        XTSegmentControlItem *item1 = (XTSegmentControlItem *)[_contentView viewWithTag:100+i];
        item1.titleLabel.textColor = _higlightTextColor;
        item1.titleLabel.font = [UIFont systemFontOfSize:XTSegmentControlItemFont];
        
    }else{
        
//        选中的标签文字
        XTSegmentControlItem *item1 = (XTSegmentControlItem *)[_contentView viewWithTag:100+i];
        item1.titleLabel.textColor = _higlightTextColor;
        item1.titleLabel.font = [UIFont systemFontOfSize:XTSegmentControlItemFont];
        
//        之前的标签文字
        XTSegmentControlItem *item2 = (XTSegmentControlItem *)[_contentView viewWithTag:100+_indexno];
        item2.titleLabel.textColor = _normalTextColor;
        item2.titleLabel.font = [UIFont systemFontOfSize:XTSegmentControlItemFont-XTFont];
    }

    _indexno = i;
    

}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self resetShadowView:scrollView];
}

- (void)resetShadowView:(UIScrollView *)scrollView
{
    if (scrollView.contentOffset.x > 0) {
        
        _leftShadowView.hidden = NO;
        
        if (scrollView.contentOffset.x == scrollView.contentSize.width - CGRectGetWidth(scrollView.bounds)) {
            _rightShadowView.hidden = YES;
        }else{
            _rightShadowView.hidden = NO;
        }
        
    }else if (scrollView.contentOffset.x == 0) {
        _leftShadowView.hidden = YES;
        if (_contentView.contentSize.width < CGRectGetWidth(_contentView.frame)) {
            _rightShadowView.hidden = YES;
        }else{
            _rightShadowView.hidden = NO;
        }
    }
}

-(void)setLineBackground:(UIColor *)lineBackground
{
    _lineBackground = lineBackground;
    _lineView.backgroundColor = _lineBackground;

}
-(void)setHiglightTextColor:(UIColor *)higlightTextColor
{
    _higlightTextColor = higlightTextColor;
    XTSegmentControlItem *item1 = (XTSegmentControlItem *)[_contentView viewWithTag:100];
    item1.titleLabel.textColor = _higlightTextColor;

}
-(void)setNormalTextColor:(UIColor *)normalTextColor
{
    _normalTextColor = normalTextColor;
}


int ExceMinIndex1(float f)
{
    int i = (int)f;
    if (f != i) {
        return i+1;
    }
    return i;
}

@end

