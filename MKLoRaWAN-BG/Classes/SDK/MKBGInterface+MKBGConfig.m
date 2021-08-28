//
//  MKBGInterface+MKBGConfig.m
//  MKLoRaWAN-BG_Example
//
//  Created by aa on 2021/5/17.
//  Copyright © 2021 aadyx2007@163.com. All rights reserved.
//

#import "MKBGInterface+MKBGConfig.h"

#import "MKBLEBaseSDKDefines.h"
#import "MKBLEBaseSDKAdopter.h"

#import "MKBGCentralManager.h"
#import "MKBGOperationID.h"
#import "MKBGOperation.h"
#import "CBPeripheral+MKBGAdd.h"
#import "MKBGSDKDataAdopter.h"

#define centralManager [MKBGCentralManager shared]

@implementation MKBGInterface (MKBGConfig)

+ (void)bg_restartDeviceWithSucBlock:(void (^)(void))sucBlock
                         failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *commandString = @"ed010100";
    [self configDataWithTaskID:mk_bg_taskRestartDeviceOperation
                          data:commandString
                      sucBlock:sucBlock
                   failedBlock:failedBlock];
}

+ (void)bg_factoryResetWithSucBlock:(void (^)(void))sucBlock
                        failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *commandString = @"ed010200";
    [self configDataWithTaskID:mk_bg_taskFactoryResetOperation
                          data:commandString
                      sucBlock:sucBlock
                   failedBlock:failedBlock];
}

+ (void)bg_configDeviceTime:(unsigned long)timestamp
                   sucBlock:(void (^)(void))sucBlock
                failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *value = [NSString stringWithFormat:@"%1lx",timestamp];
    NSString *commandString = [@"ed010304" stringByAppendingString:value];
    [self configDataWithTaskID:mk_bg_taskConfigDeviceTimeOperation
                          data:commandString
                      sucBlock:sucBlock
                   failedBlock:failedBlock];
}

+ (void)bg_configTimeZone:(NSInteger)timeZone
                 sucBlock:(void (^)(void))sucBlock
              failedBlock:(void (^)(NSError *error))failedBlock {
    if (timeZone < -12 || timeZone > 12) {
        [MKBLEBaseSDKAdopter operationParamsErrorBlock:failedBlock];
        return;
    }
    NSString *zoneValue = [MKBLEBaseSDKAdopter hexStringFromSignedNumber:timeZone];
    NSString *commandString = [@"ed010401" stringByAppendingString:zoneValue];
    [self configDataWithTaskID:mk_bg_taskConfigTimeZoneOperation
                          data:commandString
                      sucBlock:sucBlock
                   failedBlock:failedBlock];
}

+ (void)bg_configPassword:(NSString *)password
                 sucBlock:(void (^)(void))sucBlock
              failedBlock:(void (^)(NSError *error))failedBlock {
    if (!MKValidStr(password) || password.length != 8) {
        [MKBLEBaseSDKAdopter operationParamsErrorBlock:failedBlock];
        return;
    }
    NSString *commandData = @"";
    for (NSInteger i = 0; i < password.length; i ++) {
        int asciiCode = [password characterAtIndex:i];
        commandData = [commandData stringByAppendingString:[NSString stringWithFormat:@"%1lx",(unsigned long)asciiCode]];
    }
    NSString *commandString = [@"ed010508" stringByAppendingString:commandData];
    [self configDataWithTaskID:mk_bg_taskConfigPasswordOperation
                          data:commandString
                      sucBlock:sucBlock
                   failedBlock:failedBlock];
}

+ (void)bg_configWorkMode:(mk_bg_deviceMode)deviceMode
                 sucBlock:(void (^)(void))sucBlock
              failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *mode = [MKBGSDKDataAdopter fetchDeviceModeValue:deviceMode];
    NSString *commandString = [@"ed010601" stringByAppendingString:mode];
    [self configDataWithTaskID:mk_bg_taskConfigWorkModeOperation
                          data:commandString
                      sucBlock:sucBlock
                   failedBlock:failedBlock];
}

+ (void)bg_configRepoweredDefaultMode:(mk_bg_repoweredDefaultMode)mode
                             sucBlock:(void (^)(void))sucBlock
                          failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *modeString = @"00";
    if (mode == mk_bg_repoweredDefaultMode_revertToLastMode) {
        modeString = @"01";
    }
    NSString *commandString = [@"ed010701" stringByAppendingString:modeString];
    [self configDataWithTaskID:mk_bg_taskConfigRepoweredDefaultModeOperation
                          data:commandString
                      sucBlock:sucBlock
                   failedBlock:failedBlock];
}

+ (void)bg_configHeartbeatInterval:(long long)interval
                          sucBlock:(void (^)(void))sucBlock
                       failedBlock:(void (^)(NSError *error))failedBlock {
    if (interval < 300 || interval > 86400) {
        [MKBLEBaseSDKAdopter operationParamsErrorBlock:failedBlock];
        return;
    }
    NSString *timeString = [MKBLEBaseSDKAdopter fetchHexValue:interval byteLen:4];
    NSString *commandString = [@"ed010804" stringByAppendingString:timeString];
    [self configDataWithTaskID:mk_bg_taskConfigHeartbeatIntervalOperation
                          data:commandString
                      sucBlock:sucBlock
                   failedBlock:failedBlock];
}

+ (void)bg_configOffByMagnetStatus:(BOOL)isOn
                          sucBlock:(void (^)(void))sucBlock
                       failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *commandString = (isOn ? @"ed01090101" : @"ed01090100");
    [self configDataWithTaskID:mk_bg_taskConfigOffByMagnetStatusOperation
                          data:commandString
                      sucBlock:sucBlock
                   failedBlock:failedBlock];
}

+ (void)bg_configShutdownPayloadStatus:(BOOL)isOn
                              sucBlock:(void (^)(void))sucBlock
                           failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *commandString = (isOn ? @"ed010a0101" : @"ed010a0100");
    [self configDataWithTaskID:mk_bg_taskConfigShutdownPayloadStatusOperation
                          data:commandString
                      sucBlock:sucBlock
                   failedBlock:failedBlock];
}

+ (void)bg_configOfflineFix:(BOOL)isOn
                   sucBlock:(void (^)(void))sucBlock
                failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *commandString = (isOn ? @"ed010b0101" : @"ed010b0100");
    [self configDataWithTaskID:mk_bg_taskConfigOfflineFixStatusOperation
                          data:commandString
                      sucBlock:sucBlock
                   failedBlock:failedBlock];
    
}

+ (void)bg_configLowPowerPayload:(BOOL)isOn
                          prompt:(mk_bg_lowPowerPrompt)prompt
                        sucBlock:(void (^)(void))sucBlock
                     failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *payload = (isOn ? @"1" : @"0");
    NSString *promptString = (prompt == mk_bg_lowPowerPrompt_fivePercent) ? @"0" : @"1";
    NSString *binary = [NSString stringWithFormat:@"%@%@%@",@"000000",payload,promptString];
    NSString *hex = [MKBLEBaseSDKAdopter getHexByBinary:binary];
    NSString *commandString = [@"ed010c01" stringByAppendingString:hex];
    [self configDataWithTaskID:mk_bg_taskConfigLowPowerPayloadOperation
                          data:commandString
                      sucBlock:sucBlock
                   failedBlock:failedBlock];
}

+ (void)bg_configIndicatorSettings:(id <mk_bg_indicatorSettingsProtocol>)protocol
                          sucBlock:(void (^)(void))sucBlock
                       failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *Tamper = (protocol.Tamper ? @"1" : @"0");
    NSString *LowPower = (protocol.LowPower ? @"1" : @"0");
    NSString *InBluetoothFix = (protocol.InBluetoothFix ? @"1" : @"0");
    NSString *BTFixSuccessful = (protocol.BTFixSuccessful ? @"1" : @"0");
    NSString *FailToBTFix = (protocol.FailToBTFix ? @"1" : @"0");
    NSString *InGPSFix = (protocol.InGPSFix ? @"1" : @"0");
    NSString *GPSFixsuccessful = (protocol.GPSFixsuccessful ? @"1" : @"0");
    NSString *FailToGPSFix = (protocol.FailToGPSFix ? @"1" : @"0");
    
    NSString *binaryLow = [NSString stringWithFormat:@"%@%@%@%@%@%@%@%@",FailToGPSFix,GPSFixsuccessful,InGPSFix,
                           FailToBTFix,BTFixSuccessful,InBluetoothFix,LowPower,Tamper];
    
    NSString *InWIFIFix = (protocol.InWIFIFix ? @"1" : @"0");
    NSString *WIFIFixSuccessful = (protocol.WIFIFixSuccessful ? @"1" : @"0");
    NSString *FailToWIFIFix = (protocol.FailToWIFIFix ? @"1" : @"0");
    
    NSString *binaryHigh = [NSString stringWithFormat:@"%@%@%@%@",@"11111",FailToWIFIFix,WIFIFixSuccessful,InWIFIFix];
    NSString *commandString = [NSString stringWithFormat:@"%@%@%@",@"ed010d02",[MKBLEBaseSDKAdopter getHexByBinary:binaryHigh],[MKBLEBaseSDKAdopter getHexByBinary:binaryLow]];
    
    [self configDataWithTaskID:mk_bg_taskConfigIndicatorSettingsOperation
                          data:commandString
                      sucBlock:sucBlock
                   failedBlock:failedBlock];
}

#pragma mark ****************************************模式相关参数************************************************

+ (void)bg_configPeriodicModePositioningStrategy:(mk_bg_positioningStrategy)strategy
                                        sucBlock:(void (^)(void))sucBlock
                                     failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *strategyString = [MKBGSDKDataAdopter fetchPositioningStrategyCommand:strategy];
    NSString *commandString = [@"ed012001" stringByAppendingString:strategyString];
    [self configDataWithTaskID:mk_bg_taskConfigPeriodicModePositioningStrategyOperation
                          data:commandString
                      sucBlock:sucBlock
                   failedBlock:failedBlock];
}

+ (void)bg_configPeriodicModeReportInterval:(long long)interval
                                   sucBlock:(void (^)(void))sucBlock
                                failedBlock:(void (^)(NSError *error))failedBlock {
    if (interval < 30 || interval > 86400) {
        [MKBLEBaseSDKAdopter operationParamsErrorBlock:failedBlock];
        return;
    }
    NSString *value = [MKBLEBaseSDKAdopter fetchHexValue:interval byteLen:4];
    NSString *commandString = [@"ed012104" stringByAppendingString:value];
    [self configDataWithTaskID:mk_bg_taskConfigPeriodicModeReportIntervalOperation
                          data:commandString
                      sucBlock:sucBlock
                   failedBlock:failedBlock];
}

+ (void)bg_configTimingModePositioningStrategy:(mk_bg_positioningStrategy)strategy
                                      sucBlock:(void (^)(void))sucBlock
                                   failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *strategyString = [MKBGSDKDataAdopter fetchPositioningStrategyCommand:strategy];
    NSString *commandString = [@"ed012201" stringByAppendingString:strategyString];
    [self configDataWithTaskID:mk_bg_taskConfigTimingModePositioningStrategyOperation
                          data:commandString
                      sucBlock:sucBlock
                   failedBlock:failedBlock];
}

+ (void)bg_configTimingModeReportingTimePoint:(NSArray <mk_bg_timingModeReportingTimePointProtocol>*)dataList
                                     sucBlock:(void (^)(void))sucBlock
                                  failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *dataString = [MKBGSDKDataAdopter fetchTimingModeReportingTimePoint:dataList];
    if (!MKValidStr(dataString)) {
        [MKBLEBaseSDKAdopter operationParamsErrorBlock:failedBlock];
        return;
    }
    NSString *commandString = [@"ed0123" stringByAppendingString:dataString];
    [self configDataWithTaskID:mk_bg_taskConfigTimingModeReportingTimePointOperation
                          data:commandString
                      sucBlock:sucBlock
                   failedBlock:failedBlock];
}

+ (void)bg_configMotionModeEvents:(id <mk_bg_motionModeEventsProtocol>)protocol
                         sucBlock:(void (^)(void))sucBlock
                      failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *notifyEventOnStartValue = (protocol.notifyEventOnStart ? @"1" : @"0");
    NSString *fixOnStartValue = (protocol.fixOnStart ? @"1" : @"0");
    NSString *notifyEventInTripValue = (protocol.notifyEventInTrip ? @"1" : @"0");
    NSString *fixInTripValue = (protocol.fixInTrip ? @"1" : @"0");
    NSString *notifyEventOnEndValue = (protocol.notifyEventOnEnd ? @"1" : @"0");
    NSString *fixOnEndValue = (protocol.fixOnEnd ? @"1" : @"0");
    NSString *resultValue = [NSString stringWithFormat:@"%@%@%@%@%@%@%@",@"00",fixOnEndValue,notifyEventOnEndValue,fixInTripValue,notifyEventInTripValue,fixOnStartValue,notifyEventOnStartValue];
    NSString *cmdValue = [MKBLEBaseSDKAdopter getHexByBinary:resultValue];
    NSString *commandString = [@"ed012401" stringByAppendingString:cmdValue];
    [self configDataWithTaskID:mk_bg_taskConfigMotionModeEventsOperation
                          data:commandString
                      sucBlock:sucBlock
                   failedBlock:failedBlock];
}

+ (void)bg_configMotionModeNumberOfFixOnStart:(NSInteger)number
                                     sucBlock:(void (^)(void))sucBlock
                                  failedBlock:(void (^)(NSError *error))failedBlock {
    if (number < 1 || number > 255) {
        [MKBLEBaseSDKAdopter operationParamsErrorBlock:failedBlock];
        return;
    }
    NSString *value = [MKBLEBaseSDKAdopter fetchHexValue:number byteLen:1];
    NSString *commandString = [@"ed012501" stringByAppendingString:value];
    [self configDataWithTaskID:mk_bg_taskConfigMotionModeNumberOfFixOnStartOperation
                          data:commandString
                      sucBlock:sucBlock
                   failedBlock:failedBlock];
}

+ (void)bg_configMotionModePosStrategyOnStart:(mk_bg_positioningStrategy)strategy
                                     sucBlock:(void (^)(void))sucBlock
                                  failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *strategyString = [MKBGSDKDataAdopter fetchPositioningStrategyCommand:strategy];
    NSString *commandString = [@"ed012601" stringByAppendingString:strategyString];
    [self configDataWithTaskID:mk_bg_taskConfigMotionModePosStrategyOnStartOperation
                          data:commandString
                      sucBlock:sucBlock
                   failedBlock:failedBlock];
}

+ (void)bg_configMotionModeReportIntervalInTrip:(long long)interval
                                       sucBlock:(void (^)(void))sucBlock
                                    failedBlock:(void (^)(NSError *error))failedBlock {
    if (interval < 10 || interval > 86400) {
        [MKBLEBaseSDKAdopter operationParamsErrorBlock:failedBlock];
        return;
    }
    NSString *value = [MKBLEBaseSDKAdopter fetchHexValue:interval byteLen:4];
    NSString *commandString = [@"ed012704" stringByAppendingString:value];
    [self configDataWithTaskID:mk_bg_taskConfigMotionModeReportIntervalInTripOperation
                          data:commandString
                      sucBlock:sucBlock
                   failedBlock:failedBlock];
}

+ (void)bg_configMotionModePosStrategyInTrip:(mk_bg_positioningStrategy)strategy
                                    sucBlock:(void (^)(void))sucBlock
                                 failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *strategyString = [MKBGSDKDataAdopter fetchPositioningStrategyCommand:strategy];
    NSString *commandString = [@"ed012801" stringByAppendingString:strategyString];
    [self configDataWithTaskID:mk_bg_taskConfigMotionModePosStrategyInTripOperation
                          data:commandString
                      sucBlock:sucBlock
                   failedBlock:failedBlock];
}

+ (void)bg_configMotionModeTripEndTimeout:(NSInteger)time
                                 sucBlock:(void (^)(void))sucBlock
                              failedBlock:(void (^)(NSError *error))failedBlock {
    if (time < 3 || time > 180) {
        [MKBLEBaseSDKAdopter operationParamsErrorBlock:failedBlock];
        return;
    }
    NSString *value = [MKBLEBaseSDKAdopter fetchHexValue:time byteLen:1];
    NSString *commandString = [@"ed012901" stringByAppendingString:value];
    [self configDataWithTaskID:mk_bg_taskConfigMotionModeTripEndTimeoutOperation
                          data:commandString
                      sucBlock:sucBlock
                   failedBlock:failedBlock];
}

+ (void)bg_configMotionModeNumberOfFixOnEnd:(NSInteger)number
                                   sucBlock:(void (^)(void))sucBlock
                                failedBlock:(void (^)(NSError *error))failedBlock {
    if (number < 1 || number > 255) {
        [MKBLEBaseSDKAdopter operationParamsErrorBlock:failedBlock];
        return;
    }
    NSString *value = [MKBLEBaseSDKAdopter fetchHexValue:number byteLen:1];
    NSString *commandString = [@"ed012a01" stringByAppendingString:value];
    [self configDataWithTaskID:mk_bg_taskConfigMotionModeNumberOfFixOnEndOperation
                          data:commandString
                      sucBlock:sucBlock
                   failedBlock:failedBlock];
}

+ (void)bg_configMotionModeReportIntervalOnEnd:(NSInteger)interval
                                      sucBlock:(void (^)(void))sucBlock
                                   failedBlock:(void (^)(NSError *error))failedBlock {
    if (interval < 10 || interval > 300) {
        [MKBLEBaseSDKAdopter operationParamsErrorBlock:failedBlock];
        return;
    }
    NSString *value = [MKBLEBaseSDKAdopter fetchHexValue:interval byteLen:2];
    NSString *commandString = [@"ed012b02" stringByAppendingString:value];
    [self configDataWithTaskID:mk_bg_taskConfigMotionModeReportIntervalOnEndOperation
                          data:commandString
                      sucBlock:sucBlock
                   failedBlock:failedBlock];
}

+ (void)bg_configMotionModePosStrategyOnEnd:(mk_bg_positioningStrategy)strategy
                                   sucBlock:(void (^)(void))sucBlock
                                failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *strategyString = [MKBGSDKDataAdopter fetchPositioningStrategyCommand:strategy];
    NSString *commandString = [@"ed012c01" stringByAppendingString:strategyString];
    [self configDataWithTaskID:mk_bg_taskConfigMotionModePosStrategyOnEndOperation
                          data:commandString
                      sucBlock:sucBlock
                   failedBlock:failedBlock];
}

+ (void)bg_configDownlinkForPositioningStrategy:(mk_bg_positioningStrategy)strategy
                                       sucBlock:(void (^)(void))sucBlock
                                    failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *strategyString = [MKBGSDKDataAdopter fetchPositioningStrategyCommand:strategy];
    NSString *commandString = [@"ed012d01" stringByAppendingString:strategyString];
    [self configDataWithTaskID:mk_bg_taskConfigDownlinkForPositioningStrategyOperation
                          data:commandString
                      sucBlock:sucBlock
                   failedBlock:failedBlock];
}


#pragma mark ****************************************定位参数************************************************

+ (void)bg_configWifiPositioningTimeout:(NSInteger)interval
                               sucBlock:(void (^)(void))sucBlock
                            failedBlock:(void (^)(NSError *error))failedBlock {
    if (interval < 1 || interval > 5) {
        [MKBLEBaseSDKAdopter operationParamsErrorBlock:failedBlock];
        return;
    }
    NSString *value = [MKBLEBaseSDKAdopter fetchHexValue:interval byteLen:1];
    NSString *commandString = [@"ed013001" stringByAppendingString:value];
    [self configDataWithTaskID:mk_bg_taskConfigWifiPositioningTimeoutOperation
                          data:commandString
                      sucBlock:sucBlock
                   failedBlock:failedBlock];
}

+ (void)bg_configWifiNumberOfBSSID:(NSInteger)number
                          sucBlock:(void (^)(void))sucBlock
                       failedBlock:(void (^)(NSError *error))failedBlock {
    if (number < 1 || number > 5) {
        [MKBLEBaseSDKAdopter operationParamsErrorBlock:failedBlock];
        return;
    }
    NSString *value = [MKBLEBaseSDKAdopter fetchHexValue:number byteLen:1];
    NSString *commandString = [@"ed013101" stringByAppendingString:value];
    [self configDataWithTaskID:mk_bg_taskConfigWifiNumberOfBSSIDOperation
                          data:commandString
                      sucBlock:sucBlock
                   failedBlock:failedBlock];
}

+ (void)bg_configBLEPositioningTimeout:(NSInteger)interval
                              sucBlock:(void (^)(void))sucBlock
                           failedBlock:(void (^)(NSError *error))failedBlock {
    if (interval < 1 || interval > 10) {
        [MKBLEBaseSDKAdopter operationParamsErrorBlock:failedBlock];
        return;
    }
    NSString *value = [MKBLEBaseSDKAdopter fetchHexValue:interval byteLen:1];
    NSString *commandString = [@"ed013201" stringByAppendingString:value];
    [self configDataWithTaskID:mk_bg_taskConfigBLEPositioningTimeoutOperation
                          data:commandString
                      sucBlock:sucBlock
                   failedBlock:failedBlock];
}

+ (void)bg_configBLENumberOfMac:(NSInteger)number
                       sucBlock:(void (^)(void))sucBlock
                    failedBlock:(void (^)(NSError *error))failedBlock {
    if (number < 1 || number > 5) {
        [MKBLEBaseSDKAdopter operationParamsErrorBlock:failedBlock];
        return;
    }
    NSString *value = [MKBLEBaseSDKAdopter fetchHexValue:number byteLen:1];
    NSString *commandString = [@"ed013301" stringByAppendingString:value];
    [self configDataWithTaskID:mk_bg_taskConfigBLENumberOfMacOperation
                          data:commandString
                      sucBlock:sucBlock
                   failedBlock:failedBlock];
}

#pragma mark ****************************************蓝牙过滤规则************************************************

+ (void)bg_configBLELogicalRelationship:(mk_bg_BLELogicalRelationship)ship
                               sucBlock:(void (^)(void))sucBlock
                            failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *commandString = (ship == mk_bg_BLELogicalRelationshipAND ? @"ed01340101" : @"ed01340100");
    [self configDataWithTaskID:mk_bg_taskConfigBLELogicalRelationshipOperation
                          data:commandString
                      sucBlock:sucBlock
                   failedBlock:failedBlock];
}

+ (void)bg_configBLEFilterStatusWithType:(mk_bg_filterRulesType)type
                                    isOn:(BOOL)isOn
                                sucBlock:(void (^)(void))sucBlock
                             failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *typeString = (type == mk_bg_filterRulesClassAType ? @"35" : @"3e");
    NSString *state = (isOn ? @"01" : @"00");
    mk_bg_taskOperationID taskID = (type == mk_bg_filterRulesClassAType ? mk_bg_taskConfigBLEFilterAStatusOperation : mk_bg_taskConfigBLEFilterBStatusOperation);
    NSString *commandString = [NSString stringWithFormat:@"%@%@%@%@",@"ed01",typeString,@"01",state];
    [self configDataWithTaskID:taskID
                          data:commandString
                      sucBlock:sucBlock
                   failedBlock:failedBlock];
}

+ (void)bg_configBLEFilterDeviceNameWithType:(mk_bg_filterRulesType)type
                                       rules:(mk_bg_filterRules)rules
                                  deviceName:(NSString *)deviceName
                                    sucBlock:(void (^)(void))sucBlock
                                 failedBlock:(void (^)(NSError *error))failedBlock {
    if (rules == mk_bg_filterRules_off) {
        //关闭，不需要校验
        NSString *commandString = (type == mk_bg_filterRulesClassAType ? @"ed01360100" : @"ed013f0100");
        mk_bg_taskOperationID taskID = (type == mk_bg_filterRulesClassAType ? mk_bg_taskConfigBLEFilterADeviceNameOperation : mk_bg_taskConfigBLEFilterBDeviceNameOperation);
        [self configDataWithTaskID:taskID
                              data:commandString
                          sucBlock:sucBlock
                       failedBlock:failedBlock];
        return;
    }
    if (!MKValidStr(deviceName) || deviceName.length > 29) {
        [MKBLEBaseSDKAdopter operationParamsErrorBlock:failedBlock];
        return;
    }
    NSString *tempString = @"";
    for (NSInteger i = 0; i < deviceName.length; i ++) {
        int asciiCode = [deviceName characterAtIndex:i];
        tempString = [tempString stringByAppendingString:[NSString stringWithFormat:@"%1lx",(unsigned long)asciiCode]];
    }
    
    NSString *typeString = (type == mk_bg_filterRulesClassAType ? @"36" : @"3f");
    NSString *rulesString = (rules == mk_bg_filterRules_forward ? @"01" : @"02");
    mk_bg_taskOperationID taskID = (type == mk_bg_filterRulesClassAType ? mk_bg_taskConfigBLEFilterADeviceNameOperation : mk_bg_taskConfigBLEFilterBDeviceNameOperation);
    
    NSString *lenString = [MKBLEBaseSDKAdopter fetchHexValue:(deviceName.length + 1) byteLen:1];
    NSString *commandString = [NSString stringWithFormat:@"%@%@%@%@%@",@"ed01",typeString,lenString,rulesString,tempString];
    [self configDataWithTaskID:taskID
                          data:commandString
                      sucBlock:sucBlock
                   failedBlock:failedBlock];
}

+ (void)bg_configBLEFilterDeviceMacWithType:(mk_bg_filterRulesType)type
                                      rules:(mk_bg_filterRules)rules
                                        mac:(NSString *)mac
                                   sucBlock:(void (^)(void))sucBlock
                                failedBlock:(void (^)(NSError *error))failedBlock {
    if (rules == mk_bg_filterRules_off) {
        //关闭，不需要校验
        NSString *commandString = (type == mk_bg_filterRulesClassAType ? @"ed01370100" : @"ed01400100");
        mk_bg_taskOperationID taskID = (type == mk_bg_filterRulesClassAType ? mk_bg_taskConfigBLEFilterAMacOperation : mk_bg_taskConfigBLEFilterBMacOperation);
        [self configDataWithTaskID:taskID
                              data:commandString
                          sucBlock:sucBlock
                       failedBlock:failedBlock];
        return;
    }
    mac = [mac stringByReplacingOccurrencesOfString:@":" withString:@""];
    mac = [mac stringByReplacingOccurrencesOfString:@"-" withString:@""];
    if (!MKValidStr(mac) || mac.length > 12 || ![MKBLEBaseSDKAdopter checkHexCharacter:mac] || mac.length % 2 != 0) {
        [MKBLEBaseSDKAdopter operationParamsErrorBlock:failedBlock];
        return;
    }
    NSString *typeString = (type == mk_bg_filterRulesClassAType ? @"37" : @"40");
    NSString *rulesString = (rules == mk_bg_filterRules_forward ? @"01" : @"02");
    mk_bg_taskOperationID taskID = (type == mk_bg_filterRulesClassAType ? mk_bg_taskConfigBLEFilterAMacOperation : mk_bg_taskConfigBLEFilterBMacOperation);
    
    NSString *lenString = [NSString stringWithFormat:@"%1lx",(long)((mac.length / 2) + 1)];
    if (lenString.length == 1) {
        lenString = [@"0" stringByAppendingString:lenString];
    }
    NSString *commandString = [NSString stringWithFormat:@"%@%@%@%@%@",@"ed01",typeString,lenString,rulesString,mac];
    [self configDataWithTaskID:taskID
                          data:commandString
                      sucBlock:sucBlock
                   failedBlock:failedBlock];
}

+ (void)bg_configBLEFilterDeviceMajorWithType:(mk_bg_filterRulesType)type
                                        rules:(mk_bg_filterRules)rules
                                     majorMin:(NSInteger)majorMin
                                     majorMax:(NSInteger)majorMax
                                     sucBlock:(void (^)(void))sucBlock
                                  failedBlock:(void (^)(NSError *error))failedBlock {
    if (rules == mk_bg_filterRules_off) {
        //关闭，不需要校验
        NSString *commandString = (type == mk_bg_filterRulesClassAType ? @"ed01380100" : @"ed01410100");
        mk_bg_taskOperationID taskID = (type == mk_bg_filterRulesClassAType ? mk_bg_taskConfigBLEFilterAMajorOperation : mk_bg_taskConfigBLEFilterBMajorOperation);
        [self configDataWithTaskID:taskID
                              data:commandString
                          sucBlock:sucBlock
                       failedBlock:failedBlock];
        return;
    }
    if (majorMin < 0 || majorMin > 65535 || majorMax < majorMin || majorMax > 65535) {
        [MKBLEBaseSDKAdopter operationParamsErrorBlock:failedBlock];
        return;
    }
    NSString *minString = [MKBLEBaseSDKAdopter fetchHexValue:majorMin byteLen:2];
    NSString *maxString = [MKBLEBaseSDKAdopter fetchHexValue:majorMax byteLen:2];
    NSString *typeString = (type == mk_bg_filterRulesClassAType ? @"38" : @"41");
    NSString *rulesString = (rules == mk_bg_filterRules_forward ? @"01" : @"02");
    mk_bg_taskOperationID taskID = (type == mk_bg_filterRulesClassAType ? mk_bg_taskConfigBLEFilterAMajorOperation : mk_bg_taskConfigBLEFilterBMajorOperation);
    
    NSString *commandString = [NSString stringWithFormat:@"%@%@%@%@%@%@",@"ed01",typeString,@"05",rulesString,minString,maxString];
    [self configDataWithTaskID:taskID
                          data:commandString
                      sucBlock:sucBlock
                   failedBlock:failedBlock];
}

+ (void)bg_configBLEFilterDeviceMinorWithType:(mk_bg_filterRulesType)type
                                        rules:(mk_bg_filterRules)rules
                                     minorMin:(NSInteger)minorMin
                                     minorMax:(NSInteger)minorMax
                                     sucBlock:(void (^)(void))sucBlock
                                  failedBlock:(void (^)(NSError *error))failedBlock {
    if (rules == mk_bg_filterRules_off) {
        //关闭，不需要校验
        NSString *commandString = (type == mk_bg_filterRulesClassAType ? @"ed01390100" : @"ed01420100");
        mk_bg_taskOperationID taskID = (type == mk_bg_filterRulesClassAType ? mk_bg_taskConfigBLEFilterAMinorOperation : mk_bg_taskConfigBLEFilterBMinorOperation);
        [self configDataWithTaskID:taskID
                              data:commandString
                          sucBlock:sucBlock
                       failedBlock:failedBlock];
        return;
    }
    if (minorMin < 0 || minorMin > 65535 || minorMax < minorMin || minorMax > 65535) {
        [MKBLEBaseSDKAdopter operationParamsErrorBlock:failedBlock];
        return;
    }
    NSString *minString = [MKBLEBaseSDKAdopter fetchHexValue:minorMin byteLen:2];
    NSString *maxString = [MKBLEBaseSDKAdopter fetchHexValue:minorMax byteLen:2];
    NSString *typeString = (type == mk_bg_filterRulesClassAType ? @"39" : @"42");
    NSString *rulesString = (rules == mk_bg_filterRules_forward ? @"01" : @"02");
    mk_bg_taskOperationID taskID = (type == mk_bg_filterRulesClassAType ? mk_bg_taskConfigBLEFilterAMinorOperation : mk_bg_taskConfigBLEFilterBMinorOperation);
    
    NSString *commandString = [NSString stringWithFormat:@"%@%@%@%@%@%@",@"ed01",typeString,@"05",rulesString,minString,maxString];
    [self configDataWithTaskID:taskID
                          data:commandString
                      sucBlock:sucBlock
                   failedBlock:failedBlock];
}

+ (void)bg_configBLEFilterDeviceRawDataWithType:(mk_bg_filterRulesType)type
                                          rules:(mk_bg_filterRules)rules
                                    rawDataList:(NSArray <mk_bg_BLEFilterRawDataProtocol> *)rawDataList
                                       sucBlock:(void (^)(void))sucBlock
                                    failedBlock:(void (^)(NSError *error))failedBlock {
    if (rules == mk_bg_filterRules_off) {
        //关闭，不需要校验
        NSString *commandString = (type == mk_bg_filterRulesClassAType ? @"ed013a0100" : @"ed01430100");
        mk_bg_taskOperationID taskID = (type == mk_bg_filterRulesClassAType ? mk_bg_taskConfigBLEFilterARawDataOperation : mk_bg_taskConfigBLEFilterBRawDataOperation);
        [self configDataWithTaskID:taskID
                              data:commandString
                          sucBlock:sucBlock
                       failedBlock:failedBlock];
        return;
    }
    if (!MKValidArray(rawDataList) || rawDataList.count > 5) {
        [MKBLEBaseSDKAdopter operationParamsErrorBlock:failedBlock];
        return;
    }
    NSString *contentData = @"";
    for (id <mk_bg_BLEFilterRawDataProtocol>protocol in rawDataList) {
        if (![MKBGSDKDataAdopter isConfirmRawFilterProtocol:protocol]) {
            [MKBLEBaseSDKAdopter operationParamsErrorBlock:failedBlock];
            return;
        }
        NSString *minIndex = [MKBLEBaseSDKAdopter fetchHexValue:protocol.minIndex byteLen:1];
        NSString *maxIndex = [MKBLEBaseSDKAdopter fetchHexValue:protocol.maxIndex byteLen:1];
        NSString *lenString = [MKBLEBaseSDKAdopter fetchHexValue:(protocol.rawData.length / 2 + 3) byteLen:1];
        NSString *conditionString = [NSString stringWithFormat:@"%@%@%@%@%@",lenString,protocol.dataType,minIndex,maxIndex,protocol.rawData];
        contentData = [contentData stringByAppendingString:conditionString];
    }
    NSString *lenString = [MKBLEBaseSDKAdopter fetchHexValue:((contentData.length / 2) + 1) byteLen:1];
    NSString *typeString = (type == mk_bg_filterRulesClassAType ? @"3a" : @"43");
    NSString *rulesString = (rules == mk_bg_filterRules_forward ? @"01" : @"02");
    mk_bg_taskOperationID taskID = (type == mk_bg_filterRulesClassAType ? mk_bg_taskConfigBLEFilterARawDataOperation : mk_bg_taskConfigBLEFilterBRawDataOperation);
    NSString *commandString = [NSString stringWithFormat:@"%@%@%@%@%@",@"ed01",typeString,lenString,rulesString,contentData];
    [self configDataWithTaskID:taskID
                          data:commandString
                      sucBlock:sucBlock
                   failedBlock:failedBlock];
}

+ (void)bg_configBLEFilterDeviceUUIDWithType:(mk_bg_filterRulesType)type
                                       rules:(mk_bg_filterRules)rules
                                        uuid:(NSString *)uuid
                                    sucBlock:(void (^)(void))sucBlock
                                 failedBlock:(void (^)(NSError *error))failedBlock {
    if (rules == mk_bg_filterRules_off) {
        //关闭，不需要校验
        NSString *commandString = (type == mk_bg_filterRulesClassAType ? @"ed013b0100" : @"ed01440100");
        mk_bg_taskOperationID taskID = (type == mk_bg_filterRulesClassAType ? mk_bg_taskConfigBLEFilterAUUIDOperation : mk_bg_taskConfigBLEFilterBUUIDOperation);
        [self configDataWithTaskID:taskID
                              data:commandString
                          sucBlock:sucBlock
                       failedBlock:failedBlock];
        return;
    }
    if (![MKBLEBaseSDKAdopter checkHexCharacter:uuid] || uuid.length > 32 || uuid.length % 2 != 0) {
        [MKBLEBaseSDKAdopter operationParamsErrorBlock:failedBlock];
        return;
    }
    NSString *lenString = [MKBLEBaseSDKAdopter fetchHexValue:((uuid.length / 2) + 1) byteLen:1];
    NSString *typeString = (type == mk_bg_filterRulesClassAType ? @"3b" : @"44");
    NSString *rulesString = (rules == mk_bg_filterRules_forward ? @"01" : @"02");
    mk_bg_taskOperationID taskID = (type == mk_bg_filterRulesClassAType ? mk_bg_taskConfigBLEFilterAUUIDOperation : mk_bg_taskConfigBLEFilterBUUIDOperation);
    NSString *commandString = [NSString stringWithFormat:@"%@%@%@%@%@",@"ed01",typeString,lenString,rulesString,uuid];
    [self configDataWithTaskID:taskID
                          data:commandString
                      sucBlock:sucBlock
                   failedBlock:failedBlock];
}

+ (void)bg_configBLEFilterDeviceRSSIWithType:(mk_bg_filterRulesType)type
                                        rssi:(NSInteger)rssi
                                    sucBlock:(void (^)(void))sucBlock
                                 failedBlock:(void (^)(NSError *error))failedBlock {
    if (rssi < -127 || rssi > 0) {
        [MKBLEBaseSDKAdopter operationParamsErrorBlock:failedBlock];
        return;
    }
    NSString *rssiValue = [MKBLEBaseSDKAdopter hexStringFromSignedNumber:rssi];
    NSString *typeString = (type == mk_bg_filterRulesClassAType ? @"3c" : @"45");
    mk_bg_taskOperationID taskID = (type == mk_bg_filterRulesClassAType ? mk_bg_taskConfigBLEFilterARSSIOperation : mk_bg_taskConfigBLEFilterBRSSIOperation);
    NSString *commandString = [NSString stringWithFormat:@"%@%@%@%@",@"ed01",typeString,@"01",rssiValue];
    [self configDataWithTaskID:taskID
                          data:commandString
                      sucBlock:sucBlock
                   failedBlock:failedBlock];
}

#pragma mark ****************************************GPS定位参数************************************************

+ (void)bg_configGpsColdStardTime:(NSInteger)time
                         sucBlock:(void (^)(void))sucBlock
                      failedBlock:(void (^)(NSError *error))failedBlock {
    if (time < 3 || time > 15) {
        [MKBLEBaseSDKAdopter operationParamsErrorBlock:failedBlock];
        return;
    }
    NSString *timeString = [MKBLEBaseSDKAdopter fetchHexValue:time byteLen:1];
    NSString *commandString = [@"ed014701" stringByAppendingString:timeString];
    [self configDataWithTaskID:mk_bg_taskConfigGpsColdStardTimeOperation
                          data:commandString
                      sucBlock:sucBlock
                   failedBlock:failedBlock];
}

+ (void)bg_configGpsCoarseAccuracyMask:(NSInteger)value
                              sucBlock:(void (^)(void))sucBlock
                           failedBlock:(void (^)(NSError *error))failedBlock {
    if (value < 5 || value > 100) {
        [MKBLEBaseSDKAdopter operationParamsErrorBlock:failedBlock];
        return;
    }
    NSString *valueString = [MKBLEBaseSDKAdopter fetchHexValue:value byteLen:1];
    NSString *commandString = [@"ed014801" stringByAppendingString:valueString];
    [self configDataWithTaskID:mk_bg_taskConfigGpsCoarseAccuracyMaskOperation
                          data:commandString
                      sucBlock:sucBlock
                   failedBlock:failedBlock];
}

+ (void)bg_configGpsFineAccuracyTarget:(NSInteger)value
                              sucBlock:(void (^)(void))sucBlock
                           failedBlock:(void (^)(NSError *error))failedBlock {
    if (value < 5 || value > 100) {
        [MKBLEBaseSDKAdopter operationParamsErrorBlock:failedBlock];
        return;
    }
    NSString *valueString = [MKBLEBaseSDKAdopter fetchHexValue:value byteLen:1];
    NSString *commandString = [@"ed014901" stringByAppendingString:valueString];
    [self configDataWithTaskID:mk_bg_taskConfigGpsFineAccuracyTargetOperation
                          data:commandString
                      sucBlock:sucBlock
                   failedBlock:failedBlock];
}

+ (void)bg_configGpsCoarseTime:(NSInteger)time
                      sucBlock:(void (^)(void))sucBlock
                   failedBlock:(void (^)(NSError *error))failedBlock {
    if (time < 1 || time > 7620) {
        [MKBLEBaseSDKAdopter operationParamsErrorBlock:failedBlock];
        return;
    }
    NSString *timeString = [MKBLEBaseSDKAdopter fetchHexValue:time byteLen:2];
    NSString *commandString = [@"ed014a02" stringByAppendingString:timeString];
    [self configDataWithTaskID:mk_bg_taskConfigGpsCoarseTimeOperation
                          data:commandString
                      sucBlock:sucBlock
                   failedBlock:failedBlock];
}

+ (void)bg_configGpsFineTime:(NSInteger)time
                    sucBlock:(void (^)(void))sucBlock
                 failedBlock:(void (^)(NSError *error))failedBlock {
    if (time < 0 || time > 76200) {
        [MKBLEBaseSDKAdopter operationParamsErrorBlock:failedBlock];
        return;
    }
    NSString *timeString = [MKBLEBaseSDKAdopter fetchHexValue:time byteLen:4];
    NSString *commandString = [@"ed014b04" stringByAppendingString:timeString];
    [self configDataWithTaskID:mk_bg_taskConfigGpsFineTimeOperation
                          data:commandString
                      sucBlock:sucBlock
                   failedBlock:failedBlock];
}

+ (void)bg_configGpsPDOPLimit:(NSInteger)value
                     sucBlock:(void (^)(void))sucBlock
                  failedBlock:(void (^)(NSError *error))failedBlock {
    if (value < 25 || value > 100) {
        [MKBLEBaseSDKAdopter operationParamsErrorBlock:failedBlock];
        return;
    }
    NSString *valueString = [MKBLEBaseSDKAdopter fetchHexValue:value byteLen:1];
    NSString *commandString = [@"ed014c01" stringByAppendingString:valueString];
    [self configDataWithTaskID:mk_bg_taskConfigGpsPDOPLimitOperation
                          data:commandString
                      sucBlock:sucBlock
                   failedBlock:failedBlock];
}

+ (void)bg_configGpsFixMode:(mk_bg_gpsFixMode)mode
                   sucBlock:(void (^)(void))sucBlock
                failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *type = [MKBGSDKDataAdopter fetchGpsFixModeValue:mode];
    NSString *commandString = [@"ed014d01" stringByAppendingString:type];
    [self configDataWithTaskID:mk_bg_taskConfigGpsFixModeOperation
                          data:commandString
                      sucBlock:sucBlock
                   failedBlock:failedBlock];
}

+ (void)bg_configGpsMode:(mk_bg_gpsMode)mode
                sucBlock:(void (^)(void))sucBlock
             failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *type = [MKBGSDKDataAdopter fetchGpsModeValue:mode];
    NSString *commandString = [@"ed014e01" stringByAppendingString:type];
    [self configDataWithTaskID:mk_bg_taskConfigGpsModeOperation
                          data:commandString
                      sucBlock:sucBlock
                   failedBlock:failedBlock];
}

+ (void)bg_configGpsTimeBudget:(long long)time
                      sucBlock:(void (^)(void))sucBlock
                   failedBlock:(void (^)(NSError *error))failedBlock {
    if (time < 0 || time > 76200) {
        [MKBLEBaseSDKAdopter operationParamsErrorBlock:failedBlock];
        return;
    }
    NSString *timeString = [MKBLEBaseSDKAdopter fetchHexValue:time byteLen:4];
    NSString *commandString = [@"ed014f04" stringByAppendingString:timeString];
    [self configDataWithTaskID:mk_bg_taskConfigGpsTimeBudgetOperation
                          data:commandString
                      sucBlock:sucBlock
                   failedBlock:failedBlock];
}

+ (void)bg_configGpsAutonomousAidingStatus:(BOOL)isOn
                                  sucBlock:(void (^)(void))sucBlock
                               failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *commandString = (isOn ? @"ed01500101" : @"ed01500100");
    [self configDataWithTaskID:mk_bg_taskConfigGpsAutonomousAidingStatusOperation
                          data:commandString
                      sucBlock:sucBlock
                   failedBlock:failedBlock];
}

+ (void)bg_configGpsAdingAccuracy:(NSInteger)value
                         sucBlock:(void (^)(void))sucBlock
                      failedBlock:(void (^)(NSError *error))failedBlock {
    if (value < 5 || value > 1000) {
        [MKBLEBaseSDKAdopter operationParamsErrorBlock:failedBlock];
        return;
    }
    NSString *valueString = [MKBLEBaseSDKAdopter fetchHexValue:value byteLen:2];
    NSString *commandString = [@"ed015102" stringByAppendingString:valueString];
    [self configDataWithTaskID:mk_bg_taskConfigGpsAdingAccuracyOperation
                          data:commandString
                      sucBlock:sucBlock
                   failedBlock:failedBlock];
}

+ (void)bg_configGpsAidingTime:(NSInteger)time
                      sucBlock:(void (^)(void))sucBlock
                   failedBlock:(void (^)(NSError *error))failedBlock {
    if (time < 1 || time > 7620) {
        [MKBLEBaseSDKAdopter operationParamsErrorBlock:failedBlock];
        return;
    }
    NSString *timeString = [MKBLEBaseSDKAdopter fetchHexValue:time byteLen:2];
    NSString *commandString = [@"ed015202" stringByAppendingString:timeString];
    [self configDataWithTaskID:mk_bg_taskConfigGpsAidingTimeOperation
                          data:commandString
                      sucBlock:sucBlock
                   failedBlock:failedBlock];
}

+ (void)bg_configGpsExtremeModeStatus:(BOOL)extremeMode
                             sucBlock:(void (^)(void))sucBlock
                          failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *commandString = (extremeMode ? @"ed01530101" : @"ed01530100");
    [self configDataWithTaskID:mk_bg_taskConfigGpsExtremeModeStatusOperation
                          data:commandString
                      sucBlock:sucBlock
                   failedBlock:failedBlock];
}

#pragma mark ****************************************设备lorawan信息设置************************************************

+ (void)bg_configRegion:(mk_bg_loraWanRegion)region
               sucBlock:(void (^)(void))sucBlock
            failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *commandString = [NSString stringWithFormat:@"%@%@",@"ed016001",[MKBGSDKDataAdopter lorawanRegionString:region]];
    [self configDataWithTaskID:mk_bg_taskConfigRegionOperation
                          data:commandString
                      sucBlock:sucBlock
                   failedBlock:failedBlock];
}

+ (void)bg_configModem:(mk_bg_loraWanModem)modem
              sucBlock:(void (^)(void))sucBlock
           failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *commandString = (modem == mk_bg_loraWanModemABP) ? @"ed01610101" : @"ed01610102";
    [self configDataWithTaskID:mk_bg_taskConfigModemOperation
                          data:commandString
                      sucBlock:sucBlock
                   failedBlock:failedBlock];
}

+ (void)bg_configDEVEUI:(NSString *)devEUI
               sucBlock:(void (^)(void))sucBlock
            failedBlock:(void (^)(NSError *error))failedBlock {
    if (!MKValidStr(devEUI) || devEUI.length != 16 || ![MKBLEBaseSDKAdopter checkHexCharacter:devEUI]) {
        [MKBLEBaseSDKAdopter operationParamsErrorBlock:failedBlock];
        return;
    }
    NSString *commandString = [@"ed016308" stringByAppendingString:devEUI];
    [self configDataWithTaskID:mk_bg_taskConfigDEVEUIOperation
                          data:commandString
                      sucBlock:sucBlock
                   failedBlock:failedBlock];
}

+ (void)bg_configAPPEUI:(NSString *)appEUI
               sucBlock:(void (^)(void))sucBlock
            failedBlock:(void (^)(NSError *error))failedBlock {
    if (!MKValidStr(appEUI) || appEUI.length != 16 || ![MKBLEBaseSDKAdopter checkHexCharacter:appEUI]) {
        [MKBLEBaseSDKAdopter operationParamsErrorBlock:failedBlock];
        return;
    }
    NSString *commandString = [@"ed016408" stringByAppendingString:appEUI];
    [self configDataWithTaskID:mk_bg_taskConfigAPPEUIOperation
                          data:commandString
                      sucBlock:sucBlock
                   failedBlock:failedBlock];
}

+ (void)bg_configAPPKEY:(NSString *)appKey
               sucBlock:(void (^)(void))sucBlock
            failedBlock:(void (^)(NSError *error))failedBlock {
    if (!MKValidStr(appKey) || appKey.length != 32 || ![MKBLEBaseSDKAdopter checkHexCharacter:appKey]) {
        [MKBLEBaseSDKAdopter operationParamsErrorBlock:failedBlock];
        return;
    }
    NSString *commandString = [@"ed016510" stringByAppendingString:appKey];
    [self configDataWithTaskID:mk_bg_taskConfigAPPKEYOperation
                          data:commandString
                      sucBlock:sucBlock
                   failedBlock:failedBlock];
}

+ (void)bg_configDEVADDR:(NSString *)devAddr
                sucBlock:(void (^)(void))sucBlock
             failedBlock:(void (^)(NSError *error))failedBlock {
    if (!MKValidStr(devAddr) || devAddr.length != 8 || ![MKBLEBaseSDKAdopter checkHexCharacter:devAddr]) {
        [MKBLEBaseSDKAdopter operationParamsErrorBlock:failedBlock];
        return;
    }
    NSString *commandString = [@"ed016604" stringByAppendingString:devAddr];
    [self configDataWithTaskID:mk_bg_taskConfigDEVADDROperation
                          data:commandString
                      sucBlock:sucBlock
                   failedBlock:failedBlock];
}

+ (void)bg_configAPPSKEY:(NSString *)appSkey
                sucBlock:(void (^)(void))sucBlock
             failedBlock:(void (^)(NSError *error))failedBlock {
    if (!MKValidStr(appSkey) || appSkey.length != 32 || ![MKBLEBaseSDKAdopter checkHexCharacter:appSkey]) {
        [MKBLEBaseSDKAdopter operationParamsErrorBlock:failedBlock];
        return;
    }
    NSString *commandString = [@"ed016710" stringByAppendingString:appSkey];
    [self configDataWithTaskID:mk_bg_taskConfigAPPSKEYOperation
                          data:commandString
                      sucBlock:sucBlock
                   failedBlock:failedBlock];
}

+ (void)bg_configNWKSKEY:(NSString *)nwkSkey
                sucBlock:(void (^)(void))sucBlock
             failedBlock:(void (^)(NSError *error))failedBlock {
    if (!MKValidStr(nwkSkey) || nwkSkey.length != 32 || ![MKBLEBaseSDKAdopter checkHexCharacter:nwkSkey]) {
        [MKBLEBaseSDKAdopter operationParamsErrorBlock:failedBlock];
        return;
    }
    NSString *commandString = [@"ed016810" stringByAppendingString:nwkSkey];
    [self configDataWithTaskID:mk_bg_taskConfigNWKSKEYOperation
                          data:commandString
                      sucBlock:sucBlock
                   failedBlock:failedBlock];
}

+ (void)bg_configMessageType:(mk_bg_loraWanMessageType)messageType
                    sucBlock:(void (^)(void))sucBlock
                 failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *commandString = (messageType == mk_bg_loraWanUnconfirmMessage) ? @"ed01690100" : @"ed01690101";
    [self configDataWithTaskID:mk_bg_taskConfigMessageTypeOperation
                          data:commandString
                      sucBlock:sucBlock
                   failedBlock:failedBlock];
}

+ (void)bg_configCHL:(NSInteger)chlValue
                 CHH:(NSInteger)chhValue
            sucBlock:(void (^)(void))sucBlock
         failedBlock:(void (^)(NSError *error))failedBlock {
    if (chlValue < 0 || chlValue > 95 || chhValue < chlValue || chhValue > 95) {
        [MKBLEBaseSDKAdopter operationParamsErrorBlock:failedBlock];
        return;
    }
    NSString *lowValue = [MKBLEBaseSDKAdopter fetchHexValue:chlValue byteLen:1];
    NSString *highValue = [MKBLEBaseSDKAdopter fetchHexValue:chhValue byteLen:1];
    NSString *commandString = [NSString stringWithFormat:@"%@%@%@",@"ed016a02",lowValue,highValue];
    [self configDataWithTaskID:mk_bg_taskConfigCHValueOperation
                          data:commandString
                      sucBlock:sucBlock
                   failedBlock:failedBlock];
}

+ (void)bg_configDR:(NSInteger)drValue
           sucBlock:(void (^)(void))sucBlock
        failedBlock:(void (^)(NSError *error))failedBlock {
    if (drValue < 0 || drValue > 15) {
        [MKBLEBaseSDKAdopter operationParamsErrorBlock:failedBlock];
        return;
    }
    NSString *value = [MKBLEBaseSDKAdopter fetchHexValue:drValue byteLen:1];
    NSString *commandString = [NSString stringWithFormat:@"%@%@",@"ed016b01",value];
    [self configDataWithTaskID:mk_bg_taskConfigDRValueOperation
                          data:commandString
                      sucBlock:sucBlock
                   failedBlock:failedBlock];
}

+ (void)bg_configUplinkStrategy:(BOOL)isOn
                          twice:(BOOL)twice
                            DRL:(NSInteger)DRL
                            DRH:(NSInteger)DRH
                       sucBlock:(void (^)(void))sucBlock
                    failedBlock:(void (^)(NSError *error))failedBlock {
    if (DRL < 0 || DRL > 15 || DRH < DRL || DRH > 15) {
        [MKBLEBaseSDKAdopter operationParamsErrorBlock:failedBlock];
        return;
    }
    NSString *lowValue = [MKBLEBaseSDKAdopter fetchHexValue:DRL byteLen:1];
    NSString *highValue = [MKBLEBaseSDKAdopter fetchHexValue:DRH byteLen:1];
    NSString *commandString = [NSString stringWithFormat:@"%@%@%@%@%@",@"ed016c04",(isOn ? @"01" : @"00"),(twice ? @"02" : @"01"),lowValue,highValue];
    [self configDataWithTaskID:mk_bg_taskConfigUplinkStrategyOperation
                          data:commandString
                      sucBlock:sucBlock
                   failedBlock:failedBlock];
}

+ (void)bg_configDutyCycleStatus:(BOOL)isOn
                        sucBlock:(void (^)(void))sucBlock
                     failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *commandString = (isOn ? @"ed016d0101" : @"ed016d0100");
    [self configDataWithTaskID:mk_bg_taskConfigDutyCycleStatusOperation
                          data:commandString
                      sucBlock:sucBlock
                   failedBlock:failedBlock];
}

+ (void)bg_configTimeSyncInterval:(NSInteger)interval
                         sucBlock:(void (^)(void))sucBlock
                      failedBlock:(void (^)(NSError *error))failedBlock {
    if (interval < 0 || interval > 255) {
        [MKBLEBaseSDKAdopter operationParamsErrorBlock:failedBlock];
        return;
    }
    NSString *value = [MKBLEBaseSDKAdopter fetchHexValue:interval byteLen:1];
    NSString *commandString = [@"ed016e01" stringByAppendingString:value];
    [self configDataWithTaskID:mk_bg_taskConfigTimeSyncIntervalOperation
                          data:commandString
                      sucBlock:sucBlock
                   failedBlock:failedBlock];
}

+ (void)bg_configReconnectInterval:(NSInteger)interval
                          sucBlock:(void (^)(void))sucBlock
                       failedBlock:(void (^)(NSError *error))failedBlock {
    if (interval < 0 || interval > 30) {
        [MKBLEBaseSDKAdopter operationParamsErrorBlock:failedBlock];
        return;
    }
    NSString *value = [MKBLEBaseSDKAdopter fetchHexValue:interval byteLen:1];
    NSString *commandString = [@"ed016f01" stringByAppendingString:value];
    [self configDataWithTaskID:mk_bg_taskConfigReconnectIntervalOperation
                          data:commandString
                      sucBlock:sucBlock
                   failedBlock:failedBlock];
}

#pragma mark ****************************************蓝牙参数读取************************************************

+ (void)bg_configBeaconModeStatus:(BOOL)isOn
                         sucBlock:(void (^)(void))sucBlock
                      failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *commandString = (isOn ? @"ed01700101" : @"ed01700100");
    [self configDataWithTaskID:mk_bg_taskConfigBeaconModeStatusOperation
                          data:commandString
                      sucBlock:sucBlock
                   failedBlock:failedBlock];
}

+ (void)bg_configBeaconAdvInterval:(NSInteger)interval
                          sucBlock:(void (^)(void))sucBlock
                       failedBlock:(void (^)(NSError *error))failedBlock {
    if (interval < 1 || interval > 100) {
        [MKBLEBaseSDKAdopter operationParamsErrorBlock:failedBlock];
        return;
    }
    NSString *value = [MKBLEBaseSDKAdopter fetchHexValue:interval byteLen:1];
    NSString *commandString = [@"ed017101" stringByAppendingString:value];
    [self configDataWithTaskID:mk_bg_taskConfigBeaconAdvIntervalOperation
                          data:commandString
                      sucBlock:sucBlock
                   failedBlock:failedBlock];
}

+ (void)bg_configDeviceConnectable:(BOOL)connectable
                          sucBlock:(void (^)(void))sucBlock
                       failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *commandString = (connectable ? @"ed01720101" : @"ed01720100");
    [self configDataWithTaskID:mk_bg_taskConfigDeviceConnectableOperation
                          data:commandString
                      sucBlock:sucBlock
                   failedBlock:failedBlock];
}

+ (void)bg_configDeviceBroadcastTimeout:(NSInteger)time
                               sucBlock:(void (^)(void))sucBlock
                            failedBlock:(void (^)(NSError *error))failedBlock {
    if (time < 1 || time > 60) {
        [MKBLEBaseSDKAdopter operationParamsErrorBlock:failedBlock];
        return;
    }
    NSString *value = [MKBLEBaseSDKAdopter fetchHexValue:time byteLen:1];
    NSString *commandString = [@"ed017301" stringByAppendingString:value];
    [self configDataWithTaskID:mk_bg_taskConfigDeviceBroadcastTimeoutOperation
                          data:commandString
                      sucBlock:sucBlock
                   failedBlock:failedBlock];
}

+ (void)bg_configBeaconProximityUUID:(NSString *)uuid
                            sucBlock:(void (^)(void))sucBlock
                         failedBlock:(void (^)(NSError *error))failedBlock {
    if (!MKValidStr(uuid) || uuid.length != 32 || ![MKBLEBaseSDKAdopter checkHexCharacter:uuid]) {
        [MKBLEBaseSDKAdopter operationParamsErrorBlock:failedBlock];
        return;
    }
    NSString *commandString = [@"ed017410" stringByAppendingString:uuid];
    [self configDataWithTaskID:mk_bg_taskConfigBeaconProximityUUIDOperation
                          data:commandString
                      sucBlock:sucBlock
                   failedBlock:failedBlock];
}

+ (void)bg_configMajor:(NSInteger)major
              sucBlock:(void (^)(void))sucBlock
           failedBlock:(void (^)(NSError *error))failedBlock {
    if (major < 0 || major > 65535) {
        [MKBLEBaseSDKAdopter operationParamsErrorBlock:failedBlock];
        return;
    }
    NSString *value = [MKBLEBaseSDKAdopter fetchHexValue:major byteLen:2];
    NSString *commandString = [@"ed017502" stringByAppendingString:value];
    [self configDataWithTaskID:mk_bg_taskConfigBeaconMajorOperation
                          data:commandString
                      sucBlock:sucBlock
                   failedBlock:failedBlock];
}

+ (void)bg_configMinor:(NSInteger)minor
              sucBlock:(void (^)(void))sucBlock
           failedBlock:(void (^)(NSError *error))failedBlock {
    if (minor < 0 || minor > 65535) {
        [MKBLEBaseSDKAdopter operationParamsErrorBlock:failedBlock];
        return;
    }
    NSString *value = [MKBLEBaseSDKAdopter fetchHexValue:minor byteLen:2];
    NSString *commandString = [@"ed017602" stringByAppendingString:value];
    [self configDataWithTaskID:mk_bg_taskConfigBeaconMinorOperation
                          data:commandString
                      sucBlock:sucBlock
                   failedBlock:failedBlock];
}

+ (void)bg_configMeasuredPower:(NSInteger)measuredPower
                      sucBlock:(void (^)(void))sucBlock
                   failedBlock:(void (^)(NSError *error))failedBlock {
    if (measuredPower > 0 || measuredPower < -127) {
        [MKBLEBaseSDKAdopter operationParamsErrorBlock:failedBlock];
        return;
    }
    NSString *power = [MKBLEBaseSDKAdopter hexStringFromSignedNumber:measuredPower];
    NSString *commandString = [@"ed017701" stringByAppendingString:power];
    [self configDataWithTaskID:mk_bg_taskConfigMeasuredPowerOperation
                          data:commandString
                      sucBlock:sucBlock
                   failedBlock:failedBlock];
}

+ (void)bg_configTxPower:(mk_bg_txPower)txPower
                sucBlock:(void (^)(void))sucBlock
             failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *value = [MKBGSDKDataAdopter fetchTxPower:txPower];
    NSString *commandString = [@"ed017801" stringByAppendingString:value];
    [self configDataWithTaskID:mk_bg_taskConfigTxPowerOperation
                          data:commandString
                      sucBlock:sucBlock
                   failedBlock:failedBlock];
}

+ (void)bg_configDeviceName:(NSString *)deviceName
                   sucBlock:(void (^)(void))sucBlock
                failedBlock:(void (^)(NSError *error))failedBlock {
    if (![deviceName isKindOfClass:NSString.class] || deviceName.length > 13) {
        [MKBLEBaseSDKAdopter operationParamsErrorBlock:failedBlock];
        return;
    }
    NSString *tempString = @"";
    for (NSInteger i = 0; i < deviceName.length; i ++) {
        int asciiCode = [deviceName characterAtIndex:i];
        tempString = [tempString stringByAppendingString:[NSString stringWithFormat:@"%1lx",(unsigned long)asciiCode]];
    }
    NSString *lenString = [NSString stringWithFormat:@"%1lx",(long)deviceName.length];
    if (lenString.length == 1) {
        lenString = [@"0" stringByAppendingString:lenString];
    }
    NSString *commandString = [NSString stringWithFormat:@"ed0179%@%@",lenString,tempString];
    [self configDataWithTaskID:mk_bg_taskConfigDeviceNameOperation
                          data:commandString
                      sucBlock:sucBlock
                   failedBlock:failedBlock];
}

+ (void)bg_configScanningPHYType:(mk_bg_PHYMode)mode
                        sucBlock:(void (^)(void))sucBlock
                     failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *type = [MKBGSDKDataAdopter fetchPHYTypeString:mode];
    NSString *commandString = [@"ed017a01" stringByAppendingString:type];
    [self configDataWithTaskID:mk_bg_taskConfigScanningPHYTypeOperation
                          data:commandString
                      sucBlock:sucBlock
                   failedBlock:failedBlock];
}

#pragma mark ****************************************辅助功能参数配置************************************************

+ (void)bg_configThreeAxisWakeupConditions:(NSInteger)threshold
                                  duration:(NSInteger)duration
                                  sucBlock:(void (^)(void))sucBlock
                               failedBlock:(void (^)(NSError *error))failedBlock {
    if (threshold < 1 || threshold > 20 || duration < 1 || duration > 10) {
        [MKBLEBaseSDKAdopter operationParamsErrorBlock:failedBlock];
        return;
    }
    NSString *thresholdString = [MKBLEBaseSDKAdopter fetchHexValue:threshold byteLen:1];
    NSString *durationString = [MKBLEBaseSDKAdopter fetchHexValue:duration byteLen:1];
    NSString *commandString = [NSString stringWithFormat:@"%@%@%@",@"ed018002",thresholdString,durationString];
    [self configDataWithTaskID:mk_bg_taskConfigThreeAxisWakeupConditionsOperation
                          data:commandString
                      sucBlock:sucBlock
                   failedBlock:failedBlock];
}

+ (void)bg_configThreeAxisMotionParameters:(NSInteger)threshold
                                  duration:(NSInteger)duration
                                  sucBlock:(void (^)(void))sucBlock
                               failedBlock:(void (^)(NSError *error))failedBlock {
    if (threshold < 10 || threshold > 250 || duration < 1 || duration > 50) {
        [MKBLEBaseSDKAdopter operationParamsErrorBlock:failedBlock];
        return;
    }
    NSString *thresholdString = [MKBLEBaseSDKAdopter fetchHexValue:threshold byteLen:1];
    NSString *durationString = [MKBLEBaseSDKAdopter fetchHexValue:duration byteLen:1];
    NSString *commandString = [NSString stringWithFormat:@"%@%@%@",@"ed018102",thresholdString,durationString];
    [self configDataWithTaskID:mk_bg_taskConfigThreeAxisMotionParametersOperation
                          data:commandString
                      sucBlock:sucBlock
                   failedBlock:failedBlock];
}

+ (void)bg_configVibrationDetectionStatus:(BOOL)isOn
                                 sucBlock:(void (^)(void))sucBlock
                              failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *commandString = (isOn ? @"ed01820101" : @"ed01820100");
    [self configDataWithTaskID:mk_bg_taskConfigVibrationDetectionStatusOperation
                          data:commandString
                      sucBlock:sucBlock
                   failedBlock:failedBlock];
}

+ (void)bg_configVibrationThresholds:(NSInteger)threshold
                            sucBlock:(void (^)(void))sucBlock
                         failedBlock:(void (^)(NSError *error))failedBlock {
    if (threshold < 10 || threshold > 255) {
        [MKBLEBaseSDKAdopter operationParamsErrorBlock:failedBlock];
        return;
    }
    NSString *thresholdString = [MKBLEBaseSDKAdopter fetchHexValue:threshold byteLen:1];
    NSString *commandString = [@"ed018301" stringByAppendingString:thresholdString];
    [self configDataWithTaskID:mk_bg_taskConfigVibrationThresholdsOperation
                          data:commandString
                      sucBlock:sucBlock
                   failedBlock:failedBlock];
}

+ (void)bg_configVibrationDetectionReportInterval:(NSInteger)interval
                                         sucBlock:(void (^)(void))sucBlock
                                      failedBlock:(void (^)(NSError *error))failedBlock {
    if (interval < 3 || interval > 255) {
        [MKBLEBaseSDKAdopter operationParamsErrorBlock:failedBlock];
        return;
    }
    NSString *intervalString = [MKBLEBaseSDKAdopter fetchHexValue:interval byteLen:1];
    NSString *commandString = [@"ed018401" stringByAppendingString:intervalString];
    [self configDataWithTaskID:mk_bg_taskConfigVibrationDetectionReportIntervalOperation
                          data:commandString
                      sucBlock:sucBlock
                   failedBlock:failedBlock];
}

+ (void)bg_configVibrationTimeout:(NSInteger)interval
                         sucBlock:(void (^)(void))sucBlock
                      failedBlock:(void (^)(NSError *error))failedBlock {
    if (interval < 1 || interval > 20) {
        [MKBLEBaseSDKAdopter operationParamsErrorBlock:failedBlock];
        return;
    }
    NSString *intervalString = [MKBLEBaseSDKAdopter fetchHexValue:interval byteLen:1];
    NSString *commandString = [@"ed018501" stringByAppendingString:intervalString];
    [self configDataWithTaskID:mk_bg_taskConfigVibrationTimeoutOperation
                          data:commandString
                      sucBlock:sucBlock
                   failedBlock:failedBlock];
}

+ (void)bg_configManDownDetectionStatus:(BOOL)isOn
                               sucBlock:(void (^)(void))sucBlock
                            failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *commandString = (isOn ? @"ed01860101" : @"ed01860100");
    [self configDataWithTaskID:mk_bg_taskConfigManDownDetectionStatusOperation
                          data:commandString
                      sucBlock:sucBlock
                   failedBlock:failedBlock];
}

+ (void)bg_configIdleDetectionTimeout:(NSInteger)interval
                             sucBlock:(void (^)(void))sucBlock
                          failedBlock:(void (^)(NSError *error))failedBlock {
    if (interval < 1 || interval > 8760) {
        [MKBLEBaseSDKAdopter operationParamsErrorBlock:failedBlock];
        return;
    }
    NSString *intervalString = [MKBLEBaseSDKAdopter fetchHexValue:interval byteLen:2];
    NSString *commandString = [@"ed018702" stringByAppendingString:intervalString];
    [self configDataWithTaskID:mk_bg_taskConfigIdleDetectionTimeoutOperation
                          data:commandString
                      sucBlock:sucBlock
                   failedBlock:failedBlock];
}

+ (void)bg_configTamperAlarm:(BOOL)isOn
                    sucBlock:(void (^)(void))sucBlock
                 failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *commandString = (isOn ? @"ed01880101" : @"ed01880100");
    [self configDataWithTaskID:mk_bg_taskConfigTamperAlarmStatusOperation
                          data:commandString
                      sucBlock:sucBlock
                   failedBlock:failedBlock];
}

+ (void)bg_configActiveStateCountStatus:(BOOL)isOn
                               sucBlock:(void (^)(void))sucBlock
                            failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *commandString = (isOn ? @"ed01890101" : @"ed01890100");
    [self configDataWithTaskID:mk_bg_taskConfigActiveStateCountStatusOperation
                          data:commandString
                      sucBlock:sucBlock
                   failedBlock:failedBlock];
}

+ (void)bg_configActiveStateTimeout:(long long)interval
                           sucBlock:(void (^)(void))sucBlock
                        failedBlock:(void (^)(NSError *error))failedBlock {
    if (interval < 1 || interval > 86400) {
        [MKBLEBaseSDKAdopter operationParamsErrorBlock:failedBlock];
        return;
    }
    NSString *intervalString = [MKBLEBaseSDKAdopter fetchHexValue:interval byteLen:4];
    NSString *commandString = [@"ed018a04" stringByAppendingString:intervalString];
    [self configDataWithTaskID:mk_bg_taskConfigActiveStateTimeoutOperation
                          data:commandString
                      sucBlock:sucBlock
                   failedBlock:failedBlock];
}

+ (void)bg_configIdleStutasResetWithSucBlock:(void (^)(void))sucBlock
                                 failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *commandString = @"ed018b00";
    [self configDataWithTaskID:mk_bg_taskConfigIdleStutasResetOperation
                          data:commandString
                      sucBlock:sucBlock
                   failedBlock:failedBlock];
}

#pragma mark ****************************************存储数据协议************************************************

+ (void)bg_readNumberOfDaysStoredData:(NSInteger)days
                             sucBlock:(void (^)(void))sucBlock
                          failedBlock:(void (^)(NSError *error))failedBlock {
    if (days < 1 || days > 65535) {
        [MKBLEBaseSDKAdopter operationParamsErrorBlock:failedBlock];
        return;
    }
    NSString *value = [MKBLEBaseSDKAdopter fetchHexValue:days byteLen:2];
    NSString *commandString = [@"ed01a002" stringByAppendingString:value];
    [self configDataWithTaskID:mk_bg_taskReadNumberOfDaysStoredDataOperation
                          data:commandString
                      sucBlock:sucBlock
                   failedBlock:failedBlock];
}

+ (void)bg_clearAllDatasWithSucBlock:(void (^)(void))sucBlock
                         failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *commandString = @"ed01a100";
    [self configDataWithTaskID:mk_bg_taskClearAllDatasOperation
                          data:commandString
                      sucBlock:sucBlock
                   failedBlock:failedBlock];
}

+ (void)bg_pauseSendLocalData:(BOOL)pause
                     sucBlock:(void (^)(void))sucBlock
                  failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *commandString = (pause ? @"ed01a20100" : @"ed01a20101");
    [self configDataWithTaskID:mk_bg_taskPauseSendLocalDataOperation
                          data:commandString
                      sucBlock:sucBlock
                   failedBlock:failedBlock];
}

#pragma mark - private method
+ (void)configDataWithTaskID:(mk_bg_taskOperationID)taskID
                        data:(NSString *)data
                    sucBlock:(void (^)(void))sucBlock
                 failedBlock:(void (^)(NSError *error))failedBlock {
    [centralManager addTaskWithTaskID:taskID characteristic:centralManager.peripheral.bg_custom commandData:data successBlock:^(id  _Nonnull returnData) {
        BOOL success = [returnData[@"result"][@"success"] boolValue];
        if (!success) {
            [MKBLEBaseSDKAdopter operationSetParamsErrorBlock:failedBlock];
            return ;
        }
        if (sucBlock) {
            sucBlock();
        }
    } failureBlock:failedBlock];
}

@end
