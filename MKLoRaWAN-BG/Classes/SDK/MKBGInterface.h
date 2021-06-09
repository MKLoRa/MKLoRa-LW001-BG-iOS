//
//  MKBGInterface.h
//  MKLoRaWAN-BG_Example
//
//  Created by aa on 2021/5/17.
//  Copyright © 2021 aadyx2007@163.com. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, mk_bg_filterRulesType) {
    mk_bg_filterRulesClassAType,
    mk_bg_filterRulesClassBType,
};

@interface MKBGInterface : NSObject

#pragma mark ****************************************Device Service Information************************************************

/// Read the battery level of the device
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)bg_readBatteryPowerWithSucBlock:(void (^)(id returnData))sucBlock
                            failedBlock:(void (^)(NSError *error))failedBlock;

/// Read product model
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)bg_readDeviceModelWithSucBlock:(void (^)(id returnData))sucBlock
                           failedBlock:(void (^)(NSError *error))failedBlock;

/// Read device firmware information
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)bg_readFirmwareWithSucBlock:(void (^)(id returnData))sucBlock
                        failedBlock:(void (^)(NSError *error))failedBlock;

/// Read device hardware information
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)bg_readHardwareWithSucBlock:(void (^)(id returnData))sucBlock
                        failedBlock:(void (^)(NSError *error))failedBlock;

/// Read device software information
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)bg_readSoftwareWithSucBlock:(void (^)(id returnData))sucBlock
                        failedBlock:(void (^)(NSError *error))failedBlock;

/// Read device manufacturer information
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)bg_readManufacturerWithSucBlock:(void (^)(id returnData))sucBlock
                            failedBlock:(void (^)(NSError *error))failedBlock;

#pragma mark ****************************************设备系统应用信息读取************************************************

/// Read the current time zone to the device.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)bg_readTimeZoneWithSucBlock:(void (^)(id returnData))sucBlock
                        failedBlock:(void (^)(NSError *error))failedBlock;

/// Read the connection password of the device.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)bg_readPasswordWithSucBlock:(void (^)(id returnData))sucBlock
                        failedBlock:(void (^)(NSError *error))failedBlock;

/// Read the working mode of the device.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)bg_readWorkModeWithSucBlock:(void (^)(id returnData))sucBlock
                        failedBlock:(void (^)(NSError *error))failedBlock;

/// Read the heartbeat packet interval of the device.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)bg_readDeviceHeartbeatIntervalWithSucBlock:(void (^)(id returnData))sucBlock
                                       failedBlock:(void (^)(NSError *error))failedBlock;

/// Whether to enable positioning when the device fails to connect to the Lorawan network.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)bg_readOfflineFixStatusWithSucBlock:(void (^)(id returnData))sucBlock
                                failedBlock:(void (^)(NSError *error))failedBlock;

#pragma mark ****************************************定位参数************************************************

/// Read the WIFI positioning timeout.The current value multiplied by 2 is the actual time (unit: s).
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)bg_readWifiPositioningTimeoutWithSucBlock:(void (^)(id returnData))sucBlock
                                      failedBlock:(void (^)(NSError *error))failedBlock;

/// Read the number of BSSIDs with successful WIFI positioning.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)bg_readWifiNumberOfBSSIDWithSucBlock:(void (^)(id returnData))sucBlock
                                 failedBlock:(void (^)(NSError *error))failedBlock;

/// Read the BLE positioning timeout.(unit : s)
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)bg_readBLEPositioningTimeoutWithSucBlock:(void (^)(id returnData))sucBlock
                                     failedBlock:(void (^)(NSError *error))failedBlock;

/// Read the number of mac address with successful BLE positioning.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)bg_readBLENumberOfMacWithSucBlock:(void (^)(id returnData))sucBlock
                              failedBlock:(void (^)(NSError *error))failedBlock;

#pragma mark ****************************************蓝牙过滤规则************************************************

/// Read the logical relationship between the two sets of filtering rules, the two sets of rules can be OR and and.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)bg_readBLELogicalRelationshipWithSucBlock:(void (^)(id returnData))sucBlock
                                      failedBlock:(void (^)(NSError *error))failedBlock;

/// Read filter rule switch status.
/// @param type type
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)bg_readBLEFilterStatusWithType:(mk_bg_filterRulesType)type
                              sucBlock:(void (^)(id returnData))sucBlock
                           failedBlock:(void (^)(NSError *error))failedBlock;

/// Read the filtered device name.
/// @param type type
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)bg_readBLEFilterDeviceNameWithType:(mk_bg_filterRulesType)type
                                  sucBlock:(void (^)(id returnData))sucBlock
                               failedBlock:(void (^)(NSError *error))failedBlock;

/// Read the filtered device mac.
/// @param type type
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)bg_readBLEFilterDeviceMacWithType:(mk_bg_filterRulesType)type
                                 sucBlock:(void (^)(id returnData))sucBlock
                              failedBlock:(void (^)(NSError *error))failedBlock;

/// Read the filtered MAJOR range.
/// @param type type
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)bg_readBLEFilterDeviceMajorWithType:(mk_bg_filterRulesType)type
                                   sucBlock:(void (^)(id returnData))sucBlock
                                failedBlock:(void (^)(NSError *error))failedBlock;

/// Read the filtered MINOR range.
/// @param type type
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)bg_readBLEFilterDeviceMinorWithType:(mk_bg_filterRulesType)type
                                   sucBlock:(void (^)(id returnData))sucBlock
                                failedBlock:(void (^)(NSError *error))failedBlock;

/// Read filtered raw data.
/// @param type type
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)bg_readBLEFilterDeviceRawDataWithType:(mk_bg_filterRulesType)type
                                     sucBlock:(void (^)(id returnData))sucBlock
                                  failedBlock:(void (^)(NSError *error))failedBlock;

/// Read filtered UUID.
/// @param type type
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)bg_readBLEFilterDeviceUUIDWithType:(mk_bg_filterRulesType)type
                                  sucBlock:(void (^)(id returnData))sucBlock
                               failedBlock:(void (^)(NSError *error))failedBlock;

/// Read filtered RSSI.
/// @param type type
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)bg_readBLEFilterDeviceRSSIWithType:(mk_bg_filterRulesType)type
                                  sucBlock:(void (^)(id returnData))sucBlock
                               failedBlock:(void (^)(NSError *error))failedBlock;

/// Read Filter by PHY.
/// @param type type
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)bg_readBLEFilterByPHYWithType:(mk_bg_filterRulesType)type
                             sucBlock:(void (^)(id returnData))sucBlock
                          failedBlock:(void (^)(NSError *error))failedBlock;

#pragma mark ****************************************GPS定位参数************************************************

/// Read GPS cold start time.(Unit:Min)
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)bg_readGpsColdStardTimeWithSucBlock:(void (^)(id returnData))sucBlock
                                failedBlock:(void (^)(NSError *error))failedBlock;

/// Read GPS coarse positioning accuracy.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)bg_readGpsCoarseAccuracyMaskWithSucBlock:(void (^)(id returnData))sucBlock
                                     failedBlock:(void (^)(NSError *error))failedBlock;

/// Read GPS precise positioning accuracy.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)bg_readGpsFineAccuracyTargetWithSucBlock:(void (^)(id returnData))sucBlock
                                     failedBlock:(void (^)(NSError *error))failedBlock;

/// Read GPS coarse positioning timeout time.(Unit:s)
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)bg_readGpsCoarseTimeWithSucBlock:(void (^)(id returnData))sucBlock
                             failedBlock:(void (^)(NSError *error))failedBlock;

/// Read GPS precise positioning timeout time.(Unit:s)
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)bg_readGpsFineTimeWithSucBlock:(void (^)(id returnData))sucBlock
                           failedBlock:(void (^)(NSError *error))failedBlock;

/// Read GPS PDOP Limit.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)bg_readGpsPDOPLimitWithSucBlock:(void (^)(id returnData))sucBlock
                            failedBlock:(void (^)(NSError *error))failedBlock;

/// Read GPS Fix Mode.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)bg_readGpsFixModeWithSucBlock:(void (^)(id returnData))sucBlock
                          failedBlock:(void (^)(NSError *error))failedBlock;

/// Read GPS Mode.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)bg_readGpsModeWithSucBlock:(void (^)(id returnData))sucBlock
                       failedBlock:(void (^)(NSError *error))failedBlock;

/// Read GPS Time Budget.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)bg_readGpsTimeBudgetWithSucBlock:(void (^)(id returnData))sucBlock
                             failedBlock:(void (^)(NSError *error))failedBlock;

/// Read GPS Autonomous Aiding Switch Status.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)bg_readGpsAutonomousAidingStatusWithSucBlock:(void (^)(id returnData))sucBlock
                                         failedBlock:(void (^)(NSError *error))failedBlock;

/// Read GPS Ading Accuracy.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)bg_readGpsAdingAccuracyWithSucBlock:(void (^)(id returnData))sucBlock
                                failedBlock:(void (^)(NSError *error))failedBlock;

/// Read GPS Aiding Timeout.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)bg_readGpsAidingTimeWithSucBlock:(void (^)(id returnData))sucBlock
                             failedBlock:(void (^)(NSError *error))failedBlock;

/// Read GPS Extreme mode Switch Status.When Extrme Mode is on, the reported GPS data  will be shortened to achieve the maximum transmission distance.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)bg_readGpsExtremeModeStatusWithSucBlock:(void (^)(id returnData))sucBlock
                                    failedBlock:(void (^)(NSError *error))failedBlock;

#pragma mark ****************************************设备LoRa参数读取************************************************

/// Read the region information of LoRaWAN.
/*
 0:AS923 
 1:AU915
 2:CN470
 3:CN779
 4:EU433
 5:EU868
 6:KR920
 7:IN865
 8:US915
 9:RU864
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)bg_readLorawanRegionWithSucBlock:(void (^)(id returnData))sucBlock
                             failedBlock:(void (^)(NSError *error))failedBlock;

/// Read LoRaWAN network access type.
/*
 1:ABP
 2:OTAA
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)bg_readLorawanModemWithSucBlock:(void (^)(id returnData))sucBlock
                            failedBlock:(void (^)(NSError *error))failedBlock;

/// Read the current network status of LoRaWAN.
/*
    0:Connecting
    1:OTAA network access or ABP mode.
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)bg_readLorawanNetworkStatusWithSucBlock:(void (^)(id returnData))sucBlock
                                    failedBlock:(void (^)(NSError *error))failedBlock;

/// Read the DEVEUI of LoRaWAN.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)bg_readLorawanDEVEUIWithSucBlock:(void (^)(id returnData))sucBlock
                             failedBlock:(void (^)(NSError *error))failedBlock;

/// Read the APPEUI of LoRaWAN.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)bg_readLorawanAPPEUIWithSucBlock:(void (^)(id returnData))sucBlock
                             failedBlock:(void (^)(NSError *error))failedBlock;

/// Read the APPKEY of LoRaWAN.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)bg_readLorawanAPPKEYWithSucBlock:(void (^)(id returnData))sucBlock
                             failedBlock:(void (^)(NSError *error))failedBlock;

/// Read the DEVADDR of LoRaWAN.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)bg_readLorawanDEVADDRWithSucBlock:(void (^)(id returnData))sucBlock
                              failedBlock:(void (^)(NSError *error))failedBlock;

/// Read the APPSKEY of LoRaWAN.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)bg_readLorawanAPPSKEYWithSucBlock:(void (^)(id returnData))sucBlock
                              failedBlock:(void (^)(NSError *error))failedBlock;

/// Read the NWKSKEY of LoRaWAN.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)bg_readLorawanNWKSKEYWithSucBlock:(void (^)(id returnData))sucBlock
                              failedBlock:(void (^)(NSError *error))failedBlock;

/// Read lorawan upstream data type.
/*
 0:Non-acknowledgement frame.
 1:Confirm the frame.
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)bg_readLorawanMessageTypeWithSucBlock:(void (^)(id returnData))sucBlock
                                  failedBlock:(void (^)(NSError *error))failedBlock;

/// Read lorawan CH.
/*
 @{
 @"CHL":0
 @"CHH":2
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)bg_readLorawanCHWithSucBlock:(void (^)(id returnData))sucBlock
                         failedBlock:(void (^)(NSError *error))failedBlock;

/// Read lorawan DR.
/*
 @{
 @"DR":1
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)bg_readLorawanDRWithSucBlock:(void (^)(id returnData))sucBlock
                         failedBlock:(void (^)(NSError *error))failedBlock;

/// Read LoRaWAN uplink data sending strategy.
/*
    @{
 @"isOn":@(YES),
 @"transmissions":@"2",
 @"DRL":@"1",
 @"DRH":@"2",
 }
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)bg_readLorawanUplinkStrategyWithSucBlock:(void (^)(id returnData))sucBlock
                                     failedBlock:(void (^)(NSError *error))failedBlock;

/// Read lorawan duty cycle status.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)bg_readLorawanDutyCycleStatusWithSucBlock:(void (^)(id returnData))sucBlock
                                      failedBlock:(void (^)(NSError *error))failedBlock;

/// Read lorawan devtime command synchronization interval.(Hour)
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)bg_readLorawanTimeSyncIntervalWithSucBlock:(void (^)(id returnData))sucBlock
                                       failedBlock:(void (^)(NSError *error))failedBlock;

/// Read LoRaWAN timing reconnection Interval.(Day)
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)bg_readLorawanReconnectIntervalWithSucBlock:(void (^)(id returnData))sucBlock
                                        failedBlock:(void (^)(NSError *error))failedBlock;

@end

NS_ASSUME_NONNULL_END
