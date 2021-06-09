//
//  MKBGGpsPositionDataModel.m
//  MKLoRaWAN-BG_Example
//
//  Created by aa on 2021/5/21.
//  Copyright © 2021 aadyx2007@163.com. All rights reserved.
//

#import "MKBGGpsPositionDataModel.h"

#import "MKMacroDefines.h"
#import "NSObject+MKModel.h"
#import "NSString+MKAdd.h"

#import "MKBGInterface.h"
#import "MKBGInterface+MKBGConfig.h"

@interface MKBGGpsPositionDataModel ()

@property (nonatomic, strong)dispatch_queue_t readQueue;

@property (nonatomic, strong)dispatch_semaphore_t semaphore;

@end

@implementation MKBGGpsPositionDataModel

- (void)readWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock {
    dispatch_async(self.readQueue, ^{
        if (![self readColdStardTimeout]) {
            [self operationFailedBlockWithMsg:@"Read Cold Stard Timeout Error" block:failedBlock];
            return;
        }
        if (![self readCoarseAccuracyMask]) {
            [self operationFailedBlockWithMsg:@"Read Coarse Accuracy Mask Error" block:failedBlock];
            return;
        }
        if (![self readCoarseTimeout]) {
            [self operationFailedBlockWithMsg:@"Read Coarse Timeout Error" block:failedBlock];
            return;
        }
        if (![self readFineAccuracyTarget]) {
            [self operationFailedBlockWithMsg:@"Read Fine Accuracy Target Error" block:failedBlock];
            return;
        }
        if (![self readFineTimeout]) {
            [self operationFailedBlockWithMsg:@"Read Fine Timeout Error" block:failedBlock];
            return;
        }
        if (![self readPDOPLimit]) {
            [self operationFailedBlockWithMsg:@"Read PDOP Limit Error" block:failedBlock];
            return;
        }
        if (![self readAutonomousAiding]) {
            [self operationFailedBlockWithMsg:@"Read Autonomous Aiding Error" block:failedBlock];
            return;
        }
        if (![self readAdingAccuracy]) {
            [self operationFailedBlockWithMsg:@"Read Ading Accuracy Error" block:failedBlock];
            return;
        }
        if (![self readAidingTimeout]) {
            [self operationFailedBlockWithMsg:@"Read Aiding Timeout Error" block:failedBlock];
            return;
        }
        if (![self readFixMode]) {
            [self operationFailedBlockWithMsg:@"Read Fix Mode Error" block:failedBlock];
            return;
        }
        if (![self readGpsMode]) {
            [self operationFailedBlockWithMsg:@"Read GPS Model Error" block:failedBlock];
            return;
        }
        if (![self readTimeBudget]) {
            [self operationFailedBlockWithMsg:@"Read Time Budget Error" block:failedBlock];
            return;
        }
        if (![self readExtremeMode]) {
            [self operationFailedBlockWithMsg:@"Read Extreme mode Error" block:failedBlock];
            return;
        }
        moko_dispatch_main_safe(^{
            if (sucBlock) {
                sucBlock();
            }
        });
    });
}

- (void)configWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock {
    dispatch_async(self.readQueue, ^{
        if (![self validParams]) {
            [self operationFailedBlockWithMsg:@"Opps！Save failed. Please check the input characters and try again." block:failedBlock];
            return ;
        }
        if (![self configColdStardTimeout]) {
            [self operationFailedBlockWithMsg:@"Config Cold Stard Timeout Error" block:failedBlock];
            return;
        }
        if (![self configCoarseAccuracyMask]) {
            [self operationFailedBlockWithMsg:@"Config Coarse Accuracy Mask Error" block:failedBlock];
            return;
        }
        if (![self configCoarseTimeout]) {
            [self operationFailedBlockWithMsg:@"Config Coarse Timeout Error" block:failedBlock];
            return;
        }
        if (![self configFineAccuracyTarget]) {
            [self operationFailedBlockWithMsg:@"Config Fine Accuracy Target Error" block:failedBlock];
            return;
        }
        if (![self configFineTimeout]) {
            [self operationFailedBlockWithMsg:@"Config Fine Timeout Error" block:failedBlock];
            return;
        }
        if (![self configPDOPLimit]) {
            [self operationFailedBlockWithMsg:@"Config PDOP Limit Error" block:failedBlock];
            return;
        }
//        if (![self configAutonomousAiding]) {
//            [self operationFailedBlockWithMsg:@"Config Autonomous Aiding Error" block:failedBlock];
//            return;
//        }
        if (![self configAdingAccuracy]) {
            [self operationFailedBlockWithMsg:@"Config Ading Accuracy Error" block:failedBlock];
            return;
        }
        if (![self configAidingTimeout]) {
            [self operationFailedBlockWithMsg:@"Config Aiding Timeout Error" block:failedBlock];
            return;
        }
        if (![self configFixMode]) {
            [self operationFailedBlockWithMsg:@"Config Fix Mode Error" block:failedBlock];
            return;
        }
        if (![self configGpsMode]) {
            [self operationFailedBlockWithMsg:@"Config GPS Model Error" block:failedBlock];
            return;
        }
        if (![self configTimeBudget]) {
            [self operationFailedBlockWithMsg:@"Config Time Budget Error" block:failedBlock];
            return;
        }
//        if (![self configExtremeMode]) {
//            [self operationFailedBlockWithMsg:@"Config Extreme mode Error" block:failedBlock];
//            return;
//        }
        moko_dispatch_main_safe(^{
            if (sucBlock) {
                sucBlock();
            }
        });
    });
}

#pragma mark - interface
- (BOOL)readColdStardTimeout {
    __block BOOL success = NO;
    [MKBGInterface bg_readGpsColdStardTimeWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.coldStardTime = returnData[@"result"][@"time"];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)configColdStardTimeout {
    __block BOOL success = NO;
    [MKBGInterface bg_configGpsColdStardTime:[self.coldStardTime integerValue] sucBlock:^{
        success = YES;
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)readCoarseAccuracyMask {
    __block BOOL success = NO;
    [MKBGInterface bg_readGpsCoarseAccuracyMaskWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.coarseAccuracyMask = returnData[@"result"][@"value"];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)configCoarseAccuracyMask {
    __block BOOL success = NO;
    [MKBGInterface bg_configGpsCoarseAccuracyMask:[self.coarseAccuracyMask integerValue] sucBlock:^{
        success = YES;
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)readCoarseTimeout {
    __block BOOL success = NO;
    [MKBGInterface bg_readGpsCoarseTimeWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.coarseTime = returnData[@"result"][@"time"];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)configCoarseTimeout {
    __block BOOL success = NO;
    [MKBGInterface bg_configGpsCoarseTime:[self.coarseTime integerValue] sucBlock:^{
        success = YES;
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)readFineAccuracyTarget {
    __block BOOL success = NO;
    [MKBGInterface bg_readGpsFineAccuracyTargetWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.fineAccuracyTarget = returnData[@"result"][@"value"];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)configFineAccuracyTarget {
    __block BOOL success = NO;
    [MKBGInterface bg_configGpsFineAccuracyTarget:[self.fineAccuracyTarget integerValue] sucBlock:^{
        success = YES;
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)readFineTimeout {
    __block BOOL success = NO;
    [MKBGInterface bg_readGpsFineTimeWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.fineTime = returnData[@"result"][@"time"];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)configFineTimeout {
    __block BOOL success = NO;
    [MKBGInterface bg_configGpsFineTime:[self.fineTime integerValue] sucBlock:^{
        success = YES;
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)readPDOPLimit {
    __block BOOL success = NO;
    [MKBGInterface bg_readGpsPDOPLimitWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.PDOPLimit = returnData[@"result"][@"value"];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)configPDOPLimit {
    __block BOOL success = NO;
    [MKBGInterface bg_configGpsPDOPLimit:[self.PDOPLimit integerValue] sucBlock:^{
        success = YES;
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)readAutonomousAiding {
    __block BOOL success = NO;
    [MKBGInterface bg_readGpsAutonomousAidingStatusWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.autonomousAiding = [returnData[@"result"][@"isOn"] boolValue];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)configAutonomousAiding {
    __block BOOL success = NO;
    [MKBGInterface bg_configGpsAutonomousAidingStatus:self.autonomousAiding sucBlock:^{
        success = YES;
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)readAdingAccuracy {
    __block BOOL success = NO;
    [MKBGInterface bg_readGpsAdingAccuracyWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.adingAccuracy = returnData[@"result"][@"value"];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)configAdingAccuracy {
    __block BOOL success = NO;
    [MKBGInterface bg_configGpsAdingAccuracy:[self.adingAccuracy integerValue] sucBlock:^{
        success = YES;
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)readAidingTimeout {
    __block BOOL success = NO;
    [MKBGInterface bg_readGpsAidingTimeWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.aidingTime = returnData[@"result"][@"time"];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)configAidingTimeout {
    __block BOOL success = NO;
    [MKBGInterface bg_configGpsAidingTime:[self.aidingTime integerValue] sucBlock:^{
        success = YES;
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)readFixMode {
    __block BOOL success = NO;
    [MKBGInterface bg_readGpsFixModeWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.fixMode = [returnData[@"result"][@"type"] integerValue];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)configFixMode {
    __block BOOL success = NO;
    [MKBGInterface bg_configGpsFixMode:self.fixMode sucBlock:^{
        success = YES;
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)readGpsMode {
    __block BOOL success = NO;
    [MKBGInterface bg_readGpsModeWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.gpsMode = [returnData[@"result"][@"type"] integerValue];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)configGpsMode {
    __block BOOL success = NO;
    [MKBGInterface bg_configGpsMode:self.gpsMode sucBlock:^{
        success = YES;
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)readTimeBudget {
    __block BOOL success = NO;
    [MKBGInterface bg_readGpsTimeBudgetWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.timeBudget = returnData[@"result"][@"time"];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)configTimeBudget {
    __block BOOL success = NO;
    [MKBGInterface bg_configGpsTimeBudget:[self.timeBudget longLongValue] sucBlock:^{
        success = YES;
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)readExtremeMode {
    __block BOOL success = NO;
    [MKBGInterface bg_readGpsExtremeModeStatusWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.extremeMode = [returnData[@"result"][@"extremeMode"] boolValue];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)configExtremeMode {
    __block BOOL success = NO;
    [MKBGInterface bg_configGpsExtremeModeStatus:self.extremeMode sucBlock:^{
        success = YES;
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)validParams {
    if (!ValidStr(self.coldStardTime) || [self.coldStardTime integerValue] < 3 || [self.coldStardTime integerValue] > 15) {
        return NO;
    }
    if (!ValidStr(self.coarseAccuracyMask) || [self.coarseAccuracyMask integerValue] < 5 || [self.coarseAccuracyMask integerValue] > 100) {
        return NO;
    }
    if (!ValidStr(self.coarseTime) || [self.coarseTime integerValue] < 1 || [self.coarseTime integerValue] > 7620) {
        return NO;
    }
    if (!ValidStr(self.fineAccuracyTarget) || [self.fineAccuracyTarget integerValue] < 5 || [self.fineAccuracyTarget integerValue] > 100) {
        return NO;
    }
    if (!ValidStr(self.fineTime) || [self.fineTime integerValue] < 0 || [self.fineTime integerValue] > 76200) {
        return NO;
    }
    if (!ValidStr(self.PDOPLimit) || [self.PDOPLimit integerValue] < 25 || [self.PDOPLimit integerValue] > 100) {
        return NO;
    }
    if (!ValidStr(self.adingAccuracy) || [self.adingAccuracy integerValue] < 5 || [self.adingAccuracy integerValue] > 1000) {
        return NO;
    }
    if (!ValidStr(self.aidingTime) || [self.aidingTime integerValue] < 1 || [self.aidingTime integerValue] > 7620) {
        return NO;
    }
    if (!ValidStr(self.timeBudget) || [self.timeBudget integerValue] < 0 || [self.timeBudget integerValue] > 76200) {
        return NO;
    }
    return YES;
}

#pragma mark - private method
- (void)operationFailedBlockWithMsg:(NSString *)msg block:(void (^)(NSError *error))block {
    moko_dispatch_main_safe(^{
        NSError *error = [[NSError alloc] initWithDomain:@"gpsParams"
                                                    code:-999
                                                userInfo:@{@"errorInfo":msg}];
        block(error);
    })
}

#pragma mark - getter
- (dispatch_semaphore_t)semaphore {
    if (!_semaphore) {
        _semaphore = dispatch_semaphore_create(0);
    }
    return _semaphore;
}

- (dispatch_queue_t)readQueue {
    if (!_readQueue) {
        _readQueue = dispatch_queue_create("gpsQueue", DISPATCH_QUEUE_SERIAL);
    }
    return _readQueue;
}

@end
