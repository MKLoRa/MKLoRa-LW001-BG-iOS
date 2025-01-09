//
//  MKBGCentralManager.h
//  MKLoRaWAN-BG_Example
//
//  Created by aa on 2021/5/17.
//  Copyright © 2021 aadyx2007@163.com. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <MKBaseBleModule/MKBLEBaseDataProtocol.h>

#import "MKBGOperationID.h"
#import "MKBGSDKNormalDefines.h"

NS_ASSUME_NONNULL_BEGIN

//Notification of device connection status changes.
extern NSString *const mk_bg_peripheralConnectStateChangedNotification;

//Notification of changes in the status of the Bluetooth Center.
extern NSString *const mk_bg_centralManagerStateChangedNotification;

/*
 After connecting the device, if no password is entered within one minute, it returns 0x01. After successful password change, it returns 0x02, the device has no data communication for three consecutive minutes, it returns 0x03, and the shutdown protocol is sent to make the device shut down and return 0x04.
 */
extern NSString *const mk_bg_deviceDisconnectTypeNotification;

@class CBCentralManager,CBPeripheral;

@interface MKBGCentralManager : NSObject<MKBLEBaseCentralManagerProtocol>

@property (nonatomic, weak)id <mk_bg_centralManagerScanDelegate>delegate;

@property (nonatomic, weak)id <mk_bg_storageDataDelegate>dataDelegate;

@property (nonatomic, weak)id <mk_bg_centralManagerLogDelegate>logDelegate;

/// Current connection status
@property (nonatomic, assign, readonly)mk_bg_centralConnectStatus connectStatus;

+ (MKBGCentralManager *)shared;

/// Destroy the MKLoRaTHCentralManager singleton and the MKBLEBaseCentralManager singleton. After the dfu upgrade, you need to destroy these two and then reinitialize.
+ (void)sharedDealloc;

/// Destroy the MKLoRaTHCentralManager singleton and remove the manager list of MKBLEBaseCentralManager.
+ (void)removeFromCentralList;

- (nonnull CBCentralManager *)centralManager;

/// Currently connected devices
- (nullable CBPeripheral *)peripheral;

/// Current Bluetooth center status
- (mk_bg_centralManagerStatus )centralStatus;

/// Bluetooth Center starts scanning.
/// - Parameter needCharging: YES: Need charging edition of V2.  NO:Without charging edition of V2.
- (void)startScan:(BOOL)needCharging;

/// Bluetooth center stops scanning
- (void)stopScan;

/// Connect device function
/// @param trackerModel Model
/// @param password Device connection password,8 characters long ascii code
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
- (void)connectPeripheral:(nonnull CBPeripheral *)peripheral
                 password:(nonnull NSString *)password
                 sucBlock:(void (^)(CBPeripheral *peripheral))sucBlock
              failedBlock:(void (^)(NSError *error))failedBlock;

- (void)disconnect;

/**
 Whether to monitor device storage data.

 @param notify BOOL
 @return result
 */
- (BOOL)notifyStorageData:(BOOL)notify;

/// Whether to open log data monitoring.
/// @param notify notify
- (BOOL)notifyLogData:(BOOL)notify;

/// Start a task for data communication with the device
/// @param operationID operation id
/// @param characteristic characteristic for communication
/// @param commandData Data to be sent to the device for this communication
/// @param successBlock Successful callback
/// @param failureBlock Failure callback
- (void)addTaskWithTaskID:(mk_bg_taskOperationID)operationID
           characteristic:(CBCharacteristic *)characteristic
              commandData:(NSString *)commandData
             successBlock:(void (^)(id returnData))successBlock
             failureBlock:(void (^)(NSError *error))failureBlock;

/// Start a task to read device characteristic data
/// @param operationID operation id
/// @param characteristic characteristic for communication
/// @param successBlock Successful callback
/// @param failureBlock Failure callback
- (void)addReadTaskWithTaskID:(mk_bg_taskOperationID)operationID
               characteristic:(CBCharacteristic *)characteristic
                 successBlock:(void (^)(id returnData))successBlock
                 failureBlock:(void (^)(NSError *error))failureBlock;

@end

NS_ASSUME_NONNULL_END
