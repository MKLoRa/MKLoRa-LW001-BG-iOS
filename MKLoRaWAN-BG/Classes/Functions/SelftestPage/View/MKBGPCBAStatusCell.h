//
//  MKBGPCBAStatusCell.h
//  MKLoRaWAN-PB_Example
//
//  Created by aa on 2021/5/25.
//  Copyright © 2021 aadyx2007@163.com. All rights reserved.
//

#import <MKBaseModuleLibrary/MKBaseCell.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKBGPCBAStatusCellModel : NSObject

@property (nonatomic, copy)NSString *value0;

@property (nonatomic, copy)NSString *value1;

@property (nonatomic, copy)NSString *value2;

@end

@interface MKBGPCBAStatusCell : MKBaseCell

@property (nonatomic, strong)MKBGPCBAStatusCellModel *dataModel;

+ (MKBGPCBAStatusCell *)initCellWithTableView:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END
