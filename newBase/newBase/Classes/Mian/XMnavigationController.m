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
    NSDictionary *textAttribute = @{NSForegroundColorAttributeName : ColorDefault,NSFontAttributeName:[UIFont fontWithName:@"PingFang SC" size:16]};
    [[UINavigationBar appearance] setTitleTextAttributes:textAttribute];
}

-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (self.childViewControllers.count > 0) { // 非根控制器
        viewController.hidesBottomBarWhenPushed = YES;
        viewController.navigationItem.leftBarButtonItem = [self itemWithimage:[UIImage imageNamed:@"back_blus"] selImage:[UIImage imageNamed:@"back_blus"] target:self action:@selector(goback)];
    }
    
    // 真正在跳转
    [super pushViewController:viewController animated:animated];
    
    
}

// 返回的方法
- (void)goback {
    [self popViewControllerAnimated:YES];
}
// 快速创建barButtonItem
- (UIBarButtonItem *)itemWithimage:(UIImage *)image selImage:(UIImage *)selImage target:(id)target action:(SEL)action
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:image forState:UIControlStateNormal];
//    [btn setTitle:@"返回" forState:UIControlStateNormal];
    //[btn setImage:selImage forState:UIControlStateSelected];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn sizeToFit];
//    btn.titleLabel.font = defaultFont16;
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return [[UIBarButtonItem alloc] initWithCustomView:btn];
}




@end
