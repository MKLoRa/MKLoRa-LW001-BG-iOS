//
//  MKBGIndicatorSettingsController.m
//  MKLoRaWAN-BG_Example
//
//  Created by aa on 2021/5/27.
//  Copyright © 2021 aadyx2007@163.com. All rights reserved.
//

#import "MKBGIndicatorSettingsController.h"

#import "Masonry.h"

#import "MKMacroDefines.h"
#import "MKBaseTableView.h"
#import "UIView+MKAdd.h"

#import "MKHudManager.h"
#import "MKTextSwitchCell.h"
#import "MKTableSectionLineHeader.h"

#import "MKBGNormalAdopter.h"

#import "MKBGIndicatorSettingsModel.h"

@interface MKBGIndicatorSettingsController ()<UITableViewDelegate,
UITableViewDataSource,
mk_textSwitchCellDelegate>

@property (nonatomic, strong)MKBaseTableView *tableView;

@property (nonatomic, strong)NSMutableArray *section0List;

@property (nonatomic, strong)NSMutableArray *section1List;

@property (nonatomic, strong)NSMutableArray *section2List;

@property (nonatomic, strong)NSMutableArray *section3List;

@property (nonatomic, strong)NSMutableArray *headerList;

@property (nonatomic, strong)MKBGIndicatorSettingsModel *dataModel;

@end

@implementation MKBGIndicatorSettingsController

- (void)dealloc {
    NSLog(@"MKBGIndicatorSettingsController销毁");
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadSubViews];
    [self loadSectionDatas];
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44.f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10.f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    MKTableSectionLineHeader *headerView = [MKTableSectionLineHeader initHeaderViewWithTableView:tableView];
    headerView.headerModel = self.headerList[section];
    return headerView;
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return self.section0List.count;
    }
    if (section == 1) {
        return self.section1List.count;
    }
    if (section == 2) {
        return self.section2List.count;
    }
    return self.section3List.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MKTextSwitchCellModel *cellModel = nil;
    if (indexPath.section == 0) {
        cellModel = self.section0List[indexPath.row];
    }else if (indexPath.section == 1) {
        cellModel = self.section1List[indexPath.row];
    }else if (indexPath.section == 2) {
        cellModel = self.section2List[indexPath.row];
    }else {
        cellModel = self.section3List[indexPath.row];
    }
    MKTextSwitchCell *cell = [MKTextSwitchCell initCellWithTableView:tableView];
    cell.dataModel = cellModel;
    cell.delegate = self;
    return cell;
}

#pragma mark - mk_textSwitchCellDelegate
/// 开关状态发生改变了
/// @param isOn 当前开关状态
/// @param index 当前cell所在的index
- (void)mk_textSwitchCellStatusChanged:(BOOL)isOn index:(NSInteger)index {
    if (index == 0) {
        //Tamper
        MKTextSwitchCellModel *cellModel = self.section0List[0];
        cellModel.isOn = isOn;
        self.dataModel.tamperIsOn = isOn;
        return;
    }
    if (index == 1) {
        //Low-power
        MKTextSwitchCellModel *cellModel = self.section0List[1];
        cellModel.isOn = isOn;
        self.dataModel.lowPowerIsOn = isOn;
        return;
    }
    if (index == 2) {
        //In WIFI Fix
        MKTextSwitchCellModel *cellModel = self.section1List[0];
        cellModel.isOn = isOn;
        self.dataModel.inWifiFixIsOn = isOn;
        return;
    }
    if (index == 3) {
        //WIFI Fix Successful
        MKTextSwitchCellModel *cellModel = self.section1List[1];
        cellModel.isOn = isOn;
        self.dataModel.wifiFixSuccessfulIsOn = isOn;
        return;
    }
    if (index == 4) {
        //Fail To WIFI Fix
        MKTextSwitchCellModel *cellModel = self.section1List[2];
        cellModel.isOn = isOn;
        self.dataModel.failToWifiFixIsOn = isOn;
        return;
    }
    if (index == 5) {
        //In Bluetooth Fix
        MKTextSwitchCellModel *cellModel = self.section2List[0];
        cellModel.isOn = isOn;
        self.dataModel.InBleFixIsOn = isOn;
        return;
    }
    if (index == 6) {
        //BT Fix Successful
        MKTextSwitchCellModel *cellModel = self.section2List[1];
        cellModel.isOn = isOn;
        self.dataModel.BTFixSuccessfulIsOn = isOn;
        return;
    }
    if (index == 7) {
        //Fail To BT Fix
        MKTextSwitchCellModel *cellModel = self.section2List[2];
        cellModel.isOn = isOn;
        self.dataModel.failToBTFixIsOn = isOn;
        return;
    }
    if (index == 8) {
        //In GPS Fix
        MKTextSwitchCellModel *cellModel = self.section3List[0];
        cellModel.isOn = isOn;
        self.dataModel.inGpsFixIsOn = isOn;
        return;
    }
    if (index == 9) {
        //GPS Fix successful
        MKTextSwitchCellModel *cellModel = self.section3List[1];
        cellModel.isOn = isOn;
        self.dataModel.gpsFixSuccessfulIsOn = isOn;
        return;
    }
    if (index == 10) {
        //Fail To GPS Fix
        MKTextSwitchCellModel *cellModel = self.section3List[2];
        cellModel.isOn = isOn;
        self.dataModel.failToGpsFixIsOn = isOn;
        return;
    }
}

#pragma mark - loadSectionDatas
- (void)loadSectionDatas {
    [self loadSection0Datas];
    [self loadSection1Datas];
    [self loadSection2Datas];
    [self loadSection3Datas];
        
    [self.tableView reloadData];
}

- (void)loadSection0Datas {
    MKTextSwitchCellModel *cellModel1 = [[MKTextSwitchCellModel alloc] init];
    cellModel1.index = 0;
    cellModel1.msg = @"Tamper";
    cellModel1.isOn = self.dataModel.tamperIsOn;
    [self.section0List addObject:cellModel1];
    
    MKTextSwitchCellModel *cellModel2 = [[MKTextSwitchCellModel alloc] init];
    cellModel2.index = 1;
    cellModel2.msg = @"Low-power";
    cellModel2.isOn = self.dataModel.lowPowerIsOn;
    [self.section0List addObject:cellModel2];
}

- (void)loadSection1Datas {
    MKTextSwitchCellModel *cellModel1 = [[MKTextSwitchCellModel alloc] init];
    cellModel1.index = 2;
    cellModel1.msg = @"In WIFI Fix";
    cellModel1.isOn = self.dataModel.inWifiFixIsOn;
    [self.section1List addObject:cellModel1];
    
    MKTextSwitchCellModel *cellModel2 = [[MKTextSwitchCellModel alloc] init];
    cellModel2.index = 3;
    cellModel2.msg = @"WIFI Fix Successful";
    cellModel2.isOn = self.dataModel.wifiFixSuccessfulIsOn;
    [self.section1List addObject:cellModel2];
    
    MKTextSwitchCellModel *cellModel3 = [[MKTextSwitchCellModel alloc] init];
    cellModel3.index = 4;
    cellModel3.msg = @"Fail To WIFI Fix";
    cellModel3.isOn = self.dataModel.failToWifiFixIsOn;
    [self.section1List addObject:cellModel3];
}

- (void)loadSection2Datas {
    MKTextSwitchCellModel *cellModel1 = [[MKTextSwitchCellModel alloc] init];
    cellModel1.index = 5;
    cellModel1.msg = @"In Bluetooth Fix";
    cellModel1.isOn = self.dataModel.InBleFixIsOn;
    [self.section2List addObject:cellModel1];
    
    MKTextSwitchCellModel *cellModel2 = [[MKTextSwitchCellModel alloc] init];
    cellModel2.index = 6;
    cellModel2.msg = @"BT Fix Successful";
    cellModel2.isOn = self.dataModel.BTFixSuccessfulIsOn;
    [self.section2List addObject:cellModel2];
    
    MKTextSwitchCellModel *cellModel3 = [[MKTextSwitchCellModel alloc] init];
    cellModel3.index = 7;
    cellModel3.msg = @"Fail To BT Fix";
    cellModel3.isOn = self.dataModel.failToBTFixIsOn;
    [self.section2List addObject:cellModel3];
}

- (void)loadSection3Datas {
    MKTextSwitchCellModel *cellModel1 = [[MKTextSwitchCellModel alloc] init];
    cellModel1.index = 8;
    cellModel1.msg = @"In GPS Fix";
    cellModel1.isOn = self.dataModel.inGpsFixIsOn;
    [self.section3List addObject:cellModel1];
    
    MKTextSwitchCellModel *cellModel2 = [[MKTextSwitchCellModel alloc] init];
    cellModel2.index = 9;
    cellModel2.msg = @"GPS Fix successful";
    cellModel2.isOn = self.dataModel.gpsFixSuccessfulIsOn;
    [self.section3List addObject:cellModel2];
    
    MKTextSwitchCellModel *cellModel3 = [[MKTextSwitchCellModel alloc] init];
    cellModel3.index = 10;
    cellModel3.msg = @"Fail To GPS Fix";
    cellModel3.isOn = self.dataModel.failToGpsFixIsOn;
    [self.section3List addObject:cellModel3];
}

#pragma mark - UI
- (void)loadSubViews {
    self.defaultTitle = @"Indicator Settings";
    [self.rightButton setImage:LOADICON(@"MKLoRaWAN-BG", @"MKBGIndicatorSettingsController", @"bg_slotSaveIcon.png") forState:UIControlStateNormal];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(defaultTopInset);
        make.bottom.mas_equalTo(-VirtualHomeHeight);
    }];
}

#pragma mark - getter
- (MKBaseTableView *)tableView {
    if (!_tableView) {
        _tableView = [[MKBaseTableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.backgroundColor = RGBCOLOR(242, 242, 242);
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

- (NSMutableArray *)section2List {
    if (!_section2List) {
        _section2List = [NSMutableArray array];
    }
    return _section2List;
}

- (NSMutableArray *)section3List {
    if (!_section3List) {
        _section3List = [NSMutableArray array];
    }
    return _section3List;
}

- (NSMutableArray *)headerList {
    if (!_headerList) {
        _headerList = [NSMutableArray array];
        [_headerList addObjectsFromArray:[MKBGNormalAdopter loadSectionHeaderListWithNumber:4]];
    }
    return _headerList;
}

- (MKBGIndicatorSettingsModel *)dataModel {
    if (!_dataModel) {
        _dataModel = [[MKBGIndicatorSettingsModel alloc] init];
    }
    return _dataModel;
}

@end
