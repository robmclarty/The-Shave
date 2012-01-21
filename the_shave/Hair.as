package the_shave {
  import flash.display.Sprite;
  import flash.events.MouseEvent;  
  import org.coretween.Tween;
  import org.coretween.TweenEvent;
  import org.coretween.easing.Expo;
  
  public class Hair extends Sprite {
    private static var MAX_Y:uint = 1000; // pixels
    private static var FALL_TIME:Number = 6; // seconds
    
    private var _shaved:Boolean = false;
    private var _startx:int;
    private var _starty:int;
    private var _tween:Tween;
    
    // Constructor
    public function Hair(startx:int, starty:int):void {
      this.x = _startx = startx;
      this.y = _starty = starty;      
      reset_hair();
    }
    
    // Public API
    
    // Events
    private function hair_cut(e:MouseEvent):void {
      this.removeEventListener(MouseEvent.MOUSE_OVER, hair_cut);
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
      this.addEventListener(MouseEvent.MOUSE_OVER, hair_cut);
      if (_tween) {
        _tween.removeEventListener(TweenEvent.COMPLETE, reset_hair);
        _tween = null;
      }
      //_previous_time = 0;
    }
  }
}