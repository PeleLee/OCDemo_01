

#import "CCStarRateView.h"

#define ForegroundStarImage @"Selectstar"

#define BackgroundStarImage @"star"

typedef void(^completeBlock)(CGFloat currentScore);

@interface CCStarRateView()

@property (nonatomic, strong) UIView *foregroundStarView;

@property (nonatomic, strong) UIView *backgroundStarView;

@property (nonatomic, assign) NSInteger numberOfStars;

@property (nonatomic,strong)completeBlock complete;

@end

@implementation CCStarRateView

#pragma mark - 代理方式

-(instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        _numberOfStars = 5;
        
        _rateStyle = WholeStar;
        
        self.backgroundColor = [UIColor clearColor];
    }
    
    return self;
    
}

-(instancetype)initWithFrame:(CGRect)frame numberOfStars:(NSInteger)numberOfStars rateStyle:(RateStyle)rateStyle isAnination:(BOOL)isAnimation delegate:(id)delegate{
    
    if (self = [super initWithFrame:frame]) {
        
        _numberOfStars = numberOfStars;
        
        _rateStyle = rateStyle;
        
        _isAnimation = isAnimation;
        
        _delegate = delegate;
        self.backgroundColor = [UIColor clearColor];
    }
    
    return self;
    
}

#pragma mark - block方式

-(instancetype)initWithFrame:(CGRect)frame finish:(finishBlock)finish{
    
    if (self = [super initWithFrame:frame]) {
        
        _numberOfStars = 5;
        
        _rateStyle = WholeStar;
        
        _complete = ^(CGFloat currentScore){
            
            finish(currentScore);
            
        };
        self.backgroundColor = [UIColor clearColor];
        
    }
    
    return self;
    
}

-(instancetype)initWithFrame:(CGRect)frame numberOfStars:(NSInteger)numberOfStars rateStyle:(RateStyle)rateStyle isAnination:(BOOL)isAnimation finish:(finishBlock)finish{
    
    if (self = [super initWithFrame:frame]) {
        
        _numberOfStars = numberOfStars;
        
        _rateStyle = rateStyle;
        
        _isAnimation = isAnimation;
        
        _complete = ^(CGFloat currentScore){
            
            finish(currentScore);
            
        };
        self.backgroundColor = [UIColor clearColor];
        
    }
    
    return self;
    
}

- (void)drawRect:(CGRect)rect
{
    [self createStarView];
}

#pragma mark - private Method

//调用这个方法来布局
-(void)createStarView{
    
    self.foregroundStarView = [self createStarViewWithImage:ForegroundStarImage];
    
    self.backgroundStarView = [self createStarViewWithImage:BackgroundStarImage];
    
    self.foregroundStarView.frame = CGRectMake(0, 0, self.bounds.size.width*_currentScore/self.numberOfStars, self.bounds.size.height);
    
    [self addSubview:self.backgroundStarView];
    
    [self addSubview:self.foregroundStarView];
    
    //添加手势来取得所点击的位置
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(userTapRateView:)];
    
    tapGesture.numberOfTapsRequired = 1;
    
    [self addGestureRecognizer:tapGesture];
    
}

//使用这个方法来初始化子View
- (UIView *)createStarViewWithImage:(NSString *)imageName {
    
    UIView *view = [[UIView alloc] initWithFrame:self.bounds];
    
    view.clipsToBounds = YES;
    
    view.backgroundColor = [UIColor clearColor];
    
    //根据传过来的星星的数量来布局有几个星星
    for (NSInteger i = 0; i < self.numberOfStars; i ++)
        
    {
        
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName]];
        
        imageView.frame = CGRectMake(i * self.bounds.size.width / self.numberOfStars, 0, self.bounds.size.width / self.numberOfStars, self.bounds.size.height);
        
        //  保持图片内容的纵横比例，来适应视图的大小。
        
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        
        [view addSubview:imageView];
        
    }
    
    return view;
    
}

- (void)userTapRateView:(UITapGestureRecognizer *)gesture {
    
    //函数返回一个CGPoint类型的值，表示触摸在view这个视图上的位置，这里返回的位置是针对view的坐标系的。调用时传入的view参数为空的话，返回的时触摸点在整个窗口的位置。
    
    CGPoint tapPoint = [gesture locationInView:self];
    
    CGFloat offset = tapPoint.x;
    
    CGFloat realStarScore = offset / (self.bounds.size.width / self.numberOfStars);
    
    switch (_rateStyle) {
            
        case WholeStar:
            
        {
            
            self.currentScore = ceilf(realStarScore);
            
            break;
            
        }
            
        case HalfStar:
            
            self.currentScore = roundf(realStarScore)>realStarScore ? ceilf(realStarScore):(ceilf(realStarScore)-0.5);
            
            break;
            
        case IncompleteStar:
            
            self.currentScore = realStarScore;
            
            break;
            
        default:
            
            break;
            
    }
    
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    __weak CCStarRateView *weakSelf = self;
    
    CGFloat animationTimeInterval = self.isAnimation ? 0.2 : 0;
    
    [UIView animateWithDuration:animationTimeInterval animations:^{
        
        weakSelf.foregroundStarView.frame = CGRectMake(0, 0, weakSelf.bounds.size.width * weakSelf.currentScore/self.numberOfStars, weakSelf.bounds.size.height);
        
    }];
    
}

-(void)setCurrentScore:(CGFloat)currentScore {
    
    if (_currentScore == currentScore) {
        
        return;
        
    }
    
    if (currentScore < 0) {
        
        _currentScore = 0;
        
    } else if (currentScore > _numberOfStars) {
        
        _currentScore = _numberOfStars;
        
    } else {
        
        _currentScore = currentScore;
        
    }
    
    if ([self.delegate respondsToSelector:@selector(starRateView:currentScore:)]) {
        
        [self.delegate starRateView:self currentScore:_currentScore];
        
    }
    
    if (self.complete) {
        
        _complete(_currentScore);
        
    }
    //重新布局
    [self setNeedsLayout];
}
@end
