//
//  ALChatMessageTVC.h
//  AnLanBB
//
//  Created by zk on 2020/4/23.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "BaseTableViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface ALChatMessageTVC : BaseTableViewController
@property(nonatomic,strong)NSString *toUserId;
//@property(nonatomic,strong)NSString *nameStr;
//@property(nonatomic,strong)NSString *toAvatar;
@property(nonatomic,strong)NSString *aimtype;
@property(nonatomic,strong)NSString *aimUserId;
@end

NS_ASSUME_NONNULL_END
