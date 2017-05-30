//
//  DevieceCell.m
//  newBase
//
//  Created by new-1020 on 2017/5/29.
//  Copyright © 2017年 Rowling. All rights reserved.
//



#import "DevieceCell.h"

@interface DevieceCell()
@property (weak, nonatomic) IBOutlet UIImageView *headImage;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLable;

@end

@implementation DevieceCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

-(void)setData:(NSDictionary *)data {
    _data =data;
    self.titleLabel.text = data[@"name"];
    self.contentLable.text = data[@"content"];
    [self.headImage sd_setImageWithURL:[NSURL URLWithString:data[@"img_src"]] placeholderImage:nil];
    
}
@end
