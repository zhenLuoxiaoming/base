//
//  XMBaseViewController.h
//  XMNewBeeBaseController
//
//  Created by new-1020 on 2017/3/20.
//  Copyright © 2017年 new-1020. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XMBaseViewController : UIViewController
@property (nonatomic,strong)UITableView * BaseTableView;
@property (nonatomic,assign) BOOL showNoDataView;
@property (nonatomic,strong) UIView * CustomNodataView;
@property (nonatomic,strong) NSDictionary * baseData;
@property (nonatomic,strong) NSArray * baseDataArray;
@property (nonatomic,strong) NSMutableArray * baseMutableDataArray;
@property (nonatomic,strong) NSString * childClassName;
@property (nonatomic,assign) BOOL isRefresh;
@property (nonatomic,assign) BOOL isHeaderReresh;
@property(nonatomic,strong) UIImageView * XMrefreshImageView;
-(void)addFooterRefresh;
-(void)XMRefreshLoadMore;
-(void)addXMHeaderRefrsh;
-(void)XMPullDownRefrsh;
-(void)beginRefresh;
@end
