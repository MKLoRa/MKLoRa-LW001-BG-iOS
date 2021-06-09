//
//  MKBGDownlinkController.m
//  MKLoRaWAN-BG_Example
//
//  Created by aa on 2021/5/25.
//  Copyright © 2021 aadyx2007@163.com. All rights reserved.
//

#import "MKBGDownlinkController.h"

#import "Masonry.h"

#import "MKMacroDefines.h"
#import "MKBaseTableView.h"
#import "UIView+MKAdd.h"

#import "MKHudManager.h"
#import "MKTextButtonCell.h"

@interface MKBGDownlinkController ()<UITableViewDelegate,
UITableViewDataSource,
MKTextButtonCellDelegate>

@property (nonatomic, strong)MKBaseTableView *tableView;

@property (nonatomic, strong)NSMutableArray *section0List;

@end

@implementation MKBGDownlinkController

- (void)dealloc {
    NSLog(@"MKBGDownlinkController销毁");
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadSubViews];
    [self loadSectionDatas];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.section0List.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MKTextButtonCell *cell = [MKTextButtonCell initCellWithTableView:tableView];
    cell.dataModel = self.section0List[indexPath.row];
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
        //Positioning Strategy
        MKTextButtonCellModel *cellModel = self.section0List[0];
        cellModel.dataListIndex = dataListIndex;
        return;
    }
}

#pragma mark - loadSectionDatas
- (void)loadSectionDatas {
    [self loadSection0Datas];
}

- (void)loadSection0Datas {
    MKTextButtonCellModel *cellModel = [[MKTextButtonCellModel alloc] init];
    cellModel.index = 0;
    cellModel.msg = @"Positioning Strategy";
    cellModel.dataList = @[@"WIFI",@"BLE",@"GPS",@"WIFI+GPS",@"BLE+GPS",@"WIFI+BLE",@"WIFI+BLE+GPS"];
    cellModel.dataListIndex = 2;
    [self.section0List addObject:cellModel];
}

#pragma mark - UI
- (void)loadSubViews {
    self.defaultTitle = @"Downlink For Position";
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

@end
