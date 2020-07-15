//
//  ACLMineCollectChilderCVC.h
//  AnLanCustomers
//
//  Created by zk on 2020/3/20.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "BaseCollectionViewController.h"

NS_ASSUME_NONNULL_BEGIN

typedef enum {
    articleType = 1,
    dietType = 2,
    drugType = 3,
    hospitalType = 4,
    dorsType = 5
}zkManZhanHuDongType;



@interface ACLMineCollectChilderCVC : BaseViewController
/** 记录当前页面的类型type */
@property(nonatomic , assign)zkManZhanHuDongType  type;
/*记录当前页*/
@property (nonatomic , assign)NSInteger  curragePage;
/** 视图 */
@property(nonatomic , strong)UICollectionView *collectionView;

@property(nonatomic,strong)UITableView *tableView;

@end

NS_ASSUME_NONNULL_END
