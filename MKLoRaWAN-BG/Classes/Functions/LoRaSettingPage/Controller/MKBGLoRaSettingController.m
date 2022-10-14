//
//  MKBGLoRaSettingController.m
//  MKLoRaWAN-BG_Example
//
//  Created by aa on 2021/5/28.
//  Copyright © 2021 aadyx2007@163.com. All rights reserved.
//

#import "MKBGLoRaSettingController.h"

#import "Masonry.h"

#import "MLInputDodger.h"

#import "MKMacroDefines.h"
#import "MKBaseTableView.h"
#import "UIView+MKAdd.h"
#import "UITableView+MKAdd.h"

#import "MKHudManager.h"
#import "MKTextFieldCell.h"
#import "MKTextButtonCell.h"
#import "MKTextSwitchCell.h"
#import "MKLoRaAdvancedSettingCell.h"
#import "MKLoRaSettingCHCell.h"
#import "MKNormalTextCell.h"
#import "MKTableSectionLineHeader.h"

#import "MKBGNormalAdopter.h"

#import "MKBGLoRaSettingModel.h"

@interface MKBGLoRaSettingController ()<UITableViewDelegate,
UITableViewDataSource,
MKTextButtonCellDelegate,
MKTextFieldCellDelegate,
mk_textSwitchCellDelegate,
MKLoRaAdvancedSettingCellDelegate,
MKLoRaSettingCHCellDelegate>

@property (nonatomic, strong)MKBaseTableView *tableView;

@property (nonatomic, strong)NSMutableArray *section0List;

@property (nonatomic, strong)NSMutableArray *otaaDataList;

@property (nonatomic, strong)NSMutableArray *abpDataList;

@property (nonatomic, strong)NSMutableArray *section2List;

@property (nonatomic, strong)NSMutableArray *optionsList0;

@property (nonatomic, strong)NSMutableArray *optionsList1;

@property (nonatomic, strong)NSMutableArray *optionsList2;

@property (nonatomic, strong)NSMutableArray *optionsList3;

@property (nonatomic, strong)NSMutableArray *optionsList4;

@property (nonatomic, strong)NSMutableArray *optionsList5;

@property (nonatomic, strong)NSMutableArray *optionsList6;

@property (nonatomic, strong)NSMutableArray *optionsList7;

@property (nonatomic, strong)NSMutableArray *headerList;

@property (nonatomic, strong)MKBGLoRaSettingModel *dataModel;

@end

@implementation MKBGLoRaSettingController

- (void)dealloc {
    NSLog(@"MKBGLoRaSettingController销毁");
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    self.view.shiftHeightAsDodgeViewForMLInputDodger = 50.0f;
    [self.view registerAsDodgeViewForMLInputDodgerWithOriginalY:self.view.frame.origin.y];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadSubViews];
    [self readDatasFromDevice];
}

#pragma mark - super method
- (void)rightButtonMethod {
    [[MKHudManager share] showHUDWithTitle:@"Config..." inView:self.view isPenetration:NO];
    @weakify(self);
    [self.dataModel configDataWithSucBlock:^{
        @strongify(self);
        [[MKHudManager share] hide];
        [self.view showCentralToast:@"Success!"];
    } failedBlock:^(NSError * _Nonnull error) {
        @strongify(self);
        [[MKHudManager share] hide];
        [self.view showCentralToast:error.userInfo[@"errorInfo"]];
    }];
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    //底部需要高级设置
    if (indexPath.section == 3) {
        //Advanced Setting
        return 80.f;
    }
    if (indexPath.section == 4) {
        //CH
        MKLoRaSettingCHCellModel *cellModel = self.optionsList1[indexPath.row];
        return [cellModel cellHeightWithContentWidth:kViewWidth];
    }
    if (indexPath.section == 5) {
        //Duty-cycle
        MKTextSwitchCellModel *cellModel = self.optionsList2[indexPath.row];
        return [cellModel cellHeightWithContentWidth:kViewWidth];
    }
    if (indexPath.section == 6) {
        //DR For Join
        MKTextButtonCellModel *cellModel = self.optionsList3[indexPath.row];
        return [cellModel cellHeightWithContentWidth:kViewWidth];
    }
    if (indexPath.section == 10) {
        //DR For Payload
        MKLoRaSettingCHCellModel *cellModel = self.optionsList7[indexPath.row];
        return [cellModel cellHeightWithContentWidth:kViewWidth];
    }
    return 44.f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0 || section == 2 || section == 7) {
        return 10.f;
    }
    return 0.f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    MKTableSectionLineHeader *headerView = [MKTableSectionLineHeader initHeaderViewWithTableView:tableView];
    headerView.headerModel = self.headerList[section];
    return headerView;
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.headerList.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return self.section0List.count;
    }
    if (section == 1) {
        if (self.dataModel.modem == 1) {
            //ABP
            return self.abpDataList.count;
        }
        if (self.dataModel.modem == 2) {
            //OTAA
            return self.otaaDataList.count;
        }
    }
    if (section == 2) {
        return self.section2List.count;
    }
    //存在高级设置选项
    if (section == 3) {
        return self.optionsList0.count;
    }
    if (!self.dataModel.advancedStatus) {
        //高级选项开关关闭状态
        return 0;
    }
    if (section == 4) {
        //CH
        if (self.dataModel.region == 1 || self.dataModel.region == 2 || self.dataModel.region == 8) {
            //US915、AU915、CN470
            return self.optionsList1.count;
        }
        return 0;
    }
    if (section == 5) {
        //Duty-cycle
        if (self.dataModel.region == 3 || self.dataModel.region == 4 || self.dataModel.region == 5 || self.dataModel.region == 9) {
            //EU868,CN779, EU433,RU864
            return self.optionsList2.count;
        }
        return 0;
    }
    if (section == 6) {
        //DR For Join
        if (self.dataModel.region == 2 || self.dataModel.region == 3 || self.dataModel.region == 4
            || self.dataModel.region == 5 || self.dataModel.region == 6 || self.dataModel.region == 7
            || self.dataModel.region == 9) {
            //CN470, CN779, EU433, EU868,KR920, IN865, RU864
            return self.optionsList3.count;
        }
        return 0;
    }
    if (section == 7) {
        //Uplink  Strategy
        return self.optionsList4.count;
    }
    if (section == 8) {
        //ADR
        return self.optionsList5.count;
    }
    if (section == 9) {
        //Transmissions
        return (self.dataModel.adrIsOn ? 0 : self.optionsList6.count);
    }
    if (section == 10) {
        //DR For Payload
        return (self.dataModel.adrIsOn ? 0 : self.optionsList7.count);
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        MKTextButtonCell *cell = [MKTextButtonCell initCellWithTableView:tableView];
        cell.dataModel = self.section0List[indexPath.row];
        cell.delegate = self;
        return cell;
    }
    if (indexPath.section == 1) {
        MKTextFieldCell *cell = [MKTextFieldCell initCellWithTableView:tableView];
        MKTextFieldCellModel *model = (self.dataModel.modem == 1) ? self.abpDataList[indexPath.row] : self.otaaDataList[indexPath.row];
        cell.dataModel = model;
        cell.delegate = self;
        return cell;
    }
    if (indexPath.section == 2) {
        MKTextButtonCell *cell = [MKTextButtonCell initCellWithTableView:tableView];
        cell.dataModel = self.section2List[indexPath.row];
        cell.delegate = self;
        return cell;
    }
    if (indexPath.section == 3) {
        MKLoRaAdvancedSettingCell *cell = [MKLoRaAdvancedSettingCell initCellWithTableView:tableView];
        cell.dataModel = self.optionsList0[indexPath.row];
        cell.delegate = self;
        return cell;
    }
    if (indexPath.section == 4) {
        MKLoRaSettingCHCell *cell = [MKLoRaSettingCHCell initCellWithTableView:tableView];
        cell.dataModel = self.optionsList1[indexPath.row];
        cell.delegate = self;
        return cell;
    }
    if (indexPath.section == 5) {
        MKTextSwitchCell *cell = [MKTextSwitchCell initCellWithTableView:tableView];
        cell.dataModel = self.optionsList2[indexPath.row];
        cell.delegate = self;
        return cell;
    }
    if (indexPath.section == 6) {
        MKTextButtonCell *cell = [MKTextButtonCell initCellWithTableView:tableView];
        cell.dataModel = self.optionsList3[indexPath.row];
        cell.delegate = self;
        return cell;
    }
    if (indexPath.section == 7) {
        MKNormalTextCell *cell = [MKNormalTextCell initCellWithTableView:tableView];
        cell.dataModel = self.optionsList4[indexPath.row];
        return cell;
    }
    if (indexPath.section == 8) {
        MKTextSwitchCell *cell = [MKTextSwitchCell initCellWithTableView:tableView];
        cell.dataModel = self.optionsList5[indexPath.row];
        cell.delegate = self;
        return cell;
    }
    if (indexPath.section == 9) {
        MKTextButtonCell *cell = [MKTextButtonCell initCellWithTableView:tableView];
        cell.dataModel = self.optionsList6[indexPath.row];
        cell.delegate = self;
        return cell;
    }
    MKLoRaSettingCHCell *cell = [MKLoRaSettingCHCell initCellWithTableView:tableView];
    cell.dataModel = self.optionsList7[indexPath.row];
    cell.delegate = self;
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
        //modem
        self.dataModel.modem = (dataListIndex + 1);
        MKTextButtonCellModel *modeModel = self.section0List[0];
        modeModel.dataListIndex = dataListIndex;
        [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationNone];
        return;
    }
    if (index == 1) {
        //region
        self.dataModel.region = dataListIndex;
        MKTextButtonCellModel *regionModel = self.section2List[0];
        regionModel.dataListIndex = dataListIndex;
        //刷新了region，如果当前是存在高级设置的，需要同步更新所有的高级设置
        if (self.dataModel.needAdvanceSetting) {
            [self regionValueChanged];
        }
        return;
    }
    if (index == 2) {
        //message type
        self.dataModel.messageType = dataListIndex;
        MKTextButtonCellModel *messageModel = self.section2List[1];
        messageModel.dataListIndex = dataListIndex;
        return;
    }
    if (index == 3) {
        //DR For Join
        self.dataModel.join = dataListIndex;
        MKTextButtonCellModel *classModel = self.optionsList3[0];
        classModel.dataListIndex = dataListIndex;
        return;
    }
    if (index == 4) {
        //Transmissions
        self.dataModel.transmissions = dataListIndex + 1;
        MKTextButtonCellModel *drModel = self.optionsList6[0];
        drModel.dataListIndex = dataListIndex;
        return;
    }
}

#pragma mark - MKTextFieldCellDelegate
- (void)mk_deviceTextCellValueChanged:(NSInteger)index textValue:(NSString *)value {
    if (index == 5) {
        //AppKey
        self.dataModel.appKey = value;
        MKTextFieldCellModel *appKeyModel = self.otaaDataList[2];
        appKeyModel.textFieldValue = self.dataModel.appKey;
        return;
    }
    MKTextFieldCellModel *abpDataModel = self.abpDataList[index];
    abpDataModel.textFieldValue = value;
    if (index == 0) {
        //DevEUI
        self.dataModel.devEUI = value;
        MKTextFieldCellModel *devEUIModel2 = self.otaaDataList[0];
        devEUIModel2.textFieldValue = self.dataModel.devEUI;
        return;
    }
    if (index == 1) {
        //AppEUI
        self.dataModel.appEUI = value;
        MKTextFieldCellModel *appEUIModel2 = self.otaaDataList[1];
        appEUIModel2.textFieldValue = self.dataModel.appEUI;
        return;
    }
    if (index == 2) {
        //DevAddr
        self.dataModel.devAddr = value;
        return;
    }
    if (index == 3) {
        //AppSkey
        self.dataModel.appSKey = value;
        return;
    }
    if (index == 4) {
        //NwkSkey
        self.dataModel.nwkSKey = value;
        return;
    }
    
}

#pragma mark - mk_textSwitchCellDelegate
- (void)mk_textSwitchCellStatusChanged:(BOOL)isOn index:(NSInteger)index {
    if (index == 0) {
        //Duty-cycle
        self.dataModel.dutyIsOn = isOn;
        MKTextSwitchCellModel *dutyModel = self.optionsList2[0];
        dutyModel.isOn = self.dataModel.dutyIsOn;
        return;
    }
    if (index == 1) {
        //ADR
        self.dataModel.adrIsOn = isOn;
        MKTextSwitchCellModel *adrModel = self.optionsList5[0];
        adrModel.isOn = self.dataModel.adrIsOn;
        //ADR关闭状态才能显示Transmissions、DR For Payload
        [self.tableView reloadData];
        return;
    }
}

#pragma mark - MKLoRaSettingCHCellDelegate

/// 选择了右侧高位的列表
/// @param value 当前选中的值
/// @param chHighIndex 当前值在高位列表里面的index
/// @param index 当前cell所在的index
- (void)mk_loraSetting_chHighValueChanged:(NSString *)value
                              chHighIndex:(NSInteger)chHighIndex
                                cellIndex:(NSInteger)index {
    if (index == 0) {
        //CH
        self.dataModel.CHH = [value integerValue];
        MKLoRaSettingCHCellModel *cellModel = self.optionsList1[0];
        cellModel.chHighIndex = chHighIndex;
        cellModel.chLowValueList = [self.dataModel CHLValueList];
        return;
    }
    if (index == 1) {
        //DR For Payload
        self.dataModel.DRH = [value integerValue];
        MKLoRaSettingCHCellModel *cellModel = self.optionsList7[0];
        cellModel.chHighIndex = chHighIndex;
        cellModel.chLowValueList = [self.dataModel DRLValueList];
        
        if (self.dataModel.DRH < self.dataModel.DRL) {
            cellModel.chLowIndex = cellModel.chLowValueList.count - 1;
            self.dataModel.DRL = self.dataModel.DRH;
        }
        cellModel.chLowIndex = [self getCurrentDRLIndex];
        
        [self.tableView mk_reloadSection:10 withRowAnimation:UITableViewRowAnimationNone];
        return;
    }
}

/// 选择了左侧高\低位的列表
/// @param value 当前选中的值
/// @param chLowIndex 当前值在低位列表里面的index
/// @param index 当前cell所在的index
- (void)mk_loraSetting_chLowValueChanged:(NSString *)value
                              chLowIndex:(NSInteger)chLowIndex
                               cellIndex:(NSInteger)index {
    if (index == 0) {
        //CH
        self.dataModel.CHL = [value integerValue];
        MKLoRaSettingCHCellModel *cellModel = self.optionsList1[0];
        cellModel.chLowIndex = chLowIndex;
        cellModel.chHighValueList = [self.dataModel CHHValueList];
        return;
    }
    if (index == 1) {
        //DR For Payload
        self.dataModel.DRL = [value integerValue];
        MKLoRaSettingCHCellModel *cellModel = self.optionsList7[0];
        cellModel.chLowIndex = chLowIndex;
        cellModel.chHighValueList = [self.dataModel DRHValueList];
        
        if (self.dataModel.DRH < self.dataModel.DRL) {
            cellModel.chHighIndex = 0;
            self.dataModel.DRH = self.dataModel.DRL;
        }
        cellModel.chHighIndex = [self getCurrentDRHIndex];
        
        [self.tableView mk_reloadSection:10 withRowAnimation:UITableViewRowAnimationNone];
        
        return;
    }
}

#pragma mark - MKLoRaAdvancedSettingCellDelegate
- (void)mk_loraSetting_advanceCell_switchStatusChanged:(BOOL)isOn {
    self.dataModel.advancedStatus = isOn;
    MKLoRaAdvancedSettingCellModel *cellModel = self.optionsList0[0];
    cellModel.isOn = isOn;
    
    [self.headerList removeAllObjects];
    
    if (!self.dataModel.advancedStatus) {
        //高级设置开关状态关闭
        [self.headerList addObjectsFromArray:[MKBGNormalAdopter loadSectionHeaderListWithNumber:4]];
    }else {
        //高级设置开关状态打开
        [self.headerList addObjectsFromArray:[MKBGNormalAdopter loadSectionHeaderListWithNumber:11]];
    }
    
    [self.tableView reloadData];
}

#pragma mark - interface
- (void)readDatasFromDevice {
    [[MKHudManager share] showHUDWithTitle:@"Reading..." inView:self.view isPenetration:NO];
    @weakify(self);
    [self.dataModel readDataWithSucBlock:^{
        @strongify(self);
        [[MKHudManager share] hide];
        [self loadSectionDatas];
    } failedBlock:^(NSError * _Nonnull error) {
        @strongify(self);
        [[MKHudManager share] hide];
        [self.view showCentralToast:error.userInfo[@"errorInfo"]];
    }];
}

#pragma mark - private method
- (void)regionValueChanged {
    [self.dataModel configAdvanceSettingDefaultParams];
    //CH
    MKLoRaSettingCHCellModel *cellModel = self.optionsList1[0];
    cellModel.chLowValueList = [self.dataModel CHLValueList];
    cellModel.chLowIndex = [self getCurrentCHLIndex];
    cellModel.chHighValueList = [self.dataModel CHHValueList];
    cellModel.chHighIndex = [self getCurrentCHHIndex];
    //Duty-cycle
    MKTextSwitchCellModel *dutyModel = self.optionsList2[0];
    dutyModel.isOn = self.dataModel.dutyIsOn;
    //DR For Join
    MKTextButtonCellModel *joinModel = self.optionsList3[0];
    joinModel.dataListIndex = self.dataModel.join;
    joinModel.dataList = [self.dataModel DRValueList];
    //ADR
    MKTextSwitchCellModel *adrModel = self.optionsList5[0];
    adrModel.isOn = self.dataModel.adrIsOn;
    //Transmissions
    MKTextButtonCellModel *trModel = self.optionsList6[0];
    trModel.dataListIndex = self.dataModel.transmissions - 1;
    //DR For Payload
    MKLoRaSettingCHCellModel *drModel = self.optionsList7[0];
    drModel.chLowValueList = [self.dataModel DRLValueList];
    drModel.chLowIndex = [self getCurrentDRLIndex];
    drModel.chHighValueList = [self.dataModel DRHValueList];
    drModel.chHighIndex = [self getCurrentDRHIndex];
    
    
    [self.tableView reloadData];
}

#pragma mark - loadSections
- (void)loadSectionDatas {
    [self loadSection0Datas];
    [self loadABPDatas];
    [self loadOTAADatas];
    [self loadSection2Datas];
    
    if (!self.dataModel.needAdvanceSetting) {
        [self.headerList addObjectsFromArray:[MKBGNormalAdopter loadSectionHeaderListWithNumber:3]];
        
        [self.tableView reloadData];
        return;
    }
    [self loadOptionsList0];
    [self loadOptionsList1];
    [self loadOptionsList2];
    [self loadOptionsList3];
    [self loadOptionsList4];
    [self loadOptionsList5];
    [self loadOptionsList6];
    [self loadOptionsList7];
    
    //底部需要高级设置
    if (!self.dataModel.advancedStatus) {
        //高级设置开关状态关闭
        [self.headerList addObjectsFromArray:[MKBGNormalAdopter loadSectionHeaderListWithNumber:4]];
    }else {
        //高级设置开关状态打开
        [self.headerList addObjectsFromArray:[MKBGNormalAdopter loadSectionHeaderListWithNumber:11]];
    }
    
    [self.tableView reloadData];
}

#pragma mark - 加载上面那个列表

- (void)loadSection0Datas {
    MKTextButtonCellModel *modeModel = [[MKTextButtonCellModel alloc] init];
    modeModel.index = 0;
    modeModel.msg = @"LoRaWAN Mode";
    modeModel.dataList = @[@"ABP",@"OTAA"];
    modeModel.dataListIndex = (self.dataModel.modem - 1);
    modeModel.buttonLabelFont = MKFont(13.f);
    [self.section0List addObject:modeModel];
}

- (void)loadABPDatas {
    MKTextFieldCellModel *devEUIModel = [[MKTextFieldCellModel alloc] init];
    devEUIModel.index = 0;
    devEUIModel.msg = @"DevEUI";
    devEUIModel.textFieldTextFont = MKFont(13.f);
    devEUIModel.textFieldType = mk_hexCharOnly;
    devEUIModel.clearButtonMode = UITextFieldViewModeAlways;
    devEUIModel.maxLength = 16;
    devEUIModel.textFieldValue = self.dataModel.devEUI;
    [self.abpDataList addObject:devEUIModel];
    
    MKTextFieldCellModel *appEUIModel = [[MKTextFieldCellModel alloc] init];
    appEUIModel.index = 1;
    appEUIModel.msg = @"AppEUI";
    appEUIModel.textFieldTextFont = MKFont(13.f);
    appEUIModel.textFieldType = mk_hexCharOnly;
    appEUIModel.clearButtonMode = UITextFieldViewModeAlways;
    appEUIModel.maxLength = 16;
    appEUIModel.textFieldValue = self.dataModel.appEUI;
    [self.abpDataList addObject:appEUIModel];
    
    MKTextFieldCellModel *devAddrModel = [[MKTextFieldCellModel alloc] init];
    devAddrModel.index = 2;
    devAddrModel.msg = @"DevAddr";
    devAddrModel.textFieldTextFont = MKFont(13.f);
    devAddrModel.textFieldType = mk_hexCharOnly;
    devAddrModel.clearButtonMode = UITextFieldViewModeAlways;
    devAddrModel.maxLength = 8;
    devAddrModel.textFieldValue = self.dataModel.devAddr;
    [self.abpDataList addObject:devAddrModel];
    
    MKTextFieldCellModel *appSkeyModel = [[MKTextFieldCellModel alloc] init];
    appSkeyModel.index = 3;
    appSkeyModel.msg = @"AppSkey";
    appSkeyModel.textFieldTextFont = MKFont(13.f);
    appSkeyModel.textFieldType = mk_hexCharOnly;
    appSkeyModel.clearButtonMode = UITextFieldViewModeAlways;
    appSkeyModel.maxLength = 32;
    appSkeyModel.textFieldValue = self.dataModel.appSKey;
    [self.abpDataList addObject:appSkeyModel];
    
    MKTextFieldCellModel *nwkSkeyModel = [[MKTextFieldCellModel alloc] init];
    nwkSkeyModel.index = 4;
    nwkSkeyModel.msg = @"NwkSkey";
    nwkSkeyModel.textFieldTextFont = MKFont(13.f);
    nwkSkeyModel.textFieldType = mk_hexCharOnly;
    nwkSkeyModel.clearButtonMode = UITextFieldViewModeAlways;
    nwkSkeyModel.maxLength = 32;
    nwkSkeyModel.textFieldValue = self.dataModel.nwkSKey;
    [self.abpDataList addObject:nwkSkeyModel];
}

- (void)loadOTAADatas {
    MKTextFieldCellModel *devEUIModel = [[MKTextFieldCellModel alloc] init];
    devEUIModel.index = 0;
    devEUIModel.msg = @"DevEUI";
    devEUIModel.textFieldTextFont = MKFont(13.f);
    devEUIModel.textFieldType = mk_hexCharOnly;
    devEUIModel.clearButtonMode = UITextFieldViewModeAlways;
    devEUIModel.maxLength = 16;
    devEUIModel.textFieldValue = self.dataModel.devEUI;
    [self.otaaDataList addObject:devEUIModel];
    
    MKTextFieldCellModel *appEUIModel = [[MKTextFieldCellModel alloc] init];
    appEUIModel.index = 1;
    appEUIModel.msg = @"AppEUI";
    appEUIModel.textFieldTextFont = MKFont(13.f);
    appEUIModel.textFieldType = mk_hexCharOnly;
    appEUIModel.clearButtonMode = UITextFieldViewModeAlways;
    appEUIModel.maxLength = 16;
    appEUIModel.textFieldValue = self.dataModel.appEUI;
    [self.otaaDataList addObject:appEUIModel];
    
    MKTextFieldCellModel *appKeyModel = [[MKTextFieldCellModel alloc] init];
    appKeyModel.index = 5;
    appKeyModel.msg = @"AppKey";
    appKeyModel.textFieldTextFont = MKFont(13.f);
    appKeyModel.textFieldType = mk_hexCharOnly;
    appKeyModel.clearButtonMode = UITextFieldViewModeAlways;
    appKeyModel.maxLength = 32;
    appKeyModel.textFieldValue = self.dataModel.appKey;
    [self.otaaDataList addObject:appKeyModel];
}

- (void)loadSection2Datas {
    MKTextButtonCellModel *regionModel = [[MKTextButtonCellModel alloc] init];
    regionModel.index = 1;
    regionModel.msg = @"Region/Subnet";
    regionModel.dataList = @[@"AS923",@"AU915",@"CN470",@"CN779",@"EU433",@"EU868",@"KR920",@"IN865",@"US915",@"RU864"];
    regionModel.buttonLabelFont = MKFont(13.f);
    regionModel.dataListIndex = self.dataModel.region;
    [self.section2List addObject:regionModel];
    
    MKTextButtonCellModel *messageModel = [[MKTextButtonCellModel alloc] init];
    messageModel.index = 2;
    messageModel.msg = @"Message Type";
    messageModel.dataList = @[@"Unconfirmed",@"Confirmed"];
    messageModel.buttonLabelFont = MKFont(13.f);
    messageModel.dataListIndex = self.dataModel.messageType;
    [self.section2List addObject:messageModel];
}

#pragma mark - 加载底部列表
- (void)loadOptionsList0 {
    MKLoRaAdvancedSettingCellModel *cellModel = [[MKLoRaAdvancedSettingCellModel alloc] init];
    cellModel.isOn = self.dataModel.advancedStatus;
    [self.optionsList0 addObject:cellModel];
}

- (void)loadOptionsList1 {
    MKLoRaSettingCHCellModel *cellModel = [[MKLoRaSettingCHCellModel alloc] init];
    cellModel.index = 0;
    cellModel.msg = @"CH";
    cellModel.noteMsg = @"*It is only used for US915,AU915,CN470";
    cellModel.noteMsgColor = RGBCOLOR(102, 102, 102);
    cellModel.chLowValueList = [self.dataModel CHLValueList];
    cellModel.chLowIndex = [self getCurrentCHLIndex];
    cellModel.chHighValueList = [self.dataModel CHHValueList];
    cellModel.chHighIndex = [self getCurrentCHHIndex];
    [self.optionsList1 addObject:cellModel];
}

- (void)loadOptionsList2 {
    MKTextSwitchCellModel *dutyModel = [[MKTextSwitchCellModel alloc] init];
    dutyModel.index = 0;
    dutyModel.msg = @"Duty-cycle";
    dutyModel.noteMsg = @"*It is only used for EU868,CN779, EU433,and RU864. Off: The uplink report interval will not be limit by region freqency. On:The uplink report interval will be limit by region freqency.";
    dutyModel.noteMsgColor = RGBCOLOR(102, 102, 102);
    dutyModel.isOn = self.dataModel.dutyIsOn;
    [self.optionsList2 addObject:dutyModel];
}

- (void)loadOptionsList3 {
    MKTextButtonCellModel *joinModel = [[MKTextButtonCellModel alloc] init];
    joinModel.index = 3;
    joinModel.msg = @"DR For Join";
    joinModel.dataList = [self.dataModel DRValueList];
    joinModel.buttonLabelFont = MKFont(13.f);
    joinModel.dataListIndex = self.dataModel.join;
    joinModel.noteMsg = @"*It is only used for CN470, CN779, EU433, EU868,KR920, IN865, RU864.";
    joinModel.noteMsgColor = RGBCOLOR(102, 102, 102);
    [self.optionsList3 addObject:joinModel];
}

- (void)loadOptionsList4 {
    MKNormalTextCellModel *cellModel = [[MKNormalTextCellModel alloc] init];
    cellModel.leftMsg = @"Uplink  Strategy";
    [self.optionsList4 addObject:cellModel];
}

- (void)loadOptionsList5 {
    MKTextSwitchCellModel *adrModel = [[MKTextSwitchCellModel alloc] init];
    adrModel.index = 1;
    adrModel.msg = @"ADR";
    adrModel.isOn = self.dataModel.adrIsOn;
    [self.optionsList5 addObject:adrModel];
}

- (void)loadOptionsList6 {
    MKTextButtonCellModel *transmissionsModel = [[MKTextButtonCellModel alloc] init];
    transmissionsModel.index = 4;
    transmissionsModel.msg = @"Transmissions";
    transmissionsModel.dataList = @[@"1",@"2"];
    transmissionsModel.buttonLabelFont = MKFont(13.f);
    transmissionsModel.dataListIndex = self.dataModel.transmissions - 1;
    [self.optionsList6 addObject:transmissionsModel];
}

- (void)loadOptionsList7 {
    MKLoRaSettingCHCellModel *cellModel = [[MKLoRaSettingCHCellModel alloc] init];
    cellModel.index = 1;
    cellModel.msg = @"DR For Payload";
    cellModel.chLowValueList = [self.dataModel DRLValueList];
    cellModel.chLowIndex = [self getCurrentDRLIndex];
    cellModel.chHighValueList = [self.dataModel DRHValueList];
    cellModel.chHighIndex = [self getCurrentDRHIndex];
    [self.optionsList7 addObject:cellModel];
}

- (NSInteger)getCurrentCHLIndex {
    NSInteger index = 0;
    for (NSInteger i = 0; i < self.dataModel.CHLValueList.count; i ++) {
        if (self.dataModel.CHL == [self.dataModel.CHLValueList[i] integerValue]) {
            index = i;
            break;
        }
    }
    return index;
}

- (NSInteger)getCurrentCHHIndex {
    NSInteger index = 0;
    for (NSInteger i = 0; i < self.dataModel.CHHValueList.count; i ++) {
        if (self.dataModel.CHH == [self.dataModel.CHHValueList[i] integerValue]) {
            index = i;
            break;
        }
    }
    return index;
}

- (NSInteger)getCurrentDRLIndex {
    NSInteger index = 0;
    for (NSInteger i = 0; i < self.dataModel.DRLValueList.count; i ++) {
        if (self.dataModel.DRL == [self.dataModel.DRLValueList[i] integerValue]) {
            index = i;
            break;
        }
    }
    return index;
}

- (NSInteger)getCurrentDRHIndex {
    NSInteger index = 0;
    for (NSInteger i = 0; i < self.dataModel.DRHValueList.count; i ++) {
        if (self.dataModel.DRH == [self.dataModel.DRHValueList[i] integerValue]) {
            index = i;
            break;
        }
    }
    return index;
}

#pragma mark - UI
- (void)loadSubViews {
    self.defaultTitle = @"Connection Settings";
    [self.rightButton setImage:LOADICON(@"MKLoRaWAN-BG", @"MKBGLoRaSettingController", @"bg_slotSaveIcon.png") forState:UIControlStateNormal];
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
        _tableView.delegate = self;
        _tableView.dataSource = self;
        
        _tableView.backgroundColor = RGBCOLOR(242, 242, 242);
    }
    return _tableView;
}

- (NSMutableArray *)section0List {
    if (!_section0List) {
        _section0List = [NSMutableArray array];
    }
    return _section0List;
}

- (NSMutableArray *)otaaDataList {
    if (!_otaaDataList) {
        _otaaDataList = [NSMutableArray array];
    }
    return _otaaDataList;
}

- (NSMutableArray *)abpDataList {
    if (!_abpDataList) {
        _abpDataList = [NSMutableArray array];
    }
    return _abpDataList;
}

- (NSMutableArray *)section2List {
    if (!_section2List) {
        _section2List = [NSMutableArray array];
    }
    return _section2List;
}

- (MKBGLoRaSettingModel *)dataModel {
    if (!_dataModel) {
        _dataModel = [[MKBGLoRaSettingModel alloc] init];
    }
    return _dataModel;
}

- (NSMutableArray *)optionsList0 {
    if (!_optionsList0) {
        _optionsList0 = [NSMutableArray array];
    }
    return _optionsList0;
}

- (NSMutableArray *)optionsList1 {
    if (!_optionsList1) {
        _optionsList1 = [NSMutableArray array];
    }
    return _optionsList1;
}

- (NSMutableArray *)optionsList2 {
    if (!_optionsList2) {
        _optionsList2 = [NSMutableArray array];
    }
    return _optionsList2;
}

- (NSMutableArray *)optionsList3 {
    if (!_optionsList3) {
        _optionsList3 = [NSMutableArray array];
    }
    return _optionsList3;
}

- (NSMutableArray *)optionsList4 {
    if (!_optionsList4) {
        _optionsList4 = [NSMutableArray array];
    }
    return _optionsList4;
}

- (NSMutableArray *)optionsList5 {
    if (!_optionsList5) {
        _optionsList5 = [NSMutableArray array];
    }
    return _optionsList5;
}

- (NSMutableArray *)optionsList6 {
    if (!_optionsList6) {
        _optionsList6 = [NSMutableArray array];
    }
    return _optionsList6;
}

- (NSMutableArray *)optionsList7 {
    if (!_optionsList7) {
        _optionsList7 = [NSMutableArray array];
    }
    return _optionsList7;
}

- (NSMutableArray *)headerList {
    if (!_headerList) {
        _headerList = [NSMutableArray array];
    }
    return _headerList;
}

@end
