//
//  FeedBackViewController.m
//  newBase
//
//  Created by new-1020 on 2017/6/1.
//  Copyright © 2017年 Rowling. All rights reserved.
//

#import "FeedBackViewController.h"

@interface FeedBackViewController ()
@property (weak, nonatomic) IBOutlet UITextView *textView;

@end

@implementation FeedBackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.textView.layer.cornerRadius = 5;
    self.textView.layer.masksToBounds = YES;
    self.textView.layer.borderWidth = 1;
    self.textView.layer.borderColor = ColorDefault.CGColor;
}

- (IBAction)tijiaoButtonClick:(id)sender {
    if ([self.textView.text isEqualToString:@""]) {
        [Apputil showError:@"请输入内容"];
        return;
    }
    [self feedback];
}

-(void)feedback {
    
    NSDictionary * dic = @{
                           @"content" : self.textView.text,
                           @"userId" : [LoginTool shareInstance].userModel.ID
                           };
    
    [WYNetTool POST_Urlstring:feebackurl parameters:dic success:^(id responseObject) {
        if (errorCode) {
            [Apputil showError:@"反馈失败"];
            return ;
        }
        [Apputil showError:@"反馈成功"];
        [self.navigationController popViewControllerAnimated:YES];
    } fail:^(id error) {
        [Apputil showError:@"网络错误"];
    }];
}

@end
