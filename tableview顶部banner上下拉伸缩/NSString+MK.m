//
//  NSString+MK.m
//  xiaokan
//
//  Created by yaker on 16/1/30.
//  Copyright © 2016年 yaker. All rights reserved.
//

#import "NSString+MK.h"
#import <CoreText/CoreText.h>
#import "MyAttributedStringBuilder.h"
@implementation NSString (MK)



#pragma mark - 
+ (NSString *)changeDressingStr:(NSString *)string
{
    NSMutableString *str = [NSMutableString stringWithString:string];
    while ([str rangeOfString:@"&amp;"].length > 0) {
        [str replaceCharactersInRange:[str rangeOfString: @"&amp;"] withString:@"&"];
    }
    while ([str rangeOfString:@"&quot;"].length>0) {
        
        [str replaceCharactersInRange:[str rangeOfString: @"&quot;"] withString:@"\""];
    }
    
    while ([str rangeOfString:@"&lt;"].length>0) {
        
        [str replaceCharactersInRange:[str rangeOfString: @"&lt;"] withString:@"<"];
    }
    
    while ([str rangeOfString:@"&gt;"].length>0) {
        
        [str replaceCharactersInRange:[str rangeOfString: @"&gt;"] withString:@">"];
    }
    
    while ([str rangeOfString:@"&nbsp;"].length>0) {
        
        [str replaceCharactersInRange:[str rangeOfString: @"&nbsp;"] withString:@" "];
        
    }
    while ([str rangeOfString:@"<br />"].length>0) {
        
        [str replaceCharactersInRange:[str rangeOfString: @"<br />"] withString:@"\n"];
    }
    return str;
}

+ (NSString *)changeWebDressingStr:(NSString *)string
{
    NSMutableString *str = [NSMutableString stringWithString:string];
    while ([str rangeOfString:@"&amp;"].length > 0) {
        [str replaceCharactersInRange:[str rangeOfString: @"&amp;"] withString:@"&"];
    }
    while ([str rangeOfString:@"&quot;"].length>0) {
        
        [str replaceCharactersInRange:[str rangeOfString: @"&quot;"] withString:@"\""];
    }
    
    while ([str rangeOfString:@"&lt;"].length>0) {
        
        [str replaceCharactersInRange:[str rangeOfString: @"&lt;"] withString:@"<"];
    }
    
    while ([str rangeOfString:@"&gt;"].length>0) {
        
        [str replaceCharactersInRange:[str rangeOfString: @"&gt;"] withString:@">"];
    }
    
    while ([str rangeOfString:@"&nbsp;"].length>0) {
        
        [str replaceCharactersInRange:[str rangeOfString: @"&nbsp;"] withString:@" "];
        
    }
    
    while ([str rangeOfString:@"<br />"].length>0) {
        
        [str replaceCharactersInRange:[str rangeOfString: @"<br />"] withString:@""];
    }
    
    return str;
}
+ (NSString *)getDressingStr:(NSString *)string
{
    
    NSMutableString *str = [NSMutableString stringWithString:string];
    while ([str rangeOfString:@"&amp;"].length > 0) {
        [str replaceCharactersInRange:[str rangeOfString: @"&amp;"] withString:@"&"];
    }
    while ([str rangeOfString:@"&quot;"].length>0) {
        
        [str replaceCharactersInRange:[str rangeOfString: @"&quot;"] withString:@"\""];
    }
    
    while ([str rangeOfString:@"&lt;"].length>0) {
        
        [str replaceCharactersInRange:[str rangeOfString: @"&lt;"] withString:@"<"];
    }
    
    while ([str rangeOfString:@"&gt;"].length>0) {
        
        [str replaceCharactersInRange:[str rangeOfString: @"&gt;"] withString:@">"];
    }
    
    while ([str rangeOfString:@"&nbsp;"].length>0) {
        
        [str replaceCharactersInRange:[str rangeOfString: @"&nbsp;"] withString:@" "];
        
    }
    
    return str;
}


+ (NSString *)getMessageStrStr:(NSString *)string
{
    
    NSString *str = string;
    
    str = [NSString getStrFilterHTML:str];
    str = [NSString getDressingStr:str];
    //去除首尾空格和换行
    str = [str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    return str;
}
+(NSString *)getStrFilterHTML:(NSString *)html
{
    
    NSScanner * scanner = [NSScanner scannerWithString:html];
    NSString * text = nil;
    while([scanner isAtEnd]==NO)
    {
        //找到标签的起始位置
        [scanner scanUpToString:@"<" intoString:nil];
        //找到标签的结束位置
        [scanner scanUpToString:@">" intoString:&text];
        //替换字符
        html = [html stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@>",text] withString:@""];
    }
    
    return html;
}
#pragma mark - 
/** 发送邮件*/

+(void)openEmailUrlWithEmail:(NSString *)emailStr{
    
    NSString *urlStr = [NSString stringWithFormat:@"mailto://%@",emailStr];
    //注意url中包含协议名称，iOS根据协议确定调用哪个应用，例如发送邮件是“sms://”其中“//”可以省略写成“sms:”(其他协议也是如此)
    NSURL *url=[NSURL URLWithString:urlStr];
    UIApplication *application=[UIApplication sharedApplication];
    if(![application canOpenURL:url]){
        NSLog(@"无法打开\"%@\"，请确保此应用已经正确安装.",url);
        return;
    }
    [[UIApplication sharedApplication] openURL:url];
}
#pragma mark - 
- (CGSize)sizeWithConstrainedToWidth:(float)width fromFont:(UIFont *)font1 lineSpace:(float)lineSpace{
    return [self sizeWithConstrainedToSize:CGSizeMake(width, CGFLOAT_MAX) fromFont:font1 lineSpace:lineSpace];
}

- (CGSize)sizeWithConstrainedToSize:(CGSize)size fromFont:(UIFont *)font1 lineSpace:(float)lineSpace{
    CGFloat minimumLineHeight = font1.pointSize,maximumLineHeight = minimumLineHeight, linespace = lineSpace;
    CTFontRef font = CTFontCreateWithName((__bridge CFStringRef)font1.fontName,font1.pointSize,NULL);
    CTLineBreakMode lineBreakMode = kCTLineBreakByWordWrapping;
    //Apply paragraph settings
    CTTextAlignment alignment = kCTLeftTextAlignment;
    CTParagraphStyleRef style = CTParagraphStyleCreate((CTParagraphStyleSetting[6]){
        {kCTParagraphStyleSpecifierAlignment, sizeof(alignment), &alignment},
        {kCTParagraphStyleSpecifierMinimumLineHeight,sizeof(minimumLineHeight),&minimumLineHeight},
        {kCTParagraphStyleSpecifierMaximumLineHeight,sizeof(maximumLineHeight),&maximumLineHeight},
        {kCTParagraphStyleSpecifierMaximumLineSpacing, sizeof(linespace), &linespace},
        {kCTParagraphStyleSpecifierMinimumLineSpacing, sizeof(linespace), &linespace},
        {kCTParagraphStyleSpecifierLineBreakMode,sizeof(CTLineBreakMode),&lineBreakMode}
    },6);
    NSDictionary* attributes = [NSDictionary dictionaryWithObjectsAndKeys:(__bridge id)font,(NSString*)kCTFontAttributeName,(__bridge id)style,(NSString*)kCTParagraphStyleAttributeName,nil];
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:self attributes:attributes];
    //    [self clearEmoji:string start:0 font:font1];
    CFAttributedStringRef attributedString = (__bridge CFAttributedStringRef)string;
    CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)attributedString);
    CGSize result = CTFramesetterSuggestFrameSizeWithConstraints(framesetter, CFRangeMake(0, [string length]), NULL, size, NULL);
    CFRelease(framesetter);
    CFRelease(font);
    CFRelease(style);
    string = nil;
    attributes = nil;
    return result;
}

- (NSAttributedString *)strWithLineSpace:(float)lineSpace
{
    
    MyAttributedStringBuilder *builder = nil;
    builder = [[MyAttributedStringBuilder alloc] initWithString:self];
    builder.allRange.lineSpacing = lineSpace;
    return  builder.commit;

}
- (NSAttributedString *)strWithLineSpace:(float)lineSpace andColor:(UIColor*)color andFontSize:(UIFont*)font{
    MyAttributedStringBuilder *builder = nil;
    builder = [[MyAttributedStringBuilder alloc] initWithString:self];
    builder.allRange.lineSpacing = lineSpace;
    [builder.allRange setTextColor:color];
    [builder.allRange setFont:font];
    return builder.commit;
}
- (NSAttributedString *)strWithLineSpace:(float)lineSpace andParagraphSpacing:(float)paragraphSpacing {
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:self];
    NSMutableParagraphStyle   *paragraphStyle   = [[NSMutableParagraphStyle alloc] init];
    
    //行间距
    [paragraphStyle setLineSpacing:lineSpace];
    //段落间距
    [paragraphStyle setParagraphSpacing:paragraphSpacing];
    //第一行头缩进
    //[paragraphStyle setFirstLineHeadIndent:15.0];
    //头部缩进
    //[paragraphStyle setHeadIndent:15.0];
    //尾部缩进
    //[paragraphStyle setTailIndent:250.0];
    //最小行高
    //[paragraphStyle setMinimumLineHeight:20.0];
    //最大行高
    //[paragraphStyle setMaximumLineHeight:20.0];
    
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [self length])];
    return attributedString;

}
- (NSAttributedString *)strWithLineSpace:(float)lineSpace andColor:(UIColor*)color andFontSize:(UIFont*)font andTexAlignment:(NSTextAlignment)aligment{
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc]init];
    style.alignment = aligment;
    style.lineSpacing = lineSpace;
    MyAttributedStringBuilder *builder = nil;
    builder = [[MyAttributedStringBuilder alloc] initWithString:self];
    [builder.allRange setParagraphStyle:style];
    [builder.allRange setTextColor:color];
    [builder.allRange setFont:font];
    return builder.commit;
}
- (NSAttributedString *)strWithLineSpace:(float)lineSpace andColor:(UIColor*)color andFontSize:(UIFont*)font andLineBreakMode:(NSLineBreakMode)mode{
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc]init];
    style.lineBreakMode = mode;
    style.lineSpacing = lineSpace;
    MyAttributedStringBuilder *builder = nil;
    builder = [[MyAttributedStringBuilder alloc] initWithString:self];
    [builder.allRange setParagraphStyle:style];
    [builder.allRange setTextColor:color];
    [builder.allRange setFont:font];
    return builder.commit;
}

#pragma mark -
- (void)drawInContext:(CGContextRef)context withPosition:(CGPoint)p andFont:(UIFont *)font andTextColor:(UIColor *)color andHeight:(float)height andWidth:(float)width{
    CGSize size = CGSizeMake(width, font.pointSize+10);
    CGContextSetTextMatrix(context,CGAffineTransformIdentity);
    CGContextTranslateCTM(context,0,height);
    CGContextScaleCTM(context,1.0,-1.0);
    
    //Determine default text color
    UIColor* textColor = color;
    //Set line height, font, color and break mode
    CTFontRef font1 = CTFontCreateWithName((__bridge CFStringRef)font.fontName, font.pointSize,NULL);
    //Apply paragraph settings
    CGFloat minimumLineHeight = font.pointSize,maximumLineHeight = minimumLineHeight+10, linespace = 5;
    CTLineBreakMode lineBreakMode = kCTLineBreakByTruncatingTail;
    CTTextAlignment alignment = kCTLeftTextAlignment;
    //Apply paragraph settings
    CTParagraphStyleRef style = CTParagraphStyleCreate((CTParagraphStyleSetting[6]){
        {kCTParagraphStyleSpecifierAlignment, sizeof(alignment), &alignment},
        {kCTParagraphStyleSpecifierMinimumLineHeight,sizeof(minimumLineHeight),&minimumLineHeight},
        {kCTParagraphStyleSpecifierMaximumLineHeight,sizeof(maximumLineHeight),&maximumLineHeight},
        {kCTParagraphStyleSpecifierMaximumLineSpacing, sizeof(linespace), &linespace},
        {kCTParagraphStyleSpecifierMinimumLineSpacing, sizeof(linespace), &linespace},
        {kCTParagraphStyleSpecifierLineBreakMode,sizeof(CTLineBreakMode),&lineBreakMode}
    },6);
    
    NSDictionary* attributes = [NSDictionary dictionaryWithObjectsAndKeys:(__bridge id)font1,(NSString*)kCTFontAttributeName,
                                textColor.CGColor,kCTForegroundColorAttributeName,
                                style,kCTParagraphStyleAttributeName,
                                nil];
    //Create path to work with a frame with applied margins
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path,NULL,CGRectMake(p.x, height-p.y-size.height,(size.width),(size.height)));
    
    //Create attributed string, with applied syntax highlighting
    NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc] initWithString:self attributes:attributes];
    CFAttributedStringRef attributedString = (__bridge CFAttributedStringRef)attributedStr;
    
    //Draw the frame
    CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)attributedString);
    CTFrameRef ctframe = CTFramesetterCreateFrame(framesetter, CFRangeMake(0,CFAttributedStringGetLength(attributedString)),path,NULL);
    CTFrameDraw(ctframe,context);
    CGPathRelease(path);
    CFRelease(font1);
    CFRelease(framesetter);
    CFRelease(ctframe);
    [[attributedStr mutableString] setString:@""];
    CGContextSetTextMatrix(context,CGAffineTransformIdentity);
    CGContextTranslateCTM(context,0, height);
    CGContextScaleCTM(context,1.0,-1.0);
}

- (void)drawInContext:(CGContextRef)context withPosition:(CGPoint)p andFont:(UIFont *)font andTextColor:(UIColor *)color andHeight:(float)height{
    [self drawInContext:context withPosition:p andFont:font andTextColor:color andHeight:height andWidth:CGFLOAT_MAX];
}
//表情
+ (BOOL)stringContainsEmoji:(NSString *)string
{
    
    __block BOOL returnValue = NO;
    
    [string enumerateSubstringsInRange:NSMakeRange(0, [string length])
                               options:NSStringEnumerationByComposedCharacterSequences
                            usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
                                const unichar hs = [substring characterAtIndex:0];
                                if (0xd800 <= hs && hs <= 0xdbff) {
                                    if (substring.length > 1) {
                                        const unichar ls = [substring characterAtIndex:1];
                                        const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
                                        if (0x1d000 <= uc && uc <= 0x1f77f) {
                                            returnValue = YES;
                                        }
                                    }
                                } else if (substring.length > 1) {
                                    const unichar ls = [substring characterAtIndex:1];
                                    if (ls == 0x20e3) {
                                        returnValue = YES;
                                    }
                                } else {
                                    if (0x2100 <= hs && hs <= 0x27ff) {
                                        returnValue = YES;
                                    } else if (0x2B05 <= hs && hs <= 0x2b07) {
                                        returnValue = YES;
                                    } else if (0x2934 <= hs && hs <= 0x2935) {
                                        returnValue = YES;
                                    } else if (0x3297 <= hs && hs <= 0x3299) {
                                        returnValue = YES;
                                    } else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50) {
                                        returnValue = YES;
                                    }
                                }
                            }];
    
    return returnValue;

}
 /** 汉字转拼音*/
- (NSString *)transformToChinese
{
    //用kCFStringTransformMandarinLatin方法转化出来的是带音标的拼音，如果需要去掉音标，则继续使用kCFStringTransformStripCombiningMarks方法即可。
    NSMutableString *pinyin = [self mutableCopy];
    CFStringTransform((__bridge CFMutableStringRef)pinyin, NULL, kCFStringTransformMandarinLatin, NO);
    CFStringTransform((__bridge CFMutableStringRef)pinyin, NULL, kCFStringTransformStripCombiningMarks, NO);
    NSLog(@"%@", pinyin);
    return [pinyin uppercaseString];
}

- (BOOL)isWebUrl{
    NSRegularExpression *regexPerson = [NSString regexWebUrl];
    NSArray *matchsPerson = [regexPerson matchesInString:self options:kNilOptions range:NSMakeRange(0, self.length)];
    return matchsPerson.count;
}

+ (NSRegularExpression *)regexWebUrl {
    static NSRegularExpression *regex;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        regex = [NSRegularExpression regularExpressionWithPattern:@"([hH]ttp[s]{0,1})://[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\-~!@#$%^&*+?:_/=<>.',;]*)?" options:kNilOptions error:NULL];
    });
    return regex;
}
//特殊字符串  处理
/** 1111111  每天 */
/** 0111110  工作日 */
/** 0111111  工作日+周六 */
+ (NSString *)stringWithPostString:(NSString *)string
{
    if (string.length != 7) {
        return nil;
    }
    
    NSString *str  = @"";
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:@"周日",@"0",@"周一",@"1",@"周二",@"2",@"周三",@"3",@"周四",@"4",@"周五",@"5",@"周六",@"6", nil];
    
    if ([string isEqualToString:@"1111111"]) {
        str  = @"每天";
    }else if ([string isEqualToString:@"0111110"]) {
        str  = @"工作日";
    }else if ([string isEqualToString:@"0111111"]) {
        str  = @"工作日+周六";
    }else if ([string isEqualToString:@"1111110"]) {
        str  = @"工作日+周日";
    }else{
        for (int i = 0; i < string.length; i++) {
            NSString *indexstr = [NSString stringWithFormat:@"%d",i];
            NSString *weekstr = [dic objectForKey:indexstr];

            NSRange range = NSMakeRange (i,1);
            NSString *rangestr = [string substringWithRange:range];//0 或1
            if ([rangestr intValue]==1) {
                str = [str stringByAppendingString:[NSString stringWithFormat:@" %@",weekstr]];
            }
        }
    }
    return str;

}
@end
