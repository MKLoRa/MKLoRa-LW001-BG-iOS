//
//  MKBGBroadcastTxPowerCell.m
//  MKLoRaWAN-BG_Example
//
//  Created by aa on 2021/6/15.
//  Copyright © 2021 aadyx2007@163.com. All rights reserved.
//

#import "MKBGBroadcastTxPowerCell.h"

#import "Masonry.h"

#import "MKMacroDefines.h"

#import "MKCustomUIAdopter.h"
#import "MKSlider.h"

@implementation MKBGBroadcastTxPowerCellModel
@end

@interface MKBGBroadcastTxPowerCell ()

@property (nonatomic, strong)UILabel *msgLabel;

@property (nonatomic, strong)UILabel *noteLabel;

@property (nonatomic, strong)UILabel *valueLabel;

@property (nonatomic, strong)MKSlider *slider;

@end

@implementation MKBGBroadcastTxPowerCell

+ (MKBGBroadcastTxPowerCell *)initCellWithTableView:(UITableView *)tableView {
    MKBGBroadcastTxPowerCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MKBGBroadcastTxPowerCellIdenty"];
    if (!cell) {
        cell = [[MKBGBroadcastTxPowerCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MKBGBroadcastTxPowerCellIdenty"];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.msgLabel];
        [self.contentView addSubview:self.noteLabel];
        [self.contentView addSubview:self.valueLabel];
        [self.contentView addSubview:self.slider];
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
    [self.noteLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15.f);
        make.right.mas_equalTo(-15.f);
        make.top.mas_equalTo(self.msgLabel.mas_bottom).mas_offset(5.f);
        make.height.mas_equalTo(MKFont(13.f).lineHeight);
    }];
    [self.slider mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15.f);
        make.right.mas_equalTo(self.valueLabel.mas_left).mas_offset(-5.f);
        make.top.mas_equalTo(self.noteLabel.mas_bottom).mas_offset(10.f);
        make.height.mas_equalTo(10.f);
    }];
    [self.valueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-15.f);
        make.width.mas_equalTo(60.f);
        make.centerY.mas_equalTo(self.slider.mas_centerY);
        make.height.mas_equalTo(MKFont(12.f).lineHeight);
    }];
}

#pragma mark - event method
- (void)txPowerSliderValueChanged {
    self.valueLabel.text = [self txPowerValueText:self.slider.value];
    if ([self.delegate respondsToSelector:@selector(bg_txPowerValueChanged:)]) {
        [self.delegate bg_txPowerValueChanged:(NSInteger)self.slider.value];
    }
}

#pragma mark - private method
- (NSString *)txPowerValueText:(float)sliderValue{
    if (sliderValue >=0 && sliderValue < 1) {
        return @"-40dBm";
    }
    if (sliderValue >= 1 && sliderValue < 2){
        return @"-20dBm";
    }
    if (sliderValue >= 2 && sliderValue < 3){
        return @"-16dBm";
    }
    if (sliderValue >= 3 && sliderValue < 4){
        return @"-12dBm";
    }
    if (sliderValue >= 4 && sliderValue < 5){
        return @"-8dBm";
    }
    if (sliderValue >= 5 && sliderValue < 6){
        return @"-4dBm";
    }
    if (sliderValue >= 6 && sliderValue < 7){
        return @"0dBm";
    }
    if (sliderValue >= 7 && sliderValue < 8) {
        return @"2dBm";
    }
    if (sliderValue >= 8 && sliderValue < 9) {
        return @"3dBm";
    }
    if (sliderValue >= 9 && sliderValue < 10) {
        return @"4dBm";
    }
    if (sliderValue >= 10 && sliderValue < 11) {
        return @"5dBm";
    }
    if (sliderValue >= 11 && sliderValue < 12) {
        return @"6dBm";
    }
    if (sliderValue >= 12 && sliderValue < 13) {
        return @"7dBm";
    }
    return @"8dBm";
}

#pragma mark - setter
- (void)setDataModel:(MKBGBroadcastTxPowerCellModel *)dataModel {
    _dataModel = nil;
    _dataModel = dataModel;
    if (!_dataModel) {
        return;
    }
    self.slider.value = _dataModel.txPowerValue;
    self.valueLabel.text = [self txPowerValueText:self.slider.value];
}

#pragma mark - getter
- (UILabel *)msgLabel {
    if (!_msgLabel) {
        _msgLabel = [[UILabel alloc] init];
        _msgLabel.textAlignment = NSTextAlignmentLeft;
        _msgLabel.font = MKFont(15.f);
        _msgLabel.textColor = DEFAULT_TEXT_COLOR;
        _msgLabel.text = @"Tx Power";
    }
    return _msgLabel;
}

- (UILabel *)noteLabel {
    if (!_noteLabel) {
        _noteLabel = [[UILabel alloc] init];
        _noteLabel.font = MKFont(13.f);
        _noteLabel.textColor = RGBCOLOR(223, 223, 223);
        _noteLabel.textAlignment = NSTextAlignmentLeft;
        _noteLabel.text = @"(-40,-20,-16,-12,-8,-4,0,+2,+3,+4,+5,+6,+7,+8)";
    }
    return _noteLabel;
}

- (MKSlider *)slider {
    if (!_slider) {
        _slider = [[MKSlider alloc] init];
        _slider.maximumValue = 13.f;
        _slider.minimumValue = 0.f;
        _slider.value = 6.f;
        [_slider addTarget:self
                    action:@selector(txPowerSliderValueChanged)
          forControlEvents:UIControlEventValueChanged];
    }
    return _slider;
}

- (UILabel *)valueLabel {
    if (!_valueLabel) {
        _valueLabel = [[UILabel alloc] init];
        _valueLabel.textColor = DEFAULT_TEXT_COLOR;
        _valueLabel.textAlignment = NSTextAlignmentLeft;
        _valueLabel.font = MKFont(11.f);
        _valueLabel.text = @"0dBm";
    }
    return _valueLabel;
}

@end
