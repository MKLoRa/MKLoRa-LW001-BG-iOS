//
//  MKBGBleSettingsController.m
//  MKLoRaWAN-BG_Example
//
//  Created by aa on 2021/5/26.
//  Copyright © 2021 aadyx2007@163.com. All rights reserved.
//

#import "MKBGBleSettingsController.h"

#import "Masonry.h"

#import "MLInputDodger.h"

#import "MKMacroDefines.h"
#import "MKBaseTableView.h"
#import "UIView+MKAdd.h"

#import "MKHudManager.h"
#import "MKTextFieldCell.h"
#import "MKTextSwitchCell.h"
#import "MKNormalTextCell.h"

#import "MKBGBleSettingsDataModel.h"

#import "MKBGBroadcastSettingsController.h"

@interface MKBGBleSettingsController ()<UITableViewDelegate,
UITableViewDataSource,
MKTextFieldCellDelegate,
mk_textSwitchCellDelegate>

@property (nonatomic, strong)MKBaseTableView *tableView;

@property (nonatomic, strong)NSMutableArray *section0List;

@property (nonatomic, strong)NSMutableArray *section1List;

@property (nonatomic, strong)NSMutableArray *section2List;

@property (nonatomic, strong)NSMutableArray *section3List;

@property (nonatomic, strong)NSMutableArray *section4List;

@property (nonatomic, strong)MKBGBleSettingsDataModel *dataModel;

@end

@implementation MKBGBleSettingsController

- (void)dealloc {
    NSLog(@"MKBGBleSettingsController销毁");
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    self.view.shiftHeightAsDodgeViewForMLInputDodger = 50.0f;
    [self.view registerAsDodgeViewForMLInputDodgerWithOriginalY:self.view.frame.origin.y];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadSubViews];
    [self loadSectionDatas];
}

#pragma mark - super method
- (void)rightButtonMethod {
    
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44.f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0 && indexPath.row == 0) {
        //Broadcast Content
        MKBGBroadcastSettingsController *vc = [[MKBGBroadcastSettingsController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
        return;
    }
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return self.section0List.count;
    }
    if (section == 1) {
        return self.section1List.count;
    }
    if (section == 2) {
        return (self.dataModel.beaconModeIsOn ? self.section2List.count : 0);
    }
    if (section == 3) {
        return (self.dataModel.beaconModeIsOn ? self.section3List.count : 0);
    }
    return (self.dataModel.beaconModeIsOn ? 0 : self.section4List.count);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        MKNormalTextCell *cell = [MKNormalTextCell initCellWithTableView:tableView];
        cell.dataModel = self.section0List[indexPath.row];
        return cell;
    }
    if (indexPath.section == 1) {
        MKTextSwitchCell *cell = [MKTextSwitchCell initCellWithTableView:tableView];
        cell.dataModel = self.section1List[indexPath.row];
        cell.delegate = self;
        return cell;
    }
    if (indexPath.section == 2) {
        MKTextSwitchCell *cell = [MKTextSwitchCell initCellWithTableView:tableView];
        cell.dataModel = self.section2List[indexPath.row];
        cell.delegate = self;
        return cell;
    }
    if (indexPath.section == 3) {
        MKTextFieldCell *cell = [MKTextFieldCell initCellWithTableView:tableView];
        cell.dataModel = self.section3List[indexPath.row];
        cell.delegate = self;
        return cell;
    }
    MKTextFieldCell *cell = [MKTextFieldCell initCellWithTableView:tableView];
    cell.dataModel = self.section4List[indexPath.row];
    cell.delegate = self;
    return cell;
}

#pragma mark - MKTextFieldCellDelegate
/// textField内容发送改变时的回调事件
/// @param index 当前cell所在的index
/// @param value 当前textField的值
- (void)mk_deviceTextCellValueChanged:(NSInteger)index textValue:(NSString *)value {
    if (index == 0) {
        //ADV Interval
        MKTextFieldCellModel *cellModel = self.section3List[0];
        cellModel.textFieldValue = value;
        self.dataModel.advInterval = value;
        return;
    }
    if (index == 1) {
        //Broadcast Timeout
        MKTextFieldCellModel *cellModel = self.section4List[0];
        cellModel.textFieldValue = value;
        self.dataModel.broadcastTimeout = value;
        return;
    }
}

#pragma mark - mk_textSwitchCellDelegate
/// 开关状态发生改变了
/// @param isOn 当前开关状态
/// @param index 当前cell所在的index
- (void)mk_textSwitchCellStatusChanged:(BOOL)isOn index:(NSInteger)index {
    if (index == 0) {
        //Beacon  Mode
        MKTextSwitchCellModel *cellModel = self.section1List[0];
        cellModel.isOn = isOn;
        self.dataModel.beaconModeIsOn = isOn;
        [self.tableView reloadData];
        return;
    }
    if (index == 1) {
        //Connectable
        MKTextSwitchCellModel *cellModel = self.section2List[0];
        cellModel.isOn = isOn;
        self.dataModel.connectable = isOn;
        return;
    }
}

#pragma mark - loadSectionDatas
- (void)loadSectionDatas {
    [self loadSection0Datas];
    [self loadSection1Datas];
    [self loadSection2Datas];
    [self loadSection3Datas];
    [self loadSection4Datas];
    
    [self.tableView reloadData];
}

- (void)loadSection0Datas {
    MKNormalTextCellModel *cellModel = [[MKNormalTextCellModel alloc] init];
    cellModel.showRightIcon = YES;
    cellModel.leftMsg = @"Broadcast Content";
    [self.section0List addObject:cellModel];
}

- (void)loadSection1Datas {
    MKTextSwitchCellModel *cellModel = [[MKTextSwitchCellModel alloc] init];
    cellModel.index = 0;
    cellModel.msg = @"Beacon Mode";
    cellModel.isOn = self.dataModel.beaconModeIsOn;
    [self.section1List addObject:cellModel];
}

- (void)loadSection2Datas {
    MKTextSwitchCellModel *cellModel = [[MKTextSwitchCellModel alloc] init];
    cellModel.index = 1;
    cellModel.msg = @"Connectable";
    cellModel.isOn = self.dataModel.connectable;
    [self.section2List addObject:cellModel];
}

- (void)loadSection3Datas {
    MKTextFieldCellModel *cellModel = [[MKTextFieldCellModel alloc] init];
    cellModel.index = 0;
    cellModel.msg = @"ADV Interval";
    cellModel.textPlaceholder = @"1~100";
    cellModel.textFieldType = mk_realNumberOnly;
    cellModel.textFieldValue = self.dataModel.advInterval;
    cellModel.maxLength = 3;
    cellModel.unit = @"x 100ms";
    [self.section3List addObject:cellModel];
}

- (void)loadSection4Datas {
    MKTextFieldCellModel *cellModel = [[MKTextFieldCellModel alloc] init];
    cellModel.index = 1;
    cellModel.msg = @"Broadcast Timeout";
    cellModel.textPlaceholder = @"1~60";
    cellModel.textFieldType = mk_realNumberOnly;
    cellModel.textFieldValue = self.dataModel.broadcastTimeout;
    cellModel.maxLength = 2;
    cellModel.unit = @"Mins";
    [self.section4List addObject:cellModel];
}

#pragma mark - UI
- (void)loadSubViews {
    self.defaultTitle = @"Bluetooth Settings";
    [self.rightButton setImage:LOADICON(@"MKLoRaWAN-BG", @"MKBGBleSettingsController", @"bg_slotSaveIcon.png") forState:UIControlStateNormal];
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

- (NSMutableArray *)section4List {
    if (!_section4List) {
        _section4List = [NSMutableArray array];
    }
    return _section4List;
}

- (MKBGBleSettingsDataModel *)dataModel {
    if (!_dataModel) {
        _dataModel = [[MKBGBleSettingsDataModel alloc] init];
    }
    return _dataModel;
}

@end
