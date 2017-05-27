//
//  AddEquipViewController.m
//  newBase
//
//  Created by new-1020 on 2017/5/27.
//  Copyright © 2017年 Rowling. All rights reserved.
//

#import "AddEquipViewController.h"
#import "AddEquipCell.h"
#import "EquipCollectionReusableView.h"
#import "EquipDetailViewController.h"

@interface AddEquipViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic,strong)UICollectionView * collectionView;
@property (nonatomic,strong) NSArray *dataArray;
@end

@implementation AddEquipViewController

-(UICollectionView *)collectionView {
    if (_collectionView == nil) {
        UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc]init];
        layout.itemSize = CGSizeMake(SCREEN_WIDTH / 2 - 10, SCREEN_WIDTH / 2 + 20);
        layout.headerReferenceSize=CGSizeMake(SCREEN_WIDTH, XMH(40));
        _collectionView = [[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:layout];
        [_collectionView registerNib:[UINib nibWithNibName:@"AddEquipCell" bundle:nil] forCellWithReuseIdentifier:@"Cell"];
        [_collectionView registerNib:[UINib nibWithNibName:@"EquipCollectionReusableView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"RView"];
        _collectionView.backgroundColor = [UIColor whiteColor];
        
    }
    return _collectionView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"添加设备";
    [self loadEquipData];
}

-(void)creatUI {
    [self.view addSubview:self.collectionView];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
}

-(void)loadEquipData {
    [Apputil showMessage:@"获取设备列表中..."];
    [WYNetTool GET_Urlstring:getEquipList parameters:nil success:^(id responseObject) {
        self.dataArray = [responseObject objectForKey:@"data"];
        if (self.dataArray) {
            [self creatUI];
        }
        [Apputil dismiss];
    } fail:^(id error) {
        [Apputil dismiss];
        [Apputil showMessage:@"网络出错"];
    }];
}


-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.dataArray[section][@"equipInfo"] count];
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.dataArray.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    AddEquipCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    cell.data = self.dataArray[indexPath.section][@"equipInfo"][indexPath.row];
    return cell;
}

-(UICollectionReusableView*)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    EquipCollectionReusableView * view = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"RView" forIndexPath:indexPath];
//    NSLog(@"%@",self.dataArray[indexPath.section][@"type_name"]);
    view.titleLabel.text = self.dataArray[indexPath.section][@"type_name"];
    return view;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    EquipDetailViewController * vc = [[EquipDetailViewController alloc]init];
    long ID = [self.dataArray[indexPath.section][@"equipInfo"][indexPath.row][@"id"] longValue];
    vc.equipID =  [NSString stringWithFormat:@"%ld",ID];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
