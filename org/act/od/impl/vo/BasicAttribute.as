package org.act.od.impl.vo
{
	import Pattern.PatternModel;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	
	import org.act.od.impl.other.StringConvertor;

	/**
	 * The attribute about basic figures.
	 */
	public class BasicAttribute implements IAttribute
	{
		[Bindable]
		public var type:String;
		
		[Bindable]
		public var name:String;
		
		[Bindable]
		public var id:int;
		
		public var atts:ArrayCollection;
		public var patMode:PatternModel;
		public var patName:String;

			
		public function BasicAttribute():void 
		{
			this.type = "none";
			this.name = "";
			this.id = -1;
			this.atts = new ArrayCollection();
			this.patMode = new PatternModel();
			this.patName = patMode.patternName;
		}
		public function getAttributeArray():ArrayCollection 
		{
			return this.patMode.getPatAtt();
		}
		public function setPatMod(pt:PatternModel):void
		{
			patMode = pt;
		}
		public function update(attss:ArrayCollection):void {
			for each(var att:Object in attss) {
				if(att.name == "Name: ") {
					this.name = att.value;
				}
				else if(att.name == "Id: ") {
					this.id = this.id;
				}
				else if(att.name == "Type: ") {
					this.type = this.type;
				}
			}
		}
		public function setAttributeArray(attss:ArrayCollection):void
		{
			atts = attss;
		}
		public function getAttributeXML():Array {
			var xmlArray:Array = new Array();
			var idXMLValue : String = StringConvertor.readableToEscape(id.toString());
			var typeXMLValue : String = StringConvertor.readableToEscape(type);
			var nameXMLValue : String = StringConvertor.readableToEscape(name);
			var patXMLValue : String = StringConvertor.readableToEscape(patMode.toString());
			
			var idNode:XML = new XML("<Attribute></Attribute>");
			idNode.@name = "id";
//			idNode.@value = this.id;
			idNode.appendChild(idXMLValue);
			
			var typeNode:XML = new XML("<Attribute></Attribute>");
			typeNode.@name = "type";
//			typeNode.@text = this.type;
			typeNode.appendChild(typeXMLValue);
			
			var nameNode:XML = new XML("<Attribute></Attribute>");
			nameNode.@name = "name";
//			nameNode.@text = this.name;
			nameNode.appendChild(nameXMLValue);
			
			var patNode:XML = new XML("<Attribute></Attribute>");
			patNode.@name = "patMode";
			patNode.appendChild(patXMLValue);
			
			xmlArray.push(idNode,typeNode,nameNode,patNode);
			return xmlArray;
		}
		
		public function setAttribute(atts:XMLList):void {
			var nameNode:XMLList = atts.Attribute.(@name == "name");
			var idNode:XMLList = atts.Attribute.(@name == "id");
			var typeNode:XMLList = atts.Attribute.(@name == "type");
			var patNode:XMLList = atts.Attribute.(@name == "patMode");
			
			var nameXMLValue : String = (nameNode.children()!=null)?nameNode.children().toString():"";
			var idXMLValue : String = this.id.toString();
			var typeXMLValue : String = this.type;
			var patXMLValue : String = (patNode.children()!=null)?patNode.children().toString():"";
			
			var nameValue : String = StringConvertor.escapeToReadable(nameXMLValue);
			var idValue : String = StringConvertor.escapeToReadable(idXMLValue);
			var typeValue : String = StringConvertor.escapeToReadable(typeXMLValue);
			var patValue : String = StringConvertor.escapeToReadable(patXMLValue);
			
			this.name = nameValue;
			this.patName = patValue;
		}

	}
}