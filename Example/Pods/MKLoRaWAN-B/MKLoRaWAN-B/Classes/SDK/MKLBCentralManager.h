//
//  MKLBCentralManager.h
//  MKLoRaWAN-B_Example
//
//  Created by aa on 2020/12/31.
//  Copyright © 2020 aadyx2007@163.com. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <MKBaseBleModule/MKBLEBaseDataProtocol.h>

#import "MKLBOperationID.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, mk_lb_centralConnectStatus) {
    mk_lb_centralConnectStatusUnknow,                                           //未知状态
    mk_lb_centralConnectStatusConnecting,                                       //正在连接
    mk_lb_centralConnectStatusConnected,                                        //连接成功
    mk_lb_centralConnectStatusConnectedFailed,                                  //连接失败
    mk_lb_centralConnectStatusDisconnect,
};

typedef NS_ENUM(NSInteger, mk_lb_centralManagerStatus) {
    mk_lb_centralManagerStatusUnable,                           //不可用
    mk_lb_centralManagerStatusEnable,                           //可用状态
};

//Notification of device connection status changes.
extern NSString *const mk_lb_peripheralConnectStateChangedNotification;

//Notification of changes in the status of the Bluetooth Center.
extern NSString *const mk_lb_centralManagerStateChangedNotification;

//Notification of receive scanner tracked data.
extern NSString *const mk_lb_receiveStorageDataNotification;

/*
 After connecting the device, if no password is entered within one minute, it returns 0x01. After successful password change, it returns 0x02, the device has no data communication for two consecutive minutes, it returns 0x03, and the shutdown protocol is sent to make the device shut down and return 0x04.
 */
extern NSString *const mk_lb_deviceDisconnectTypeNotification;

@class CBCentralManager,CBPeripheral;
@protocol mk_lb_centralManagerScanDelegate <NSObject>

/// Scan to new device.
/// @param trackerModel device
- (void)mk_lb_receiveDevice:(NSDictionary *)deviceModel;

@optional

/// Starts scanning equipment.
- (void)mk_lb_startScan;

/// Stops scanning equipment.
- (void)mk_lb_stopScan;

@end

@interface MKLBCentralManager : NSObject<MKBLEBaseCentralManagerProtocol>

@property (nonatomic, weak)id <mk_lb_centralManagerScanDelegate>delegate;

/// Current connection status
@property (nonatomic, assign, readonly)mk_lb_centralConnectStatus connectStatus;

+ (MKLBCentralManager *)shared;

/// Destroy the MKLoRaTHCentralManager singleton and the MKBLEBaseCentralManager singleton. After the dfu upgrade, you need to destroy these two and then reinitialize.
+ (void)sharedDealloc;

/// Destroy the MKLoRaTHCentralManager singleton and remove the manager list of MKBLEBaseCentralManager.
+ (void)removeFromCentralList;

- (nonnull CBCentralManager *)centralManager;

/// Currently connected devices
- (nullable CBPeripheral *)peripheral;

/// Current Bluetooth center status
- (mk_lb_centralManagerStatus )centralStatus;

/// Bluetooth Center starts scanning
- (void)startScan;

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
- (BOOL)notifyStorageDataData:(BOOL)notify;

/// Start a task for data communication with the device
/// @param operationID operation id
/// @param characteristic characteristic for communication
/// @param commandData Data to be sent to the device for this communication
/// @param successBlock Successful callback
/// @param failureBlock Failure callback
- (void)addTaskWithTaskID:(mk_lb_taskOperationID)operationID
           characteristic:(CBCharacteristic *)characteristic
              commandData:(NSString *)commandData
             successBlock:(void (^)(id returnData))successBlock
             failureBlock:(void (^)(NSError *error))failureBlock;

/// Start a task to read device characteristic data
/// @param operationID operation id
/// @param characteristic characteristic for communication
/// @param successBlock Successful callback
/// @param failureBlock Failure callback
- (void)addReadTaskWithTaskID:(mk_lb_taskOperationID)operationID
               characteristic:(CBCharacteristic *)characteristic
                 successBlock:(void (^)(id returnData))successBlock
                 failureBlock:(void (^)(NSError *error))failureBlock;

@end

NS_ASSUME_NONNULL_END
