package it.ht.rcs.console.entities.view.components.timeline
{
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	import mx.collections.ArrayCollection;
	import mx.events.FlexEvent;
	
	import spark.components.Button;
	import spark.components.Group;
	import spark.components.HSlider;


	public class DashboardSlider extends HSlider
	{
		[SkinPart(required="false")]
		public var incrementButton:Button;
		[SkinPart(required="false")]
		public var decrementButton:Button;
		[SkinPart(required="false")]
		public var thumbGroup:Group;
    
    
    private var monthNames:Array=["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"];

		public function DashboardSlider()
		{
			super();

			addEventListener('creationComplete', setupListeners);

		}
    
    public function highlight(flows:ArrayCollection):void
    {
      var skin:DashboardSliderSkin=this.skin as DashboardSliderSkin;
      var trackskin:HSliderTrackSkinTicks=track.skin as HSliderTrackSkinTicks
      trackskin.highlightTicks(flows)
    
    }

		private function setupListeners(e:FlexEvent):void
		{

			if (incrementButton)
			{
				incrementButton.addEventListener('click', incrementSlider);
			}

			if (decrementButton)
			{
				decrementButton.addEventListener('click', decrementSlider);
			}
		}

		private function incrementSlider(e:MouseEvent):void
		{
			value+=stepSize;
		}

		private function decrementSlider(e:MouseEvent):void
		{
			value-=stepSize;
		}

		/**
		 *  @private
		 */
		override protected function updateSkinDisplayList():void
		{
			if (!thumb || !track || !thumbGroup)
				return;

			var thumbRange:Number=track.getLayoutBoundsWidth() - thumbGroup.getLayoutBoundsWidth();
			var range:Number=maximum - minimum;

			// calculate new thumb position.
			var thumbPosTrackX:Number=(range > 0) ? ((pendingValue - minimum) / range) * thumbRange : 0;

			// convert to parent's coordinates.
			var thumbPos:Point=track.localToGlobal(new Point(thumbPosTrackX, 0));
			var thumbPosParentX:Number=thumbGroup.parent.globalToLocal(thumbPos).x;

			thumbGroup.setLayoutBoundsPosition(Math.round(thumbPosParentX), thumbGroup.getLayoutBoundsY());

			// set the thumb label
			var time:Number=Number(value);
			var d:Date=new Date();
			d.time=time;
			thumb.label=doubleDigits(d.date) + " " + monthNames[d.month]

		}

		private function doubleDigits(val:Number):String
		{
			if (val < 10)
				return String("0" + val);
			return String(val)
		}
	}
}
