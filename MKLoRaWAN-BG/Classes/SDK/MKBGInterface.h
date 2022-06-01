//
//  MKBGInterface.h
//  MKLoRaWAN-BG_Example
//
//  Created by aa on 2021/5/17.
//  Copyright © 2021 aadyx2007@163.com. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MKBGSDKNormalDefines.h"

NS_ASSUME_NONNULL_BEGIN

@interface MKBGInterface : NSObject

#pragma mark ****************************************Device Service Information************************************************

/// Read the battery level of the device.(%)
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
/*
 @{
 @"mode":@"2"
 }
 
 0：Off mode
 1：Standby mode
 2：Periodic mode
 3：Timing mode
 4：Motion Mode
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)bg_readWorkModeWithSucBlock:(void (^)(id returnData))sucBlock
                        failedBlock:(void (^)(NSError *error))failedBlock;

/// Default Operating mode after the device is repowered.
/*
 @{
 @"mode":@"1"
 }
 0: Off mode
 1:Revert to last mode
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)bg_readRepoweredDefaultModeWithSucBlock:(void (^)(id returnData))sucBlock
                                    failedBlock:(void (^)(NSError *error))failedBlock;

/// Read the heartbeat packet interval of the device.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)bg_readDeviceHeartbeatIntervalWithSucBlock:(void (^)(id returnData))sucBlock
                                       failedBlock:(void (^)(NSError *error))failedBlock;

/// Read Off By Magnet Status.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)bg_readOffByMagnetStatusWithSucBlock:(void (^)(id returnData))sucBlock
                                 failedBlock:(void (^)(NSError *error))failedBlock;

/// Read Shutdown Payload Status.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)bg_readShutdownPayloadStatusWithSucBlock:(void (^)(id returnData))sucBlock
                                     failedBlock:(void (^)(NSError *error))failedBlock;

/// Whether to enable positioning when the device fails to connect to the Lorawan network.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)bg_readOfflineFixStatusWithSucBlock:(void (^)(id returnData))sucBlock
                                failedBlock:(void (^)(NSError *error))failedBlock;

/// Read low battery related parameters.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)bg_readLowPowerParamsWithSucBlock:(void (^)(id returnData))sucBlock
                              failedBlock:(void (^)(NSError *error))failedBlock;

/// Read Indicator Settings.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)bg_readIndicatorSettingsWithSucBlock:(void (^)(id returnData))sucBlock
                                 failedBlock:(void (^)(NSError *error))failedBlock;

/// Read the current temperature of the chip.(Unit:℃)
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)bg_readTemperatureOfChipWithSucBlock:(void (^)(id returnData))sucBlock
                                 failedBlock:(void (^)(NSError *error))failedBlock;

/// Read the current system time zone time.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)bg_readCurrentSystemTimeZoneTimeWithSucBlock:(void (^)(id returnData))sucBlock
                                         failedBlock:(void (^)(NSError *error))failedBlock;

/// Read battery level.(Unit:mV)
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)bg_readBatteryLevelWithSucBlock:(void (^)(id returnData))sucBlock
                            failedBlock:(void (^)(NSError *error))failedBlock;

/// Read the mac address of the device.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)bg_readMacAddressWithSucBlock:(void (^)(id returnData))sucBlock
                          failedBlock:(void (^)(NSError *error))failedBlock;

/// Read the PCBA Status of the device.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)bg_readPCBAStatusWithSucBlock:(void (^)(id returnData))sucBlock
                          failedBlock:(void (^)(NSError *error))failedBlock;

/// Read the Selftest Status of the device.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)bg_readSelftestStatusWithSucBlock:(void (^)(id returnData))sucBlock
                              failedBlock:(void (^)(NSError *error))failedBlock;

/// ON/Off Method.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)bg_readOnOffMethodWithSucBlock:(void (^)(id returnData))sucBlock
                           failedBlock:(void (^)(NSError *error))failedBlock;

#pragma mark ****************************************模式相关参数************************************************

/// Read Periodic Mode positioning strategy.
/*
 @{
 @"strategy":@(1)
 }
 
 1:Wifi
 2:BLE
 3:BLE+Wifi
 4:GPS
 5:GPS+Wifi
 6:GPS+BLE
 7:GPS+BLE+Wifi
 
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)bg_readPeriodicModePositioningStrategyWithSucBlock:(void (^)(id returnData))sucBlock
                                               failedBlock:(void (^)(NSError *error))failedBlock;

/// Read Periodic Mode reporting interval.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)bg_readPeriodicModeReportIntervalWithSucBlock:(void (^)(id returnData))sucBlock
                                          failedBlock:(void (^)(NSError *error))failedBlock;

/// Read Timing Mode positioning strategy.
/*
 @{
 @"strategy":@(1)
 }
 
 1:Wifi
 2:BLE
 3:BLE+Wifi
 4:GPS
 5:GPS+Wifi
 6:GPS+BLE
 7:GPS+BLE+Wifi
 
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)bg_readTimingModePositioningStrategyWithSucBlock:(void (^)(id returnData))sucBlock
                                             failedBlock:(void (^)(NSError *error))failedBlock;

/// Read Timing Mode Reporting Time Point.
/*
 @[@{
 @"hour":@(0),
 @"minuteGear":@(0)
 },
 @{
 @"hour":@(0),
 @"minuteGear":@(1)
 }]
 
 hour:0~23,
 minuteGear:  0:00, 1:15, 2:30, 3:45
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)bg_readTimingModeReportingTimePointWithSucBlock:(void (^)(id returnData))sucBlock
                                            failedBlock:(void (^)(NSError * error))failedBlock;

/// Read Motion Mode Events.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)bg_readMotionModeEventsWithSucBlock:(void (^)(id returnData))sucBlock
                                failedBlock:(void (^)(NSError * error))failedBlock;

/// Read Motion Mode Number Of Fix On Start.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)bg_readMotionModeNumberOfFixOnStartWithSucBlock:(void (^)(id returnData))sucBlock
                                            failedBlock:(void (^)(NSError * error))failedBlock;

/// Read Motion Mode Pos-Strategy On Start.
/*
 @{
 @"strategy":@(1)
 }
 
 1:Wifi
 2:BLE
 3:BLE+Wifi
 4:GPS
 5:GPS+Wifi
 6:GPS+BLE
 7:GPS+BLE+Wifi
 
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)bg_readMotionModePosStrategyOnStartWithSucBlock:(void (^)(id returnData))sucBlock
                                            failedBlock:(void (^)(NSError * error))failedBlock;

/// Read Motion Mode Report Interval In Trip.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)bg_readMotionModeReportIntervalInTripWithSucBlock:(void (^)(id returnData))sucBlock
                                              failedBlock:(void (^)(NSError * error))failedBlock;

/// Read Motion Mode Pos-Strategy In Trip.
/*
 @{
 @"strategy":@(1)
 }
 
 1:Wifi
 2:BLE
 3:BLE+Wifi
 4:GPS
 5:GPS+Wifi
 6:GPS+BLE
 7:GPS+BLE+Wifi
 
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)bg_readMotionModePosStrategyInTripWithSucBlock:(void (^)(id returnData))sucBlock
                                           failedBlock:(void (^)(NSError * error))failedBlock;

/// Read Motion Mode Trip End Timeout.(Unit:10s)
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)bg_readMotionModeTripEndTimeoutWithSucBlock:(void (^)(id returnData))sucBlock
                                        failedBlock:(void (^)(NSError * error))failedBlock;

/// Read Motion Mode Number Of Fix On End.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)bg_readMotionModeNumberOfFixOnEndWithSucBlock:(void (^)(id returnData))sucBlock
                                          failedBlock:(void (^)(NSError * error))failedBlock;

/// Read Motion Mode Report Interval On End.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)bg_readMotionModeReportIntervalOnEndWithSucBlock:(void (^)(id returnData))sucBlock
                                             failedBlock:(void (^)(NSError * error))failedBlock;

/// Read Motion Mode Pos-Strategy On End.
/*
 @{
 @"strategy":@(1)
 }
 
 1:Wifi
 2:BLE
 3:BLE+Wifi
 4:GPS
 5:GPS+Wifi
 6:GPS+BLE
 7:GPS+BLE+Wifi
 
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)bg_readMotionModePosStrategyOnEndWithSucBlock:(void (^)(id returnData))sucBlock
                                          failedBlock:(void (^)(NSError * error))failedBlock;

/// Read Downlink  For Position Pos-Strategy.
/*
 @{
 @"strategy":@(1)
 }
 
 1:Wifi
 2:BLE
 3:BLE+Wifi
 4:GPS
 5:GPS+Wifi
 6:GPS+BLE
 7:GPS+BLE+Wifi
 
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)bg_readDownlinkForPositioningStrategyWithSucBlock:(void (^)(id returnData))sucBlock
                                              failedBlock:(void (^)(NSError * error))failedBlock;

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

#pragma mark ****************************************蓝牙参数读取************************************************

/// Read whether the device has the Beacon broadcast function turned on.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)bg_readBeaconModeStatusWithSucBlock:(void (^)(id returnData))sucBlock
                                failedBlock:(void (^)(NSError *error))failedBlock;

/// Read beacon broadcast time interval.(Unit:100ms)
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)bg_readBeaconAdvIntervalWithSucBlock:(void (^)(id returnData))sucBlock
                                 failedBlock:(void (^)(NSError *error))failedBlock;

/// Read the Bluetooth connection status of the device.When the device is set to be unconnectable, 3min is allowed to connect after the beacon mode is turned on.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)bg_readDeviceConnectableWithSucBlock:(void (^)(id returnData))sucBlock
                                 failedBlock:(void (^)(NSError *error))failedBlock;

/// Read the broadcast timeout time in Bluetooth configuration mode.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)bg_readDeviceBroadcastTimeoutWithSucBlock:(void (^)(id returnData))sucBlock
                                      failedBlock:(void (^)(NSError *error))failedBlock;

/// Read the UUID of iBeacon.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)bg_readBeaconProximityUUIDWithSucBlock:(void (^)(id returnData))sucBlock
                                   failedBlock:(void (^)(NSError *error))failedBlock;

/// Read the major of iBeacon.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)bg_readBeaconMajorWithSucBlock:(void (^)(id returnData))sucBlock
                           failedBlock:(void (^)(NSError *error))failedBlock;

/// Read the minor of iBeacon.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)bg_readBeaconMinorWithSucBlock:(void (^)(id returnData))sucBlock
                           failedBlock:(void (^)(NSError *error))failedBlock;

/// Read the measured power(RSSI@1M) of device.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)bg_readMeasuredPowerWithSucBlock:(void (^)(id returnData))sucBlock
                             failedBlock:(void (^)(NSError *error))failedBlock;

/// Read the txPower of device.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)bg_readTxPowerWithSucBlock:(void (^)(id returnData))sucBlock
                       failedBlock:(void (^)(NSError *error))failedBlock;

/// Read the broadcast name of the device.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)bg_readDeviceNameWithSucBlock:(void (^)(id returnData))sucBlock
                          failedBlock:(void (^)(NSError *error))failedBlock;

/// Read the Scanning Type/PHY.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)bg_readScanningPHYTypeWithSucBlock:(void (^)(id returnData))sucBlock
                               failedBlock:(void (^)(NSError *error))failedBlock;

#pragma mark ****************************************辅助功能参数读取************************************************

/// Read three-axis sensor wake-up conditions.
/*
 @{
     @"threshold":threshold,        //x 16mg
     @"duration":duration,          //x 10ms
 };
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)bg_readThreeAxisWakeupConditionsWithSucBlock:(void (^)(id returnData))sucBlock
                                         failedBlock:(void (^)(NSError *error))failedBlock;

/// Read three-axis data motion detection judgment parameters.
/*
 @{
     @"threshold":threshold,        //x 2mg
     @"duration":duration,          //x 5ms
 };
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)bg_readThreeAxisMotionParametersWithSucBlock:(void (^)(id returnData))sucBlock
                                         failedBlock:(void (^)(NSError *error))failedBlock;

/// Read the state of the vibration detection switch.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)bg_readVibrationDetectionStatusWithSucBlock:(void (^)(id returnData))sucBlock
                                        failedBlock:(void (^)(NSError *error))failedBlock;

/// Read the vibration detection threshold.
/*
 @{
     @"threshold":threshold,        //x 10mg
 };
 */
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)bg_readVibrationThresholdsWithSucBlock:(void (^)(id returnData))sucBlock
                                   failedBlock:(void (^)(NSError *error))failedBlock;

/// Read the report interval of the vibration detection.(Unit:s)
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)bg_readVibrationDetectionReportIntervalWithSucBlock:(void (^)(id returnData))sucBlock
                                                failedBlock:(void (^)(NSError *error))failedBlock;

/// Read Vibration Timeout.(Unit:s)
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)bg_readVibrationTimeoutWithSucBlock:(void (^)(id returnData))sucBlock
                                failedBlock:(void (^)(NSError *error))failedBlock;

/// Read  Man Down Detection.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)bg_readManDownDetectionWithSucBlock:(void (^)(id returnData))sucBlock
                                failedBlock:(void (^)(NSError *error))failedBlock;

/// Read Idle Detection Timeout.(Unit:h)
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)bg_readIdleDetectionTimeoutWithSucBlock:(void (^)(id returnData))sucBlock
                                    failedBlock:(void (^)(NSError *error))failedBlock;

/// Read the alarm switch status to prevent the device from being disassembled.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)bg_readTamperAlarmStatusWithSucBlock:(void (^)(id returnData))sucBlock
                                 failedBlock:(void (^)(NSError *error))failedBlock;

/// Read Active State Count.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)bg_readActiveStateCountStatusWithSucBlock:(void (^)(id returnData))sucBlock
                                      failedBlock:(void (^)(NSError *error))failedBlock;

/// Read Active State Timeout.(Unit:s)
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)bg_readActiveStateTimeoutWithSucBlock:(void (^)(id returnData))sucBlock
                                  failedBlock:(void (^)(NSError *error))failedBlock;

@end

NS_ASSUME_NONNULL_END
