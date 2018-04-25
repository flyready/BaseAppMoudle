//
//  UIImage+CKBase64.m
//  ALaTranslation
//
//  Created by 何铭康 on 2017/3/6.
//  Copyright © 2017年 覃盼. All rights reserved.
//

#import "UIImage+CKBase64.h"

@implementation UIImage (CKBase64)

- (NSString *)base64String {
    NSData *_data = UIImageJPEGRepresentation(self, 0.9);
    
    NSString *_encodedImageStr = [_data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
//    NSData * data = [UIImagePNGRepresentation(self) base64EncodedDataWithOptions:NSDataBase64Encoding64CharacterLineLength];
//    return [NSString stringWithUTF8String:[data bytes]];
    return _encodedImageStr;
}



@end
