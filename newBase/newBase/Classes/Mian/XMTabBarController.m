//
//  XMTabBarController.m
//  xiaorizi
//
//  Created by new-1020 on 2017/2/28.
//  Copyright © 2017年 begmoon. All rights reserved.
//

#import "XMTabBarController.h"
#import "DiscoverViewController.h"
#import "ShopViewController.h"
#import "DevieceViewController.h"
#import "MessageViewController.h"
#import "XMnavigationController.h"

@interface XMTabBarController ()

@end

@implementation XMTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.navigationController.navigationBarHidden = YES;
    [self createControllers];
    [self createTabBar];
}

#pragma mark - 创建viewControllers
-(void)createControllers
{
    //首页
    DevieceViewController *indexVC = [[DevieceViewController alloc] init];
    XMnavigationController *indexNav = [[XMnavigationController alloc]initWithRootViewController:indexVC];
    indexVC.title = @"设备";
    
    //榜单
    DiscoverViewController * homeVC = [[DiscoverViewController alloc]init];
    XMnavigationController * homeNav = [[XMnavigationController alloc]initWithRootViewController:homeVC];
    homeVC.title = @"发现";
    
    //发布小店
    MessageViewController * publishVC = [[MessageViewController alloc]init];
    XMnavigationController * publishNav = [[XMnavigationController alloc]initWithRootViewController:publishVC];
    publishVC.title = @"消息";
    
    //心愿单
    ShopViewController * foodVC = [[ShopViewController alloc]init];
    XMnavigationController * foodNav =  [[XMnavigationController alloc]initWithRootViewController:foodVC];
    foodVC.title = @"商场";
    
    //将导航页面添加到数组中
    NSArray * ViewControllersArray = @[indexNav,homeNav,publishNav,foodNav];
    self.viewControllers = ViewControllersArray;
}

#pragma mark - 创建tabBar

-(void)createTabBar
{
    //未选中的图片
    NSArray * unselectedImageArray = @[@"eqa_sel_ys",  @"find_sel_ys",@"shop_sel_ys",@"news_sel_yss"];
    //选中的图片
    NSArray * selectedImageArray = @[@"eqa_sel_nor",  @"find_sel_nor",@"shop_sel_nor",@"news_sel_nors"];
    //标题
    NSArray * titleArray = @[@"设备",@"发现",@"消息",@"商场"];
    
    for(int i = 0;i < self.tabBar.items.count;i ++)
    {
        //设置未选中的图片并对图片做处理，使用图片原尺寸
        UIImage * unselectedImage = [UIImage imageNamed:unselectedImageArray[i]];
        unselectedImage = [unselectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        
        //同样的，处理选中的图片
        UIImage * selectedImage = [UIImage imageNamed:selectedImageArray[i]];
        selectedImage = [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        
        //获取tabBarItem
        UITabBarItem * item = self.tabBar.items[i];
        item = [item initWithTitle:titleArray[i] image:unselectedImage selectedImage:selectedImage];
    }
    //设置选中时候的标题颜色,appearance属性全局修改某个属性
    [[UITabBarItem appearance]setTitleTextAttributes:@{NSForegroundColorAttributeName:XMColor(92, 152, 55)} forState:UIControlStateSelected];
    [[UITabBarItem appearance]setTitleTextAttributes:@{NSForegroundColorAttributeName:XMColor(142, 196, 164)} forState:UIControlStateNormal];
}



@end
