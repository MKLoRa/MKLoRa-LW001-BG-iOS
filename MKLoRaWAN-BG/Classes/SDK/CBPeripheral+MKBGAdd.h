//
//  CBPeripheral+MKBGAdd.h
//  MKLoRaWAN-BG_Example
//
//  Created by aa on 2021/5/17.
//  Copyright © 2021 aadyx2007@163.com. All rights reserved.
//

#import <CoreBluetooth/CoreBluetooth.h>

NS_ASSUME_NONNULL_BEGIN

@interface CBPeripheral (MKBGAdd)

/// R
@property (nonatomic, strong, readonly)CBCharacteristic *bg_batteryPower;

/// R
@property (nonatomic, strong, readonly)CBCharacteristic *bg_manufacturer;

/// R
@property (nonatomic, strong, readonly)CBCharacteristic *bg_deviceModel;

@property (nonatomic, strong, readonly)CBCharacteristic *bg_hardware;

/// R
@property (nonatomic, strong, readonly)CBCharacteristic *bg_sofeware;

/// R
@property (nonatomic, strong, readonly)CBCharacteristic *bg_firmware;

#pragma mark - custom

/// W/N
@property (nonatomic, strong, readonly)CBCharacteristic *bg_password;

/// N
@property (nonatomic, strong, readonly)CBCharacteristic *bg_disconnectType;

/// W/N
@property (nonatomic, strong, readonly)CBCharacteristic *bg_custom;

/// N
@property (nonatomic, strong, readonly)CBCharacteristic *bg_storageData;

/// N  V1.0.7
@property (nonatomic, strong, readonly)CBCharacteristic *bg_logData;

- (void)bg_updateCharacterWithService:(CBService *)service;

- (void)bg_updateCurrentNotifySuccess:(CBCharacteristic *)characteristic;

- (BOOL)bg_connectSuccess;

- (void)bg_setNil;

@end

NS_ASSUME_NONNULL_END
