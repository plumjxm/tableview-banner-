//
//  NSString+MK.h
//  xiaokan
//
//  Created by yaker on 16/1/30.
//  Copyright © 2016年 yaker. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (MK)

//+(NSString *)getBackimageStr1:(NSString *)str;

+ (NSString *)changeDressingStr:(NSString *)string;
+ (NSString *)changeWebDressingStr:(NSString *)string;

+ (NSString *)getDressingStr:(NSString *)string;
+ (NSString *)getStrFilterHTML:(NSString *)html;
+ (NSString *)getMessageStrStr:(NSString *)string;
/** 发送邮件*/
+(void)openEmailUrlWithEmail:(NSString *)emailStr;


//计算大小带间距
- (CGSize)sizeWithConstrainedToWidth:(float)width fromFont:(UIFont *)font1 lineSpace:(float)lineSpace;
- (CGSize)sizeWithConstrainedToSize:(CGSize)size fromFont:(UIFont *)font1 lineSpace:(float)lineSpace;
//字符串 设置 行间距
- (NSAttributedString *)strWithLineSpace:(float)lineSpace;

//行间距 颜色 字体大小
- (NSAttributedString *)strWithLineSpace:(float)lineSpace andColor:(UIColor*)color andFontSize:(UIFont*)font;
- (NSAttributedString *)strWithLineSpace:(float)lineSpace andParagraphSpacing:(float)paragraphSpacing;
//breadkMode
- (NSAttributedString *)strWithLineSpace:(float)lineSpace andColor:(UIColor*)color andFontSize:(UIFont*)font andLineBreakMode:(NSLineBreakMode)mode;
- (NSAttributedString *)strWithLineSpace:(float)lineSpace andColor:(UIColor*)color andFontSize:(UIFont*)font andTexAlignment:(NSTextAlignment)aligment;


//绘画文字
- (void)drawInContext:(CGContextRef)context withPosition:(CGPoint)p andFont:(UIFont *)font andTextColor:(UIColor *)color andHeight:(float)height andWidth:(float)width;

- (void)drawInContext:(CGContextRef)context withPosition:(CGPoint)p andFont:(UIFont *)font andTextColor:(UIColor *)color andHeight:(float)height;


//表情
+ (BOOL)stringContainsEmoji:(NSString *)string;

 /** 汉字转拼音*/
- (NSString *)transformToChinese;


- (BOOL)isWebUrl;



//特殊字符串  处理
 /** 1111111  每天 */
 /** 0111110  工作日 */
 /** 0111111  工作日+周六 */
+ (NSString *)stringWithPostString:(NSString *)string;
@end
