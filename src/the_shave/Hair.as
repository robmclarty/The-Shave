package the_shave {
  import flash.display.Sprite;
  import flash.events.MouseEvent;
  import flash.events.TimerEvent;
  import flash.utils.Timer;
  import org.coretween.Tween;
  import org.coretween.TweenEvent;
  import org.coretween.easing.Expo;

  public class Hair extends Sprite {
    private static var MAX_Y:uint = 1000; // pixels
    private static var FALL_TIME:Number = 1.5; // seconds
    private static var DEFAULT_GROW_RATE = 100; // seconds

    private var _shaved:Boolean = false;
    private var _startx:int;
    private var _starty:int;
    private var _tween:Tween;
    private var _grow_rate:Number = DEFAULT_GROW_RATE;
    private var _timer:Timer;


    // Constructor
    public function Hair(startx:int, starty:int, start_rotation:int):void {
      this.cacheAsBitmap = true;
      this.x = _startx = startx;
      this.y = _starty = starty;
      this.rotation = start_rotation;
      if (start_rotation > 90 || start_rotation < -90) {
        this.scaleY = -this.scaleY; // Flip graphic to mirror on face.
      }
      reset_hair();
    }

    // Public API
    public function cut_hair():void {
      _shaved = true;
      _tween = new Tween(this, { y: this.y + MAX_Y }, FALL_TIME, Expo.easeOut);
      _tween.addEventListener(TweenEvent.COMPLETE, tween_finished);
      _tween.start();
    }

    public function not_yet_cut():Boolean {
      return !_shaved;
    }

    // Events
    private function hair_cut(e:MouseEvent):void {
      //this.removeEventListener(MouseEvent.MOUSE_OVER, hair_cut);
      _shaved = true;
      _tween = new Tween(this, { y: this.y + MAX_Y }, FALL_TIME, Expo.easeOut);
      _tween.addEventListener(TweenEvent.COMPLETE, tween_finished);
      _tween.start();
    }

    private function tween_finished(e:TweenEvent):void {
      reset_hair();
    }

    // Helpers
    private function reset_hair():void {
      this.y = _starty;
      this.x = _startx;
      this.mustache_hair.gotoAndStop(1);
      _shaved = false;
      //this.addEventListener(MouseEvent.MOUSE_OVER, hair_cut);
      if (_tween) {
        _tween.removeEventListener(TweenEvent.COMPLETE, reset_hair);
        _tween = null;
      }
      stop_growing();
      grow_hair();
    }

    private function grow_hair():void {
      _timer = new Timer(_grow_rate);
      _timer.addEventListener(TimerEvent.TIMER, grow);
      _timer.start();
    }

    private function stop_growing():void {
      if (_timer) { // stop timer
        _timer.stop();
        _timer.removeEventListener(TimerEvent.TIMER, grow);
        _timer = null;
      }
    }

    private function grow(e:TimerEvent):void {
      if (this.mustache_hair.currentFrame < this.mustache_hair.totalFrames) {
        this.mustache_hair.nextFrame();
      } else {
        stop_growing();
      }
    }
  }
}
