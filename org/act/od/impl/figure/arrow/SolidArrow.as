package org.act.od.impl.figure.arrow
{
	import flash.display.*;
	
	public class SolidArrow extends AbstractArrow
	{
		public function SolidArrow()
		{
			super();
			this.arrowId=1;
		}
		
		override public function drawArrow(sprite:Sprite):void{
/*			var square_commands:Vector.<int>=new Vector.<int>(4,true);
			square_commands[0]=1;
			square_commands[1]=2;
			square_commands[2]=2;
			square_commands[3]=2;
			var square_coord:Vector.<Number>=new Vector.<Number>(8,true);
			square_coord[0]=this.headPoint.x;
			square_coord[1]=this.headPoint.y;
			square_coord[2]=this.leftPoint.x;
			square_coord[3]=this.leftPoint.y;
			square_coord[4]=this.rightPoint.x;
			square_coord[5]=this.rightPoint.y;
			square_coord[6]=this.headPoint.x;
			square_coord[7]=this.headPoint.y;
			sprite.graphics.beginFill(0x000000);
			sprite.graphics.drawPath(square_commands,square_coord);
			sprite.graphics.endFill();
*/
			sprite.graphics.beginFill(0x000000);
			sprite.graphics.moveTo(this.headPoint.x,this.headPoint.y);
			sprite.graphics.lineTo(this.leftPoint.x,this.leftPoint.y);
			sprite.graphics.lineTo(this.rightPoint.x,this.rightPoint.y);
			sprite.graphics.lineTo(this.headPoint.x,this.headPoint.y);
			sprite.graphics.endFill();
		}
		
	}
}