//
//  MKBGInterface.m
//  MKLoRaWAN-BG_Example
//
//  Created by aa on 2021/5/17.
//  Copyright © 2021 aadyx2007@163.com. All rights reserved.
//

#import "MKBGInterface.h"

#import "MKBGCentralManager.h"
#import "MKBGOperationID.h"
#import "MKBGOperation.h"
#import "CBPeripheral+MKBGAdd.h"

#define centralManager [MKBGCentralManager shared]
#define peripheral ([MKBGCentralManager shared].peripheral)

@implementation MKBGInterface

#pragma mark ****************************************Device Service Information************************************************

+ (void)bg_readBatteryPowerWithSucBlock:(void (^)(id returnData))sucBlock
                            failedBlock:(void (^)(NSError *error))failedBlock {
    [centralManager addReadTaskWithTaskID:mk_bg_taskReadBatteryPowerOperation
                           characteristic:peripheral.bg_batteryPower
                             successBlock:sucBlock
                             failureBlock:failedBlock];
}

+ (void)bg_readDeviceModelWithSucBlock:(void (^)(id returnData))sucBlock
                           failedBlock:(void (^)(NSError *error))failedBlock {
    [centralManager addReadTaskWithTaskID:mk_bg_taskReadDeviceModelOperation
                           characteristic:peripheral.bg_deviceModel
                             successBlock:sucBlock
                             failureBlock:failedBlock];
}

+ (void)bg_readFirmwareWithSucBlock:(void (^)(id returnData))sucBlock
                        failedBlock:(void (^)(NSError *error))failedBlock {
    [centralManager addReadTaskWithTaskID:mk_bg_taskReadFirmwareOperation
                           characteristic:peripheral.bg_firmware
                             successBlock:sucBlock
                             failureBlock:failedBlock];
}

+ (void)bg_readHardwareWithSucBlock:(void (^)(id returnData))sucBlock
                        failedBlock:(void (^)(NSError *error))failedBlock {
    [centralManager addReadTaskWithTaskID:mk_bg_taskReadHardwareOperation
                           characteristic:peripheral.bg_hardware
                             successBlock:sucBlock
                             failureBlock:failedBlock];
}

+ (void)bg_readSoftwareWithSucBlock:(void (^)(id returnData))sucBlock
                        failedBlock:(void (^)(NSError *error))failedBlock {
    [centralManager addReadTaskWithTaskID:mk_bg_taskReadSoftwareOperation
                           characteristic:peripheral.bg_sofeware
                             successBlock:sucBlock
                             failureBlock:failedBlock];
}

+ (void)bg_readManufacturerWithSucBlock:(void (^)(id returnData))sucBlock
                            failedBlock:(void (^)(NSError *error))failedBlock {
    [centralManager addReadTaskWithTaskID:mk_bg_taskReadManufacturerOperation
                           characteristic:peripheral.bg_manufacturer
                             successBlock:sucBlock
                             failureBlock:failedBlock];
}

#pragma mark ****************************************设备系统应用信息读取************************************************

+ (void)bg_readTimeZoneWithSucBlock:(void (^)(id returnData))sucBlock
                        failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_bg_taskReadTimeZoneOperation
                     cmdFlag:@"04"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)bg_readPasswordWithSucBlock:(void (^)(id returnData))sucBlock
                        failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_bg_taskReadPasswordOperation
                     cmdFlag:@"05"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)bg_readWorkModeWithSucBlock:(void (^)(id returnData))sucBlock
                        failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_bg_taskReadWorkModeOperation
                     cmdFlag:@"06"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)bg_readRepoweredDefaultModeWithSucBlock:(void (^)(id returnData))sucBlock
                                    failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_bg_taskReadRepoweredDefaultModeOperation
                     cmdFlag:@"07"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)bg_readDeviceHeartbeatIntervalWithSucBlock:(void (^)(id returnData))sucBlock
                                       failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_bg_taskReadDeviceHeartbeatIntervalOperation
                     cmdFlag:@"08"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)bg_readOffByMagnetStatusWithSucBlock:(void (^)(id returnData))sucBlock
                                 failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_bg_taskReadOffByMagnetStatusOperation
                     cmdFlag:@"09"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)bg_readShutdownPayloadStatusWithSucBlock:(void (^)(id returnData))sucBlock
                                     failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_bg_taskReadShutdownPayloadStatusOperation
                     cmdFlag:@"0a"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)bg_readOfflineFixStatusWithSucBlock:(void (^)(id returnData))sucBlock
                                failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_bg_taskReadOfflineFixStatusOperation
                     cmdFlag:@"0b"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)bg_readLowPowerParamsWithSucBlock:(void (^)(id returnData))sucBlock
                              failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_bg_taskReadLowPowerParamsOperation
                     cmdFlag:@"0c"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)bg_readIndicatorSettingsWithSucBlock:(void (^)(id returnData))sucBlock
                                 failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_bg_taskReadIndicatorSettingsOperation
                     cmdFlag:@"0d"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)bg_readTemperatureOfChipWithSucBlock:(void (^)(id returnData))sucBlock
                                 failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_bg_taskReadTemperatureOfChipOperation
                     cmdFlag:@"0e"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)bg_readCurrentSystemTimeZoneTimeWithSucBlock:(void (^)(id returnData))sucBlock
                                         failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_bg_taskReadCurrentSystemTimeZoneTimeOperation
                     cmdFlag:@"0f"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)bg_readBatteryLevelWithSucBlock:(void (^)(id returnData))sucBlock
                            failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_bg_taskReadBatteryLevelOperation
                     cmdFlag:@"11"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)bg_readMacAddressWithSucBlock:(void (^)(id returnData))sucBlock
                          failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_bg_taskReadMacAddressOperation
                     cmdFlag:@"12"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)bg_readPCBAStatusWithSucBlock:(void (^)(id returnData))sucBlock
                          failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_bg_taskReadPCBAStatusOperation
                     cmdFlag:@"13"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)bg_readSelftestStatusWithSucBlock:(void (^)(id returnData))sucBlock
                              failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_bg_taskReadSelftestStatusOperation
                     cmdFlag:@"14"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)bg_readOnOffMethodWithSucBlock:(void (^)(id returnData))sucBlock
                           failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_bg_taskReadOnOffMethodOperation
                     cmdFlag:@"15"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)bg_readBatteryInformationWithSucBlock:(void (^)(id returnData))sucBlock
                                  failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_bg_taskReadBatteryInformationOperation
                     cmdFlag:@"17"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)bg_readLastCycleBatteryInformationWithSucBlock:(void (^)(id returnData))sucBlock
                                           failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_bg_taskReadLastCycleBatteryInformationOperation
                     cmdFlag:@"18"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)bg_readAllCycleBatteryInformationWithSucBlock:(void (^)(id returnData))sucBlock
                                          failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_bg_taskReadAllCycleBatteryInformationOperation
                     cmdFlag:@"19"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)bg_readLowPowerPayloadStatusWithSucBlock:(void (^)(id returnData))sucBlock
                                     failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_bg_taskReadLowPowerPayloadStatusOperation
                     cmdFlag:@"1a"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)bg_readLowPowerPromptWithSucBlock:(void (^)(id returnData))sucBlock
                              failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_bg_taskReadLowPowerPromptOperation
                     cmdFlag:@"1b"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)bg_readAutoPowerOnAfterChargingWithSucBlock:(void (^)(id returnData))sucBlock
                                        failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_bg_taskReadAutoPowerOnAfterChargingOperation
                     cmdFlag:@"1d"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

#pragma mark ****************************************模式相关参数************************************************

+ (void)bg_readPeriodicModePositioningStrategyWithSucBlock:(void (^)(id returnData))sucBlock
                                               failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_bg_taskReadPeriodicModePositioningStrategyOperation
                     cmdFlag:@"20"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)bg_readPeriodicModeReportIntervalWithSucBlock:(void (^)(id returnData))sucBlock
                                          failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_bg_taskReadPeriodicModeReportIntervalOperation
                     cmdFlag:@"21"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)bg_readTimingModePositioningStrategyWithSucBlock:(void (^)(id returnData))sucBlock
                                             failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_bg_taskReadTimingModePositioningStrategyOperation
                     cmdFlag:@"22"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)bg_readTimingModeReportingTimePointWithSucBlock:(void (^)(id returnData))sucBlock
                                            failedBlock:(void (^)(NSError * error))failedBlock {
    [self readDataWithTaskID:mk_bg_taskReadTimingModeReportingTimePointOperation
                     cmdFlag:@"23"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)bg_readMotionModeEventsWithSucBlock:(void (^)(id returnData))sucBlock
                                failedBlock:(void (^)(NSError * error))failedBlock {
    [self readDataWithTaskID:mk_bg_taskReadMotionModeEventsOperation
                     cmdFlag:@"24"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)bg_readMotionModeNumberOfFixOnStartWithSucBlock:(void (^)(id returnData))sucBlock
                                            failedBlock:(void (^)(NSError * error))failedBlock {
    [self readDataWithTaskID:mk_bg_taskReadMotionModeNumberOfFixOnStartOperation
                     cmdFlag:@"25"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)bg_readMotionModePosStrategyOnStartWithSucBlock:(void (^)(id returnData))sucBlock
                                            failedBlock:(void (^)(NSError * error))failedBlock {
    [self readDataWithTaskID:mk_bg_taskReadMotionModePosStrategyOnStartOperation
                     cmdFlag:@"26"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)bg_readMotionModeReportIntervalInTripWithSucBlock:(void (^)(id returnData))sucBlock
                                              failedBlock:(void (^)(NSError * error))failedBlock {
    [self readDataWithTaskID:mk_bg_taskReadMotionModeReportIntervalInTripOperation
                     cmdFlag:@"27"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)bg_readMotionModePosStrategyInTripWithSucBlock:(void (^)(id returnData))sucBlock
                                           failedBlock:(void (^)(NSError * error))failedBlock {
    [self readDataWithTaskID:mk_bg_taskReadMotionModePosStrategyInTripOperation
                     cmdFlag:@"28"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)bg_readMotionModeTripEndTimeoutWithSucBlock:(void (^)(id returnData))sucBlock
                                        failedBlock:(void (^)(NSError * error))failedBlock {
    [self readDataWithTaskID:mk_bg_taskReadMotionModeTripEndTimeoutOperation
                     cmdFlag:@"29"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)bg_readMotionModeNumberOfFixOnEndWithSucBlock:(void (^)(id returnData))sucBlock
                                          failedBlock:(void (^)(NSError * error))failedBlock {
    [self readDataWithTaskID:mk_bg_taskReadMotionModeNumberOfFixOnEndOperation
                     cmdFlag:@"2a"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)bg_readMotionModeReportIntervalOnEndWithSucBlock:(void (^)(id returnData))sucBlock
                                             failedBlock:(void (^)(NSError * error))failedBlock {
    [self readDataWithTaskID:mk_bg_taskReadMotionModeReportIntervalOnEndOperation
                     cmdFlag:@"2b"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)bg_readMotionModePosStrategyOnEndWithSucBlock:(void (^)(id returnData))sucBlock
                                          failedBlock:(void (^)(NSError * error))failedBlock {
    [self readDataWithTaskID:mk_bg_taskReadMotionModePosStrategyOnEndOperation
                     cmdFlag:@"2c"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)bg_readDownlinkForPositioningStrategyWithSucBlock:(void (^)(id returnData))sucBlock
                                              failedBlock:(void (^)(NSError * error))failedBlock {
    [self readDataWithTaskID:mk_bg_taskReadDownlinkForPositioningStrategyOperation
                     cmdFlag:@"2d"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

#pragma mark ****************************************定位参数************************************************

+ (void)bg_readWifiPositioningTimeoutWithSucBlock:(void (^)(id returnData))sucBlock
                                      failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_bg_taskReadWifiPositioningTimeoutOperation
                     cmdFlag:@"30"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)bg_readWifiNumberOfBSSIDWithSucBlock:(void (^)(id returnData))sucBlock
                                 failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_bg_taskReadWifiNumberOfBSSIDOperation
                     cmdFlag:@"31"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)bg_readBLEPositioningTimeoutWithSucBlock:(void (^)(id returnData))sucBlock
                                     failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_bg_taskReadBLEPositioningTimeoutOperation
                     cmdFlag:@"32"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)bg_readBLENumberOfMacWithSucBlock:(void (^)(id returnData))sucBlock
                              failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_bg_taskReadBLENumberOfMacOperation
                     cmdFlag:@"33"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

#pragma mark ****************************************蓝牙过滤规则************************************************

+ (void)bg_readBLELogicalRelationshipWithSucBlock:(void (^)(id returnData))sucBlock
                                      failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_bg_taskReadBLELogicalRelationshipOperation
                     cmdFlag:@"34"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)bg_readBLEFilterStatusWithType:(mk_bg_filterRulesType)type
                              sucBlock:(void (^)(id returnData))sucBlock
                           failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *cmd = @"35";
    mk_bg_taskOperationID taskID = mk_bg_taskReadBLEFilterAStatusOperation;
    if (type == mk_bg_filterRulesClassBType) {
        cmd = @"3e";
        taskID = mk_bg_taskReadBLEFilterBStatusOperation;
    }
    [self readDataWithTaskID:taskID
                     cmdFlag:cmd
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)bg_readBLEFilterDeviceNameWithType:(mk_bg_filterRulesType)type
                                  sucBlock:(void (^)(id returnData))sucBlock
                               failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *cmd = @"36";
    mk_bg_taskOperationID taskID = mk_bg_taskReadBLEFilterADeviceNameOperation;
    if (type == mk_bg_filterRulesClassBType) {
        cmd = @"3f";
        taskID = mk_bg_taskReadBLEFilterBDeviceNameOperation;
    }
    [self readDataWithTaskID:taskID
                     cmdFlag:cmd
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)bg_readBLEFilterDeviceMacWithType:(mk_bg_filterRulesType)type
                                 sucBlock:(void (^)(id returnData))sucBlock
                              failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *cmd = @"37";
    mk_bg_taskOperationID taskID = mk_bg_taskReadBLEFilterADeviceMacOperation;
    if (type == mk_bg_filterRulesClassBType) {
        cmd = @"40";
        taskID = mk_bg_taskReadBLEFilterBDeviceMacOperation;
    }
    [self readDataWithTaskID:taskID
                     cmdFlag:cmd
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)bg_readBLEFilterDeviceMajorWithType:(mk_bg_filterRulesType)type
                                   sucBlock:(void (^)(id returnData))sucBlock
                                failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *cmd = @"38";
    mk_bg_taskOperationID taskID = mk_bg_taskReadBLEFilterAMajorOperation;
    if (type == mk_bg_filterRulesClassBType) {
        cmd = @"41";
        taskID = mk_bg_taskReadBLEFilterBMajorOperation;
    }
    [self readDataWithTaskID:taskID
                     cmdFlag:cmd
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)bg_readBLEFilterDeviceMinorWithType:(mk_bg_filterRulesType)type
                                   sucBlock:(void (^)(id returnData))sucBlock
                                failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *cmd = @"39";
    mk_bg_taskOperationID taskID = mk_bg_taskReadBLEFilterAMinorOperation;
    if (type == mk_bg_filterRulesClassBType) {
        cmd = @"42";
        taskID = mk_bg_taskReadBLEFilterBMinorOperation;
    }
    [self readDataWithTaskID:taskID
                     cmdFlag:cmd
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)bg_readBLEFilterDeviceRawDataWithType:(mk_bg_filterRulesType)type
                                     sucBlock:(void (^)(id returnData))sucBlock
                                  failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *cmd = @"3a";
    mk_bg_taskOperationID taskID = mk_bg_taskReadBLEFilterARawDataOperation;
    if (type == mk_bg_filterRulesClassBType) {
        cmd = @"43";
        taskID = mk_bg_taskReadBLEFilterBRawDataOperation;
    }
    [self readDataWithTaskID:taskID
                     cmdFlag:cmd
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)bg_readBLEFilterDeviceUUIDWithType:(mk_bg_filterRulesType)type
                                  sucBlock:(void (^)(id returnData))sucBlock
                               failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *cmd = @"3b";
    mk_bg_taskOperationID taskID = mk_bg_taskReadBLEFilterAUUIDOperation;
    if (type == mk_bg_filterRulesClassBType) {
        cmd = @"44";
        taskID = mk_bg_taskReadBLEFilterBUUIDOperation;
    }
    [self readDataWithTaskID:taskID
                     cmdFlag:cmd
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)bg_readBLEFilterDeviceRSSIWithType:(mk_bg_filterRulesType)type
                                  sucBlock:(void (^)(id returnData))sucBlock
                               failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *cmd = @"3c";
    mk_bg_taskOperationID taskID = mk_bg_taskReadBLEFilterARssiOperation;
    if (type == mk_bg_filterRulesClassBType) {
        cmd = @"45";
        taskID = mk_bg_taskReadBLEFilterBRssiOperation;
    }
    [self readDataWithTaskID:taskID
                     cmdFlag:cmd
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

#pragma mark ****************************************GPS定位参数************************************************

+ (void)bg_readGpsColdStardTimeWithSucBlock:(void (^)(id returnData))sucBlock
                                failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_bg_taskReadGpsColdStardTimeOperation
                     cmdFlag:@"47"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)bg_readGpsCoarseAccuracyMaskWithSucBlock:(void (^)(id returnData))sucBlock
                                     failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_bg_taskReadGpsCoarseAccuracyMaskOperation
                     cmdFlag:@"48"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)bg_readGpsFineAccuracyTargetWithSucBlock:(void (^)(id returnData))sucBlock
                                     failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_bg_taskReadGpsFineAccuracyTargetOperation
                     cmdFlag:@"49"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)bg_readGpsCoarseTimeWithSucBlock:(void (^)(id returnData))sucBlock
                             failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_bg_taskReadGpsCoarseTimeOperation
                     cmdFlag:@"4a"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)bg_readGpsFineTimeWithSucBlock:(void (^)(id returnData))sucBlock
                           failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_bg_taskReadGpsFineTimeOperation
                     cmdFlag:@"4b"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)bg_readGpsPDOPLimitWithSucBlock:(void (^)(id returnData))sucBlock
                            failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_bg_taskReadGpsPDOPLimitOperation
                     cmdFlag:@"4c"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)bg_readGpsFixModeWithSucBlock:(void (^)(id returnData))sucBlock
                          failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_bg_taskReadGpsFixModeOperation
                     cmdFlag:@"4d"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)bg_readGpsModeWithSucBlock:(void (^)(id returnData))sucBlock
                       failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_bg_taskReadGpsModeOperation
                     cmdFlag:@"4e"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)bg_readGpsTimeBudgetWithSucBlock:(void (^)(id returnData))sucBlock
                             failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_bg_taskReadGpsTimeBudgetOperation
                     cmdFlag:@"4f"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)bg_readGpsAutonomousAidingStatusWithSucBlock:(void (^)(id returnData))sucBlock
                                         failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_bg_taskReadGpsAutonomousAidingStatusOperation
                     cmdFlag:@"50"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)bg_readGpsAdingAccuracyWithSucBlock:(void (^)(id returnData))sucBlock
                                failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_bg_taskReadGpsAdingAccuracyOperation
                     cmdFlag:@"51"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)bg_readGpsAidingTimeWithSucBlock:(void (^)(id returnData))sucBlock
                             failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_bg_taskReadGpsAidingTimeOperation
                     cmdFlag:@"52"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)bg_readGpsExtremeModeStatusWithSucBlock:(void (^)(id returnData))sucBlock
                                    failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_bg_taskReadGpsExtremeModeStatusOperation
                     cmdFlag:@"53"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

#pragma mark ****************************************设备LoRa参数读取************************************************

+ (void)bg_readLorawanRegionWithSucBlock:(void (^)(id returnData))sucBlock
                             failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_bg_taskReadLorawanRegionOperation
                     cmdFlag:@"60"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)bg_readLorawanModemWithSucBlock:(void (^)(id returnData))sucBlock
                            failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_bg_taskReadLorawanModemOperation
                     cmdFlag:@"61"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)bg_readLorawanNetworkStatusWithSucBlock:(void (^)(id returnData))sucBlock
                                    failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_bg_taskReadLorawanNetworkStatusOperation
                     cmdFlag:@"62"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)bg_readLorawanDEVEUIWithSucBlock:(void (^)(id returnData))sucBlock
                             failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_bg_taskReadLorawanDEVEUIOperation
                     cmdFlag:@"63"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)bg_readLorawanAPPEUIWithSucBlock:(void (^)(id returnData))sucBlock
                             failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_bg_taskReadLorawanAPPEUIOperation
                     cmdFlag:@"64"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)bg_readLorawanAPPKEYWithSucBlock:(void (^)(id returnData))sucBlock
                             failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_bg_taskReadLorawanAPPKEYOperation
                     cmdFlag:@"65"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)bg_readLorawanDEVADDRWithSucBlock:(void (^)(id returnData))sucBlock
                              failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_bg_taskReadLorawanDEVADDROperation
                     cmdFlag:@"66"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)bg_readLorawanAPPSKEYWithSucBlock:(void (^)(id returnData))sucBlock
                              failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_bg_taskReadLorawanAPPSKEYOperation
                     cmdFlag:@"67"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)bg_readLorawanNWKSKEYWithSucBlock:(void (^)(id returnData))sucBlock
                              failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_bg_taskReadLorawanNWKSKEYOperation
                     cmdFlag:@"68"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)bg_readLorawanMessageTypeWithSucBlock:(void (^)(id returnData))sucBlock
                                  failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_bg_taskReadLorawanMessageTypeOperation
                     cmdFlag:@"69"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)bg_readLorawanCHWithSucBlock:(void (^)(id returnData))sucBlock
                         failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_bg_taskReadLorawanCHOperation
                     cmdFlag:@"6a"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)bg_readLorawanDRWithSucBlock:(void (^)(id returnData))sucBlock
                         failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_bg_taskReadLorawanDROperation
                     cmdFlag:@"6b"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)bg_readLorawanUplinkStrategyWithSucBlock:(void (^)(id returnData))sucBlock
                                     failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_bg_taskReadLorawanUplinkStrategyOperation
                     cmdFlag:@"6c"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)bg_readLorawanDutyCycleStatusWithSucBlock:(void (^)(id returnData))sucBlock
                                      failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_bg_taskReadLorawanDutyCycleStatusOperation
                     cmdFlag:@"6d"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)bg_readLorawanTimeSyncIntervalWithSucBlock:(void (^)(id returnData))sucBlock
                                       failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_bg_taskReadLorawanDevTimeSyncIntervalOperation
                     cmdFlag:@"6e"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)bg_readLorawanReconnectIntervalWithSucBlock:(void (^)(id returnData))sucBlock
                                        failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_bg_taskReadLorawanReconnectIntervalOperation
                     cmdFlag:@"6f"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

#pragma mark ****************************************蓝牙参数读取************************************************

+ (void)bg_readBeaconModeStatusWithSucBlock:(void (^)(id returnData))sucBlock
                                failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_bg_taskReadBeaconModeStatusOperation
                     cmdFlag:@"70"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)bg_readBeaconAdvIntervalWithSucBlock:(void (^)(id returnData))sucBlock
                                 failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_bg_taskReadBeaconAdvIntervalOperation
                     cmdFlag:@"71"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)bg_readDeviceConnectableWithSucBlock:(void (^)(id returnData))sucBlock
                                 failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_bg_taskReadDeviceConnectableOperation
                     cmdFlag:@"72"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)bg_readDeviceBroadcastTimeoutWithSucBlock:(void (^)(id returnData))sucBlock
                                      failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_bg_taskReadDeviceBroadcastTimeoutOperation
                     cmdFlag:@"73"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)bg_readBeaconProximityUUIDWithSucBlock:(void (^)(id returnData))sucBlock
                                   failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_bg_taskReadBeaconProximityUUIDOperation
                     cmdFlag:@"74"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)bg_readBeaconMajorWithSucBlock:(void (^)(id returnData))sucBlock
                           failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_bg_taskReadBeaconMajorOperation
                     cmdFlag:@"75"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)bg_readBeaconMinorWithSucBlock:(void (^)(id returnData))sucBlock
                           failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_bg_taskReadBeaconMinorOperation
                     cmdFlag:@"76"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)bg_readMeasuredPowerWithSucBlock:(void (^)(id returnData))sucBlock
                             failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_bg_taskReadMeasuredPowerOperation
                     cmdFlag:@"77"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)bg_readTxPowerWithSucBlock:(void (^)(id returnData))sucBlock
                       failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_bg_taskReadTxPowerOperation
                     cmdFlag:@"78"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)bg_readDeviceNameWithSucBlock:(void (^)(id returnData))sucBlock
                          failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_bg_taskReadDeviceNameOperation
                     cmdFlag:@"79"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)bg_readScanningPHYTypeWithSucBlock:(void (^)(id returnData))sucBlock
                               failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_bg_taskReadScanningPHYTypeOperation
                     cmdFlag:@"7a"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

#pragma mark ****************************************辅助功能参数读取************************************************

+ (void)bg_readThreeAxisWakeupConditionsWithSucBlock:(void (^)(id returnData))sucBlock
                                         failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_bg_taskReadThreeAxisWakeupConditionsOperation
                     cmdFlag:@"80"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)bg_readThreeAxisMotionParametersWithSucBlock:(void (^)(id returnData))sucBlock
                                         failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_bg_taskReadThreeAxisMotionParametersOperation
                     cmdFlag:@"81"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)bg_readVibrationDetectionStatusWithSucBlock:(void (^)(id returnData))sucBlock
                                        failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_bg_taskReadVibrationDetectionStatusOperation
                     cmdFlag:@"82"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)bg_readVibrationThresholdsWithSucBlock:(void (^)(id returnData))sucBlock
                                   failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_bg_taskReadVibrationThresholdsOperation
                     cmdFlag:@"83"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)bg_readVibrationDetectionReportIntervalWithSucBlock:(void (^)(id returnData))sucBlock
                                                failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_bg_taskReadVibrationDetectionReportIntervalOperation
                     cmdFlag:@"84"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)bg_readVibrationTimeoutWithSucBlock:(void (^)(id returnData))sucBlock
                                failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_bg_taskReadVibrationTimeoutOperation
                     cmdFlag:@"85"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)bg_readManDownDetectionWithSucBlock:(void (^)(id returnData))sucBlock
                                failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_bg_taskReadManDownDetectionOperation
                     cmdFlag:@"86"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)bg_readIdleDetectionTimeoutWithSucBlock:(void (^)(id returnData))sucBlock
                                    failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_bg_taskReadIdleDetectionTimeoutOperation
                     cmdFlag:@"87"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)bg_readTamperAlarmStatusWithSucBlock:(void (^)(id returnData))sucBlock
                                 failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_bg_taskReadTamperAlarmStatusOperation
                     cmdFlag:@"88"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)bg_readActiveStateCountStatusWithSucBlock:(void (^)(id returnData))sucBlock
                                      failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_bg_taskReadActiveStateCountStatusOperation
                     cmdFlag:@"89"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)bg_readActiveStateTimeoutWithSucBlock:(void (^)(id returnData))sucBlock
                                  failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_bg_taskReadActiveStateTimeoutOperation
                     cmdFlag:@"8a"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

#pragma mark - private method

+ (void)readDataWithTaskID:(mk_bg_taskOperationID)taskID
                   cmdFlag:(NSString *)flag
                  sucBlock:(void (^)(id returnData))sucBlock
               failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *commandString = [NSString stringWithFormat:@"%@%@%@",@"ed00",flag,@"00"];
    [centralManager addTaskWithTaskID:taskID
                       characteristic:peripheral.bg_custom
                          commandData:commandString
                         successBlock:sucBlock
                         failureBlock:failedBlock];
}

@end
