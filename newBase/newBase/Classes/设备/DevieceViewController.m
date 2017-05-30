//
//  DevieceViewController.m
//  newBase
//
//  Created by new-1020 on 2017/5/24.
//  Copyright © 2017年 Rowling. All rights reserved.
//

#import "DevieceViewController.h"
#import "LoginViewController.h"
#import "AddEquipViewController.h"
#import "DevieceCell.h"
#import "EnvironmentVC.h"
@interface DevieceViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)UITableView * tableView;
@property (nonatomic,strong) NSArray *dataArray;

@end

@implementation DevieceViewController

-(UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [[UIView alloc]init];
        [_tableView registerNib:[UINib nibWithNibName:@"DevieceCell" bundle:nil] forCellReuseIdentifier:@"Cell"];
    }
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self showLogin];
    [self setUpUI];
    
}

-(void)viewWillAppear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    [self getBandEquipData];
}

-(void)viewWillDisappear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

-(void)getBandEquipData {
    if ([[LoginTool shareInstance] isLogin]) {
        [Apputil showMessage:@"获取设备信息中..."];
        NSDictionary * dic = @{
                               @"userId" : [LoginTool shareInstance].userModel.ID
                               };
        [WYNetTool GET_Urlstring:getBandEquip parameters:dic success:^(id responseObject) {
            self.dataArray = responseObject[@"data"];
            [self.view addSubview:self.tableView];
            [Apputil dismiss];
        } fail:^(id error) {
            [Apputil showError:@"网络出错"];
        }];
    }
}
#pragma -mark:tableDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    UITableViewCell * cell = [[UITableViewCell alloc]init];
    DevieceCell * cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    cell.data = self.dataArray[indexPath.row];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 140;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    EnvironmentVC * vc = [[EnvironmentVC alloc]init];
    vc.data = self.dataArray[indexPath.row];
    [self.navigationController pushViewController:vc animated:YES];
}


-(void)setUpUI {
    self.view.backgroundColor = [UIColor whiteColor];
    UIView * navView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 64)];
    [self.view addSubview:navView];
    UIImageView * headImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
    [XMSuperHelper clipCircleFromeView:headImageView withRadius:20];
    headImageView.layer.borderWidth = 1;
    headImageView.layer.borderColor = [UIColor blackColor].CGColor;
    [headImageView sd_setImageWithURL:[NSURL URLWithString:[LoginTool shareInstance].userModel.user_img] placeholderImage:nil];
    [navView addSubview:headImageView];
    [headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(navView).offset(10);
        make.bottom.equalTo(navView).offset(-10);
        make.height.width.equalTo(@40);
    }];
    
    UILabel * NameLabel = [[UILabel alloc]init];
    NameLabel.textColor = XMColor(104, 173, 128);
    if ([[LoginTool shareInstance] isLogin]) {
        NameLabel.text = [LoginTool shareInstance].userModel.nickname;
    }else {
        NameLabel.text = @"请登录";
    }
    [navView addSubview:NameLabel];
    [NameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(headImageView.mas_centerY);
        make.left.equalTo(headImageView.mas_right).offset(10);
    }];
    
    UIButton * addButton = [[UIButton alloc]init];
    [addButton setImage:[UIImage imageNamed:@"tinajiashe"] forState:UIControlStateNormal];
    [addButton sizeToFit];
    [navView addSubview:addButton];
    [addButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(headImageView.mas_centerY);
        make.right.equalTo(navView).offset(-20);
    }];
    [addButton addTarget:self action:@selector(addButtonClick) forControlEvents:UIControlEventTouchUpInside];
    UIView *lineView = [[UIView alloc]init];
    [navView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(navView);
        make.height.equalTo(@1);
    }];
    lineView.backgroundColor = [UIColor grayColor];
    
    UILabel * noEqumLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 200)];
    noEqumLabel.text = @"你还没有设备\n点击右上角的 + 添加设备";
    noEqumLabel.numberOfLines = 2;
    noEqumLabel.textColor = ColorDefault;
    noEqumLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:noEqumLabel];
    noEqumLabel.center = self.view.center;
}


-(void)addButtonClick {
    [[LoginTool shareInstance] youMustLoinWithTarget:self Dothis:^{
        AddEquipViewController * vc = [[AddEquipViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }];
}


-(void)showLogin {
    LoginViewController * vc = [[LoginViewController alloc]init];
    [self presentViewController:vc animated:YES completion:nil];
}



@end
