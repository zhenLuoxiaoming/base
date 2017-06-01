//
//  EnvironmentVC.m
//  newBase
//
//  Created by new-1020 on 2017/5/29.
//  Copyright © 2017年 Rowling. All rights reserved.
//

#import "EnvironmentVC.h"
#import "CityChoseView.h"
#import "EnviroHeaderView.h"
#import "XMSocktManager.h"
#import "WeekModelViewControolerViewController.h"
#import "WuranModeViewController.h"

@interface EnvironmentVC ()<UITableViewDelegate,UITableViewDataSource,CityChoseViewDelegate,XMSocktManagerDelegate>
@property (nonatomic,strong) UITableView * tableView;
@property (nonatomic,strong) CityChoseView *choseView;
@property (nonatomic,strong) EnviroHeaderView *headerView;
@property (nonatomic,strong) NSArray *stringArray;
@property (nonatomic,strong) NSString *currentCity;
@property (nonatomic,strong) UIButton *cityButton;
@property (nonatomic,strong) UIButton *openButton;
@end
@implementation EnvironmentVC

-(EnviroHeaderView *)headerView {
    if (_headerView == nil) {
        _headerView =  [EnviroHeaderView fastLogin];
        _headerView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 907);
    }
    return _headerView;
}

-(UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64 - 50) style:UITableViewStylePlain];
        _tableView.tableFooterView = [[UIView alloc]init];
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
    self.title = @"环境监测";
    self.currentCity = @"成都";
    self.stringArray = @[@"儿童模式",@"周末模式",@"污染模式",@"历史数据"];
    [self setUpUI];
    [self setStaticUI];
    [self getAInfo];
    [self getWeather];
    [self setFooterView];
}
//脚部view
-(void)setFooterView {
    UIView * footer = [[UIView alloc]init];
    footer.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:footer];
    [footer mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self.view);
        make.height.equalTo(@50);
    }];
    UIButton * btn = [[UIButton alloc]init];
    [footer addSubview:btn];
    [btn setTitle:@"开启" forState:UIControlStateNormal];
    [btn setTitle:@"关闭" forState:UIControlStateSelected];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(footer).offset(50);
        make.right.equalTo(footer).offset(-50);
        make.centerY.equalTo(footer);
        make.height.equalTo(@35);
    }];
    self.openButton = btn;
    [btn setTitleColor:ColorDefault forState:UIControlStateNormal];
    [btn setTitleColor:ColorDefault forState:UIControlStateSelected];
    btn.layer.cornerRadius = 5;
    btn.layer.masksToBounds = YES;
    btn.layer.borderWidth = 1;
    btn.layer.borderColor = ColorDefault.CGColor;
    [btn addTarget:self action:@selector(openButtonClikc:) forControlEvents:UIControlEventTouchUpInside];
}

-(void)openButtonClikc:(UIButton *)sender {
    sender.selected = !sender.selected;
    [[XMSocktManager shareInstance] sendDirectorWithA:sender.selected b:0 c:0 d:2];
}

-(void)setStaticUI {
    UIButton * btn = [[UIButton alloc]init];
    [btn setTitle:@"成都" forState:UIControlStateNormal];
    [btn sizeToFit];
    [btn setTitleColor:ColorDefault forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:btn];
    [btn addTarget: self  action:@selector(cityClick) forControlEvents:UIControlEventTouchUpInside];
    self.cityButton = btn;
}

-(void)cityClick {
    [self.view addSubview:self.choseView];
}

-(void)CityChoseViewSelecityCityWithString:(NSString *)str {
    self.currentCity = str;
    [self.cityButton setTitle:str forState:UIControlStateNormal];
    [self.cityButton sizeToFit];
    [self getWeather];
}

-(void)setUpUI {
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return  4;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell * cell = [[UITableViewCell alloc]init];
    cell.textLabel.textColor = ColorDefault;
    cell.textLabel.text = self.stringArray[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        WeekModelViewControolerViewController * vc = [[WeekModelViewControolerViewController alloc]init];
        vc.title = @"儿童模式";
        [self.navigationController pushViewController:vc animated:YES];
        return;
    }
    if (indexPath.row == 1) {
        WeekModelViewControolerViewController * vc = [[WeekModelViewControolerViewController alloc]init];
        vc.title = @"周末模式";
        [self.navigationController pushViewController:vc animated:YES];
        return;
    }
    if (indexPath.row == 2) {
        WuranModeViewController * vc = [[WuranModeViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }
}


-(void)getAInfo {
    [XMSocktManager shareInstance].delegate = self;
    [[XMSocktManager shareInstance] sendMessageWithEquipID:self.data[@"equip_number"]];//@"CDHS100000003"];
    [self getRuntime];
}

#pragma -mark:xmsocktDelegate
-(void)XMSocktManagerGetAWithData:(NSDictionary *)data {
    self.headerView.Adata = data;
}

-(void)XMSocktManagerGetBWithData:(NSDictionary *)data {
    self.openButton.selected = [data[@"fan"] isEqualToString:@"1"];
    self.headerView.Bdata = data;
}


-(void)getRuntime {
    NSDictionary * dic = @{
                           @"equipId" :self.data[@"equip_number"]// @"CDHS100000003"
                           };
    
    [WYNetTool GET_Urlstring:rumtimeUrl parameters:dic success:^(id responseObject) {
        if (errorCode) {
            [Apputil showError:@"错误"];
            return ;
        }
        self.headerView.rumtimeData = responseObject[@"data"];
    } fail:^(id error) {
        [Apputil showError:@"网络错误"];
    }];
}

-(void)getWeather {
    NSDictionary * dic = @{
                           @"city" : self.currentCity
                           };
    [WYNetTool GET_Urlstring:cityWeather parameters:dic success:^(id responseObject) {
        self.tableView.tableHeaderView = self.headerView;
        self.headerView.data = responseObject[@"result"];
    } fail:^(id error) {
        [Apputil showError:@"请求失败"];
    }];
}
@end
