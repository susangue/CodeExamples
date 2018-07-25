package com
{
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.events.*;
	import flash.events.MouseEvent;
	
	import flashx.textLayout.conversion.TextConverter;
	import flashx.textLayout.elements.*;
	import flashx.textLayout.formats.WhiteSpaceCollapse;
	
	import mx.controls.Alert;
	import mx.core.FlexGlobals;
	import mx.graphics.SolidColor;
	import mx.graphics.SolidColorStroke;
	import mx.styles.StyleManager;
	
	import skins.btnRemand01Skin;
	import skins.btnRemand02Skin;
	import skins.btnRemand03Skin;
	import skins.btnRemand04Skin;
	import skins.btnRemand05Skin;
	import skins.btnRemand06Skin;
	
	import spark.components.Button;
	import spark.components.Image;
	import spark.components.RichEditableText;
	import spark.components.ToggleButton;
	import spark.primitives.Line;
	import spark.primitives.Rect;

	public class remandProcess extends Sprite
	{
		private var whiteRectBg:Rect = new Rect();
		
		private var mainBg:Image=new Image();
		private var arrBtnSkin:Array = new Array();
		private var btnAppeal:ToggleButton = new ToggleButton();

		[Embed(source="xml/remandProcess.xml", mimeType="application/octet-stream")]
		protected const EmbeddedXML:Class;
		public var xmlData:XML = XML(new EmbeddedXML());
		
		[Embed(source="img/lsn01_09Bg.png")]
		[Bindable]
		public var clsMainBgImg:Class;
		
		private var arrBtn:Array=new Array();
		private var arrBtnTxt:Array=new Array();
		private var strWelcome:String = new String();
		private var strAnswerHdr:String = new String();
		private var strAnswerTxt:String = new String();
		private var txtWelcome:RichEditableText=new RichEditableText();
		public var txtAnswerHdr:RichEditableText=new RichEditableText();
		private var txtAnswer:RichEditableText=new RichEditableText();
		
		private var objBtn:Object=new Object();
		private var objBtnTxt:Object=new Object();

		public function remandProcess()
		{
		}
		
		public function init():void
		{
			FlexGlobals.topLevelApplication.grpBg.removeAllElements();
			FlexGlobals.topLevelApplication.grpAppealDescription.removeAllElements();
			FlexGlobals.topLevelApplication.grpBg.visible=true;
			FlexGlobals.topLevelApplication.grpAppealDescription.visible=true;
			
			arrBtnSkin[0]=skins.btnRemand01Skin;	
			arrBtnSkin[1]=skins.btnRemand02Skin;	
			arrBtnSkin[2]=skins.btnRemand03Skin;	
			arrBtnSkin[3]=skins.btnRemand04Skin;	
			arrBtnSkin[4]=skins.btnRemand05Skin;	
			arrBtnSkin[5]=skins.btnRemand06Skin;	

			objBtn=null;
			arrBtn=[];
			strWelcome="";
			txtWelcome.textFlow = TextConverter.importToFlow(strWelcome,TextConverter.TEXT_FIELD_HTML_FORMAT);
			txtWelcome.visible=false;

			mainBg.id='mainBg';
			mainBg.visible=true;
			mainBg.width=770;
			mainBg.height=510;
			mainBg.x=0;
			mainBg.y=FlexGlobals.topLevelApplication.contentAreaHeight-mainBg.height;
			mainBg.tabEnabled=false;
			mainBg.buttonMode=false;
			mainBg.mouseEnabled=false;
			mainBg.source = clsMainBgImg;
			FlexGlobals.topLevelApplication.grpBg.addElement(mainBg);
			
			whiteRectBg.fill = new SolidColor(0xffffff,1);
			whiteRectBg.radiusX=20;
			whiteRectBg.radiusY=20;
			whiteRectBg.width=400;
			whiteRectBg.height=460;
			whiteRectBg.y=mainBg.y;
			whiteRectBg.visible=false;
			whiteRectBg.x=mainBg.x+mainBg.width+30;
			
			strWelcome=""+xmlData.instructions[0].text();
			txtWelcome=new RichEditableText();
			txtWelcome.styleName="branchStart";
			txtWelcome.textFlow = TextConverter.importToFlow(strWelcome,TextConverter.TEXT_FIELD_HTML_FORMAT);
			txtWelcome.accessibilityName="Welcome";
			txtWelcome.height=340;
			txtWelcome.width=358;
			txtWelcome.editable=false;
			txtWelcome.selectable=false;
			txtWelcome.tabEnabled=true;
			txtWelcome.tabIndex=32;
			txtWelcome.buttonMode=false;
			txtWelcome.mouseEnabled=false;
			txtWelcome.visible=true;
			txtWelcome.x=whiteRectBg.x+25;
			txtWelcome.y=whiteRectBg.y+40;
			FlexGlobals.topLevelApplication.grpBg.addElement(txtWelcome);
			
			for(var iSelect:int=0;iSelect<xmlData.paraContent.length();iSelect++)
			{
				btnAppeal=new ToggleButton();
				btnAppeal.id=""+(iSelect);
				btnAppeal.setStyle("skinClass", arrBtnSkin[iSelect]);
				btnAppeal.width=220;
				btnAppeal.height=126;				
				btnAppeal.addEventListener(MouseEvent.CLICK, selectQuestionBtn);				
				btnAppeal.buttonMode= true;
				btnAppeal.mouseEnabled= true;		
				btnAppeal.tabEnabled= true;				
				btnAppeal.tabIndex=(33+iSelect);	
				btnAppeal.accessibilityName=""+xmlData.paraContent[iSelect].@id;
				btnAppeal.accessibilityDescription="Not Selected";
				btnAppeal.y=mainBg.y;
				FlexGlobals.topLevelApplication.grpBg.addElement(btnAppeal);
				objBtn=btnAppeal;
				arrBtn.push(objBtn);
				arrBtn[0].x=mainBg.x+30;
				
				if(btnAppeal!=arrBtn[0])
				{
					arrBtn[iSelect].x=arrBtn[iSelect-1].x+arrBtn[iSelect-1].width+35;
				}				
				if(btnAppeal==arrBtn[3])
				{
					arrBtn[3].y=arrBtn[iSelect].y+arrBtn[iSelect].height+106;
					arrBtn[3].x=(mainBg.x+mainBg.width)-arrBtn[iSelect].width;
				}
				if(btnAppeal==arrBtn[4])
				{
					arrBtn[4].y=arrBtn[3].y;
					arrBtn[4].x=arrBtn[3].x-arrBtn[4].width-35;
				}
				if(btnAppeal==arrBtn[5])
				{
					arrBtn[5].y=arrBtn[4].y;
					arrBtn[5].x=arrBtn[4].x-arrBtn[5].width-35;
				}
			}

		}
		
		private function selectQuestionBtn(event:MouseEvent):void
		{
			resetQuestion();
			txtWelcome.visible=false;
			whiteRectBg.visible=true;
			FlexGlobals.topLevelApplication.grpBg.addElement(whiteRectBg);
			arrBtn[int(event.currentTarget.id)].buttonMode=false;
			arrBtn[int(event.currentTarget.id)].mouseEnabled=false;
			arrBtn[int(event.currentTarget.id)].removeEventListener(MouseEvent.CLICK, selectQuestionBtn);
			arrBtn[int(event.currentTarget.id)].selected=true;
			arrBtn[int(event.currentTarget.id)].accessibilityDescription="Selected";
			
			var intCurrent:int=event.currentTarget.id;
			var intCharCount:int;
			var intBoxHeight:int;
			var numBoxHeight:Number;
			strAnswerTxt="";			
			strAnswerHdr="<p>"+xmlData.paraContent[intCurrent].@id+"</p>";
			strAnswerTxt="<p>"+xmlData.paraContent[intCurrent].text()+"</p>";	
			intCharCount=strAnswerHdr.length;
			
			txtAnswerHdr.styleName="optionHdr";
			txtAnswerHdr.accessibilityName="Header";
			txtAnswerHdr.width=whiteRectBg.width-60;
			txtAnswerHdr.editable=false;
			txtAnswerHdr.selectable=false;
			txtAnswerHdr.tabEnabled=true;
			txtAnswerHdr.tabIndex=31;
			txtAnswerHdr.buttonMode=false;
			txtAnswerHdr.mouseEnabled=false;
			txtAnswerHdr.x=whiteRectBg.x+20;
			txtAnswerHdr.y=whiteRectBg.y+25;
			txtAnswerHdr.visible=false;	
			numBoxHeight=(intCharCount/txtAnswerHdr.width)*10;
			txtAnswerHdr.heightInLines=int(numBoxHeight)+1;
			if(numBoxHeight>1.35)
			{
				intBoxHeight=(txtAnswerHdr.heightInLines-1)*25+25;				
			} else if(numBoxHeight>=1&&numBoxHeight<1.35){
				intBoxHeight=(txtAnswerHdr.heightInLines-1)*25;				
			} else if(numBoxHeight<1){
				intBoxHeight=25;				
			}
			
			txtAnswer.styleName="appealTxt";
			txtAnswer.height=340;
			txtAnswer.width=txtAnswerHdr.width;
			txtAnswer.accessibilityName="Description";
			txtAnswer.editable=false;
			txtAnswer.selectable=false;
			txtAnswer.tabEnabled=true;
			txtAnswer.tabIndex=32;
			txtAnswer.buttonMode=false;
			txtAnswer.mouseEnabled=false;
			txtAnswer.x=txtAnswerHdr.x+10;
			txtAnswer.y=txtAnswerHdr.y+intBoxHeight+15;
			txtAnswer.visible=false;	
			
			txtAnswerHdr.visible=true;	
			txtAnswer.visible=true;			
			txtAnswerHdr.textFlow = TextConverter.importToFlow(strAnswerHdr,TextConverter.TEXT_FIELD_HTML_FORMAT);
			txtAnswer.textFlow = TextConverter.importToFlow(strAnswerTxt,TextConverter.TEXT_FIELD_HTML_FORMAT);
			FlexGlobals.topLevelApplication.grpAppealDescription.addElement(txtAnswer);
			FlexGlobals.topLevelApplication.grpAppealDescription.addElement(txtAnswerHdr);
			FlexGlobals.topLevelApplication.focusManager.setFocus(txtAnswerHdr);

		}
		
		public function resetQuestion():void
		{
			for(var iBtn:int=0;iBtn<arrBtn.length;iBtn++)
			{
				arrBtn[iBtn].buttonMode=true;
				arrBtn[iBtn].mouseEnabled=true;
				arrBtn[iBtn].addEventListener(MouseEvent.CLICK, selectQuestionBtn);
				arrBtn[iBtn].selected=false;
				arrBtn[iBtn].accessibilityDescription="Not Selected";
			}
		}
		
		public function hideInteraction():void
		{
			FlexGlobals.topLevelApplication.grpBg.visible=false;
			FlexGlobals.topLevelApplication.grpAppealDescription.visible=false;
		}
		
		public function tabOn():void
		{	
			txtWelcome.tabEnabled=true;
			txtWelcome.tabIndex=32;
			for(var i:int=0;i<arrBtn.length;i++)
			{
				arrBtn[i].tabEnabled=true;
				arrBtn[i].tabIndex=33;
			}
			txtAnswerHdr.tabEnabled=true;
			txtAnswerHdr.tabIndex=33;
			txtAnswer.tabEnabled=true;
			txtAnswer.tabIndex=33;
			silentOff();
		}
		
		public function silentOff():void
		{
			txtWelcome.accessibilityEnabled=true;
			for(var i:int=0;i<arrBtn.length;i++)
			{
				arrBtn[i].accessibilityEnabled=true;
			}
			txtAnswerHdr.accessibilityEnabled=true;
			txtAnswer.accessibilityEnabled=true;
		}
		
		public function tabOff():void
		{
			txtWelcome.tabEnabled=false;
			txtWelcome.tabIndex=0;
			for(var i:int=0;i<arrBtn.length;i++)
			{
				arrBtn[i].tabEnabled=false;
				arrBtn[i].tabIndex=0;
			}
			txtAnswerHdr.tabEnabled=false;
			txtAnswerHdr.tabIndex=0;
			txtAnswer.tabEnabled=false;
			txtAnswer.tabIndex=0;
			silentOn();
		}

		public function silentOn():void
		{
			txtWelcome.accessibilityEnabled=false;
			for(var i:int=0;i<arrBtn.length;i++)
			{
				arrBtn[i].accessibilityEnabled=false;
			}
			txtAnswerHdr.accessibilityEnabled=false;
			txtAnswer.accessibilityEnabled=false;
		}

	}
}
