//
//  XMBaseViewController.m
//  XMNewBeeBaseController
//
//  Created by new-1020 on 2017/3/20.
//  Copyright © 2017年 new-1020. All rights reserved.
//
#define FooterHeight 40.0
#define HeaderHeight 50.0
#import "XMBaseViewController.h"

@interface XMBaseViewController ()<UITableViewDelegate>
@property (nonatomic,strong) UIView * nodataView;
@property (nonatomic,strong) UILabel *BottomLabel;
@property (nonatomic,strong) UILabel *headLabel;
@property (nonatomic,strong) UIView *refreshHeaderView;
@end

@implementation XMBaseViewController
-(UITableView *)BaseTableView {
    if (_BaseTableView == nil) {
        CGRect tableFrame;
        if (self.navigationController) {
            tableFrame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 64) ;
        }else {
            tableFrame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) ;
        }
        _BaseTableView = [[UITableView alloc]initWithFrame:tableFrame style:UITableViewStylePlain];
        _BaseTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
       [self.view addSubview:_BaseTableView];
    }
    return _BaseTableView;
}

-(UIView *)nodataView {
    if (_nodataView == nil) {
        _nodataView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
        _nodataView.userInteractionEnabled = NO;
        UILabel * label  = [[UILabel alloc]init];
        label.text = @"暂无数据";
        [self.nodataView addSubview:label];
        label.textColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:1];
        label.font = [UIFont systemFontOfSize:15];
        [label sizeToFit];
        label.center = _nodataView.center;
    }
    return _nodataView;
}

-(NSMutableArray *)baseMutableDataArray {
    if (_baseMutableDataArray == nil) {
        _baseMutableDataArray = [[NSMutableArray alloc]init];
    }
    return  _baseMutableDataArray;
}

-(void)setShowNoDataView:(BOOL)showNoDataView {
    _showNoDataView = showNoDataView;
    [self showCutomNOdataView:showNoDataView];
}

-(void)showCutomNOdataView:(BOOL)show {
    if (show) {
        if (self.CustomNodataView != nil) {
            [self.view addSubview:self.CustomNodataView];
            self.CustomNodataView.center = self.view.center;
        }else {
            [self.view addSubview:self.nodataView];
        }
    }else {
        [self.CustomNodataView removeFromSuperview];
        [self.nodataView removeFromSuperview];
    }
}

-(void)dealloc {
    if (self.childClassName) {
        NSLog(@"[%@ dealloc]",self.childClassName);
    }else {
        NSLog(@"[baseVC dealloc]");
    }
}

#pragma mark: XMRefresh
-(void)addFooterRefresh {
    UIView * footerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, FooterHeight)];
    UILabel * label = [[UILabel alloc]init];
    label.text = @"上拉加载更多";
    [label sizeToFit];
    label.frame = footerView.bounds;
    label.textAlignment = NSTextAlignmentCenter;
    self.BottomLabel = label;
//    footerView.backgroundColor = [UIColor redColor];
    [footerView addSubview:label];
    self.BaseTableView.tableFooterView = footerView;
}

-(void)addXMHeaderRefrsh {
    UIView * headerView = [[UIView alloc]initWithFrame:CGRectMake(0, -HeaderHeight, [UIScreen mainScreen].bounds.size.width, HeaderHeight)];
    UILabel * label = [[UILabel alloc]init];
    label.text = @"下拉刷新";
    [label sizeToFit];
    label.frame = headerView.bounds;
//    headerView.backgroundColor = [UIColor yellowColor];
    self.headLabel = label;
    label.textAlignment = NSTextAlignmentCenter;
    [headerView addSubview:label];
    self.refreshHeaderView = headerView;
//    [self imageForheaderRefresh]; //图片header
    [self.BaseTableView addSubview:headerView];
}

-(void)imageForheaderRefresh {
    if (_XMrefreshImageView) {
//        [_XMrefreshImageView sizeToFit];
        self.headLabel.alpha = 0;
        [self.refreshHeaderView addSubview:_XMrefreshImageView];
        _XMrefreshImageView.center = CGPointMake(self.refreshHeaderView.center
                                                     .x, HeaderHeight / 2);
    }
}

-(void)setXMrefreshImageView:(UIImageView *)XMrefreshImageView {
    _XMrefreshImageView = XMrefreshImageView;
    [self imageForheaderRefresh];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (self.BaseTableView.contentSize.height == 0) {
        return;
    }
    [self headerSholdDoWhenScolling:scrollView];
    [self footerSholdDoWhenScolling:scrollView];
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    [self headerSholdDoWhenEndDragging:scrollView];
}
//headerRfreshMethod
-(void)headerSholdDoWhenScolling:(UIScrollView *)scrollView {
    if (self.isHeaderReresh) {
        return;
    }
    if (-scrollView.contentOffset.y > HeaderHeight) {
        [self headerCanRefresh];
    }else if(-scrollView.contentOffset.y > 0){
        [self headerBeinPullDown:((-scrollView.contentOffset.y) / HeaderHeight)];
    }
}

-(void)headerSholdDoWhenEndDragging:(UIScrollView *)scrollView {
    if (self.isHeaderReresh) {
        return;
    }
    if (-scrollView.contentOffset.y > HeaderHeight) {
        NSLog(@"进入刷新");
        [self headerIsRefreshing];
        self.isHeaderReresh = YES;
        [UIView animateWithDuration:0.25 animations:^{
            UIEdgeInsets inset = self.BaseTableView.contentInset;
            inset.top += HeaderHeight;
            self.BaseTableView.contentInset = inset;
        }];
        [self XMPullDownRefrsh];
    }
}

//footerRfreshMethod
-(void)footerSholdDoWhenScolling:(UIScrollView *)scrollView{
    
    if (self.isRefresh) {
        return;
    }
    if ((scrollView.contentOffset.y + self.BaseTableView.bounds.size.height) >= self.BaseTableView.contentSize.height && self.BaseTableView.contentOffset.y > 0){
        self.BottomLabel.text = @"加载中...";
        self.isRefresh = YES;
        NSLog(@"footer 出现");
        [self XMRefreshLoadMore];
    }
}

// 刷新的方法
-(void)XMRefreshLoadMore {
    self.isRefresh = NO;
}
// 进入后自动刷新
-(void)beginRefresh {
    CGPoint point = self.BaseTableView.contentOffset;
    point.y = -(HeaderHeight + 5);
    [UIView animateWithDuration: 0.25 animations:^{
       self.BaseTableView.contentOffset = point;
        [self scrollViewDidEndDragging:self.BaseTableView willDecelerate:YES];
    }];
}
//refresh Header
-(void)XMPullDownRefrsh {
    self.isHeaderReresh = NO;
}

-(void)setIsHeaderReresh:(BOOL)isHeaderReresh {
    if (_isHeaderReresh && !isHeaderReresh) {
        [UIView animateWithDuration:0.25 animations:^{
            UIEdgeInsets inset = self.BaseTableView.contentInset;
            inset.top -= HeaderHeight;
            self.BaseTableView.contentInset = inset;
        }];
        [self headerIsEndRefreshing];
    }
    _isHeaderReresh = isHeaderReresh;
}

-(void)setIsRefresh:(BOOL)isRefresh {
    _isRefresh = isRefresh;
    if (_isRefresh == NO) {
      self.BottomLabel.text = @"上拉加载更多";
    }
}

// header下拉的三种状态
-(void)headerCanRefresh {
    self.headLabel.text = @"松开即可刷新";
}
// 拉动过程
-(void)headerBeinPullDown:(CGFloat)progress {
    self.headLabel.text = @"下拉即可刷新";
    if(self.XMrefreshImageView){
        CGFloat angle = progress * M_PI * 2;
        CATransform3D transform = CATransform3DMakeRotation(angle,0, 1, 0);
        self.XMrefreshImageView.layer.transform = transform;
    }
}
// 正在刷新
-(void)headerIsRefreshing {
    self.headLabel.text = @"正在刷新";
    if (self.XMrefreshImageView) {
        CAAnimationGroup * group = [CAAnimationGroup animation];
        CABasicAnimation * rotation = [CABasicAnimation animation];
        rotation.keyPath = @"transform.rotation.y";
        rotation.toValue = @[@(M_PI)];
        group.animations = @[rotation];
        group.repeatCount = MAXFLOAT;
        group.duration = 0.8;
        [self.XMrefreshImageView.layer addAnimation:group forKey:nil];
    }
}

//刷新结束
-(void)headerIsEndRefreshing {
    if (self.XMrefreshImageView) {
        [self.XMrefreshImageView.layer removeAllAnimations];
    }
}

@end
