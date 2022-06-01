//
//  MKBGDebuggerCell.h
//  MKLoRaWAN-BG_Example
//
//  Created by aa on 2021/12/29.
//  Copyright © 2021 aadyx2007@163.com. All rights reserved.
//

#import <MKBaseModuleLibrary/MKBaseCell.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKBGDebuggerCellModel : NSObject

@property (nonatomic, assign)NSInteger index;

@property (nonatomic, copy)NSString *timeMsg;

@property (nonatomic, assign)BOOL selected;

@property (nonatomic, copy)NSString *logInfo;

@end

@protocol MKBGDebuggerCellDelegate <NSObject>

- (void)bg_debuggerCellSelectedChanged:(NSInteger)index selected:(BOOL)selected;

@end

@interface MKBGDebuggerCell : MKBaseCell

@property (nonatomic, strong)MKBGDebuggerCellModel *dataModel;

@property (nonatomic, weak)id <MKBGDebuggerCellDelegate>delegate;

+ (MKBGDebuggerCell *)initCellWithTableView:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END
