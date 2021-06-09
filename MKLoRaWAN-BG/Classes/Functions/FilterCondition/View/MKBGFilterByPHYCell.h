//
//  MKBGFilterByPHYCell.h
//  MKLoRaWAN-BG_Example
//
//  Created by aa on 2021/6/1.
//  Copyright © 2021 aadyx2007@163.com. All rights reserved.
//

#import <MKBaseModuleLibrary/MKBaseCell.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKBGFilterByPHYCellModel : NSObject

/// cell所在index
@property (nonatomic, assign)NSInteger index;

/// 左上角标签msg
@property (nonatomic, copy)NSString *msg;

/// 开关状态
@property (nonatomic, assign)BOOL isOn;

/// 底部按钮点击之后展示pickView的数据源
@property (nonatomic, strong)NSArray <NSString *>*dataList;

/// pickView选中的index
@property (nonatomic, assign)NSInteger dataListIndex;

@end

@protocol MKBGFilterByPHYCellDelegate <NSObject>

/// 开关发生改变
/// @param index cell的index
/// @param isOn isOn
- (void)bg_filterByPHYStatusChanged:(NSInteger)index isOn:(BOOL)isOn;

/// 底部按钮点击之后出现的pickView，选中数据之后点击了Confirm按钮事件
/// @param index cell的index
/// @param dataListIndex 点击按钮选中的dataList里面的index
/// @param value dataList[dataListIndex]
- (void)bg_filterByPHYTypeChanged:(NSInteger)index
                    dataListIndex:(NSInteger)dataListIndex
                            value:(NSString *)value;

@end

@interface MKBGFilterByPHYCell : MKBaseCell

@property (nonatomic, weak)id <MKBGFilterByPHYCellDelegate>delegate;

@property (nonatomic, strong)MKBGFilterByPHYCellModel *dataModel;

+ (MKBGFilterByPHYCell *)initCellWithTableView:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END
