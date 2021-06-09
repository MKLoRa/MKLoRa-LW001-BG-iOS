//
//  MKBGDeviceController.m
//  MKLoRaWAN-BG_Example
//
//  Created by aa on 2021/5/20.
//  Copyright © 2021 aadyx2007@163.com. All rights reserved.
//

#import "MKBGDeviceController.h"

#import "Masonry.h"

#import "MKMacroDefines.h"
#import "MKBaseTableView.h"
#import "UIView+MKAdd.h"
#import "UITableView+MKAdd.h"

#import "MKHudManager.h"
#import "MKNormalTextCell.h"
#import "MKTextSwitchCell.h"
#import "MKTextButtonCell.h"

#import "MKTableSectionLineHeader.h"

#import "MKBGNormalAdopter.h"

#import "MKBGIndicatorSettingsController.h"
#import "MKBGOnOffSettingsController.h"
#import "MKBGDeviceInfoController.h"

@interface MKBGDeviceController ()<UITableViewDelegate,
UITableViewDataSource,
MKTextButtonCellDelegate,
mk_textSwitchCellDelegate>

@property (nonatomic, strong)MKBaseTableView *tableView;

@property (nonatomic, strong)NSMutableArray *section0List;

@property (nonatomic, strong)NSMutableArray *section1List;

@property (nonatomic, strong)NSMutableArray *section2List;

@property (nonatomic, strong)NSMutableArray *section3List;

@property (nonatomic, strong)NSMutableArray *section4List;

@property (nonatomic, strong)NSMutableArray *section5List;

@property (nonatomic, strong)NSMutableArray *section6List;

@property (nonatomic, strong)NSMutableArray *section7List;

@property (nonatomic, strong)NSMutableArray *section8List;

@property (nonatomic, strong)NSMutableArray *headerList;

@end

@implementation MKBGDeviceController

- (void)dealloc {
    NSLog(@"MKBGDeviceController销毁");
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadSubViews];
    [self loadSectionDatas];
}

#pragma mark - super method
- (void)leftButtonMethod {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"mk_bg_popToRootViewControllerNotification" object:nil];
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 5) {
        MKTextButtonCellModel *cellModel = self.section5List[0];
        return [cellModel cellHeightWithContentWidth:kViewWidth];
    }
    return 44.f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 8) {
        return 0.f;
    }
    return 10.f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    MKTableSectionLineHeader *headerView = [MKTableSectionLineHeader initHeaderViewWithTableView:tableView];
    headerView.headerModel = self.headerList[section];
    return headerView;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1 && indexPath.row == 0) {
        //Indicator Settings
        MKBGIndicatorSettingsController *vc = [[MKBGIndicatorSettingsController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
        return;
    }
    if (indexPath.section == 4 && indexPath.row == 0) {
        //On/Off
        MKBGOnOffSettingsController *vc = [[MKBGOnOffSettingsController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
        return;
    }
    if (indexPath.section == 6 && indexPath.row == 0) {
        //Device Info
        MKBGDeviceInfoController *vc = [[MKBGDeviceInfoController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
        return;
    }
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 9;
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
    if (section == 7) {
        return self.section7List.count;
    }
    return self.section8List.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        MKNormalTextCell *cell = [MKNormalTextCell initCellWithTableView:tableView];
        cell.dataModel = self.section0List[indexPath.row];
        return cell;
    }
    if (indexPath.section == 1) {
        MKNormalTextCell *cell = [MKNormalTextCell initCellWithTableView:tableView];
        cell.dataModel = self.section1List[indexPath.row];
        return cell;
    }
    if (indexPath.section == 2) {
        MKTextButtonCell *cell = [MKTextButtonCell initCellWithTableView:tableView];
        cell.dataModel = self.section2List[indexPath.row];
        cell.delegate = self;
        return cell;
    }
    if (indexPath.section == 3) {
        MKTextSwitchCell *cell = [MKTextSwitchCell initCellWithTableView:tableView];
        cell.dataModel = self.section3List[indexPath.row];
        cell.delegate = self;
        return cell;
    }
    if (indexPath.section == 4) {
        MKNormalTextCell *cell = [MKNormalTextCell initCellWithTableView:tableView];
        cell.dataModel = self.section4List[indexPath.row];
        return cell;
    }
    if (indexPath.section == 5) {
        MKTextButtonCell *cell = [MKTextButtonCell initCellWithTableView:tableView];
        cell.dataModel = self.section5List[indexPath.row];
        cell.delegate = self;
        return cell;
    }
    if (indexPath.section == 6) {
        MKNormalTextCell *cell = [MKNormalTextCell initCellWithTableView:tableView];
        cell.dataModel = self.section6List[indexPath.row];
        return cell;
    }
    if (indexPath.section == 7) {
        MKNormalTextCell *cell = [MKNormalTextCell initCellWithTableView:tableView];
        cell.dataModel = self.section7List[indexPath.row];
        return cell;
    }
    MKTextSwitchCell *cell = [MKTextSwitchCell initCellWithTableView:tableView];
    cell.dataModel = self.section8List[indexPath.row];
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
        //Current Time Zone
        MKTextButtonCellModel *cellModel = self.section2List[0];
        cellModel.dataListIndex = dataListIndex;
        return;
    }
    if (index == 1) {
        //Low Power Prompt
        MKTextButtonCellModel *cellModel = self.section5List[0];
        cellModel.dataListIndex = dataListIndex;
        cellModel.noteMsg = [NSString stringWithFormat:@"*When the battery is less than or equal to %@, the red LED will flashe once every 30 seconds.",value];
        [self.tableView mk_reloadRow:0 inSection:5 withRowAnimation:UITableViewRowAnimationNone];
        return;
    }
}

#pragma mark - mk_textSwitchCellDelegate
/// 开关状态发生改变了
/// @param isOn 当前开关状态
/// @param index 当前cell所在的index
- (void)mk_textSwitchCellStatusChanged:(BOOL)isOn index:(NSInteger)index {
    if (index == 0) {
        //Shutdown Payload
        MKTextSwitchCellModel *cellModel = self.section3List[0];
        cellModel.isOn = isOn;
        return;
    }
    if (index == 1) {
        //Low-power Payload
        MKTextSwitchCellModel *cellModel = self.section3List[1];
        cellModel.isOn = isOn;
        return;
    }
    if (index == 2) {
        //Power Off
        MKTextSwitchCellModel *cellModel = self.section8List[0];
        cellModel.isOn = isOn;
        return;
    }
}

#pragma mark - loadSections
- (void)loadSectionDatas {
    [self loadSection0Datas];
    [self loadSection1Datas];
    [self loadSection2Datas];
    [self loadSection3Datas];
    [self loadSection4Datas];
    [self loadSection5Datas];
    [self loadSection6Datas];
    [self loadSection7Datas];
    [self loadSection8Datas];
        
    [self.tableView reloadData];
}

- (void)loadSection0Datas {
    MKNormalTextCellModel *cellModel = [[MKNormalTextCellModel alloc] init];
    cellModel.showRightIcon = YES;
    cellModel.leftMsg = @"Local Data Sync";
    [self.section0List addObject:cellModel];
    
    
}

- (void)loadSection1Datas {
    MKNormalTextCellModel *cellModel = [[MKNormalTextCellModel alloc] init];
    cellModel.showRightIcon = YES;
    cellModel.leftMsg = @"Indicator Settings";
    [self.section1List addObject:cellModel];
}

- (void)loadSection2Datas {
    MKTextButtonCellModel *cellModel = [[MKTextButtonCellModel alloc] init];
    cellModel.index = 0;
    cellModel.msg = @"Current Time Zone";
    cellModel.dataList = @[@"UTC-12",@"UTC-11",@"UTC-10",@"UTC-9",
                           @"UTC-8",@"UTC-7",@"UTC-6",@"UTC-5",
                           @"UTC-4",@"UTC-3",@"UTC-2",@"UTC-1",
                           @"UTC",@"UTC+1",@"UTC+2",@"UTC+3",
                           @"UTC+4",@"UTC+5",@"UTC+6",@"UTC+7",
                           @"UTC+8",@"UTC+9",@"UTC+10",@"UTC+11",
                           @"UTC+12"];
    cellModel.dataListIndex = 2;
    [self.section2List addObject:cellModel];
}

- (void)loadSection3Datas {
    MKTextSwitchCellModel *cellModel1 = [[MKTextSwitchCellModel alloc] init];
    cellModel1.index = 0;
    cellModel1.msg = @"Shutdown Payload";
    [self.section3List addObject:cellModel1];
    
    MKTextSwitchCellModel *cellModel2 = [[MKTextSwitchCellModel alloc] init];
    cellModel2.index = 1;
    cellModel2.msg = @"Low-power Payload";
    [self.section3List addObject:cellModel2];
}

- (void)loadSection4Datas {
    MKNormalTextCellModel *cellModel = [[MKNormalTextCellModel alloc] init];
    cellModel.showRightIcon = YES;
    cellModel.leftMsg = @"On/Off";
    [self.section4List addObject:cellModel];
}

- (void)loadSection5Datas {
    MKTextButtonCellModel *cellModel = [[MKTextButtonCellModel alloc] init];
    cellModel.index = 1;
    cellModel.msg = @"Low Power Prompt";
    cellModel.dataList = @[@"5%",@"10%"];
    cellModel.noteMsg = @"*When the battery is less than or equal to 10%, the red LED will flashe once every 30 seconds.";
    cellModel.noteMsgColor = RGBCOLOR(102, 102, 102);
    cellModel.dataListIndex = 1;
    [self.section5List addObject:cellModel];
}

- (void)loadSection6Datas {
    MKNormalTextCellModel *cellModel = [[MKNormalTextCellModel alloc] init];
    cellModel.showRightIcon = YES;
    cellModel.leftMsg = @"Device Information";
    [self.section6List addObject:cellModel];
}

- (void)loadSection7Datas {
    MKNormalTextCellModel *cellModel1 = [[MKNormalTextCellModel alloc] init];
    cellModel1.showRightIcon = YES;
    cellModel1.leftMsg = @"Factory Reset";
    [self.section7List addObject:cellModel1];
    
    MKNormalTextCellModel *cellModel2 = [[MKNormalTextCellModel alloc] init];
    cellModel2.showRightIcon = YES;
    cellModel2.leftMsg = @"Change Password";
    [self.section7List addObject:cellModel2];
}

- (void)loadSection8Datas {
    MKTextSwitchCellModel *cellModel = [[MKTextSwitchCellModel alloc] init];
    cellModel.index = 2;
    cellModel.msg = @"Power Off";
    [self.section8List addObject:cellModel];
}

#pragma mark - UI
- (void)loadSubViews {
    self.defaultTitle = @"Device Settings";
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(defaultTopInset);
        make.bottom.mas_equalTo(-VirtualHomeHeight - 49.f);
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

- (NSMutableArray *)section8List {
    if (!_section8List) {
        _section8List = [NSMutableArray array];
    }
    return _section8List;
}

- (NSMutableArray *)headerList {
    if (!_headerList) {
        _headerList = [NSMutableArray array];
        [_headerList addObjectsFromArray:[MKBGNormalAdopter loadSectionHeaderListWithNumber:9]];
    }
    return _headerList;
}

@end
