//
//  JJLoopImages.m
//  JJLoopImage
//
//  Created by myjawdrops on 2016/12/14.
//  Copyright © 2016年 MyJawDrops. All rights reserved.
//

#import "JJLoopImages.h"
#import "NSTimer+PauseResume.h"

@interface JJLoopImages ()<UIScrollViewDelegate>

@property (strong, nonatomic)   NSTimer *timer;
@property (weak, nonatomic)   UIPageControl *pageControl;
@property (weak, nonatomic)   UIScrollView *scrollView;

- (UIViewController*)viewController;
@end




@implementation JJLoopImages

#pragma mark - lazy load timer

- (void)startTick{
    [self.timer fire];
}

- (NSTimer *)timer{
    if (!_timer) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:self.tickInterval target:self selector:@selector(tick) userInfo:nil repeats:YES];
        [[NSRunLoop mainRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
    }
    return _timer;
}


- (void)tick{
    NSInteger currentPage = self.pageControl.currentPage;
    currentPage++;
    if(currentPage == self.pageControl.numberOfPages){
        currentPage = 0;
    }
    self.pageControl.currentPage = currentPage;
    CGPoint offset = CGPointMake((self.pageControl.currentPage)*(self.frame.size.width),0);
    self.scrollView.contentOffset = offset;

}


- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        self.scrollView = scrollView;
        [self addSubview:scrollView];
        [self initialization];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame images:(NSArray<UIImage *>*)images selectors:(NSArray *)selectors{
    if (self = [self initWithFrame:frame]){
        self.selectors = selectors;
        self.images = images;
    }
    return self;
}


- (void)setImages:(NSArray *)images{
    _images = images;
    
    for (int i = 0; i < images.count; i++) {
        UIImage *img = images[i];
        int x = (i)*self.bounds.size.width;
        UIImageView *imgView = [[UIImageView alloc]initWithFrame:CGRectMake(x, 0, self.bounds.size.width, self.bounds.size.height)];
        imgView.userInteractionEnabled = YES;
        imgView.image = img;
        if (self.selectors != nil) {
            SEL selector = NSSelectorFromString(self.selectors[i]);
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:[self viewController]  action:selector];
            [imgView addGestureRecognizer:tap];
        }
        [self.scrollView addSubview:imgView];
    }
    
    self.scrollView.contentSize = CGSizeMake(images.count*(self.bounds.size.width), self.bounds.size.height);

    //添加pageControl
    CGFloat pcW = images.count * 30;
    CGFloat pcH = 30;
    CGFloat pcX = (self.frame.size.width - pcW)/2;
    CGFloat pcY = self.frame.size.height - 20 - pcH;
    UIPageControl *page = [[UIPageControl alloc]initWithFrame:CGRectMake(pcX, pcY   , pcW, pcH)];
    page.pageIndicatorTintColor = [UIColor grayColor];
//    page.tintColor = [UIColor redColor];
    page.currentPageIndicatorTintColor = self.selectedPageTintColor;
    page.pageIndicatorTintColor = self.normalPageTintColor;
    page.numberOfPages = images.count;
    self.pageControl = page;
    [self addSubview:page];
}


- (void)setSelectors:(NSArray *)selectors{
    _selectors = selectors;
    if (self.images != nil) {
        int i = 0;
        for (UIView *view in self.scrollView.subviews) {
            if ([view isKindOfClass:[UIImageView class]]) {
                UIImageView *imgView = (UIImageView *)view;
                imgView.userInteractionEnabled = YES;
                SEL selector = NSSelectorFromString(self.selectors[i]);
                UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:[self viewController]  action:selector];
                [imgView addGestureRecognizer:tap];
                i++;
            }
        }
    }
    

}

- (void)initialization{
    self.scrollView.pagingEnabled = YES;
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.bounces = NO;
    self.scrollView.delegate = self;
    self.tickInterval = 2.0;
    self.normalPageTintColor = [UIColor grayColor];
    self.selectedPageTintColor = [UIColor whiteColor];
}

#pragma mark - ScrollView Delegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGPoint offset = scrollView.contentOffset;
    int pageIndex = (offset.x + 0.5 *scrollView.bounds.size.width)/ scrollView.bounds.size.width;
    self.pageControl.currentPage = pageIndex;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self.timer pauseTimer];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    [self.timer resumeTimer];

}


-(UIViewController *)viewController{
    UIResponder *next = [self nextResponder];
    do {
        if ([next isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)next;
        }
        next = [next nextResponder];
    } while (next != nil);
    return nil;
}


@end
