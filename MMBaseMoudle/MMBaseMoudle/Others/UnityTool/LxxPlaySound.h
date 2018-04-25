//
//  LxxPlaySound.h
//  B_MileClient_iPhone4
//
//  Created by YunShangCompany on 2017/8/29.
//  Copyright © 2017年 HanYu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AudioToolbox/AudioToolbox.h>

@interface LxxPlaySound : NSObject{
    SystemSoundID soundID;
}
/**
 20
 21  *  @brief  为播放震动效果初始化
 25  *  @return self
 27  */

-(id)initForPlayingVibrate;
/**
 35  *  @brief  为播放系统音效初始化(无需提供音频文件)
 37  *
 39  *  @param resourceName 系统音效名称
 41  *  @param type 系统音效类型
 45  *  @return self
 47  */

-(id)initForPlayingSystemSoundEffectWith:(NSString *)resourceName ofType:(NSString *)type;
/**
 55  *  @brief  为播放特定的音频文件初始化（需提供音频文件）
 59  *  @param filename 音频文件名（加在工程中）
 63  *  @return self
 65  */

-(id)initForPlayingSoundEffectWith:(NSString *)filename;
/**
 73  *  @brief  播放音效
 75  */

-(void)play;

@end
