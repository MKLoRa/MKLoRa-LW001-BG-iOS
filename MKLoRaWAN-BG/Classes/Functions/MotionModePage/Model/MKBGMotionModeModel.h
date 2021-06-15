//
//  MKBGMotionModeModel.h
//  MKLoRaWAN-BG_Example
//
//  Created by aa on 2021/5/24.
//  Copyright © 2021 aadyx2007@163.com. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MKBGSDKNormalDefines.h"

NS_ASSUME_NONNULL_BEGIN

@interface MKBGMotionModeEventsModel : NSObject<mk_bg_motionModeEventsProtocol>

@property (nonatomic, assign)BOOL fixOnStart;

@property (nonatomic, assign)BOOL fixInTrip;

@property (nonatomic, assign)BOOL fixOnEnd;

@property (nonatomic, assign)BOOL notifyEventOnStart;

@property (nonatomic, assign)BOOL notifyEventInTrip;

@property (nonatomic, assign)BOOL notifyEventOnEnd;

@end

@interface MKBGMotionModeModel : NSObject

@property (nonatomic, assign)BOOL fixOnStart;

@property (nonatomic, copy)NSString *numberOfFixOnStart;

/*
 0:Wifi
 1:BLE
 2:GPS
 3:GPS+Wifi
 4:GPS+BLE
 5:BLE+Wifi
 6:GPS+BLE+Wifi
 */
@property (nonatomic, assign)NSInteger posStrategyOnStart;

@property (nonatomic, assign)BOOL fixInTrip;

@property (nonatomic, copy)NSString *reportIntervalInTrip;

/*
 0:Wifi
 1:BLE
 2:GPS
 3:GPS+Wifi
 4:GPS+BLE
 5:BLE+Wifi
 6:GPS+BLE+Wifi
 */
@property (nonatomic, assign)NSInteger posStrategyInTrip;

@property (nonatomic, assign)BOOL fixOnEnd;

@property (nonatomic, copy)NSString *tripEndTimeout;

@property (nonatomic, copy)NSString *numberOfFixOnEnd;

@property (nonatomic, copy)NSString *reportIntervalOnEnd;

@property (nonatomic, assign)NSInteger posStrategyOnEnd;

@property (nonatomic, assign)BOOL notifyEventOnStart;

@property (nonatomic, assign)BOOL notifyEventInTrip;

@property (nonatomic, assign)BOOL notifyEventOnEnd;

- (void)readDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock;

- (void)configDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock;

- (void)configMotionModeEvents:(MKBGMotionModeEventsModel *)eventsModel
                      sucBlock:(void (^)(void))sucBlock
                   failedBlock:(void (^)(NSError *error))failedBlock;

@end

NS_ASSUME_NONNULL_END
