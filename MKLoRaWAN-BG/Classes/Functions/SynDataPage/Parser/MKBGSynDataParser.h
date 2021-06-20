//
//  MKBGSynDataParser.h
//  MKLoRaWAN-BG_Example
//
//  Created by aa on 2021/6/19.
//  Copyright © 2021 aadyx2007@163.com. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKBGSynDataParser : NSObject

+ (NSArray *)parseSynData:(NSString *)content;

@end

NS_ASSUME_NONNULL_END
