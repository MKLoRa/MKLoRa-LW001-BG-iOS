//
//  MKBGDeviceModeController.m
//  MKLoRaWAN-BG_Example
//
//  Created by aa on 2021/5/24.
//  Copyright © 2021 aadyx2007@163.com. All rights reserved.
//

#import "MKBGDeviceModeController.h"

#import "Masonry.h"

#import "MKMacroDefines.h"
#import "MKBaseTableView.h"
#import "UIView+MKAdd.h"
#import "UITableView+MKAdd.h"

#import "MKHudManager.h"
#import "MKNormalTextCell.h"
#import "MKTextButtonCell.h"

#import "MKBGInterface.h"
#import "MKBGInterface+MKBGConfig.h"

#import "MKBGTimingModeController.h"
#import "MKBGPeriodicModeController.h"
#import "MKBGMotionModeController.h"

@interface MKBGDeviceModeController ()<UITableViewDelegate,
UITableViewDataSource,
MKTextButtonCellDelegate>

@property (nonatomic, strong)MKBaseTableView *tableView;

@property (nonatomic, strong)NSMutableArray *section0List;

@property (nonatomic, strong)NSMutableArray *section1List;

@end

@implementation MKBGDeviceModeController

- (void)dealloc {
    NSLog(@"MKBGDeviceModeController销毁");
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadSubViews];
    [self loadSectionDatas];
    [self readDataFromDevice];
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44.f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1 && indexPath.row == 0) {
        //MKBGTimingModeController
        MKBGTimingModeController *vc = [[MKBGTimingModeController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
        return;
    }
    if (indexPath.section == 1 && indexPath.row == 1) {
        //Periodic Mode
        MKBGPeriodicModeController *vc = [[MKBGPeriodicModeController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
        return;
    }
    if (indexPath.section == 1 && indexPath.row == 2) {
        //Motion Mode
        MKBGMotionModeController *vc = [[MKBGMotionModeController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
        return;
    }
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return self.section0List.count;
    }
    return self.section1List.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        MKTextButtonCell *cell = [MKTextButtonCell initCellWithTableView:tableView];
        cell.dataModel = self.section0List[indexPath.row];
        cell.delegate = self;
        return cell;
    }
    MKNormalTextCell *cell = [MKNormalTextCell initCellWithTableView:tableView];
    cell.dataModel = self.section1List[indexPath.row];
    return cell;
}

#pragma mark - MKTextButtonCellDelegate
/// 右侧按钮点击触发的回调事件
/// @param index 当前cell所在的index
/// @param dataListIndex 点击按钮选中的dataList里面的index
/// @param value dataList[dataListIndex]
- (void)mk_loraTextButtonCellSelected:(NSInteger)index
                        dataListIndex:(NSInteger)dataListIndex
                                value:(NSString *)value {
    if (index == 0) {
        //Device Mode
        [self saveWorkModeToDevice:dataListIndex];
        return;
    }
}

#pragma mark - interface
- (void)readDataFromDevice {
    [[MKHudManager share] showHUDWithTitle:@"Reading..." inView:self.view isPenetration:NO];
    [MKBGInterface bg_readWorkModeWithSucBlock:^(id  _Nonnull returnData) {
        [[MKHudManager share] hide];
        [self updateDeviceMode:[returnData[@"result"][@"mode"] integerValue]];
    } failedBlock:^(NSError * _Nonnull error) {
        [[MKHudManager share] hide];
        [self.view showCentralToast:error.userInfo[@"errorInfo"]];
    }];
}

- (void)saveWorkModeToDevice:(NSInteger)mode {
    /*
     0:mk_bg_deviceMode_standbyMode,
     1:mk_bg_deviceMode_timingMode,
     2:mk_bg_deviceMode_periodicMode,
     3:mk_bg_deviceMode_motionMode,
     */
    mk_bg_deviceMode deviceMode = mk_bg_deviceMode_standbyMode;
    if (mode == 1) {
        deviceMode = mk_bg_deviceMode_timingMode;
    }else if (mode == 2) {
        deviceMode = mk_bg_deviceMode_periodicMode;
    }else if (mode == 3) {
        deviceMode = mk_bg_deviceMode_motionMode;
    }
    [[MKHudManager share] showHUDWithTitle:@"Config..." inView:self.view isPenetration:NO];
    [MKBGInterface bg_configWorkMode:deviceMode sucBlock:^{
        [[MKHudManager share] hide];
        MKTextButtonCellModel *cellModel = self.section0List[0];
        cellModel.dataListIndex = mode;
        [self.tableView mk_reloadSection:0 withRowAnimation:UITableViewRowAnimationNone];
    } failedBlock:^(NSError * _Nonnull error) {
        [[MKHudManager share] hide];
        [self.view showCentralToast:error.userInfo[@"errorInfo"]];
        [self.tableView mk_reloadSection:0 withRowAnimation:UITableViewRowAnimationNone];
    }];
}

#pragma mark - updateCellValues
- (void)updateDeviceMode:(NSInteger)mode {
    /*
     mk_bg_deviceMode_offMode,             //Off mode
     mk_bg_deviceMode_standbyMode,         //Standby mode
     mk_bg_deviceMode_periodicMode,        //Periodic mode
     mk_bg_deviceMode_timingMode,          //Timing mode
     mk_bg_deviceMode_motionMode,          //Motion Mode
     */
    NSInteger index = 0;
    if (mode == mk_bg_deviceMode_timingMode) {
        index = 1;
    }else if (mode == mk_bg_deviceMode_periodicMode) {
        index = 2;
    }else if (mode == mk_bg_deviceMode_motionMode) {
        index = 3;
    }
    MKTextButtonCellModel *cellModel = self.section0List[0];
    cellModel.dataListIndex = index;
    [self.tableView mk_reloadSection:0 withRowAnimation:UITableViewRowAnimationNone];
}

#pragma mark - loadSectionDatas
- (void)loadSectionDatas {
    [self loadSection0Datas];
    [self loadSection1Datas];
    
    [self.tableView reloadData];
}

- (void)loadSection0Datas {
    MKTextButtonCellModel *cellModel = [[MKTextButtonCellModel alloc] init];
    cellModel.index = 0;
    cellModel.msg = @"Device Mode";
    cellModel.dataList = @[@"Standby Mode",@"Timing Mode",@"Periodic Mode",@"Motion Mode"];
    cellModel.dataListIndex = 2;
    [self.section0List addObject:cellModel];
}

- (void)loadSection1Datas {
    MKNormalTextCellModel *cellModel1 = [[MKNormalTextCellModel alloc] init];
    cellModel1.leftMsg = @"Timing Mode";
    cellModel1.showRightIcon = YES;
    [self.section1List addObject:cellModel1];
    
    MKNormalTextCellModel *cellModel2 = [[MKNormalTextCellModel alloc] init];
    cellModel2.leftMsg = @"Periodic Mode";
    cellModel2.showRightIcon = YES;
    [self.section1List addObject:cellModel2];
    
    MKNormalTextCellModel *cellModel3 = [[MKNormalTextCellModel alloc] init];
    cellModel3.leftMsg = @"Motion Mode";
    cellModel3.showRightIcon = YES;
    [self.section1List addObject:cellModel3];
}

#pragma mark - UI
- (void)loadSubViews {
    self.defaultTitle = @"Device Mode";
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(self.view.mas_safeAreaLayoutGuideTop);
        make.bottom.mas_equalTo(self.view.mas_safeAreaLayoutGuideBottom);
    }];
}

#pragma mark - getter
- (MKBaseTableView *)tableView {
    if (!_tableView) {
        _tableView = [[MKBaseTableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

- (NSMutableArray *)section0List {
    if (!_section0List) {
        _section0List = [NSMutableArray array];
    }
    return _section0List;
}

- (NSMutableArray *)section1List {
    if (!_section1List) {
        _section1List = [NSMutableArray array];
    }
    return _section1List;
}

@end
