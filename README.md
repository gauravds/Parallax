# Parallax effect demo

[![Build Status](https://travis-ci.org/dayitv89/Parallax.svg?branch=master)](https://travis-ci.org/dayitv89/Parallax)
[![codecov.io](https://codecov.io/github/dayitv89/Parallax/coverage.svg?branch=master)](https://codecov.io/github/dayitv89/Parallax?branch=master)

what is Parallax effect?


read from here : http://en.wikipedia.org/wiki/Parallax
But in term of programming, we can simply say varing speed/size of two different visible objects shows parallax effect.
Now a days in web sites and mobile application it is most common attractive point.

So How to achieve this?


One point is that just varing speed or size of two visible object, shows parallax effect. So lets assume a situation where scrollview has a image at top and when scroll down it must zoom up to center, and when scroll up image must be vary with different speed (should be slow).

![alt tag](https://raw.githubusercontent.com/gauravds/Parallax/master/HappyHoli.gif)


Just add few lines of codes and we can achieve that :

```
#pragma mark - scroll view delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView1 {
    CGFloat scrollOffset = scrollView.contentOffset.y;

    //-- that is image view where we want to show effect
    imgView.frame = [self parallaxFrame:imgViewFrame
                            scrollFrame:scrollView1.frame
                      withParallaxValue:scrollOffset];
}

#pragma mark - parallax effect logic
- (CGRect)parallaxFrame:(CGRect)frame
            scrollFrame:(CGRect)scrollFrame
      withParallaxValue:(CGFloat)val
{
    NSInteger factor = 4;

    //--  scroll up (slow motion frame up)
    if (val > 0) {
        return CGRectMake(frame.origin.x, frame.origin.y - val/factor, frame.size.width, frame.size.height);
    }

    // scroll down (must be zoom to center)
    return CGRectMake(frame.origin.x + val, frame.origin.y + val, frame.size.width - val*factor, frame.size.height - val*factor);
}

```
