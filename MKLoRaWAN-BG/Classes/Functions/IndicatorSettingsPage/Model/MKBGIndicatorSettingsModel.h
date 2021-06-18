//
//  MKBGIndicatorSettingsModel.h
//  MKLoRaWAN-BG_Example
//
//  Created by aa on 2021/5/27.
//  Copyright © 2021 aadyx2007@163.com. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MKBGSDKNormalDefines.h"

NS_ASSUME_NONNULL_BEGIN

@interface MKBGIndicatorSettingsModel : NSObject<mk_bg_indicatorSettingsProtocol>

@property (nonatomic, assign)BOOL Tamper;
@property (nonatomic, assign)BOOL LowPower;
@property (nonatomic, assign)BOOL InBluetoothFix;
@property (nonatomic, assign)BOOL BTFixSuccessful;
@property (nonatomic, assign)BOOL FailToBTFix;
@property (nonatomic, assign)BOOL InGPSFix;
@property (nonatomic, assign)BOOL GPSFixsuccessful;
@property (nonatomic, assign)BOOL FailToGPSFix;
@property (nonatomic, assign)BOOL InWIFIFix;
@property (nonatomic, assign)BOOL WIFIFixSuccessful;
@property (nonatomic, assign)BOOL FailToWIFIFix;

- (void)readWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock;

- (void)configWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock;

@end

NS_ASSUME_NONNULL_END
