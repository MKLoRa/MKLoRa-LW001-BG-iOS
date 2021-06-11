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
        [self operationParamsErrorBlock:failedBlock];
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
        [self operationParamsErrorBlock:failedBlock];
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

+ (void)bg_configHeartbeatInterval:(long long)interval
                          sucBlock:(void (^)(void))sucBlock
                       failedBlock:(void (^)(NSError *error))failedBlock {
    if (interval < 300 || interval > 86400) {
        [self operationParamsErrorBlock:failedBlock];
        return;
    }
    NSString *timeString = [NSString stringWithFormat:@"%1lx",interval];
    if (timeString.length == 1) {
        timeString = [@"0000000" stringByAppendingString:timeString];
    }else if (timeString.length == 2) {
        timeString = [@"000000" stringByAppendingString:timeString];
    }else if (timeString.length == 3) {
        timeString = [@"00000" stringByAppendingString:timeString];
    }else if (timeString.length == 4) {
        timeString = [@"0000" stringByAppendingString:timeString];
    }else if (timeString.length == 5) {
        timeString = [@"000" stringByAppendingString:timeString];
    }else if (timeString.length == 6) {
        timeString = [@"00" stringByAppendingString:timeString];
    }else if (timeString.length == 7) {
        timeString = [@"0" stringByAppendingString:timeString];
    }
    NSString *commandString = [@"ed010804" stringByAppendingString:timeString];
    [self configDataWithTaskID:mk_bg_taskConfigHeartbeatIntervalOperation
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
        [self operationParamsErrorBlock:failedBlock];
        return;
    }
    NSString *value = [MKBGSDKDataAdopter fetchHexValue:interval byteLen:4];
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
        [self operationParamsErrorBlock:failedBlock];
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
    NSString *cmdValue = [MKBGSDKDataAdopter getHexByBinary:resultValue];
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
        [self operationParamsErrorBlock:failedBlock];
        return;
    }
    NSString *value = [MKBGSDKDataAdopter fetchHexValue:number byteLen:1];
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
        [self operationParamsErrorBlock:failedBlock];
        return;
    }
    NSString *value = [MKBGSDKDataAdopter fetchHexValue:interval byteLen:4];
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
        [self operationParamsErrorBlock:failedBlock];
        return;
    }
    NSString *value = [MKBGSDKDataAdopter fetchHexValue:time byteLen:1];
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
        [self operationParamsErrorBlock:failedBlock];
        return;
    }
    NSString *value = [MKBGSDKDataAdopter fetchHexValue:number byteLen:1];
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
        [self operationParamsErrorBlock:failedBlock];
        return;
    }
    NSString *value = [MKBGSDKDataAdopter fetchHexValue:interval byteLen:2];
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
        [self operationParamsErrorBlock:failedBlock];
        return;
    }
    NSString *value = [NSString stringWithFormat:@"%1lx",(unsigned long)interval];
    if (value.length == 1) {
        value = [@"0" stringByAppendingString:value];
    }
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
        [self operationParamsErrorBlock:failedBlock];
        return;
    }
    NSString *value = [NSString stringWithFormat:@"%1lx",(unsigned long)number];
    if (value.length == 1) {
        value = [@"0" stringByAppendingString:value];
    }
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
        [self operationParamsErrorBlock:failedBlock];
        return;
    }
    NSString *value = [NSString stringWithFormat:@"%1lx",(unsigned long)interval];
    if (value.length == 1) {
        value = [@"0" stringByAppendingString:value];
    }
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
        [self operationParamsErrorBlock:failedBlock];
        return;
    }
    NSString *value = [NSString stringWithFormat:@"%1lx",(unsigned long)number];
    if (value.length == 1) {
        value = [@"0" stringByAppendingString:value];
    }
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
        [self operationParamsErrorBlock:failedBlock];
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
    
    NSString *lenString = [NSString stringWithFormat:@"%1lx",(long)(deviceName.length + 1)];
    if (lenString.length == 1) {
        lenString = [@"0" stringByAppendingString:lenString];
    }
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
        [self operationParamsErrorBlock:failedBlock];
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
        [self operationParamsErrorBlock:failedBlock];
        return;
    }
    NSString *minString = [NSString stringWithFormat:@"%1lx",(unsigned long)majorMin];
    if (minString.length == 1) {
        minString = [@"000" stringByAppendingString:minString];
    }else if (minString.length == 2) {
        minString = [@"00" stringByAppendingString:minString];
    }else if (minString.length == 3) {
        minString = [@"0" stringByAppendingString:minString];
    }
    NSString *maxString = [NSString stringWithFormat:@"%1lx",(unsigned long)majorMax];
    if (maxString.length == 1) {
        maxString = [@"000" stringByAppendingString:maxString];
    }else if (maxString.length == 2) {
        maxString = [@"00" stringByAppendingString:maxString];
    }else if (maxString.length == 3) {
        maxString = [@"0" stringByAppendingString:maxString];
    }
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
        [self operationParamsErrorBlock:failedBlock];
        return;
    }
    NSString *minString = [NSString stringWithFormat:@"%1lx",(unsigned long)minorMin];
    if (minString.length == 1) {
        minString = [@"000" stringByAppendingString:minString];
    }else if (minString.length == 2) {
        minString = [@"00" stringByAppendingString:minString];
    }else if (minString.length == 3) {
        minString = [@"0" stringByAppendingString:minString];
    }
    NSString *maxString = [NSString stringWithFormat:@"%1lx",(unsigned long)minorMax];
    if (maxString.length == 1) {
        maxString = [@"000" stringByAppendingString:maxString];
    }else if (maxString.length == 2) {
        maxString = [@"00" stringByAppendingString:maxString];
    }else if (maxString.length == 3) {
        maxString = [@"0" stringByAppendingString:maxString];
    }
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
        [self operationParamsErrorBlock:failedBlock];
        return;
    }
    NSString *contentData = @"";
    for (id <mk_bg_BLEFilterRawDataProtocol>protocol in rawDataList) {
        if (![MKBGSDKDataAdopter isConfirmRawFilterProtocol:protocol]) {
            [self operationParamsErrorBlock:failedBlock];
            return;
        }
        NSString *minIndex = [NSString stringWithFormat:@"%1lx",(unsigned long)protocol.minIndex];
        if (minIndex.length == 1) {
            minIndex = [@"0" stringByAppendingString:minIndex];
        }
        NSString *maxIndex = [NSString stringWithFormat:@"%1lx",(unsigned long)protocol.maxIndex];
        if (maxIndex.length == 1) {
            maxIndex = [@"0" stringByAppendingString:maxIndex];
        }
        NSString *lenString = [NSString stringWithFormat:@"%1lx",(unsigned long)(protocol.rawData.length / 2 + 3)];
        if (lenString.length == 1) {
            lenString = [@"0" stringByAppendingString:lenString];
        }
        NSString *conditionString = [NSString stringWithFormat:@"%@%@%@%@%@",lenString,protocol.dataType,minIndex,maxIndex,protocol.rawData];
        contentData = [contentData stringByAppendingString:conditionString];
    }
    NSString *lenString = [NSString stringWithFormat:@"%1lx",(long)((contentData.length / 2) + 1)];
    if (lenString.length == 1) {
        lenString = [@"0" stringByAppendingString:lenString];
    }
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
        [self operationParamsErrorBlock:failedBlock];
        return;
    }
    NSString *lenString = [NSString stringWithFormat:@"%1lx",(long)((uuid.length / 2) + 1)];
    if (lenString.length == 1) {
        lenString = [@"0" stringByAppendingString:lenString];
    }
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
        [self operationParamsErrorBlock:failedBlock];
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

+ (void)bg_configBLEFilterDeviceByPHYWithType:(mk_bg_filterRulesType)type
                                         isOn:(BOOL)isOn
                                      phyMode:(mk_bg_filterByPHYMode)phyMode
                                     sucBlock:(void (^)(void))sucBlock
                                  failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *data = @"";
    NSString *lenString = @"";
    if (isOn) {
        if (phyMode == mk_bg_filterByPHYMode_1MPHY) {
            data = @"0100";
        }else if (phyMode == mk_bg_filterByPHYMode_2MPHY) {
            data = @"0101";
        }else {
            data = @"0102";
        }
        lenString = @"02";
    }else {
        data = @"00";
        lenString = @"01";
    }
    NSString *typeString = (type == mk_bg_filterRulesClassAType ? @"3d" : @"46");
    mk_bg_taskOperationID taskID = (type == mk_bg_filterRulesClassAType ? mk_bg_taskConfigBLEFilterAByPHYOperation : mk_bg_taskConfigBLEFilterBByPHYOperation);
    NSString *commandString = [NSString stringWithFormat:@"%@%@%@%@",@"ed01",typeString,lenString,data];
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
        [self operationParamsErrorBlock:failedBlock];
        return;
    }
    NSString *timeString = [NSString stringWithFormat:@"%1lx",(long)time];
    if (timeString.length == 1) {
        timeString = [@"0" stringByAppendingString:timeString];
    }
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
        [self operationParamsErrorBlock:failedBlock];
        return;
    }
    NSString *valueString = [NSString stringWithFormat:@"%1lx",(long)value];
    if (valueString.length == 1) {
        valueString = [@"0" stringByAppendingString:valueString];
    }
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
        [self operationParamsErrorBlock:failedBlock];
        return;
    }
    NSString *valueString = [NSString stringWithFormat:@"%1lx",(long)value];
    if (valueString.length == 1) {
        valueString = [@"0" stringByAppendingString:valueString];
    }
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
        [self operationParamsErrorBlock:failedBlock];
        return;
    }
    NSString *timeString = [NSString stringWithFormat:@"%1lx",(long)time];
    if (timeString.length == 1) {
        timeString = [@"000" stringByAppendingString:timeString];
    }else if (timeString.length == 2) {
        timeString = [@"00" stringByAppendingString:timeString];
    }else if (timeString.length == 3) {
        timeString = [@"0" stringByAppendingString:timeString];
    }
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
        [self operationParamsErrorBlock:failedBlock];
        return;
    }
    NSString *timeString = [NSString stringWithFormat:@"%1lx",time];
    if (timeString.length == 1) {
        timeString = [@"0000000" stringByAppendingString:timeString];
    }else if (timeString.length == 2) {
        timeString = [@"000000" stringByAppendingString:timeString];
    }else if (timeString.length == 3) {
        timeString = [@"00000" stringByAppendingString:timeString];
    }else if (timeString.length == 4) {
        timeString = [@"0000" stringByAppendingString:timeString];
    }else if (timeString.length == 5) {
        timeString = [@"000" stringByAppendingString:timeString];
    }else if (timeString.length == 6) {
        timeString = [@"00" stringByAppendingString:timeString];
    }else if (timeString.length == 7) {
        timeString = [@"0" stringByAppendingString:timeString];
    }
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
        [self operationParamsErrorBlock:failedBlock];
        return;
    }
    NSString *valueString = [NSString stringWithFormat:@"%1lx",(long)value];
    if (valueString.length == 1) {
        valueString = [@"0" stringByAppendingString:valueString];
    }
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
        [self operationParamsErrorBlock:failedBlock];
        return;
    }
    NSString *timeString = [NSString stringWithFormat:@"%1lx",time];
    if (timeString.length == 1) {
        timeString = [@"0000000" stringByAppendingString:timeString];
    }else if (timeString.length == 2) {
        timeString = [@"000000" stringByAppendingString:timeString];
    }else if (timeString.length == 3) {
        timeString = [@"00000" stringByAppendingString:timeString];
    }else if (timeString.length == 4) {
        timeString = [@"0000" stringByAppendingString:timeString];
    }else if (timeString.length == 5) {
        timeString = [@"000" stringByAppendingString:timeString];
    }else if (timeString.length == 6) {
        timeString = [@"00" stringByAppendingString:timeString];
    }else if (timeString.length == 7) {
        timeString = [@"0" stringByAppendingString:timeString];
    }
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
        [self operationParamsErrorBlock:failedBlock];
        return;
    }
    NSString *valueString = [NSString stringWithFormat:@"%1lx",(long)value];
    if (valueString.length == 1) {
        valueString = [@"000" stringByAppendingString:valueString];
    }else if (valueString.length == 2) {
        valueString = [@"00" stringByAppendingString:valueString];
    }else if (valueString.length == 3) {
        valueString = [@"0" stringByAppendingString:valueString];
    }
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
        [self operationParamsErrorBlock:failedBlock];
        return;
    }
    NSString *timeString = [NSString stringWithFormat:@"%1lx",(long)time];
    if (timeString.length == 1) {
        timeString = [@"000" stringByAppendingString:timeString];
    }else if (timeString.length == 2) {
        timeString = [@"00" stringByAppendingString:timeString];
    }else if (timeString.length == 3) {
        timeString = [@"0" stringByAppendingString:timeString];
    }
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
        [self operationParamsErrorBlock:failedBlock];
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
        [self operationParamsErrorBlock:failedBlock];
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
        [self operationParamsErrorBlock:failedBlock];
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
        [self operationParamsErrorBlock:failedBlock];
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
        [self operationParamsErrorBlock:failedBlock];
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
        [self operationParamsErrorBlock:failedBlock];
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
        [self operationParamsErrorBlock:failedBlock];
        return;
    }
    NSString *lowValue = [NSString stringWithFormat:@"%1lx",(unsigned long)chlValue];
    if (lowValue.length == 1) {
        lowValue = [@"0" stringByAppendingString:lowValue];
    }
    NSString *highValue = [NSString stringWithFormat:@"%1lx",(unsigned long)chhValue];
    if (highValue.length == 1) {
        highValue = [@"0" stringByAppendingString:highValue];
    }
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
        [self operationParamsErrorBlock:failedBlock];
        return;
    }
    NSString *value = [NSString stringWithFormat:@"%1lx",(unsigned long)drValue];
    if (value.length == 1) {
        value = [@"0" stringByAppendingString:value];
    }
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
        [self operationParamsErrorBlock:failedBlock];
        return;
    }
    NSString *lowValue = [NSString stringWithFormat:@"%1lx",(unsigned long)DRL];
    if (lowValue.length == 1) {
        lowValue = [@"0" stringByAppendingString:lowValue];
    }
    NSString *highValue = [NSString stringWithFormat:@"%1lx",(unsigned long)DRH];
    if (highValue.length == 1) {
        highValue = [@"0" stringByAppendingString:highValue];
    }
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
        [self operationParamsErrorBlock:failedBlock];
        return;
    }
    NSString *value = [NSString stringWithFormat:@"%1lx",(unsigned long)interval];
    if (value.length == 1) {
        value = [@"0" stringByAppendingString:value];
    }
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
        [self operationParamsErrorBlock:failedBlock];
        return;
    }
    NSString *value = [NSString stringWithFormat:@"%1lx",(unsigned long)interval];
    if (value.length == 1) {
        value = [@"0" stringByAppendingString:value];
    }
    NSString *commandString = [@"ed016f01" stringByAppendingString:value];
    [self configDataWithTaskID:mk_bg_taskConfigReconnectIntervalOperation
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
            [self operationSetParamsErrorBlock:failedBlock];
            return ;
        }
        if (sucBlock) {
            sucBlock();
        }
    } failureBlock:failedBlock];
}

+ (void)operationParamsErrorBlock:(void (^)(NSError *error))block {
    MKBLEBase_main_safe(^{
        if (block) {
            NSError *error = [MKBLEBaseSDKAdopter getErrorWithCode:-999 message:@"Params error"];
            block(error);
        }
    });
}

+ (void)operationSetParamsErrorBlock:(void (^)(NSError *error))block{
    MKBLEBase_main_safe(^{
        if (block) {
            NSError *error = [MKBLEBaseSDKAdopter getErrorWithCode:-10001 message:@"Set parameter error"];
            block(error);
        }
    });
}

@end
