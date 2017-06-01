//
//  EnviroHeaderView.m
//  newBase
//
//  Created by new-1020 on 2017/5/30.
//  Copyright © 2017年 Rowling. All rights reserved.
//

#import "EnviroHeaderView.h"
#import "XMSocktManager.h"
@interface EnviroHeaderView()
@property (weak, nonatomic) IBOutlet UILabel *pingfenLable;
@property (weak, nonatomic) IBOutlet UILabel *firstLable;
@property (weak, nonatomic) IBOutlet UILabel *secondLable;
@property (weak, nonatomic) IBOutlet UILabel *wetherLable;
@property (weak, nonatomic) IBOutlet UILabel *thirdLable;

@property (weak, nonatomic) IBOutlet UILabel *ShiNeiTepLable;
@property (weak, nonatomic) IBOutlet UILabel *shiduLable;

@property (weak, nonatomic) IBOutlet UIButton *zhinengButton;

@property (weak, nonatomic) IBOutlet UIButton *kaidengButton;

@property (weak, nonatomic) IBOutlet UIButton *hengwenButton;

@property (weak, nonatomic) IBOutlet UIButton *jiandangButton;

@property (weak, nonatomic) IBOutlet UIButton *jiadangButton;
@property (weak, nonatomic) IBOutlet UIButton *shoudongButton;
@property (weak, nonatomic) IBOutlet UILabel *shineiPmLable;

@end

@implementation EnviroHeaderView

+(instancetype)fastLogin {
    return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil].firstObject;
}

-(void)setData:(NSDictionary *)data {
    _data = data;
    self.wetherLable.text = data[@"weather"];
    self.secondLable.text = [NSString stringWithFormat:@"温度:%@°C",data[@"temp"]];
    self.pingfenLable.text = data[@"aqi"][@"pm2_5"];
    
}

-(void)setAdata:(NSDictionary *)Adata {
    _Adata = Adata;
    NSString * air;
    if ([Adata[@"air"] isEqualToString:@"00"]) {
        air = @"清洁";
    }
    if ([Adata[@"air"] isEqualToString:@"01"]) {
        air = @"轻度污染";
    }
    if ([Adata[@"air"] isEqualToString:@"10"]) {
        air = @"中度污染";
    }
    if ([Adata[@"air"] isEqualToString:@"11"]) {
        air = @"重度污染";
    }
    self.firstLable.text = [NSString stringWithFormat:@"室外空气·%@",air];
    self.thirdLable.text = [NSString stringWithFormat:@"湿度%@ %%",Adata[@"humidity"]];
    self.ShiNeiTepLable.text = [NSString stringWithFormat:@"温度:%@°C",Adata[@"temperature"]];
    self.shiduLable.text = [NSString stringWithFormat:@"湿度%@ %%",Adata[@"humidity"]];
    self.shineiPmLable.text = Adata[@"pm"];
 }


-(void)setBdata:(NSDictionary *)Bdata {
    _Bdata = Bdata;
    self.kaidengButton.selected = [Bdata[@"light"] isEqualToString:@"1"];
    self.hengwenButton.selected = [Bdata[@"heating"] isEqualToString:@"1"];
}

- (IBAction)btnClick:(UIButton *)sender {
    if (sender.tag == 104 ) {
        [[XMSocktManager shareInstance]  sendDirectorWithA:1 b:self.kaidengButton.selected c:self.hengwenButton.selected d:1];
        return;
    }
    if (sender.tag == 103) {
          [[XMSocktManager shareInstance]  sendDirectorWithA:1 b:self.kaidengButton.selected c:self.hengwenButton.selected d:0];
        return;
    }
    sender.selected = !sender.selected;
    [[XMSocktManager shareInstance]  sendDirectorWithA:1 b:self.kaidengButton.selected c:self.hengwenButton.selected d:2];
}


- (IBAction)shoudongButtonCLick:(id)sender {
    [[XMSocktManager shareInstance] sendEWith:1];
}

- (IBAction)zhinengButtonClick:(id)sender {
    [[XMSocktManager shareInstance] sendEWith:0];

}

@end
