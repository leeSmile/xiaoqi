
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Tostal : NSObject
{
    UIView *_mesgView;
    UILabel *_lbmesg;
    NSString *_mesgStr;
    NSTimer *_timer;
    int _disTime;
    BOOL isShow;
}


- (void)tostalMesg:(NSString *)mesgStr tostalTime:(int)disTime;
+(Tostal *)sharTostal;
@end
