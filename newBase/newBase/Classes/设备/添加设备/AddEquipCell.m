//
//  AddEquipCell.m
//  newBase
//
//  Created by new-1020 on 2017/5/27.
//  Copyright © 2017年 Rowling. All rights reserved.
//

#import "AddEquipCell.h"

@interface AddEquipCell()

@property (weak, nonatomic) IBOutlet UIImageView *picImageView;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

@end

@implementation AddEquipCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setData:(NSDictionary *)data {
    _data = data;
    [self.picImageView sd_setImageWithURL:[NSURL URLWithString:data[@"img_src"]] placeholderImage:nil];
    self.contentLabel.text = [NSString stringWithFormat:@"%@\n%@",data[@"name"],data[@"content"]];
}

@end
