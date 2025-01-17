//
//  MKBGBatteryInfoCell.m
//  MKLoRaWAN-PIR_Example
//
//  Created by aa on 2021/5/24.
//  Copyright © 2021 aadyx2007@163.com. All rights reserved.
//

#import "MKBGBatteryInfoCell.h"

#import "Masonry.h"

#import "MKMacroDefines.h"
#import "UIView+MKAdd.h"

#import "MKCustomUIAdopter.h"

@implementation MKBGBatteryInfoCellModel
@end

@interface MKBGBatteryInfoCell ()

@property (nonatomic, strong)UILabel *msgLabel;

@property (nonatomic, strong)UILabel *workTimeLabel;

@property (nonatomic, strong)UILabel *advCountLabel;

@property (nonatomic, strong)UILabel *axisPostionLabel;

@property (nonatomic, strong)UILabel *blePostionLabel;

@property (nonatomic, strong)UILabel *wifiPostionLabel;

@property (nonatomic, strong)UILabel *gpsPostionLabel;

@property (nonatomic, strong)UILabel *loraSendCountLabel;

@property (nonatomic, strong)UILabel *loraPowerLabel;

@property (nonatomic, strong)UILabel *batteryPowerLabel;

@property (nonatomic, strong)UILabel *staticReportLabel;

@property (nonatomic, strong)UILabel *moveReportLabel;

@end

@implementation MKBGBatteryInfoCell

+ (MKBGBatteryInfoCell *)initCellWithTableView:(UITableView *)tableView {
    MKBGBatteryInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MKBGBatteryInfoCellIdenty"];
    if (!cell) {
        cell = [[MKBGBatteryInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MKBGBatteryInfoCellIdenty"];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.msgLabel];
        [self.contentView addSubview:self.workTimeLabel];
        [self.contentView addSubview:self.advCountLabel];
        [self.contentView addSubview:self.axisPostionLabel];
        [self.contentView addSubview:self.blePostionLabel];
        [self.contentView addSubview:self.wifiPostionLabel];
        [self.contentView addSubview:self.gpsPostionLabel];
        [self.contentView addSubview:self.loraPowerLabel];
        [self.contentView addSubview:self.loraSendCountLabel];
        [self.contentView addSubview:self.batteryPowerLabel];
        [self.contentView addSubview:self.staticReportLabel];
        [self.contentView addSubview:self.moveReportLabel];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self.msgLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15.f);
        make.right.mas_equalTo(-15.f);
        make.top.mas_equalTo(10.f);
        make.height.mas_equalTo(MKFont(15.f).lineHeight);
    }];
    [self.workTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15.f);
        make.right.mas_equalTo(-15.f);
        make.top.mas_equalTo(self.msgLabel.mas_bottom).mas_offset(10.f);
        make.height.mas_equalTo(MKFont(13.f).lineHeight);
    }];
    [self.advCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15.f);
        make.right.mas_equalTo(-15.f);
        make.top.mas_equalTo(self.workTimeLabel.mas_bottom).mas_offset(10.f);
        make.height.mas_equalTo(MKFont(13.f).lineHeight);
    }];
    [self.axisPostionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15.f);
        make.right.mas_equalTo(-15.f);
        make.top.mas_equalTo(self.advCountLabel.mas_bottom).mas_offset(10.f);
        make.height.mas_equalTo(MKFont(13.f).lineHeight);
    }];
    [self.blePostionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15.f);
        make.right.mas_equalTo(-15.f);
        make.top.mas_equalTo(self.axisPostionLabel.mas_bottom).mas_offset(10.f);
        make.height.mas_equalTo(MKFont(13.f).lineHeight);
    }];
    [self.wifiPostionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15.f);
        make.right.mas_equalTo(-15.f);
        make.top.mas_equalTo(self.blePostionLabel.mas_bottom).mas_offset(10.f);
        make.height.mas_equalTo(MKFont(13.f).lineHeight);
    }];
    [self.gpsPostionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15.f);
        make.right.mas_equalTo(-15.f);
        make.top.mas_equalTo(self.wifiPostionLabel.mas_bottom).mas_offset(10.f);
        make.height.mas_equalTo(MKFont(13.f).lineHeight);
    }];
    [self.loraSendCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15.f);
        make.right.mas_equalTo(-15.f);
        make.top.mas_equalTo(self.gpsPostionLabel.mas_bottom).mas_offset(10.f);
        make.height.mas_equalTo(MKFont(13.f).lineHeight);
    }];
    [self.loraPowerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15.f);
        make.right.mas_equalTo(-15.f);
        make.top.mas_equalTo(self.loraSendCountLabel.mas_bottom).mas_offset(10.f);
        make.height.mas_equalTo(MKFont(13.f).lineHeight);
    }];
    [self.batteryPowerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15.f);
        make.right.mas_equalTo(-15.f);
        make.top.mas_equalTo(self.loraPowerLabel.mas_bottom).mas_offset(10.f);
        make.height.mas_equalTo(MKFont(13.f).lineHeight);
    }];
    [self.staticReportLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15.f);
        make.right.mas_equalTo(-15.f);
        make.top.mas_equalTo(self.batteryPowerLabel.mas_bottom).mas_offset(10.f);
        make.height.mas_equalTo(MKFont(13.f).lineHeight);
    }];
    [self.moveReportLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15.f);
        make.right.mas_equalTo(-15.f);
        make.top.mas_equalTo(self.staticReportLabel.mas_bottom).mas_offset(10.f);
        make.height.mas_equalTo(MKFont(13.f).lineHeight);
    }];
}

#pragma mark - setter
- (void)setDataModel:(MKBGBatteryInfoCellModel *)dataModel {
    _dataModel = nil;
    _dataModel = dataModel;
    if (!_dataModel || ![_dataModel isKindOfClass:MKBGBatteryInfoCellModel.class]) {
        return;
    }
    self.msgLabel.text = SafeStr(_dataModel.msg);
    self.workTimeLabel.text = [SafeStr(_dataModel.workTimes) stringByAppendingString:@" s"];
    self.advCountLabel.text = [SafeStr(_dataModel.advCount) stringByAppendingString:@" times"];
    self.axisPostionLabel.text = [SafeStr(_dataModel.axisWakeupTimes) stringByAppendingString:@"s"];
    self.blePostionLabel.text = [SafeStr(_dataModel.blePostionTimes) stringByAppendingString:@"s"];
    self.wifiPostionLabel.text = [SafeStr(_dataModel.wifiPostionTimes) stringByAppendingString:@"s"];
    self.gpsPostionLabel.text = [SafeStr(_dataModel.gpsPostionTimes) stringByAppendingString:@"s"];
    self.loraPowerLabel.text = [SafeStr(_dataModel.loraPowerConsumption) stringByAppendingString:@" mAS"];
    self.loraSendCountLabel.text = [SafeStr(_dataModel.loraSendCount) stringByAppendingString:@" times"];
    self.batteryPowerLabel.text = [NSString stringWithFormat:@"%.3f %@",([_dataModel.batteryPower integerValue] * 0.001),@"mAH"];
    self.staticReportLabel.text = [SafeStr(_dataModel.staticReportCount) stringByAppendingString:@" peices of payload 1"];
    self.moveReportLabel.text = [SafeStr(_dataModel.moveReportCount) stringByAppendingString:@" peices of payload 2"];
}

#pragma mark - getter
- (UILabel *)msgLabel {
    if (!_msgLabel) {
        _msgLabel = [[UILabel alloc] init];
        _msgLabel.textColor = DEFAULT_TEXT_COLOR;
        _msgLabel.textAlignment = NSTextAlignmentLeft;
        _msgLabel.font = MKFont(15.f);
    }
    return _msgLabel;
}

- (UILabel *)workTimeLabel {
    if (!_workTimeLabel) {
        _workTimeLabel = [self fetchValueLabel];
    }
    return _workTimeLabel;
}

- (UILabel *)advCountLabel {
    if (!_advCountLabel) {
        _advCountLabel = [self fetchValueLabel];
    }
    return _advCountLabel;
}

- (UILabel *)axisPostionLabel {
    if (!_axisPostionLabel) {
        _axisPostionLabel = [self fetchValueLabel];
    }
    return _axisPostionLabel;
}

- (UILabel *)blePostionLabel {
    if (!_blePostionLabel) {
        _blePostionLabel = [self fetchValueLabel];
    }
    return _blePostionLabel;
}

- (UILabel *)wifiPostionLabel {
    if (!_wifiPostionLabel) {
        _wifiPostionLabel = [self fetchValueLabel];
    }
    return _wifiPostionLabel;
}

- (UILabel *)gpsPostionLabel {
    if (!_gpsPostionLabel) {
        _gpsPostionLabel = [self fetchValueLabel];
    }
    return _gpsPostionLabel;
}

- (UILabel *)loraSendCountLabel {
    if (!_loraSendCountLabel) {
        _loraSendCountLabel = [self fetchValueLabel];
    }
    return _loraSendCountLabel;
}

- (UILabel *)loraPowerLabel {
    if (!_loraPowerLabel) {
        _loraPowerLabel = [self fetchValueLabel];
    }
    return _loraPowerLabel;
}

- (UILabel *)batteryPowerLabel {
    if (!_batteryPowerLabel) {
        _batteryPowerLabel = [self fetchValueLabel];
    }
    return _batteryPowerLabel;
}

- (UILabel *)staticReportLabel {
    if (!_staticReportLabel) {
        _staticReportLabel = [self fetchValueLabel];
    }
    return _staticReportLabel;
}

- (UILabel *)moveReportLabel {
    if (!_moveReportLabel) {
        _moveReportLabel = [self fetchValueLabel];
    }
    return _moveReportLabel;
}

- (UILabel *)fetchValueLabel {
    UILabel *label = [[UILabel alloc] init];
    label.textColor = DEFAULT_TEXT_COLOR;
    label.textAlignment = NSTextAlignmentLeft;
    label.font = MKFont(13.f);
    return label;
}

@end
