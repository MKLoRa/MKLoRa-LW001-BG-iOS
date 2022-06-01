//
//  MKBGConnectModel.m
//  MKLoRaWAN-BG_Example
//
//  Created by aa on 2021/5/17.
//  Copyright © 2021 aadyx2007@163.com. All rights reserved.
//

#import "MKBGConnectModel.h"

#import <CoreBluetooth/CoreBluetooth.h>

#import "MKMacroDefines.h"

#import "MKBGSDK.h"

@interface MKBGConnectModel ()

@property (nonatomic, copy)NSString *firmware;

@property (nonatomic, strong)dispatch_queue_t connectQueue;

@property (nonatomic, strong)dispatch_semaphore_t semaphore;

@end

@implementation MKBGConnectModel

+ (MKBGConnectModel *)shared {
    static MKBGConnectModel *connectModel = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (!connectModel) {
            connectModel = [MKBGConnectModel new];
        }
    });
    return connectModel;
}

- (void)connectDevice:(CBPeripheral *)peripheral
             password:(NSString *)password
             sucBlock:(void (^)(void))sucBlock
          failedBlock:(void (^)(NSError *error))failedBlock {
    dispatch_async(self.connectQueue, ^{
        NSDictionary *dic = [self connectDevice:peripheral password:password];
        if (![dic[@"success"] boolValue]) {
            [self operationFailedMsg:dic[@"msg"] completeBlock:failedBlock];
            return ;
        }
        if (![self configDate]) {
            [self operationFailedMsg:@"Config Date Error" completeBlock:failedBlock];
            return;
        }
        if (![self readFirmware]) {
            [self operationFailedMsg:@"Read Firmware Error" completeBlock:failedBlock];
            return;
        }
        moko_dispatch_main_safe(^{
            if (sucBlock) {
                sucBlock();
            }
        });
    });
}

- (BOOL)firmwareVersion107 {
    if (!ValidStr(self.firmware)) {
        return NO;
    }
    NSString *tempVersion = [self.firmware stringByReplacingOccurrencesOfString:@"V" withString:@""];
    tempVersion = [tempVersion stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSArray *versionList = [tempVersion componentsSeparatedByString:@"."];
    if (!ValidArray(versionList) || versionList.count != 3) {
        return NO;
    }
    NSInteger highVersion = [versionList[0] integerValue];
    if (highVersion > 1) {
        return YES;
    }
    NSInteger centerVersion = [versionList[1] integerValue];
    if (highVersion == 1 && centerVersion > 0) {
        return YES;
    }
    NSInteger lowVersion = [versionList[2] integerValue];
    if (highVersion == 1 && centerVersion == 0 && lowVersion >= 7) {
        return YES;
    }
    return NO;
}

#pragma mark - interface
- (NSDictionary *)connectDevice:(CBPeripheral *)peripheral password:(NSString *)password {
    __block NSDictionary *connectResult = @{};
    [[MKBGCentralManager shared] connectPeripheral:peripheral password:password sucBlock:^(CBPeripheral * _Nonnull peripheral) {
        connectResult = @{
            @"success":@(YES),
        };
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        connectResult = @{
            @"success":@(NO),
            @"msg":SafeStr(error.userInfo[@"errorInfo"]),
        };
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return connectResult;
}

- (BOOL)readFirmware {
    __block BOOL success = NO;
    [MKBGInterface bg_readFirmwareWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.firmware = returnData[@"result"][@"firmware"];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)configDate {
    __block BOOL success = NO;
    long long recordTime = [[NSDate date] timeIntervalSince1970];
    [MKBGInterface bg_configDeviceTime:recordTime sucBlock:^{
        success = YES;
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

#pragma mark - private method
- (void)operationFailedMsg:(NSString *)msg completeBlock:(void (^)(NSError *error))block {
    moko_dispatch_main_safe(^{
        [[MKBGCentralManager shared] disconnect];
        if (block) {
            NSError *error = [[NSError alloc] initWithDomain:@"connectDevice"
                                                        code:-999
                                                    userInfo:@{@"errorInfo":SafeStr(msg)}];
            block(error);
        }
    });
}

#pragma mark - getter
- (dispatch_queue_t)connectQueue {
    if (!_connectQueue) {
        _connectQueue = dispatch_queue_create("com.moko.connectQueue", DISPATCH_QUEUE_SERIAL);
    }
    return _connectQueue;
}

- (dispatch_semaphore_t)semaphore {
    if (!_semaphore) {
        _semaphore = dispatch_semaphore_create(0);
    }
    return _semaphore;
}

@end
