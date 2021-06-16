//
//  MKBGManDownController.m
//  MKLoRaWAN-BG_Example
//
//  Created by aa on 2021/5/25.
//  Copyright © 2021 aadyx2007@163.com. All rights reserved.
//

#import "MKBGManDownController.h"

#import "Masonry.h"

#import "MLInputDodger.h"

#import "MKMacroDefines.h"
#import "MKBaseTableView.h"
#import "UIView+MKAdd.h"
#import "UITableView+MKAdd.h"

#import "MKHudManager.h"
#import "MKTextFieldCell.h"
#import "MKTextSwitchCell.h"

#import "MKBGInterface+MKBGConfig.h"

#import "MKBGTextButtonCell.h"

#import "MKBGManDownDataModel.h"

@interface MKBGManDownController ()<UITableViewDelegate,
UITableViewDataSource,
MKTextFieldCellDelegate,
mk_textSwitchCellDelegate,
MKBGTextButtonCellDelegate>

@property (nonatomic, strong)MKBaseTableView *tableView;

@property (nonatomic, strong)NSMutableArray *section0List;

@property (nonatomic, strong)NSMutableArray *section1List;

@property (nonatomic, strong)NSMutableArray *section2List;

@property (nonatomic, strong)MKBGManDownDataModel *dataModel;

@property (nonatomic, strong)UIAlertController *alertView;

@end

@implementation MKBGManDownController

- (void)dealloc {
    NSLog(@"MKBGManDownController销毁");
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
    [self configDataToDevice];
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44.f;
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
    return self.section2List.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        MKTextSwitchCell *cell = [MKTextSwitchCell initCellWithTableView:tableView];
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
    MKBGTextButtonCell *cell = [MKBGTextButtonCell initCellWithTableView:tableView];
    cell.dataModel = self.section2List[indexPath.row];
    cell.delegate = self;
    return cell;
}

#pragma mark - MKTextFieldCellDelegate
/// textField内容发送改变时的回调事件
/// @param index 当前cell所在的index
/// @param value 当前textField的值
- (void)mk_deviceTextCellValueChanged:(NSInteger)index textValue:(NSString *)value {
    if (index == 0) {
        //Idle Detection Timeout
        MKTextFieldCellModel *cellModel = self.section1List[0];
        cellModel.textFieldValue = value;
        self.dataModel.interval = value;
        return;
    }
}

#pragma mark - mk_textSwitchCellDelegate
/// 开关状态发生改变了
/// @param isOn 当前开关状态
/// @param index 当前cell所在的index
- (void)mk_textSwitchCellStatusChanged:(BOOL)isOn index:(NSInteger)index {
    if (index == 0) {
        //Man Down Detection
        [self configManDownDetection:isOn];
        return;
    }
}

#pragma mark - MKBGTextButtonCellDelegate
/// 用户点击了右侧按钮
/// @param index cell所在序列号
- (void)bg_textButtonCell_buttonAction:(NSInteger)index {
    if (index == 0) {
        //Idle Stutas
        [self presentViewController:self.alertView animated:YES completion:nil];
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

- (void)configDataToDevice {
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

- (void)configManDownDetection:(BOOL)isOn {
    [[MKHudManager share] showHUDWithTitle:@"Config..." inView:self.view isPenetration:NO];
    [MKBGInterface bg_configManDownDetectionStatus:isOn sucBlock:^{
        [[MKHudManager share] hide];
        MKTextSwitchCellModel *cellModel = self.section0List[0];
        cellModel.isOn = isOn;
        self.dataModel.isOn = isOn;
    } failedBlock:^(NSError * _Nonnull error) {
        [[MKHudManager share] hide];
        [self.view showCentralToast:error.userInfo[@"errorInfo"]];
        [self.tableView mk_reloadSection:0 withRowAnimation:UITableViewRowAnimationNone];
    }];
    
}

- (void)resetIdleStatus{
    [[MKHudManager share] showHUDWithTitle:@"Setting..."
                                     inView:self.view
                              isPenetration:NO];
    [MKBGInterface bg_configIdleStutasResetWithSucBlock:^{
        [[MKHudManager share] hide];
        [self.view showCentralToast:@"Success"];
    } failedBlock:^(NSError * _Nonnull error) {
        [[MKHudManager share] hide];
        [self.view showCentralToast:error.userInfo[@"errorInfo"]];
    }];
}

#pragma mark - loadSectionDatas
- (void)loadSectionDatas {
    [self loadSection0Datas];
    [self loadSection1Datas];
    [self loadSection2Datas];
    
    [self.tableView reloadData];
}

- (void)loadSection0Datas {
    MKTextSwitchCellModel *cellModel = [[MKTextSwitchCellModel alloc] init];
    cellModel.index = 0;
    cellModel.msg = @"Man Down Detection";
    cellModel.isOn = self.dataModel.isOn;
    [self.section0List addObject:cellModel];
}

- (void)loadSection1Datas {
    MKTextFieldCellModel *cellModel = [[MKTextFieldCellModel alloc] init];
    cellModel.index = 0;
    cellModel.msg = @"Idle Detection Timeout";
    cellModel.textPlaceholder = @"1~8760";
    cellModel.textFieldType = mk_realNumberOnly;
    cellModel.maxLength = 4;
    cellModel.unit = @"H";
    cellModel.textFieldValue = self.dataModel.interval;
    [self.section1List addObject:cellModel];
}

- (void)loadSection2Datas {
    MKBGTextButtonCellModel *cellModel = [[MKBGTextButtonCellModel alloc] init];
    cellModel.index = 0;
    cellModel.leftMsg = @"Idle Stutas";
    cellModel.rightButtonTitle = @"Reset";
    [self.section2List addObject:cellModel];
}

#pragma mark - UI
- (void)loadSubViews {
    self.defaultTitle = @"ManDown Detection";
    [self.rightButton setImage:LOADICON(@"MKLoRaWAN-BG", @"MKBGManDownController", @"bg_slotSaveIcon.png") forState:UIControlStateNormal];
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

- (MKBGManDownDataModel *)dataModel {
    if (!_dataModel) {
        _dataModel = [[MKBGManDownDataModel alloc] init];
    }
    return _dataModel;
}

- (UIAlertController *)alertView {
    if (!_alertView) {
        _alertView = [UIAlertController alertControllerWithTitle:@"Reset Idle Status"
                                                         message:@"Whether to confirm the reset"
                                                  preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        [_alertView addAction:cancelAction];
        @weakify(self);
        UIAlertAction *moreAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            @strongify(self);
            [self resetIdleStatus];
        }];
        [_alertView addAction:moreAction];
    }
    return _alertView;
}

@end
