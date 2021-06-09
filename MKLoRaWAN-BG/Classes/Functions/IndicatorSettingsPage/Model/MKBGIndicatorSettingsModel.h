//
//  MKBGIndicatorSettingsModel.h
//  MKLoRaWAN-BG_Example
//
//  Created by aa on 2021/5/27.
//  Copyright © 2021 aadyx2007@163.com. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKBGIndicatorSettingsModel : NSObject

@property (nonatomic, assign)BOOL tamperIsOn;

@property (nonatomic, assign)BOOL lowPowerIsOn;

@property (nonatomic, assign)BOOL inWifiFixIsOn;

@property (nonatomic, assign)BOOL wifiFixSuccessfulIsOn;

@property (nonatomic, assign)BOOL failToWifiFixIsOn;

@property (nonatomic, assign)BOOL InBleFixIsOn;

@property (nonatomic, assign)BOOL BTFixSuccessfulIsOn;

@property (nonatomic, assign)BOOL failToBTFixIsOn;

@property (nonatomic, assign)BOOL inGpsFixIsOn;

@property (nonatomic, assign)BOOL gpsFixSuccessfulIsOn;

@property (nonatomic, assign)BOOL failToGpsFixIsOn;

@end

NS_ASSUME_NONNULL_END
