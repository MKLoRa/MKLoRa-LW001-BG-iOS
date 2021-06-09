//
//  MKBGFilterByPHYCell.m
//  MKLoRaWAN-BG_Example
//
//  Created by aa on 2021/6/1.
//  Copyright © 2021 aadyx2007@163.com. All rights reserved.
//

#import "MKBGFilterByPHYCell.h"

#import "Masonry.h"

#import "MKMacroDefines.h"
#import "MKPickerView.h"

static CGFloat const switchButtonWidth = 40.f;
static CGFloat const switchButtonHeight = 30.f;

@implementation MKBGFilterByPHYCellModel
@end

@interface MKBGFilterByPHYCell ()

@property (nonatomic, strong)UILabel *msgLabel;

@property (nonatomic, strong)UIButton *switchButton;

@property (nonatomic, strong)UIButton *phyButton;

@property (nonatomic, strong)NSMutableArray *dataList;

@end

@implementation MKBGFilterByPHYCell

+ (MKBGFilterByPHYCell *)initCellWithTableView:(UITableView *)tableView {
    MKBGFilterByPHYCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MKBGFilterByPHYCellIdenty"];
    if (!cell) {
        cell = [[MKBGFilterByPHYCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MKBGFilterByPHYCellIdenty"];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.msgLabel];
        [self.contentView addSubview:self.switchButton];
        [self.contentView addSubview:self.phyButton];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    if (!self.dataModel.isOn) {
        //开关关闭
        [self.msgLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(15.f);
            make.right.mas_equalTo(self.switchButton.mas_left).mas_offset(-15.f);
            make.centerY.mas_equalTo(self.contentView.mas_centerY);
            make.height.mas_equalTo(MKFont(15.f).lineHeight);
        }];
        [self.switchButton mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-15.f);
            make.width.mas_equalTo(switchButtonWidth);
            make.centerY.mas_equalTo(self.contentView.mas_centerY);
            make.height.mas_equalTo(switchButtonHeight);
        }];
        return;
    }
    [self.msgLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15.f);
        make.right.mas_equalTo(self.switchButton.mas_left).mas_offset(-15.f);
        make.top.mas_equalTo(15.f);
        make.height.mas_equalTo(MKFont(15.f).lineHeight);
    }];
    [self.switchButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-15.f);
        make.width.mas_equalTo(switchButtonWidth);
        make.centerY.mas_equalTo(self.msgLabel.mas_centerY);
        make.height.mas_equalTo(switchButtonHeight);
    }];
    [self.phyButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15.f);
        make.width.mas_equalTo(90.f);
        make.top.mas_equalTo(self.switchButton.mas_bottom).mas_offset(10.f);
        make.height.mas_equalTo(30.f);
    }];
}

#pragma mark - event method
- (void)switchButtonPressed {
    self.switchButton.selected = !self.switchButton.selected;
    UIImage *switchIcon = (self.switchButton.selected ? LOADICON(@"MKLoRaWAN-BG", @"MKBGFilterByPHYCell", @"bg_switchSelectedIcon.png") : LOADICON(@"MKLoRaWAN-BG", @"MKBGFilterByPHYCell", @"bg_switchUnselectedIcon.png"));
    [self.switchButton setImage:switchIcon forState:UIControlStateNormal];
    if ([self.delegate respondsToSelector:@selector(bg_filterByPHYStatusChanged:isOn:)]) {
        [self.delegate bg_filterByPHYStatusChanged:self.dataModel.index isOn:self.switchButton.selected];
    }
}

- (void)phyButtonPressed {
    
    NSInteger index = 0;
    for (NSInteger i = 0; i < self.dataList.count; i ++) {
        if ([self.phyButton.titleLabel.text isEqualToString:self.dataList[i]]) {
            index = i;
            break;
        }
    }
    
    MKPickerView *pickView = [[MKPickerView alloc] init];
    [pickView showPickViewWithDataList:self.dataList selectedRow:index block:^(NSInteger currentRow) {
        [self.phyButton setTitle:self.dataList[currentRow] forState:UIControlStateNormal];
        if ([self.delegate respondsToSelector:@selector(bg_filterByPHYTypeChanged:dataListIndex:value:)]) {
            [self.delegate bg_filterByPHYTypeChanged:self.dataModel.index
                                       dataListIndex:currentRow
                                               value:self.dataList[currentRow]];
        }
    }];
}

#pragma mark - setter
- (void)setDataModel:(MKBGFilterByPHYCellModel *)dataModel {
    _dataModel = nil;
    _dataModel = dataModel;
    if (!_dataModel || ![_dataModel isKindOfClass:MKBGFilterByPHYCellModel.class]
        || !ValidArray(_dataModel.dataList) || _dataModel.dataListIndex >= _dataModel.dataList.count) {
        return;
    }
    self.msgLabel.text = SafeStr(_dataModel.msg);
    [self.dataList removeAllObjects];
    [self.dataList addObjectsFromArray:_dataModel.dataList];
    self.switchButton.selected = _dataModel.isOn;
    UIImage *switchIcon = (self.switchButton.selected ? LOADICON(@"MKLoRaWAN-BG", @"MKBGFilterByPHYCell", @"bg_switchSelectedIcon.png") : LOADICON(@"MKLoRaWAN-BG", @"MKBGFilterByPHYCell", @"bg_switchUnselectedIcon.png"));
    [self.switchButton setImage:switchIcon forState:UIControlStateNormal];
    [self.phyButton setTitle:self.dataList[_dataModel.dataListIndex] forState:UIControlStateNormal];
    self.phyButton.hidden = !_dataModel.isOn;
    [self setNeedsLayout];
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

- (UIButton *)switchButton {
    if (!_switchButton) {
        _switchButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_switchButton setImage:LOADICON(@"MKLoRaWAN-BG", @"MKBGFilterByPHYCell", @"bg_switchUnselectedIcon.png") forState:UIControlStateNormal];
        [_switchButton addTarget:self
                          action:@selector(switchButtonPressed)
                forControlEvents:UIControlEventTouchUpInside];
    }
    return _switchButton;
}

- (UIButton *)phyButton {
    if (!_phyButton) {
        _phyButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_phyButton.titleLabel setFont:MKFont(13.f)];
        [_phyButton setTitleColor:COLOR_WHITE_MACROS forState:UIControlStateNormal];
        [_phyButton setBackgroundColor:NAVBAR_COLOR_MACROS];
        [_phyButton.layer setMasksToBounds:YES];
        [_phyButton.layer setCornerRadius:6.f];
        [_phyButton addTarget:self
                       action:@selector(phyButtonPressed)
             forControlEvents:UIControlEventTouchUpInside];
    }
    return _phyButton;
}

- (NSMutableArray *)dataList {
    if (!_dataList) {
        _dataList = [NSMutableArray array];
    }
    return _dataList;
}

@end
