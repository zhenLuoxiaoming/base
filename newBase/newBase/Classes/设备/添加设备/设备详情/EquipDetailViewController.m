//
//  EquipDetailViewController.m
//  newBase
//
//  Created by new-1020 on 2017/5/27.
//  Copyright © 2017年 Rowling. All rights reserved.
//

#import "EquipDetailViewController.h"
#import "BandViewController.h"
@interface EquipDetailViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UIButton *nextButton;
@property (nonatomic,strong) NSDictionary * data;
@end

@implementation EquipDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadData];
    // Do any additional setup after loading the view from its nib.
}
-(void)viewWillAppear:(BOOL)animated {
    [self setUpUI];
}

-(void)setUpUI {
    self.nextButton.layer.cornerRadius = 5;
    self.nextButton.layer.masksToBounds = YES;
    self.nextButton.layer.borderWidth = 2;
    self.nextButton.layer.borderColor = XMColor(104, 173, 128).CGColor;
}


-(void)loadData {
    [Apputil showMessage:@"加载中..."];
    NSDictionary * dic = @{
                           @"equipId" : self.equipID
                           };
    
    [WYNetTool GET_Urlstring:getSingleEquipInfo parameters:dic success:^(id responseObject) {
        self.data = responseObject[@"data"];
        if (self.data) {
            [self setUIAfterGetData];
        }
        [Apputil dismiss];
    } fail:^(id error) {
        [Apputil dismiss];
        [Apputil showError:@"网络出错"];
    }];
}

-(void)setUIAfterGetData {
    [self.headImageView sd_setImageWithURL:[NSURL URLWithString:self.data[@"img_src"]] placeholderImage:nil];
    self.contentLabel.text = self.data[@"content"];
    self.title = self.data[@"name"];
}
- (IBAction)nextButtonClick:(id)sender {
    BandViewController * vc = [[BandViewController alloc]init];
    vc.equipId = self.equipID;
    vc.title = self.data[@"name"];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
