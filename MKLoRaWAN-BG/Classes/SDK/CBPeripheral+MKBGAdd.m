//
//  CBPeripheral+MKBGAdd.m
//  MKLoRaWAN-BG_Example
//
//  Created by aa on 2021/5/17.
//  Copyright © 2021 aadyx2007@163.com. All rights reserved.
//

#import "CBPeripheral+MKBGAdd.h"

#import <objc/runtime.h>

static const char *bg_batteryPowerKey = "bg_batteryPowerKey";
static const char *bg_manufacturerKey = "bg_manufacturerKey";
static const char *bg_deviceModelKey = "bg_deviceModelKey";
static const char *bg_hardwareKey = "bg_hardwareKey";
static const char *bg_softwareKey = "bg_softwareKey";
static const char *bg_firmwareKey = "bg_firmwareKey";

static const char *bg_passwordKey = "bg_passwordKey";
static const char *bg_disconnectTypeKey = "bg_disconnectTypeKey";
static const char *bg_customKey = "bg_customKey";
static const char *bg_storageDataKey = "bg_storageDataKey";
static const char *bg_logDataKey = "bg_logDataKey";

static const char *bg_passwordNotifySuccessKey = "bg_passwordNotifySuccessKey";
static const char *bg_disconnectTypeNotifySuccessKey = "bg_disconnectTypeNotifySuccessKey";
static const char *bg_customNotifySuccessKey = "bg_customNotifySuccessKey";
static const char *bg_storageDataNotifySuccessKey = "bg_storageDataNotifySuccessKey";

@implementation CBPeripheral (MKBGAdd)

- (void)bg_updateCharacterWithService:(CBService *)service {
    NSArray *characteristicList = service.characteristics;
    if ([service.UUID isEqual:[CBUUID UUIDWithString:@"180F"]]) {
        //电池电量
        for (CBCharacteristic *characteristic in characteristicList) {
            if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"2A19"]]) {
                objc_setAssociatedObject(self, &bg_batteryPowerKey, characteristic, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
                break;
            }
        }
        return;
    }
    if ([service.UUID isEqual:[CBUUID UUIDWithString:@"180A"]]) {
        //设备信息
        for (CBCharacteristic *characteristic in characteristicList) {
            if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"2A24"]]) {
                objc_setAssociatedObject(self, &bg_deviceModelKey, characteristic, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            }else if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"2A26"]]) {
                objc_setAssociatedObject(self, &bg_firmwareKey, characteristic, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            }else if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"2A27"]]) {
                objc_setAssociatedObject(self, &bg_hardwareKey, characteristic, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            }else if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"2A28"]]) {
                objc_setAssociatedObject(self, &bg_softwareKey, characteristic, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            }else if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"2A29"]]) {
                objc_setAssociatedObject(self, &bg_manufacturerKey, characteristic, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            }
        }
        return;
    }
    if ([service.UUID isEqual:[CBUUID UUIDWithString:@"AA00"]]) {
        //自定义
        for (CBCharacteristic *characteristic in characteristicList) {
            if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"AA00"]]) {
                objc_setAssociatedObject(self, &bg_passwordKey, characteristic, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
                [self setNotifyValue:YES forCharacteristic:characteristic];
            }else if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"AA01"]]) {
                objc_setAssociatedObject(self, &bg_disconnectTypeKey, characteristic, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
                [self setNotifyValue:YES forCharacteristic:characteristic];
            }else if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"AA02"]]) {
                objc_setAssociatedObject(self, &bg_customKey, characteristic, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
                [self setNotifyValue:YES forCharacteristic:characteristic];
            }else if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"AA03"]]) {
                objc_setAssociatedObject(self, &bg_storageDataKey, characteristic, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
                [self setNotifyValue:YES forCharacteristic:characteristic];
            }else if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"AA05"]]) {
                objc_setAssociatedObject(self, &bg_logDataKey, characteristic, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            }
        }
        return;
    }
}

- (void)bg_updateCurrentNotifySuccess:(CBCharacteristic *)characteristic {
    if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"AA00"]]) {
        objc_setAssociatedObject(self, &bg_passwordNotifySuccessKey, @(YES), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        return;
    }
    if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"AA01"]]) {
        objc_setAssociatedObject(self, &bg_disconnectTypeNotifySuccessKey, @(YES), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        return;
    }
    if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"AA02"]]) {
        objc_setAssociatedObject(self, &bg_customNotifySuccessKey, @(YES), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        return;
    }
    if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"AA03"]]) {
        objc_setAssociatedObject(self, &bg_storageDataNotifySuccessKey, @(YES), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        return;
    }
}

- (BOOL)bg_connectSuccess {
    if (![objc_getAssociatedObject(self, &bg_customNotifySuccessKey) boolValue] || ![objc_getAssociatedObject(self, &bg_passwordNotifySuccessKey) boolValue] || ![objc_getAssociatedObject(self, &bg_disconnectTypeNotifySuccessKey) boolValue] || ![objc_getAssociatedObject(self, &bg_storageDataNotifySuccessKey) boolValue]) {
        return NO;
    }
    if (!self.bg_batteryPower || !self.bg_manufacturer || !self.bg_deviceModel || !self.bg_hardware || !self.bg_sofeware || !self.bg_firmware) {
        return NO;
    }
    if (!self.bg_password || !self.bg_disconnectType || !self.bg_custom || !self.bg_storageData) {
        return NO;
    }
    return YES;
}

- (void)bg_setNil {
    objc_setAssociatedObject(self, &bg_batteryPowerKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(self, &bg_manufacturerKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(self, &bg_deviceModelKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(self, &bg_hardwareKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(self, &bg_softwareKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(self, &bg_firmwareKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    objc_setAssociatedObject(self, &bg_passwordKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(self, &bg_disconnectTypeKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(self, &bg_customKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(self, &bg_storageDataKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(self, &bg_logDataKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    objc_setAssociatedObject(self, &bg_passwordNotifySuccessKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(self, &bg_disconnectTypeNotifySuccessKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(self, &bg_customNotifySuccessKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(self, &bg_storageDataNotifySuccessKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

#pragma mark - getter

- (CBCharacteristic *)bg_batteryPower {
    return objc_getAssociatedObject(self, &bg_batteryPowerKey);
}

- (CBCharacteristic *)bg_manufacturer {
    return objc_getAssociatedObject(self, &bg_manufacturerKey);
}

- (CBCharacteristic *)bg_deviceModel {
    return objc_getAssociatedObject(self, &bg_deviceModelKey);
}

- (CBCharacteristic *)bg_hardware {
    return objc_getAssociatedObject(self, &bg_hardwareKey);
}

- (CBCharacteristic *)bg_sofeware {
    return objc_getAssociatedObject(self, &bg_softwareKey);
}

- (CBCharacteristic *)bg_firmware {
    return objc_getAssociatedObject(self, &bg_firmwareKey);
}

- (CBCharacteristic *)bg_password {
    return objc_getAssociatedObject(self, &bg_passwordKey);
}

- (CBCharacteristic *)bg_disconnectType {
    return objc_getAssociatedObject(self, &bg_disconnectTypeKey);
}

- (CBCharacteristic *)bg_custom {
    return objc_getAssociatedObject(self, &bg_customKey);
}

- (CBCharacteristic *)bg_storageData {
    return objc_getAssociatedObject(self, &bg_storageDataKey);
}

- (CBCharacteristic *)bg_logData {
    return objc_getAssociatedObject(self, &bg_logDataKey);
}

@end
