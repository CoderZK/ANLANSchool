//
//  ALMessageModel.m
//  AnLanBB
//
//  Created by zk on 2020/4/23.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "ALMessageModel.h"

@implementation ALMessageModel
+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"ID":@"id",@"des":@"description"};
}


#pragma mark ----- 转模型 ------
- (void)setArticle:(ALMessageModel *)article {
    _article = [ALMessageModel mj_objectWithKeyValues:article];
}
- (void)setInfo:(ALMessageModel *)info {
    _info = [ALMessageModel mj_objectWithKeyValues:info];
}

- (void)setProjectDetail:(ALMessageModel *)projectDetail {
    _projectDetail = [ALMessageModel mj_objectWithKeyValues:projectDetail];
}
- (void)setHeartrate:(ALMessageModel *)heartrate {
    _heartrate = [ALMessageModel mj_objectWithKeyValues:heartrate];
}

- (void)setWeightData:(ALMessageModel *)weightData {
    _weightData = [ALMessageModel mj_objectWithKeyValues:weightData];
}

- (void)setBloodpressure:(ALMessageModel *)bloodpressure {
    _bloodpressure = [ALMessageModel mj_objectWithKeyValues:bloodpressure];
}
- (void)setStepnumberData:(ALMessageModel *)stepnumberData {
    _stepnumberData = [ALMessageModel mj_objectWithKeyValues:stepnumberData];
}

- (void)setMenstrual:(ALMessageModel *)menstrual {
    _menstrual = [ALMessageModel mj_objectWithKeyValues:menstrual];
}

- (void)setUserInfo:(ALMessageModel *)userInfo {
    _userInfo = [ALMessageModel mj_objectWithKeyValues:userInfo];
}

- (void)setHealthdata:(ALMessageModel *)healthdata {
    _healthdata = [ALMessageModel mj_objectWithKeyValues:healthdata];
}

#pragma mark ------- 转模型数组 -------

- (void)setCommentList:(NSMutableArray<ALMessageModel *> *)commentList {
    _commentList = [ALMessageModel mj_objectArrayWithKeyValuesArray:commentList];
}

- (void)setRecommendProjectList:(NSMutableArray<ALMessageModel *> *)recommendProjectList {
    _recommendProjectList = [ALMessageModel mj_objectArrayWithKeyValuesArray:recommendProjectList];
}

- (void)setDepartmentList:(NSMutableArray<ALMessageModel *> *)departmentList {
    _departmentList = [ALMessageModel mj_objectArrayWithKeyValuesArray:departmentList];
}

- (void)setRecommendDoctorList:(NSMutableArray<ALMessageModel *> *)recommendDoctorList {
    _recommendDoctorList = [ALMessageModel mj_objectArrayWithKeyValuesArray:recommendDoctorList];
}

- (void)setDoctorList:(NSMutableArray<ALMessageModel *> *)doctorList {
    _doctorList = [ALMessageModel mj_objectArrayWithKeyValuesArray:doctorList];
}

- (void)setInstitutionList:(NSMutableArray<ALMessageModel *> *)institutionList {
    _institutionList = [ALMessageModel mj_objectArrayWithKeyValuesArray:institutionList];
}

- (void)setDoctorAppointment:(NSMutableArray<ALMessageModel *> *)doctorAppointment {
    _doctorAppointment = [ALMessageModel mj_objectArrayWithKeyValuesArray:doctorAppointment];
}

- (void)setCalenderSchedule:(NSMutableArray<ALMessageModel *> *)calenderSchedule {
    _calenderSchedule = [ALMessageModel mj_objectArrayWithKeyValuesArray:calenderSchedule];
}

- (void)setArticleList:(NSMutableArray<ALMessageModel *> *)articleList {
    _articleList = [ALMessageModel mj_objectArrayWithKeyValuesArray:articleList];
}

- (void)setAppoinmentHistory:(NSMutableArray<ALMessageModel *> *)appoinmentHistory {
    _appoinmentHistory = [ALMessageModel mj_objectArrayWithKeyValuesArray:appoinmentHistory];
}

- (void)setDoctors:(NSMutableArray<ALMessageModel *> *)doctors {
    _doctors = [ALMessageModel mj_objectArrayWithKeyValuesArray:doctors];
    
}
- (void)setDoctorAppoints:(NSMutableArray<ALMessageModel *> *)doctorAppoints {
    _doctorAppoints = [ALMessageModel mj_objectArrayWithKeyValuesArray:doctorAppoints];
}

- (void)setStepNub:(NSMutableArray<ALMessageModel *> *)stepNub {
    _stepNub = [ALMessageModel mj_objectArrayWithKeyValuesArray:stepNub];
}

- (void)setHeartrateNub:(NSMutableArray<ALMessageModel *> *)heartrateNub {
    _heartrateNub = [ALMessageModel mj_objectArrayWithKeyValuesArray:heartrateNub];
}
- (void)setBloodpressureNub:(NSMutableArray<ALMessageModel *> *)bloodpressureNub {
    _bloodpressureNub = [ALMessageModel mj_objectArrayWithKeyValuesArray:bloodpressureNub];
}
- (void)setWeightNub:(NSMutableArray<ALMessageModel *> *)weightNub {
    _weightNub =[ALMessageModel mj_objectArrayWithKeyValuesArray:weightNub];
}

@end
