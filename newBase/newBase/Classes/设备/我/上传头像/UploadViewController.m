//
//  UploadViewController.m
//  newBase
//
//  Created by new-1020 on 2017/6/1.
//  Copyright © 2017年 Rowling. All rights reserved.
//

#import "UploadViewController.h"
#import "JFImagePickerController.h"

@interface UploadViewController ()<UITableViewDelegate,UITableViewDataSource,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (nonatomic,strong) UIImageView *headeImageView;
@property (nonatomic,strong) UIImage *currentImage;
@property (nonatomic,strong) NSString *currentName;
@end

@implementation UploadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.BaseTableView.delegate = self;
    self.BaseTableView.dataSource = self;
    UIButton * bton = [XMSuperHelper XMbuttonWithFrame:CGRectMake(0, 0, 70, 50) Tile:@"保存" FontSize:15 selector:@selector(btonCLick) Target:self];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:bton];
    [bton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
}

-(void)btonCLick {
    if (self.currentImage != nil) {
        [self upLoadImag];
    }
}

-(void)upLoadImag {
//    NSDictionary * dic = @{
////                           @"userId" : [LoginTool shareInstance].userModel.ID,
////                           @"name" : @"ssd"
//                           @"filekey" : @"name=files?"
//                           };
    [WYNetTool startMultiPartUploadTaskWithURL:[NSString stringWithFormat:@"http://119.23.45.80/Demo/public/Index/updateHeadImg?userId=%@",[LoginTool shareInstance].userModel.ID] imagesArray:@[self.currentImage] parameterOfimages:@"files" parametersDict:nil compressionRatio:0.5 succeedBlock:^(id task, id responseObject) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        NSLog(@"提交活动返回结果:%@",dict);

    } failedBlock:^(id task, NSError *error) {
        
    } uploadProgressBlock:nil];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell * cell = [[UITableViewCell alloc]init];
    if (indexPath.row == 0) {
        cell.textLabel.text = @"头像";
        UIImageView * imageView = [[UIImageView alloc]init];
        [imageView sd_setImageWithURL:[NSURL URLWithString:[LoginTool shareInstance].userModel.user_img]];
        [cell.contentView addSubview:imageView];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(cell.contentView);
            make.centerY.equalTo(cell.contentView);
            make.height.width.equalTo(@40);
        }];
        self.headeImageView = imageView;
        self.headeImageView.layer.cornerRadius = 20;
        self.headeImageView.layer.masksToBounds = YES;
    } else {
        cell.textLabel.text = @"昵称";
        UILabel * lable = [[UILabel alloc]init];
        [cell.contentView addSubview:lable];
        [lable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.top.bottom.equalTo(cell.contentView);
        }];
        lable.text = [LoginTool shareInstance].userModel.nickname;
        self.currentName = lable.text;
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        [self showTheAlert];
    }else {
        
    }
}

-(void)showTheAlert {
    UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"take a photo" message:@"come" preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction * selectFromPhoto = [UIAlertAction actionWithTitle:@"打开相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self openPhotoFile];
    }];
    UIAlertAction * takeAPhoto = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self openCamera];
    }];
    UIAlertAction * cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:selectFromPhoto];
    [alert addAction:takeAPhoto];
    [alert addAction:cancel];
    [self presentViewController:alert animated:YES completion:nil];
}
- (void)imagePickerDidFinished:(JFImagePickerController *)picker{
    __weak typeof(self) weakself = self;
    for (ALAsset *asset in picker.assets) {
        [[JFImageManager sharedManager] imageWithAsset:asset resultHandler:^(CGImageRef imageRef, BOOL longImage) {
            UIImage *image = [UIImage imageWithCGImage:imageRef];
            dispatch_async(dispatch_get_main_queue(), ^{
//                [weakself.ImageArray addObject:image];
//                [weakself.tableView reloadData];
                weakself.headeImageView.image = image;
                weakself.currentImage = image;
            });
        }];
    }
    [self imagePickerDidCancel:picker];
}

- (void)imagePickerDidCancel:(JFImagePickerController *)picker{
    [picker dismissViewControllerAnimated:YES completion:nil];
    [JFImagePickerController clear];
}
- (void)openPhotoFile
{
    NSInteger count = 1;
    [JFImagePickerController setMaxCount:count];
    JFImagePickerController *picker = [[JFImagePickerController alloc] initWithRootViewController:[UIViewController new]];
    picker.pickerDelegate = self;
    [self.navigationController presentViewController:picker animated:YES completion:nil];
}

- (void)openCamera
{
    UIImagePickerController *vc = [UIImagePickerController new];
    vc.sourceType = UIImagePickerControllerSourceTypeCamera;//sourcetype有三种分别是camera，photoLibrary和photoAlbum
    vc.delegate = self;
    [self.navigationController presentViewController:vc animated:YES completion:nil];
}

//#pragma mark - UIImagePickerControllerDelegate
//- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
//{
//    [self imageHandleWithpickerController:picker MdediaInfo:info];
//}
//
//- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
//    [picker dismissViewControllerAnimated:YES completion:^{}];
//}
//
//- (void)imageHandleWithpickerController:(UIImagePickerController *)picker MdediaInfo:(NSDictionary *)info {
//    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
////    [self.ImageArray addObject:image];
////    self.headeImageView.image = image;
////    [self.tableView reloadData];
//    [picker dismissViewControllerAnimated:YES completion:^{}];
//}
@end
