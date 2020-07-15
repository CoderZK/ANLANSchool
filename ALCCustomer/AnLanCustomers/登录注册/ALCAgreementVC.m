//
//  ALCAgreementVC.m
//  AnLanCustomers
//
//  Created by zk on 2020/4/27.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "ALCAgreementVC.h"

@interface ALCAgreementVC ()
@property (weak, nonatomic) IBOutlet UITextView *TV;

@end

@implementation ALCAgreementVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"用户协议和隐私";
    
    [self getData];
    
}

- (void)getData {
    [SVProgressHUD show];
    NSMutableDictionary * dict = @{}.mutableCopy;
    dict[@"type"] = @"1";
    [zkRequestTool networkingPOST:[QYZJURLDefineTool app_getBaseInfoURL] parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
    
        [SVProgressHUD dismiss];
        if ([responseObject[@"key"] intValue]== 1) {
            
            self.TV.text = [NSString stringWithFormat:@"%@",responseObject[@"data"][@"content"]];
            
        }else {
             [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"key"]] message:responseObject[@"message"]];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
      
        
    }];
}




@end
