//
//  MKBGGpsPositionController.m
//  MKLoRaWAN-BG_Example
//
//  Created by aa on 2021/5/21.
//  Copyright © 2021 aadyx2007@163.com. All rights reserved.
//

#import "MKBGGpsPositionController.h"

#import "Masonry.h"

#import "MLInputDodger.h"

#import "MKMacroDefines.h"
#import "MKBaseTableView.h"
#import "UIView+MKAdd.h"

#import "MKHudManager.h"
#import "MKTextFieldCell.h"
#import "MKTextSwitchCell.h"
#import "MKTextButtonCell.h"
#import "MKTableSectionLineHeader.h"

#import "MKBGNormalAdopter.h"

#import "MKBGGpsPositionDataModel.h"

@interface MKBGGpsPositionController ()<UITableViewDelegate,
UITableViewDataSource,
MKTextFieldCellDelegate,
mk_textSwitchCellDelegate,
MKTextButtonCellDelegate>

@property (nonatomic, strong)MKBaseTableView *tableView;

@property (nonatomic, strong)NSMutableArray *section0List;

@property (nonatomic, strong)NSMutableArray *section1List;

@property (nonatomic, strong)NSMutableArray *section2List;

@property (nonatomic, strong)NSMutableArray *section3List;

@property (nonatomic, strong)NSMutableArray *section4List;

@property (nonatomic, strong)NSMutableArray *section5List;

@property (nonatomic, strong)NSMutableArray *section6List;

@property (nonatomic, strong)NSMutableArray *section7List;

@property (nonatomic, strong)NSMutableArray *sectionHeaderList;

@property (nonatomic, strong)MKBGGpsPositionDataModel *dataModel;

@property (nonatomic, assign)BOOL debugMode;

@end

@implementation MKBGGpsPositionController

- (void)dealloc {
    NSLog(@"MKBGGpsPositionController销毁");
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    self.view.shiftHeightAsDodgeViewForMLInputDodger = 50.0f;
    [self.view registerAsDodgeViewForMLInputDodgerWithOriginalY:self.view.frame.origin.y];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadSubViews];
    [self readDataFromDevice];
}

#pragma mark - super method
- (void)rightButtonMethod {
    [self saveDataToDevice];
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 7) {
        MKTextSwitchCellModel *cellModel = self.section7List[indexPath.row];
        return [cellModel cellHeightWithContentWidth:kViewWidth];
    }
    return 44.f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 1 || section == 3) {
        return 0.f;
    }
    return 10.f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    MKTableSectionLineHeader *headerView = [MKTableSectionLineHeader initHeaderViewWithTableView:tableView];
    headerView.headerModel = self.sectionHeaderList[section];
    return headerView;
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 8;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return (self.debugMode ? self.section0List.count : 0);
    }
    if (section == 1) {
        return self.section1List.count;
    }
    if (section == 2) {
        return self.section2List.count;
    }
    if (section == 3) {
        return self.section3List.count;
    }
    if (section == 4) {
        return self.section4List.count;
    }
    if (section == 5) {
        return self.section5List.count;
    }
    if (section == 6) {
        return self.section6List.count;
    }
    return self.section7List.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        MKTextFieldCell *cell = [MKTextFieldCell initCellWithTableView:tableView];
        cell.dataModel = self.section0List[indexPath.row];
        cell.delegate = self;
        return cell;
    }
    if (indexPath.section == 1) {
        MKTextFieldCell *cell = [MKTextFieldCell initCellWithTableView:tableView];
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
    if (indexPath.section == 4) {
        MKTextButtonCell *cell = [MKTextButtonCell initCellWithTableView:tableView];
        cell.dataModel = self.section4List[indexPath.row];
        cell.delegate = self;
        return cell;
    }
    if (indexPath.section == 5) {
        MKTextButtonCell *cell = [MKTextButtonCell initCellWithTableView:tableView];
        cell.dataModel = self.section5List[indexPath.row];
        cell.delegate = self;
        return cell;
    }
    if (indexPath.section == 6) {
        MKTextFieldCell *cell = [MKTextFieldCell initCellWithTableView:tableView];
        cell.dataModel = self.section6List[indexPath.row];
        cell.delegate = self;
        return cell;
    }
    MKTextSwitchCell *cell = [MKTextSwitchCell initCellWithTableView:tableView];
    cell.dataModel = self.section7List[indexPath.row];
    cell.delegate = self;
    return cell;
}

#pragma mark - MKTextFieldCellDelegate
/// textField内容发送改变时的回调事件
/// @param index 当前cell所在的index
/// @param value 当前textField的值
- (void)mk_deviceTextCellValueChanged:(NSInteger)index textValue:(NSString *)value {
    if (index == 0) {
        //Cold Stard Timeout
        MKTextFieldCellModel *cellModel = self.section0List[0];
        cellModel.textFieldValue = value;
        self.dataModel.coldStardTime = value;
        return;
    }
    if (index == 1) {
        //Coarse Accuracy Mask
        MKTextFieldCellModel *cellModel = self.section1List[0];
        cellModel.textFieldValue = value;
        self.dataModel.coarseAccuracyMask = value;
        return;
    }
    if (index == 2) {
        //Coarse Timeout
        MKTextFieldCellModel *cellModel = self.section1List[1];
        cellModel.textFieldValue = value;
        self.dataModel.coarseTime = value;
        return;
    }
    if (index == 3) {
        //Fine Accuracy Target
        MKTextFieldCellModel *cellModel = self.section1List[2];
        cellModel.textFieldValue = value;
        self.dataModel.fineAccuracyTarget = value;
        return;
    }
    if (index == 4) {
        //Fine Timeout
        MKTextFieldCellModel *cellModel = self.section1List[3];
        cellModel.textFieldValue = value;
        self.dataModel.fineTime = value;
        return;
    }
    if (index == 5) {
        //PDOP Limit
        MKTextFieldCellModel *cellModel = self.section1List[4];
        cellModel.textFieldValue = value;
        self.dataModel.PDOPLimit = value;
        return;
    }
    if (index == 6) {
        //Ading Accuracy
        MKTextFieldCellModel *cellModel = self.section3List[0];
        cellModel.textFieldValue = value;
        self.dataModel.adingAccuracy = value;
        return;
    }
    if (index == 7) {
        //Aiding Timeout
        MKTextFieldCellModel *cellModel = self.section3List[1];
        cellModel.textFieldValue = value;
        self.dataModel.aidingTime = value;
        return;
    }
    if (index == 8) {
        //Time Budget
        MKTextFieldCellModel *cellModel = self.section6List[0];
        cellModel.textFieldValue = value;
        self.dataModel.timeBudget = value;
        return;
    }
}

#pragma mark - mk_textSwitchCellDelegate
/// 开关状态发生改变了
/// @param isOn 当前开关状态
/// @param index 当前cell所在的index
- (void)mk_textSwitchCellStatusChanged:(BOOL)isOn index:(NSInteger)index {
    if (index == 0) {
        //Autonomous Aiding
        MKTextSwitchCellModel *cellModel = self.section2List[0];
        cellModel.isOn = isOn;
        self.dataModel.autonomousAiding = isOn;
        return;
    }
    if (index == 1) {
        //Extreme Mode
        MKTextSwitchCellModel *cellModel = self.section7List[0];
        cellModel.isOn = isOn;
        self.dataModel.extremeMode = isOn;
        return;
    }
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
        //Fix Mode
        MKTextButtonCellModel *cellModel = self.section4List[0];
        cellModel.dataListIndex = dataListIndex;
        self.dataModel.fixMode = dataListIndex;
        return;
    }
    if (index == 1) {
        //GPS Model
        MKTextButtonCellModel *cellModel = self.section5List[0];
        cellModel.dataListIndex = dataListIndex;
        self.dataModel.gpsMode = dataListIndex;
        return;
    }
}

#pragma mark - interface
- (void)readDataFromDevice {
    [[MKHudManager share] showHUDWithTitle:@"Reading..." inView:self.view isPenetration:NO];
    @weakify(self);
    [self.dataModel readWithSucBlock:^{
        @strongify(self);
        [[MKHudManager share] hide];
        [self loadSectionDatas];
    } failedBlock:^(NSError * _Nonnull error) {
        @strongify(self);
        [[MKHudManager share] hide];
        [self.view showCentralToast:error.userInfo[@"errorInfo"]];
    }];
}

- (void)saveDataToDevice {
    [[MKHudManager share] showHUDWithTitle:@"Config..." inView:self.view isPenetration:NO];
    @weakify(self);
    [self.dataModel configWithSucBlock:^{
        @strongify(self);
        [[MKHudManager share] hide];
        [self.view showCentralToast:@"Success"];
    } failedBlock:^(NSError * _Nonnull error) {
        @strongify(self);
        [[MKHudManager share] hide];
        [self.view showCentralToast:error.userInfo[@"errorInfo"]];
    }];
}

#pragma mark - loadSectionDatas
- (void)loadSectionDatas {
    [self loadSection0Datas];
    [self loadSection1Datas];
    [self loadSection2Datas];
    [self loadSection3Datas];
    [self loadSection4Datas];
    [self loadSection5Datas];
    [self loadSection6Datas];
    [self loadSection7Datas];
        
    [self.tableView reloadData];
}

- (void)loadSection0Datas {
    MKTextFieldCellModel *cellModel1 = [[MKTextFieldCellModel alloc] init];
    cellModel1.index = 0;
    cellModel1.msg = @"Cold Stard Timeout";
    cellModel1.textPlaceholder = @"3~15";
    cellModel1.textFieldType = mk_realNumberOnly;
    cellModel1.maxLength = 2;
    cellModel1.unit = @"Mins";
    cellModel1.textFieldValue = self.dataModel.coldStardTime;
    [self.section0List addObject:cellModel1];
}

- (void)loadSection1Datas {
    MKTextFieldCellModel *cellModel1 = [[MKTextFieldCellModel alloc] init];
    cellModel1.index = 1;
    cellModel1.msg = @"Coarse Accuracy Mask";
    cellModel1.textPlaceholder = @"5~100";
    cellModel1.textFieldType = mk_realNumberOnly;
    cellModel1.maxLength = 3;
    cellModel1.unit = @"m";
    cellModel1.textFieldValue = self.dataModel.coarseAccuracyMask;
    [self.section1List addObject:cellModel1];
    
    MKTextFieldCellModel *cellModel2 = [[MKTextFieldCellModel alloc] init];
    cellModel2.index = 2;
    cellModel2.msg = @"Coarse Timeout";
    cellModel2.textPlaceholder = @"1~7620";
    cellModel2.textFieldType = mk_realNumberOnly;
    cellModel2.maxLength = 4;
    cellModel2.unit = @"s";
    cellModel2.textFieldValue = self.dataModel.coarseTime;
    [self.section1List addObject:cellModel2];
    
    MKTextFieldCellModel *cellModel3 = [[MKTextFieldCellModel alloc] init];
    cellModel3.index = 3;
    cellModel3.msg = @"Fine Accuracy Target";
    cellModel3.textPlaceholder = @"5~100";
    cellModel3.textFieldType = mk_realNumberOnly;
    cellModel3.maxLength = 3;
    cellModel3.unit = @"m";
    cellModel3.textFieldValue = self.dataModel.fineAccuracyTarget;
    [self.section1List addObject:cellModel3];
    
    MKTextFieldCellModel *cellModel4 = [[MKTextFieldCellModel alloc] init];
    cellModel4.index = 4;
    cellModel4.msg = @"Fine Timeout";
    cellModel4.textPlaceholder = @"0~76200";
    cellModel4.textFieldType = mk_realNumberOnly;
    cellModel4.maxLength = 5;
    cellModel4.unit = @"s";
    cellModel4.textFieldValue = self.dataModel.fineTime;
    [self.section1List addObject:cellModel4];
    
    MKTextFieldCellModel *cellModel5 = [[MKTextFieldCellModel alloc] init];
    cellModel5.index = 5;
    cellModel5.msg = @"PDOP Limit";
    cellModel5.textPlaceholder = @"25~100";
    cellModel5.textFieldType = mk_realNumberOnly;
    cellModel5.maxLength = 3;
    cellModel5.unit = @"x 0.1";
    cellModel5.textFieldValue = self.dataModel.PDOPLimit;
    [self.section1List addObject:cellModel5];
}

- (void)loadSection2Datas {
    MKTextSwitchCellModel *cellModel = [[MKTextSwitchCellModel alloc] init];
    cellModel.index = 0;
    cellModel.msg = @"Autonomous Aiding";
    cellModel.isOn = self.dataModel.autonomousAiding;
    [self.section2List addObject:cellModel];
}

- (void)loadSection3Datas {
    MKTextFieldCellModel *cellModel1 = [[MKTextFieldCellModel alloc] init];
    cellModel1.index = 6;
    cellModel1.msg = @"Aiding Accuracy";
    cellModel1.textPlaceholder = @"5~1000";
    cellModel1.textFieldType = mk_realNumberOnly;
    cellModel1.maxLength = 4;
    cellModel1.unit = @"m";
    cellModel1.textFieldValue = self.dataModel.adingAccuracy;
    [self.section3List addObject:cellModel1];
    
    MKTextFieldCellModel *cellModel2 = [[MKTextFieldCellModel alloc] init];
    cellModel2.index = 7;
    cellModel2.msg = @"Aiding Timeout";
    cellModel2.textPlaceholder = @"1~7620";
    cellModel2.textFieldType = mk_realNumberOnly;
    cellModel2.maxLength = 4;
    cellModel2.unit = @"s";
    cellModel2.textFieldValue = self.dataModel.aidingTime;
    [self.section3List addObject:cellModel2];
}

- (void)loadSection4Datas {
    MKTextButtonCellModel *cellModel = [[MKTextButtonCellModel alloc] init];
    cellModel.index = 0;
    cellModel.msg = @"Fix Mode";
    cellModel.dataList = @[@"2D",@"3D",@"Auto"];
    cellModel.dataListIndex = self.dataModel.fixMode;
    [self.section4List addObject:cellModel];
}
- (void)loadSection5Datas {
    MKTextButtonCellModel *cellModel = [[MKTextButtonCellModel alloc] init];
    cellModel.index = 1;
    cellModel.msg = @"GPS Model";
    cellModel.dataList = @[@"Portable",@"Stationary",@"Pedestrian",
                            @"Automotive",@"At sea",@"Airborne<1g",
                            @"Airborne<2g",@"Airborne<4g",@"Wrist"];
    cellModel.dataListIndex = self.dataModel.gpsMode;
    [self.section5List addObject:cellModel];
}

- (void)loadSection6Datas {
    MKTextFieldCellModel *cellModel = [[MKTextFieldCellModel alloc] init];
    cellModel.index = 8;
    cellModel.msg = @"Time Budget";
    cellModel.textPlaceholder = @"0~76200";
    cellModel.textFieldType = mk_realNumberOnly;
    cellModel.maxLength = 5;
    cellModel.unit = @"s";
    cellModel.textFieldValue = self.dataModel.timeBudget;
    [self.section6List addObject:cellModel];
}

- (void)loadSection7Datas {
    MKTextSwitchCellModel *cellModel = [[MKTextSwitchCellModel alloc] init];
    cellModel.index = 1;
    cellModel.msg = @"Extreme Mode";
    cellModel.noteMsg = @"*When Extrme Mode is on, the reported GPS data  will be shortened to achieve the maximum transmission distance";
    cellModel.noteMsgColor = RGBCOLOR(102, 102, 102);
    cellModel.isOn = self.dataModel.extremeMode;
    [self.section7List addObject:cellModel];
}

#pragma mark - UI
- (void)loadSubViews {
    self.defaultTitle = @"GPS Fix";
    [self.rightButton setImage:LOADICON(@"MKLoRaWAN-BG", @"MKBGGpsPositionController", @"bg_slotSaveIcon.png") forState:UIControlStateNormal];
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

- (NSMutableArray *)section5List {
    if (!_section5List) {
        _section5List = [NSMutableArray array];
    }
    return _section5List;
}

- (NSMutableArray *)section6List {
    if (!_section6List) {
        _section6List = [NSMutableArray array];
    }
    return _section6List;
}

- (NSMutableArray *)section7List {
    if (!_section7List) {
        _section7List = [NSMutableArray array];
    }
    return _section7List;
}

- (NSMutableArray *)sectionHeaderList {
    if (!_sectionHeaderList) {
        _sectionHeaderList = [NSMutableArray array];
        [_sectionHeaderList addObjectsFromArray:[MKBGNormalAdopter loadSectionHeaderListWithNumber:8]];
    }
    return _sectionHeaderList;
}

- (MKBGGpsPositionDataModel *)dataModel {
    if (!_dataModel) {
        _dataModel = [[MKBGGpsPositionDataModel alloc] init];
    }
    return _dataModel;
}

@end
