package org.act.od.impl.figure.arrow
{
	public class ArrowFactory
	{
		public function ArrowFactory()
		{
		}
		
		public function CreateArrow(arrowId:int):IArrow{
			var ia:IArrow;
			switch(arrowId)
			{
				case 1:
				ia=new SolidArrow();
				break;
				default:
				ia=null;
				break;
			}
			return ia;
		}

	}
}