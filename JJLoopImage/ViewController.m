//
//  ViewController.m
//  JJLoopImage
//
//  Created by myjawdrops on 2016/12/14.
//  Copyright © 2016年 MyJawDrops. All rights reserved.
//

#import "ViewController.h"
#import "JJLoopImages.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSMutableArray *mutableArr = [NSMutableArray array];
    for(int i = 1; i <= 4; i++){
        UIImage *img = [UIImage imageNamed:[NSString stringWithFormat:@"%d.jpeg",i]];
        [mutableArr addObject:img];
    }
    
    NSArray *selectors = @[@"tap1",@"tap2",@"tap3",@"tap4"];
    
    
    JJLoopImages *loop = [[JJLoopImages alloc] initWithFrame:CGRectMake(0, 20, self.view.frame.size.width, 200)];
    loop.tickInterval = 2;
    
    //!!!
    loop.selectedPageTintColor = [UIColor redColor];
    loop.normalPageTintColor = [UIColor whiteColor];
    loop.images = mutableArr;
    
    //!!!
    [self.view addSubview:loop];
    loop.selectors = selectors;
    
    [loop startTick];
}

- (void)tap1{
    NSLog(@"%s",__func__);
}

- (void)tap2{
    NSLog(@"%s",__func__);
}

- (void)tap3{
    NSLog(@"%s",__func__);
}
- (void)tap4{
    NSLog(@"%s",__func__);
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
