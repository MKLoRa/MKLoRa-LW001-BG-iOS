//
//  MKBGScanPageCell.h
//  MKLoRaWAN-BG_Example
//
//  Created by aa on 2021/5/20.
//  Copyright © 2021 aadyx2007@163.com. All rights reserved.
//

#import <MKBaseModuleLibrary/MKBaseCell.h>

NS_ASSUME_NONNULL_BEGIN

@protocol MKBGScanPageCellDelegate <NSObject>

/// 连接按钮点击事件
/// @param index 当前cell的row
- (void)bg_scanCellConnectButtonPressed:(NSInteger)index;

@end

@class MKBGScanPageModel;
@interface MKBGScanPageCell : MKBaseCell

@property (nonatomic, strong)MKBGScanPageModel *dataModel;

@property (nonatomic, weak)id <MKBGScanPageCellDelegate>delegate;

+ (MKBGScanPageCell *)initCellWithTableView:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END
