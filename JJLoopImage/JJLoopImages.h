//
//  JJLoopImages.h
//  JJLoopImage
//
//  Created by myjawdrops on 2016/12/14.
//  Copyright © 2016年 MyJawDrops. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JJLoopImages : UIView

@property (strong, nonatomic)   NSArray *images;
@property (strong, nonatomic)   NSArray *selectors;
@property (assign, nonatomic) NSTimeInterval tickInterval;
@property (strong, nonatomic)   UIColor *normalPageTintColor;
@property (strong, nonatomic)   UIColor *selectedPageTintColor;


- (instancetype)initWithFrame:(CGRect)frame images:(NSArray<UIImage *>*)images selectors:(NSArray *)selectors;

- (void)startTick;

- (UIViewController *)viewController;

@end
