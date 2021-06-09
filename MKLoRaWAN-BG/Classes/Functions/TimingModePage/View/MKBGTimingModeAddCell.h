//
//  MKBGTimingModeAddCell.h
//  MKLoRaWAN-BG_Example
//
//  Created by aa on 2021/5/25.
//  Copyright © 2021 aadyx2007@163.com. All rights reserved.
//

#import <MKBaseModuleLibrary/MKBaseCell.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKBGTimingModeAddCellModel : NSObject

@property (nonatomic, copy)NSString *msg;

@end

@protocol MKBGTimingModeAddCellDelegate <NSObject>

- (void)bg_addButtonPressed;

@end

@interface MKBGTimingModeAddCell : MKBaseCell

@property (nonatomic, strong)MKBGTimingModeAddCellModel *dataModel;

@property (nonatomic, weak)id <MKBGTimingModeAddCellDelegate>delegate;

+ (MKBGTimingModeAddCell *)initCellWithTableView:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END
