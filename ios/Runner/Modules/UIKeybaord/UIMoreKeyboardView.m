//
//  UIMoreKeyboardView.m
//  iFans
//
//  Created by Zanilia on 16/8/15.
//  Copyright © 2016年 王宾. All rights reserved.
//




#import "UIMoreKeyboardView.h"
#import "UIMoreButtonItem.h"
#import "UIView+Methods.h"
#define NumberPerLine   4
#define ItemWidth   54
#define ItemHeight  84

@interface UIMoreKeyboardView ()<UIScrollViewDelegate>

@property (assign, nonatomic) CGFloat space;

@property (copy, nonatomic) NSArray *titles;
@property (copy, nonatomic) NSArray *imageNames;

@property (strong, nonatomic) UIScrollView *scrollView;
@property (strong, nonatomic) UIPageControl *pageControl;
@property (strong, nonatomic) NSMutableArray *itemViews;

@end

@implementation UIMoreKeyboardView
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.itemViews = [NSMutableArray array];
        
        self.backgroundColor = [UIColor whiteColor];
        
        [self addSubview:self.scrollView];
        [self addSubview:self.pageControl];
    }
    return self;
}


- (UIScrollView *)scrollView{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height -30)];
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.pagingEnabled = YES;
        _scrollView.delegate = self;
        _scrollView.backgroundColor = [UIColor clearColor];
    }
    return _scrollView;
}

- (UIPageControl *)pageControl{
    if (!_pageControl) {
        _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, self.frame.size.height - 30, self.frame.size.width, 20)];
        _pageControl.pageIndicatorTintColor = [UIColor colorWithRed:0.8069 green:0.8069 blue:0.8069 alpha:1.0];
        _pageControl.currentPageIndicatorTintColor = [UIColor colorWithRed:0.4487 green:0.4487 blue:0.4487 alpha:1.0];
        _pageControl.hidesForSinglePage = YES;
    }
    return _pageControl;
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    [self.pageControl setCurrentPage:scrollView.contentOffset.x / scrollView.frame.size.width];
}

- (void)setDataSource:(id<UIMoreKeyboardViewDataSource>)dataSource{
    _dataSource = dataSource;
    [self reloadData];
}

- (void)reloadData{
    self.space = 30;
    if ([self.dataSource keyboardMoreViewTitlesOfMoreView:self]) {
        self.titles = [self.dataSource keyboardMoreViewTitlesOfMoreView:self];
    }
    if ([self.dataSource keyboardMoreViewImageNamesOfMoreView:self]) {
        self.imageNames = [self.dataSource keyboardMoreViewImageNamesOfMoreView:self];
    }
    
    [self.itemViews makeObjectsPerformSelector:@selector(removeFromSuperview) withObject:nil];
    [self.itemViews removeAllObjects];
    [self initItems];
}

- (void)initItems{
    
    __block NSUInteger line = 0;
    __block NSUInteger column = 0;
    __block NSUInteger page = 0;
    [self.titles enumerateObjectsUsingBlock:^(NSString *obj, NSUInteger idx, BOOL *stop) {
        
        if (column > 3) {
            line ++ ;
            column = 0;
        }
        if (line > 1) {
            line = 0;
            column = 0;
            page ++ ;
        }
        
        CGFloat startX = self.space + column * ItemWidth+column *self.space + page * self.frame.size.width;
        CGFloat startY = line * ItemHeight+(line+1)*20;
        
        UIMoreButtonItem *item = [[UIMoreButtonItem alloc] initWithFrame:CGRectMake(startX, startY, ItemWidth,ItemHeight)];
        [item initWithTitle:obj imageName:self.imageNames[idx]];
        item.tag = idx;
        [item addTarget:self action:@selector(itemClickAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.scrollView addSubview:item];
        [self.itemViews addObject:item];
        column ++ ;
        
        if (idx == self.titles.count - 1) {
            [self.scrollView setContentSize:CGSizeMake(self.scrollView.frame.size.width * (page + 1), self.scrollView.frame.size.height)];
            self.pageControl.numberOfPages = page + 1;
            *stop = YES;
        }
        
    }];
}

- (void)itemClickAction:(UIMoreButtonItem *)item{
    if (self.delegate && [self.delegate respondsToSelector:@selector(keyboard:selectIndex:title:)]) {
        [self.delegate keyboard:self selectIndex:item.tag title:_titles[item.tag]];
    }
}

@end
