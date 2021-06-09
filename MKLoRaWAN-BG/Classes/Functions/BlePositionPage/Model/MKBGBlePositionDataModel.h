//
//  MKBGBlePositionDataModel.h
//  MKLoRaWAN-BG_Example
//
//  Created by aa on 2021/5/21.
//  Copyright © 2021 aadyx2007@163.com. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKBGBlePositionDataModel : NSObject

/// Positioning Timeout,1s~10s
@property (nonatomic, copy)NSString *interval;

/// Number Of MAC,1~5
@property (nonatomic, copy)NSString *numberOfMac;

@property (nonatomic, assign)BOOL conditionAIsOn;

@property (nonatomic, assign)BOOL conditionBIsOn;

/// 两组规则关系，YES:OR ,NO:AND
@property (nonatomic, assign)BOOL ABIsOr;

- (void)readWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock;

- (void)configWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock;

@end

NS_ASSUME_NONNULL_END
