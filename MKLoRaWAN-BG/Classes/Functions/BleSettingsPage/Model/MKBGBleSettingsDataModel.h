//
//  MKBGBleSettingsDataModel.h
//  MKLoRaWAN-BG_Example
//
//  Created by aa on 2021/5/26.
//  Copyright © 2021 aadyx2007@163.com. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKBGBleSettingsDataModel : NSObject

@property (nonatomic, assign)BOOL beaconModeIsOn;

@property (nonatomic, assign)BOOL connectable;

@property (nonatomic, copy)NSString *advInterval;

@property (nonatomic, copy)NSString *broadcastTimeout;

- (void)readWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock;

- (void)configDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock;

@end

NS_ASSUME_NONNULL_END
