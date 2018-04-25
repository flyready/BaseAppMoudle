//
//  CustomUtils.m
//  Common
//
#import "CustomUtils.h"
//#import "NSObject+ObjectMap.h"
//#import "PHProgressHUD.h"

@implementation CustomUtils

+ (CGSize)sizeOfString:(NSString *)string sizeWithFont:(UIFont *)font lineBreakMode:(NSLineBreakMode)lineBreakMode maxSize:(CGSize)maxSize
{
    CGSize retSize;
    {
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        paragraphStyle.lineBreakMode = lineBreakMode;
        
        NSDictionary * attributes = @{NSFontAttributeName: font,
                                      NSParagraphStyleAttributeName: paragraphStyle};
        
        retSize = [string boundingRectWithSize:maxSize
                                       options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                    attributes:attributes
                                       context:nil].size;
    }
    return retSize;
}

+ (id)dataHandle:(id)data
{
    id ret;
    if ([data isKindOfClass:[NSDictionary class]]) {
        ret = [self AllObjectsInDicConvertToNSString:data];
    } else if ([data isKindOfClass:[NSArray class]]) {
        ret = [self AllObjectsInArrayConvertToNSString:data];
    } else if ([data isKindOfClass:[NSString class]]) {
        ret = data;
    }
    return ret;
}

+ (NSDictionary *)AllObjectsInDicConvertToNSString:(NSDictionary *)dict
{
    NSMutableDictionary *retDict = [[NSMutableDictionary alloc] initWithCapacity:dict.count];
    NSArray *keys = dict.allKeys;
    for (int i = 0; i < keys.count; i++) {
        id obj;
        if ([dict[keys[i]] isKindOfClass:[NSString class]]) {
            obj = dict[keys[i]];
        }
        if ([dict[keys[i]] isKindOfClass:[NSNumber class]]) {
            obj = [dict[keys[i]] stringValue];
        }
        if ([dict[keys[i]] isKindOfClass:[NSNull class]]) {
            obj = @"";
        }
        if ([dict[keys[i]] isKindOfClass:[NSArray class]]) {
            obj = [self AllObjectsInArrayConvertToNSString:dict[keys[i]]];
        }
        if ([dict[keys[i]] isKindOfClass:[NSDictionary class]]) {
            obj = [self AllObjectsInDicConvertToNSString:dict[keys[i]]];
        }
        if (obj) {
            [retDict setObject:obj forKey:keys[i]];
        }
    }
    return retDict;
}

+ (NSArray *)AllObjectsInArrayConvertToNSString:(NSArray *)array
{
    NSMutableArray *tempArr = [[NSMutableArray alloc] init];
    for (id object in array) {
        id obj;
        if ([object isKindOfClass:[NSString class]]) {
            obj = object;
        }
        if ([object isKindOfClass:[NSNumber class]]) {
            obj = [object stringValue];
        }
        
        if ([object isKindOfClass:[NSNull class]]) {
            obj = @"";
        }
        if ([object isKindOfClass:[NSArray class]]) {
            obj = [self AllObjectsInArrayConvertToNSString:object];
        }
        if ([object isKindOfClass:[NSDictionary class]]) {
            obj = [self AllObjectsInDicConvertToNSString:object];
        }
        if (obj) {
            [tempArr addObject:obj];
        }
    }
    return tempArr;
}

+ (UIColor *)getRandomColor
{
    return [UIColor colorWithRed:(float)(1+arc4random()%99)/100 green:(float)(1+arc4random()%99)/100 blue:(float)(1+arc4random()%99)/100 alpha:1];
}

/*0--1 : lerp( float percent, float x, float y ){ return x + ( percent * ( y - x ) ); };*/
+ (CGFloat)lerp:(float)percent min:(float)nMin max:(float)nMax
{
    CGFloat result = nMin;
    result = nMin + percent * (nMax - nMin);
    return result;
}

//  *****************  图片 旋转 角度   *****************************************  //
+ (UIImage *)image:(UIImage *)image rotation:(UIImageOrientation)orientation
{
    long double rotate = 0.0;
    CGRect rect;
    float translateX = 0;
    float translateY = 0;
    float scaleX = 1.0;
    float scaleY = 1.0;
    
    switch (orientation) {
        case UIImageOrientationLeft:
            rotate = M_PI_2;
            rect = CGRectMake(0, 0, image.size.width, image.size.height);
            translateX = 0;
            translateY = -rect.size.width;
            scaleY = rect.size.width/rect.size.height;
            scaleX = rect.size.height/rect.size.width;
            break;
        case UIImageOrientationRight:
            rotate = 3 * M_PI_2;
            rect = CGRectMake(0, 0, image.size.height, image.size.width);
            translateX = -rect.size.height;
            translateY = 0;
            scaleY = rect.size.width/rect.size.height;
            scaleX = rect.size.height/rect.size.width;
            break;
        case UIImageOrientationDown:
            rotate = M_PI;
            rect = CGRectMake(0, 0, image.size.width, image.size.height);
            translateX = -rect.size.width;
            translateY = -rect.size.height;
            break;
        default:
            rotate = 0.0;
            rect = CGRectMake(0, 0, image.size.width, image.size.height);
            translateX = 0;
            translateY = 0;
            break;
    }
    
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    //做CTM变换
    CGContextTranslateCTM(context, 0.0, rect.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    CGContextRotateCTM(context, rotate);
    CGContextTranslateCTM(context, translateX, translateY);
    
    CGContextScaleCTM(context, scaleX, scaleY);
    //绘制图片
    CGContextDrawImage(context, CGRectMake(0, 0, rect.size.width, rect.size.height), image.CGImage);
    UIImage *newPic = UIGraphicsGetImageFromCurrentImageContext();
    
    return newPic;
}

+ (void)avstarAnimation:(UIImageView *)avstar
{
    CATransition *trans=[CATransition animation];
    [trans setDuration:0.4f];
    [trans setType:@"flip"];
    [trans setSubtype:kCATransitionFromLeft];
    [avstar.layer addAnimation:trans forKey:nil];
}

+ (NSTimeInterval)keyBoardAnimationTime:(NSDictionary *)dict
{
    return [[dict objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
}

//判断 输入的值 是否为空
+ (BOOL)ISNULL:(id)string
{
    if ([string isEqual:@""]||[string isEqual:@" "]||(string == nil)||(string == [NSNull null])) {
        return YES;
    }
    return NO;
}

+ (BOOL)judustString:(NSString *)content title:(NSString *)title
{
    if ([CustomUtils ISNULL:content]) {
        //[kActivityHub ShowHub:title];
        return YES;
    }else{
        return NO;
    }
}

+ (UIImage *)imageFromColor:(UIColor *)color {
    CGRect rect = CGRectMake(0, 0, 1, 1);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

//    改变图片的颜色
+ (UIImage *)imageWithColor:(UIColor *)color withImage:(UIImage *)image
{
    if (!image) return nil;
    UIGraphicsBeginImageContextWithOptions(image.size, NO, 0.0f);
    [color setFill];
    CGRect bounds = CGRectMake(0, 0, image.size.width, image.size.height);
    UIRectFill(bounds);
    //Draw the tinted image in context
    [image drawInRect:bounds blendMode:kCGBlendModeDestinationIn alpha:1.0f];
    
    UIImage *tintedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return tintedImage;
}
//对图片尺寸进行压缩--放大 缩放
+ (UIImage*)imageWithImage:(UIImage*)image scaledToSize:(CGSize)newSize
{
    // Create a graphics image context
    UIGraphicsBeginImageContext(newSize);
    // Tell the old image to draw in this new context, with the desired
    // new size
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    // Get the new image from the context
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    // End the context
    UIGraphicsEndImageContext();
    // Return the new image.
    return newImage;
}

+ (UIImage *)getImageFromView:(UIView *)view
{
    UIGraphicsBeginImageContext(view.bounds.size);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

//#define kShadowOffsetY (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad ? 4.0f : 1.0f)
//#define kShadowBlur (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad ? 10.0f : 1.0f)
//// **********************  给文字 加阴影  ********************  //
//+ (void)addShadowLabel:(THLabel *)label
//{
//    [label setShadowColor:[UIColor colorWithWhite:0.f alpha:0.8]];
//    [label setShadowOffset:CGSizeMake(0.0f, kShadowOffsetY)];
//    [label setShadowBlur:kShadowBlur];
//}

// 字典转 josn 字符串
+ (NSString*)dictionaryToJson:(NSDictionary *)dic
{
    NSError *parseError = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}

//  **************  字典转字符串  ***********************  //
+ (NSString *)paramsForGet:(NSDictionary *)params
{
    NSMutableString *str = [[NSMutableString alloc] init];
    NSArray *keys = [params allKeys];
    for (NSString *key in keys) {
        id value = params[key];
        NSString *strValue = nil;
        if ([value isKindOfClass:[NSNumber class]]) {
            strValue = [value stringValue];
        } else {
            strValue = value; }
        if (str.length == 0) {
            [str appendString:[NSString stringWithFormat:@"%@=%@",key, strValue]];
        } else {
            [str appendString:[NSString stringWithFormat:@"&%@=%@",key, strValue]];
        }
    }
    return str;
}

+ (void)alertWithError:(NSError *)error
{
    NSString *result = nil;
    if (!error) {
        result = @"亲！分享成功！";
        ShowErrorOnWindow(result);
    }else{
        NSMutableString *str = [NSMutableString string];
        if (error.userInfo) {
            for (NSString *key in error.userInfo) {
                [str appendFormat:@"%@ = %@\n", key, error.userInfo[key]];
            }
        }
        if (error) {
            if ((int)error.code==2000) {
                result = @"亲！未知错误！";
            }
            else if ((int)error.code==2001) {
                result = @"亲！客户端版本不支持！";
            }
            else if ((int)error.code==2002) {
                result = @"亲！授权失败！";
            }
            else if ((int)error.code==2003) {
                result = @"亲！分享失败！";
            }
            else if ((int)error.code==2004) {
                result = @"亲！请求用户信息失败！";
            }
            else if ((int)error.code==2005) {
                result = @"亲！分享内容为空！";
            }
            else if ((int)error.code==2006) {
                result = @"亲！分享内容不支持！";
            }
            else if ((int)error.code==2007) {
                result = @"亲！schemaurl失败！";
            }
            else if ((int)error.code==2008) {
                result = @"亲！应用未安装！";
            }
            else if ((int)error.code==2009) {
                result = @"亲！取消操作！";
            }
            else if ((int)error.code==2010) {
                result = @"亲！网络异常！";
            }
            else if ((int)error.code==2011) {
                result = @"亲！第三方错误！";
            }
            else if ((int)error.code==2013) {
                result = @"亲！APP没有实现！";
            }
            else if ((int)error.code==2014) {
                result = @"亲！没有用https的请求！";
            }
        }
        else{
            result = @"亲！分享失败！";
        }
        //[PHProgressHUD showError:result];
        ShowErrorOnWindow(result);
    }
    /*
     UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"分享提示！"
     message:result
     delegate:nil
     cancelButtonTitle: @"确定"
     otherButtonTitles:nil];
     [alert show]; */
}

@end
