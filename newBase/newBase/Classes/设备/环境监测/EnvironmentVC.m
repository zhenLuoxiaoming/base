//
//  EnvironmentVC.m
//  newBase
//
//  Created by new-1020 on 2017/5/29.
//  Copyright © 2017年 Rowling. All rights reserved.
//

#import "EnvironmentVC.h"
#import "CityChoseView.h"


@interface EnvironmentVC ()<UITableViewDelegate,UITableViewDataSource,CityChoseViewDelegate>
@property (nonatomic,strong) UITableView * tableView;
@property (nonatomic,strong) CityChoseView *choseView;
@end
@implementation EnvironmentVC

-(UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    }
    return _tableView;
}

-(CityChoseView *)choseView {
    if (_choseView == nil) {
        _choseView = [[CityChoseView alloc]initWithFrame:self.view.bounds];;
    }
    _choseView.xDelegate = self;
    return _choseView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setStaticUI];
    [self getAInfo];
    [self getWeather];
}


-(void)setStaticUI {
    UIButton * btn = [[UIButton alloc]init];
    [btn setTitle:@"城市" forState:UIControlStateNormal];
    [btn sizeToFit];
    [btn setTitleColor:ColorDefault forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:btn];
    [btn addTarget: self  action:@selector(cityClick) forControlEvents:UIControlEventTouchUpInside];
}

-(void)cityClick {
    [self.view addSubview:self.choseView];
}

-(void)CityChoseViewSelecityCityWithString:(NSString *)str {
    
}

-(void)setUpUI {
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return  10;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell * cell = [[UITableViewCell alloc]init];
    
    return cell;
}


#warning TEST
-(void)getAInfo {
    NSDictionary * dic = @{
                           @"equipId" :@"CDHS100000003" //self.data[@"equip_number"]
                           };
    [WYNetTool GET_Urlstring:getA parameters:dic success:^(id responseObject) {
        
    } fail:^(id error) {
        
    }];
}

-(void)getWeather {
    NSDictionary * dic = @{
                           @"city" : @"成都"
                           };
    [WYNetTool GET_Urlstring:cityWeather parameters:dic success:^(id responseObject) {
        
    } fail:^(id error) {
        
    }];
}
@end
