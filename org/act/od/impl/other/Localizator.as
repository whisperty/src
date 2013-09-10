package org.act.od.impl.other
{
	import flash.events.EventDispatcher;
	
	import mx.resources.ResourceBundle;
	import mx.resources.ResourceManager;
	
	public class Localizator extends EventDispatcher
	{

          private static var _instance : Localizator;   
             
          private var _language : String;   
             
          //这里的resource名应与.properties文件名相同   
          [ResourceBundle("OrDesigner")]   
          private var lang_en_US : ResourceBundle;   
             
          [Bindable]   
          private var currRes : ResourceBundle;   
             
          public function Localizator(language : String = "en_US") {   
              selectLanguage(language);   
          }   
             
          public static function getInstance(language : String = "en_US"):Localizator {   
              if (_instance == null) {   
                  _instance = new Localizator(language);   
              }   
              return _instance;   
          }   
             
          private function selectLanguage(language : String):void {   
              this._language = language;   
                 
              if (_language == "en_US") {   
                  this.currRes = lang_en_US;   
              } 
              else {   
                  this.currRes = lang_en_US;   
              }   
          }   
             
          [Bindable(event="languageChange")]   
          public function getText(key : String):String {  
          	  
              return ResourceManager.getInstance().getString(this.currRes.bundleName,key);   
          }   
             
          public function get language():String {   
              return this._language;   
          }   
             
          public function set language(language : String):void {   
              if (this._language != language) {   
                  selectLanguage(language);   
                  dispatchEvent(new Event("languageChange"));   
              }   
          }   
      }   

	
}