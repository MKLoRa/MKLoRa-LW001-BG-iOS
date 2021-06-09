//
//  MKBGNormalAdopter.h
//  MKLoRaWAN-BG_Example
//
//  Created by aa on 2021/5/24.
//  Copyright © 2021 aadyx2007@163.com. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <MKCustomUIModule/MKTableSectionLineHeader.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKBGNormalAdopter : NSObject

/// 返回若干个MKTableSectionLineHeaderModel数组，用来tableView显示的sectionHeader线条
/// @param number 个数
+ (NSMutableArray <MKTableSectionLineHeaderModel *>*)loadSectionHeaderListWithNumber:(NSInteger)number;

@end

NS_ASSUME_NONNULL_END
