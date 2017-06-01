//
//  OutBandTableViewController.m
//  newBase
//
//  Created by new-1020 on 2017/6/1.
//  Copyright © 2017年 Rowling. All rights reserved.
//

#import "OutBandTableViewController.h"
#import "DevieceCell.h"
@interface OutBandTableViewController ()
@property (nonatomic,strong) NSArray *dataArray;
@end

@implementation OutBandTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerNib:[UINib nibWithNibName:@"DevieceCell" bundle:nil] forCellReuseIdentifier:@"Cell"];
    self.tableView.tableFooterView = [[UIView alloc]init];
    [self getBandEquipData];
}

-(void)getBandEquipData {
    if ([[LoginTool shareInstance] isLogin]) {
        [Apputil showMessage:@"获取设备信息中..."];
        NSDictionary * dic = @{
                               @"userId" : [LoginTool shareInstance].userModel.ID
                               };
        [WYNetTool GET_Urlstring:getBandEquip parameters:dic success:^(id responseObject) {
            self.dataArray = responseObject[@"data"];
            [self.tableView reloadData];
            [Apputil dismiss];
        } fail:^(id error) {
            [Apputil showError:@"网络出错"];
        }];
    }
}

-(void)jiebangEquip:(NSString *)ID {
    [Apputil showMessage:@"请求中"];
    NSDictionary * dic = @{
                           @"equipNum" : ID
                           };
    [WYNetTool GET_Urlstring:jiebang parameters:dic success:^(id responseObject) {
        if (errorCode) {
            [Apputil showError:@"失败"];
            return ;
        }
        [Apputil showError:@"成功"];
        [self getBandEquipData];
    } fail:^(id error) {
       [Apputil showError:@"失败"];
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DevieceCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"    forIndexPath:indexPath];
    cell.data = self.dataArray[indexPath.row];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//
    [self showAlert:indexPath.row];
    
}

-(void)showAlert:(NSInteger)tag {
    UIAlertController * vc = [UIAlertController alertControllerWithTitle:@"提示" message:@"确定要解除该设备?" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction * yes = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        [self jiebangEquip:self.dataArray[tag][@"equip_id"]];
    }];
    UIAlertAction * no = [UIAlertAction actionWithTitle:@"取消" style:0 handler:nil];
    [vc addAction:yes];
    [vc addAction:no];
    [self presentViewController:vc animated:YES completion:nil];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 140;
}

@end
