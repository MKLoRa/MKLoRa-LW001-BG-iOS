//
//  MKBGBroadcastSettingsController.m
//  MKLoRaWAN-BG_Example
//
//  Created by aa on 2021/5/26.
//  Copyright © 2021 aadyx2007@163.com. All rights reserved.
//

#import "MKBGBroadcastSettingsController.h"

#import "Masonry.h"

#import "MLInputDodger.h"

#import "MKMacroDefines.h"
#import "MKBaseTableView.h"
#import "UIView+MKAdd.h"

#import "MKHudManager.h"
#import "MKTextFieldCell.h"
#import "MKNormalSliderCell.h"
#import "MKCustomUIAdopter.h"

#import "MKBGBroadcastTxPowerCell.h"

#import "MKBGBroadcastSettingsModel.h"

@interface MKBGBroadcastSettingsController ()<UITableViewDelegate,
UITableViewDataSource,
MKTextFieldCellDelegate,
MKNormalSliderCellDelegate,
MKBGBroadcastTxPowerCellDelegate>

@property (nonatomic, strong)MKBaseTableView *tableView;

@property (nonatomic, strong)NSMutableArray *section0List;

@property (nonatomic, strong)NSMutableArray *section1List;

@property (nonatomic, strong)NSMutableArray *section2List;

@property (nonatomic, strong)MKBGBroadcastSettingsModel *dataModel;

@end

@implementation MKBGBroadcastSettingsController

- (void)dealloc {
    NSLog(@"MKBGBroadcastSettingsController销毁");
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    self.view.shiftHeightAsDodgeViewForMLInputDodger = 50.0f;
    [self.view registerAsDodgeViewForMLInputDodgerWithOriginalY:self.view.frame.origin.y];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadSubViews];
    [self loadSectionDatas];
    [self readDataFromDevice];
}

#pragma mark - super method
- (void)rightButtonMethod {
    [[MKHudManager share] showHUDWithTitle:@"Config..." inView:self.view isPenetration:NO];
    @weakify(self);
    [self.dataModel configDataWithSucBlock:^{
        [[MKHudManager share] hide];
        [self.view showCentralToast:@"Success"];
    } failedBlock:^(NSError * _Nonnull error) {
        @strongify(self);
        [[MKHudManager share] hide];
        [self.view showCentralToast:error.userInfo[@"errorInfo"]];
    }];
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 2) {
        return 80.f;
    }
    return 60.f;
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
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
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        MKTextFieldCell *cell = [MKTextFieldCell initCellWithTableView:tableView];
        cell.dataModel = self.section0List[indexPath.row];
        cell.delegate = self;
        return cell;
    }
    if (indexPath.section == 1) {
        MKNormalSliderCell *cell = [MKNormalSliderCell initCellWithTableView:tableView];
        cell.dataModel = self.section1List[indexPath.row];
        cell.delegate = self;
        return cell;
    }
    MKBGBroadcastTxPowerCell *cell = [MKBGBroadcastTxPowerCell initCellWithTableView:tableView];
    cell.dataModel = self.section2List[indexPath.row];
    cell.delegate = self;
    return cell;
}

#pragma mark - MKTextFieldCellDelegate
- (void)mk_deviceTextCellValueChanged:(NSInteger)index textValue:(NSString *)value {
    MKTextFieldCellModel *cellModel = self.section0List[index];
    cellModel.textFieldValue = value;
    if (index == 0) {
        //BLE Name
        self.dataModel.advName = value;
        return;
    }
    if (index == 1) {
        //UUID
        self.dataModel.uuid = value;
        return;
    }
    if (index == 2) {
        //Major
        self.dataModel.major = value;
        return;
    }
    if (index == 3) {
        //Minor
        self.dataModel.minor = value;
        return;
    }
}

#pragma mark - MKNormalSliderCellDelegate
/// slider值发生改变的回调事件
/// @param value 当前slider的值
/// @param index 当前cell所在的index
- (void)mk_normalSliderValueChanged:(NSInteger)value index:(NSInteger)index {
    if (index == 0) {
        //RSSI@1m
        self.dataModel.measuredPower = value;
        MKNormalSliderCellModel *cellModel = self.section1List[0];
        cellModel.sliderValue = value;
        return;
    }
}

#pragma mark - MKBGBroadcastTxPowerCellDelegate
- (void)bg_txPowerValueChanged:(NSInteger)txPower {
    MKBGBroadcastTxPowerCellModel *cellModel = self.section2List[0];
    cellModel.txPowerValue = txPower;
    self.dataModel.txPower = txPower;
}

#pragma mark - interface
- (void)readDataFromDevice {
    [[MKHudManager share] showHUDWithTitle:@"Reading..." inView:self.view isPenetration:NO];
    @weakify(self);
    [self.dataModel readDataWithSucBlock:^{
        [[MKHudManager share] hide];
        [self updateCellModels];
    } failedBlock:^(NSError * _Nonnull error) {
        @strongify(self);
        [[MKHudManager share] hide];
        [self.view showCentralToast:error.userInfo[@"errorInfo"]];
    }];
}

- (void)updateCellModels {
    MKTextFieldCellModel *advNameModel = self.section0List[0];
    advNameModel.textFieldValue = self.dataModel.advName;
    
    MKTextFieldCellModel *uuidModel = self.section0List[1];
    uuidModel.textFieldValue = self.dataModel.uuid;
    
    MKTextFieldCellModel *majorModel = self.section0List[2];
    majorModel.textFieldValue = self.dataModel.major;
    
    MKTextFieldCellModel *minorModel = self.section0List[3];
    minorModel.textFieldValue = self.dataModel.minor;
    
    
    MKNormalSliderCellModel *rssiModel = self.section1List[0];
    rssiModel.sliderValue = self.dataModel.measuredPower;
    
    MKBGBroadcastTxPowerCellModel *txPowerModel = self.section2List[0];
    txPowerModel.txPowerValue = self.dataModel.txPower;
    
    [self.tableView reloadData];
}

#pragma mark - loadSectionDatas
- (void)loadSectionDatas {
    [self loadSection0Datas];
    [self loadSection1Datas];
    [self loadSection2Datas];
    
    [self.tableView reloadData];
}

- (void)loadSection0Datas {
    MKTextFieldCellModel *advNameModel = [[MKTextFieldCellModel alloc] init];
    advNameModel.msg = @"ADV Name";
    advNameModel.textPlaceholder = @"0~13 Characters";
    advNameModel.maxLength = 13;
    advNameModel.textFieldType = mk_normal;
    advNameModel.index = 0;
    [self.section0List addObject:advNameModel];
    
    MKTextFieldCellModel *uuidModel = [[MKTextFieldCellModel alloc] init];
    uuidModel.msg = @"Proximity UUID";
    uuidModel.textPlaceholder = @"16 Bytes";
    uuidModel.textFieldType = mk_uuidMode;
    uuidModel.index = 1;
    [self.section0List addObject:uuidModel];
    
    MKTextFieldCellModel *majorModel = [[MKTextFieldCellModel alloc] init];
    majorModel.msg = @"Major";
    majorModel.textPlaceholder = @"0~65535";
    majorModel.maxLength = 5;
    majorModel.textFieldType = mk_realNumberOnly;
    majorModel.index = 2;
    [self.section0List addObject:majorModel];
    
    MKTextFieldCellModel *minorModel = [[MKTextFieldCellModel alloc] init];
    minorModel.msg = @"Minor";
    minorModel.textPlaceholder = @"0~65535";
    minorModel.maxLength = 5;
    minorModel.textFieldType = mk_realNumberOnly;
    minorModel.index = 3;
    [self.section0List addObject:minorModel];
}

- (void)loadSection1Datas {
    MKNormalSliderCellModel *cellModel = [[MKNormalSliderCellModel alloc] init];
    cellModel.index = 0;
    cellModel.msg = [MKCustomUIAdopter attributedString:@[@"RSSI@1m",@"   (-127dBm ~ 0dBm)"] fonts:@[MKFont(15.f),MKFont(13.f)] colors:@[DEFAULT_TEXT_COLOR,RGBCOLOR(223, 223, 223)]];
    [self.section1List addObject:cellModel];
}

- (void)loadSection2Datas {
    MKBGBroadcastTxPowerCellModel *cellModel = [[MKBGBroadcastTxPowerCellModel alloc] init];
    [self.section2List addObject:cellModel];
}

#pragma mark - UI
- (void)loadSubViews {
    self.defaultTitle = @"Broadcast Content";
    [self.rightButton setImage:LOADICON(@"MKLoRaWAN-BG", @"MKBGBroadcastSettingsController", @"bg_slotSaveIcon.png") forState:UIControlStateNormal];
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

- (MKBGBroadcastSettingsModel *)dataModel {
    if (!_dataModel) {
        _dataModel = [[MKBGBroadcastSettingsModel alloc] init];
    }
    return _dataModel;
}

@end
