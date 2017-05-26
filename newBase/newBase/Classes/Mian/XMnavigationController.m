//
//  XMnavigationController.m
//  xianshi
//
//  Created by new-1020 on 2016/10/18.
//  Copyright © 2016年 dengchunhua. All rights reserved.
//

#import "XMnavigationController.h"
@interface XMnavigationController ()


@end

@implementation XMnavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationBar.translucent = NO;
    self.navigationBar.tintColor = [UIColor blackColor];
}                                                                                                                                                               

-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (self.childViewControllers.count > 0) { // 非根控制器
        viewController.hidesBottomBarWhenPushed = YES;
    }
    
    // 真正在跳转
    [super pushViewController:viewController animated:animated];
    
    
}





@end
