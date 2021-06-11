//
//  MKBGTimingModeModel.h
//  MKLoRaWAN-BG_Example
//
//  Created by aa on 2021/5/24.
//  Copyright © 2021 aadyx2007@163.com. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MKBGSDKNormalDefines.h"

NS_ASSUME_NONNULL_BEGIN

@interface MKBGTimingModeTimePointModel : NSObject<mk_bg_timingModeReportingTimePointProtocol>

/// 0~23
@property (nonatomic, assign)NSInteger hour;

/// 0:00   1:15   2:30   3:45
@property (nonatomic, assign)NSInteger minuteGear;

@end

@interface MKBGTimingModeModel : NSObject

/*
 0:Wifi
 1:BLE
 2:GPS
 3:GPS+Wifi
 4:GPS+BLE
 5:BLE+Wifi
 6:GPS+BLE+Wifi
 */
@property (nonatomic, assign)NSInteger strategy;

@property (nonatomic, strong)NSArray <MKBGTimingModeTimePointModel *>*pointList;

- (void)readDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock;

@end

NS_ASSUME_NONNULL_END
