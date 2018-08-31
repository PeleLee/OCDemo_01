








#import<UIKit/UIKit.h>


@class CCStarRateView;

typedef void(^finishBlock)(CGFloat currentScore);
typedef NS_ENUM(NSInteger, RateStyle){
    WholeStar = 0, //只能整星评论
    HalfStar = 1,  //允许半星评论
    IncompleteStar = 2  //允许不完整星评论
};

@protocol CCStarRateViewDelegate<NSObject>
-(void)starRateView:(CCStarRateView *)starRateView currentScore:(CGFloat)currentScore;
@end

@interface CCStarRateView : UIView
@property (nonatomic,assign)CGFloat currentScore;  // 当前评分：0-5  默认0
@property (nonatomic,assign)BOOL isAnimation;      //是否动画显示，默认NO
@property (nonatomic,assign)RateStyle rateStyle;    //评分样式    默认WholeStar
@property (nonatomic, weak) id<CCStarRateViewDelegate>delegate;

-(instancetype)initWithFrame:(CGRect)frame;

-(instancetype)initWithFrame:(CGRect)frame numberOfStars:(NSInteger)numberOfStars rateStyle:(RateStyle)rateStyle isAnination:(BOOL)isAnimation delegate:(id)delegate;

//block当做一个参数传递
-(instancetype)initWithFrame:(CGRect)frame finish:(finishBlock)finish;

//block当做一个参数传递
-(instancetype)initWithFrame:(CGRect)frame numberOfStars:(NSInteger)numberOfStars rateStyle:(RateStyle)rateStyle isAnination:(BOOL)isAnimation finish:(finishBlock)finish;

@end
