//
//  MKBGLoRaSettingAccountCell.h
//  MKLoRaWAN-BG_Example
//
//  Created by aa on 2025/3/3.
//  Copyright © 2025 aadyx2007@163.com. All rights reserved.
//

#import <MKBaseModuleLibrary/MKBaseCell.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKBGLoRaSettingAccountCellModel : NSObject

@property (nonatomic, copy)NSString *account;

@end

@protocol MKBGLoRaSettingAccountCellDelegate <NSObject>

- (void)bg_loRaSettingAccountCell_logoutBtnPressed;

@end

@interface MKBGLoRaSettingAccountCell : MKBaseCell

@property (nonatomic, strong)MKBGLoRaSettingAccountCellModel *dataModel;

@property (nonatomic, weak)id <MKBGLoRaSettingAccountCellDelegate>delegate;

+ (MKBGLoRaSettingAccountCell *)initCellWithTableView:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END
