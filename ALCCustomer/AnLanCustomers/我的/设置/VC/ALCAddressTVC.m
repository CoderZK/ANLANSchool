//
//  ALCAddressTVC.m
//  AnLanCustomers
//
//  Created by zk on 2020/3/23.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "ALCAddressTVC.h"
#import "ALCAddressCell.h"
#import "QYZJAddAddressVC.h"
@interface ALCAddressTVC ()<ALCAddressCellDelegete>

@end

@implementation ALCAddressTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setFootV];
    self.navigationItem.title = @"管理收货地址";
    [self.tableView registerNib:[UINib nibWithNibName:@"ALCAddressCell" bundle:nil] forCellReuseIdentifier:@"cell"];
     self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
     self.tableView.estimatedRowHeight = 80;
     self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    
}

- (CGFloat )tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 10;
}

- (UIView * )tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView * view  =[tableView dequeueReusableHeaderFooterViewWithIdentifier:@"view"];
    if (view == nil ) {
        view =[[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 10)];
        view.clipsToBounds = YES;
        view.backgroundColor = [UIColor clearColor];
    }
    return view;
}

- (UIView * )tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView * view  =[tableView dequeueReusableHeaderFooterViewWithIdentifier:@"view"];
    if (view == nil ) {
        view =[[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 10)];
        view.clipsToBounds = YES;
        view.backgroundColor = [UIColor clearColor];
    }
    return view;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ALCAddressCell * cell =[tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.delegate = self;
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}


#pragma mark --- 顶级编辑删除默认 ----
- (void)didClickALCAddressCell:(UITableViewCell *)cell withTag:(NSInteger)tag {
    
    NSIndexPath * indexPath = [self.tableView indexPathForCell:cell];
    
    if (tag == 100) {
        //设为默认
        
    }else if (tag == 101) {
        //编辑
        QYZJAddAddressVC * vc =[[QYZJAddAddressVC alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        vc.isEdit  = YES;
        [self.navigationController pushViewController:vc animated:YES];
        
    }else {
        //删除
        
    }
    
    
    
}

- (void)setFootV {
    self.tableView.frame = CGRectMake(0, 0, ScreenW, ScreenH - 60);
    if (sstatusHeight > 20) {
        self.tableView.frame = CGRectMake(0, 0, ScreenW, ScreenH  - 60 - 34);
    }

    KKKKFootView * view = [[PublicFuntionTool shareTool] createFootvWithTitle:@"新增收获地址" andImgaeName:@""];
    Weak(weakSelf);
        view.footViewClickBlock = ^(UIButton *button) {
           
            QYZJAddAddressVC * vc =[[QYZJAddAddressVC alloc] init];
            vc.hidesBottomBarWhenPushed = YES;
            [weakSelf.navigationController pushViewController:vc animated:YES];
           
       };
    [self.view addSubview:view];
}




@end
