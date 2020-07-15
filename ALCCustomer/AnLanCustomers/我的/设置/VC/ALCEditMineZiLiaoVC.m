//
//  ALCEditMineZiLiaoVC.m
//  AnLanCustomers
//
//  Created by zk on 2020/4/28.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "ALCEditMineZiLiaoVC.h"
#import <Photos/Photos.h>

@interface ALCEditMineZiLiaoVC ()
@property (weak, nonatomic) IBOutlet UIImageView *imgV;
@property (weak, nonatomic) IBOutlet UILabel *nameLB;
@property(nonatomic,strong)UIImage *image;

@end

@implementation ALCEditMineZiLiaoVC

- (void)viewDidLoad {
    [super viewDidLoad];
   
    
    self.navigationItem.title = @"修改资料";
    
    self.imgV.layer.cornerRadius = 25;
    self.imgV.clipsToBounds = YES;
    self.nameLB.text = [zkSignleTool shareTool].nick_name;
    [self.imgV sd_setImageWithURL:[[zkSignleTool shareTool].avatar getPicURL] placeholderImage:[UIImage imageNamed:@"369"] options:(SDWebImageRetryFailed)];
    
    
    
}
- (IBAction)action:(UIButton *)button {
    if (button.tag == 100) {
        [self addPict];
    }else {
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:@"请输入昵称" preferredStyle:UIAlertControllerStyleAlert];
                                      
                                      [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
                                      
                                      [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                                          
                                          UITextField*userNameTF = alertController.textFields.firstObject;
                                          if (userNameTF.text.length == 0) {
                                              return ;
                                              
                                          }
                                          [self editUserInfoWithDict:@{@"nickname":userNameTF.text} type:2];
                                          
                                          
                                      }]];
                                      
                                      [alertController addTextFieldWithConfigurationHandler:^(UITextField*_Nonnull textField) {
                                          
                                          textField.placeholder=@"请输入昵称";
                                          
                                          
                                          
                                      }];
                                      
                                      [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alertController animated:YES completion:nil];
        
        
       
        
        
    }
    
    
}

- (void)editUserInfoWithDict:(NSDictionary *)dict type:(NSUInteger )type{
    if (!isDidLogin) {
           [self gotoLoginVC];
           return;
       }
    [SVProgressHUD show];
    [zkRequestTool networkingPOST:[QYZJURLDefineTool user_editUserInfoURL] parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {

        [SVProgressHUD dismiss];
        if ([responseObject[@"key"] intValue]== 1) {
            if (type == 2) {
                self.nameLB.text = dict[@"nickname"];
            }
        }else {
            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"key"]] message:responseObject[@"message"]];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
       
        
    }];
    
}

- (void)addPict {
    
    UIAlertController *ac = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if ([self isCanUsePhotos]) {
            
         
            [self showMXPhotoCameraAndNeedToEdit:YES completion:^(UIImage *image, UIImage *originImage, CGRect cutRect) {
                
                self.image = image;
                [self updateImgsToQiNiuYun];
                
//                    [self.picsArr addObject:image];
//                    [self addPicsWithArr:self.picsArr];
//                    [self updateImgsToQiNiuYun];
            }];
       
        }else{
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"无法使用相机" message:@"请在iPhone的""设置-隐私-相机""中允许访问相机" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
        }
        
    }];
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"从相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        if ([self isCanUsePicture]) {
            [self showMXPickerWithMaximumPhotosAllow:1 completion:^(NSArray *assets) {
                
                if (assets.count>0) {
                    ALAsset *asset = assets[0];
                    ALAssetRepresentation *assetRep = [asset defaultRepresentation];
                    CGImageRef imgRef = [assetRep fullResolutionImage];
                    UIImage *image = [[UIImage alloc] initWithCGImage:imgRef
                                                                scale:assetRep.scale
                                                          orientation:(UIImageOrientation)assetRep.orientation];
                    
                    if (!image) {
                        image = [[UIImage alloc] initWithCGImage:[[asset defaultRepresentation] fullScreenImage]
                                                           scale:assetRep.scale
                                                     orientation:(UIImageOrientation)assetRep.orientation];
                        
                    }
                    if (!image) {
                        CGImageRef thum = [asset aspectRatioThumbnail];
                        image = [UIImage imageWithCGImage:thum];
                    }
                    self.image = image;
                    [self updateImgsToQiNiuYun];
                
                }
                
                
            }];
           
        }else{
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"无法使用相册" message:@"请在iPhone的""设置-隐私-相册""中允许访问相册" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
        }
    }];
    
    UIAlertAction * action4 = [UIAlertAction actionWithTitle:@"看大图" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {

        NSString * str = [zkSignleTool shareTool].avatar;
        if (str.length > 0) {
            [[zkPhotoShowVC alloc] initWithArray:@[[zkSignleTool shareTool].avatar] index:0];
        }
    }];
    
    UIAlertAction *action3 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [ac addAction:action1];
    [ac addAction:action2];
    [ac addAction:action4];
    [ac addAction:action3];
    
    [self.navigationController presentViewController:ac animated:YES completion:nil];
    
}


- (void)updateImgsToQiNiuYun {
    
    [zkRequestTool NetWorkingUpLoad:[QYZJURLDefineTool upload_file_to_qiniuURL] images:@[self.image] name:@"file" parameters:@{@"type":@1} success:^(NSURLSessionDataTask *task, id responseObject) {
                
                if ([responseObject[@"key"] intValue]== 1) {
                    
                    NSArray * arr = responseObject[@"data"];
                    if (arr.count > 0) {
//                        [self updateServWithStr:[NSString stringWithFormat:@"http://%@",arr[0][@"qiniu_url"]]];
                        
                        [self editUserInfoWithDict:@{@"avatar":[NSString stringWithFormat:@"http://%@",arr[0][@"qiniu_url"]]} type:1];
                        
                        [zkSignleTool shareTool].avatar = [NSString stringWithFormat:@"http://%@",arr[0][@"qiniu_url"]];
                        [self.imgV sd_setImageWithURL:[[zkSignleTool shareTool].avatar getPicURL] placeholderImage:[UIImage imageNamed:@"369"] options:(SDWebImageRetryFailed)];
                    }
                    
                   
                }else {
                    [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"key"]] message:responseObject[@"message"]];
                }
            } failure:^(NSURLSessionDataTask *task, NSError *error) {
                NSLog(@"%@",error);
    
            }];
    
}

//- (void)updateServWithStr:(NSString *  )str  {
//    [SVProgressHUD show];
//    NSMutableDictionary * dict = @{}.mutableCopy;
//    dict[@"avatar"] = str;
//    [zkRequestTool networkingPOST:[QYZJURLDefineTool user_editUserInfoURL] parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
//        [SVProgressHUD dismiss];
//
//    } failure:^(NSURLSessionDataTask *task, NSError *error) {
//
//         [SVProgressHUD dismiss];
//    }];
//}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
