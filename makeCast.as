package com
{	
	import com.focusableImg;
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import mx.controls.Alert;
	import mx.core.FlexGlobals;
	import mx.graphics.SolidColor;
	
	import spark.components.Button;
	import spark.components.Group;
	import spark.components.Image;
	import spark.components.RichEditableText;
	import spark.primitives.Rect;
	
	import flashx.textLayout.conversion.TextConverter;
	
	import skins.btnArrowLeftSkin;
	import skins.btnArrowRightSkin;
	import skins.btnCallerNavSkin;
	import skins.btnDocCloseSkin;
	import spark.filters.DropShadowFilter;
	import skins.btnLearnMoreSkin;
	
	public class makeCast extends Sprite
	{
		/*-- Rays --*/
		[Embed(source="gui/callerCenter.png")]
		[Bindable]
		public var clsCallerCenter:Class;
		
		[Embed(source="gui/callerArrow.png")]
		[Bindable]
		public var clsCallerArrow:Class;
		
		public var xmlCallerData:XML=new XML();
		
		public var arrCastMember:Array=new Array();
		public var arrCastMemberCls:Array=new Array();
		public var arrCastAttributes:Array=new Array();
		public var arrCallerXPos:Array=new Array();
		
		public var retCallerNm:RichEditableText=new RichEditableText();
		
		public var strCallerNm:String=new String();
		
		private var btnLearnMore:Button=new Button();
		private var btnNavLeft:Button=new Button();
		private var btnNavRight:Button=new Button();
		
		public var grpCast:Group = new Group();
		private var grpNav:Group = new Group();
		private var grpMaskInfo:Group=new Group();
		
		private var rectMask:Rect=new Rect();
		
		public var centerImg:Image=new Image();
		public var imgArrow:Image=new Image();
		
		public var intCurrentCast:int=0;		
		public var intAmtCast:int;
		
		public var boolViewed:Boolean;
		
		public var showTimer:Timer;
		
		private var dsf:DropShadowFilter;
		
		public function makeCast()
		{
		}
		
		/*******************************************************************************
		 ** Function: createCast()
		 ** Input:  None
		 ** Output:  Caller Cast Member layout
		 *******************************************************************************/
		public function createCast():void
		{
			dsf = new DropShadowFilter(4,90,0x166570,.6);
			FlexGlobals.topLevelApplication.arrCastMemberCls=FlexGlobals.topLevelApplication.moduleImg.arrModImg;
			FlexGlobals.topLevelApplication.grpCallers.removeAllElements();
			grpMaskInfo=new Group();
			grpMaskInfo.width=1230;
			grpMaskInfo.height=591;
			
			rectMask.fill=new SolidColor(0x00FFFF,1);
			rectMask.width=930;
			rectMask.x=(grpMaskInfo.width/2)-(rectMask.width/2);
			rectMask.height=grpMaskInfo.height;
			grpMaskInfo.addElement(rectMask);	
			
			grpNav=new Group();
			grpNav.width=1230;
			grpNav.height=591;
			
			strCallerNm="";
			xmlCallerData=FlexGlobals.topLevelApplication.setLessonData.currentLsnData;
			var objCastImg:Object=null;
			var castImg:focusableImg=new focusableImg();
			
			arrCastMemberCls=[];
			arrCastMemberCls=FlexGlobals.topLevelApplication.arrCastMemberCls;
			
			arrCallerXPos[0]=1104;
			arrCallerXPos[1]=802;
			arrCallerXPos[2]=500;
			arrCallerXPos[3]=198;
			arrCallerXPos[4]=-104;
			arrCallerXPos[5]=-406;
			arrCallerXPos[6]=-708;
			
			arrCastAttributes[0]=[0,0,230,390,1];
			
			intAmtCast=xmlCallerData.caller.length();
			
			centerImg.id="sun rays";
			centerImg.visible=true;
			centerImg.width=362;
			centerImg.height=404;
			centerImg.buttonMode=false;
			centerImg.mouseEnabled=false;
			centerImg.accessibilityName="Sun rays";
			centerImg.source=clsCallerCenter;
			centerImg.tabEnabled=false;
			centerImg.tabIndex=0;
			centerImg.x=FlexGlobals.topLevelApplication.stageWidth/2-centerImg.width/2;
			centerImg.y=75;
			grpCast.addElement(centerImg);
			
			imgArrow.id="arrow";
			imgArrow.visible=true;
			imgArrow.width=20;
			imgArrow.height=20;
			imgArrow.buttonMode=false;
			imgArrow.mouseEnabled=false;
			imgArrow.accessibilityName="Caller name arrow";
			imgArrow.source=clsCallerArrow;
			imgArrow.tabEnabled=false;
			imgArrow.tabIndex=0;
			imgArrow.x=(centerImg.x+centerImg.width/2)+50;
			imgArrow.y=(centerImg.y+284);
			grpCast.addElement(imgArrow);
			
			strCallerNm="";
			retCallerNm.textFlow = TextConverter.importToFlow(strCallerNm,TextConverter.TEXT_FIELD_HTML_FORMAT);
			strCallerNm=""+xmlCallerData.caller[0].@callerNm;
			retCallerNm=new RichEditableText();
			retCallerNm.textFlow = TextConverter.importToFlow(strCallerNm,TextConverter.TEXT_FIELD_HTML_FORMAT);
			retCallerNm.accessibilityName="Caller's Name";
			retCallerNm.selectable=false;
			retCallerNm.editable=false;
			retCallerNm.tabIndex=30;
			retCallerNm.tabEnabled=true;
			retCallerNm.buttonMode=false;
			retCallerNm.mouseEnabled=false;
			retCallerNm.styleName="callerNmTxt";
			retCallerNm.height=36;
			retCallerNm.width=100;
			retCallerNm.x=(centerImg.x+centerImg.width)-(retCallerNm.width+10);
			retCallerNm.y=(imgArrow.y+imgArrow.height/2)-(retCallerNm.height/4);
			
			btnLearnMore.id="btnLearnMore";
			btnLearnMore.visible=true;
			btnLearnMore.width=56;
			btnLearnMore.height=70;
			btnLearnMore.label="";
			btnLearnMore.buttonMode=true;
			btnLearnMore.mouseEnabled=true;
			btnLearnMore.accessibilityName="Learn More";
			btnLearnMore.accessibilityDescription="Directional arrow pointing to icon to learn more about caller";
			btnLearnMore.setStyle("skinClass", skins.btnLearnMoreSkin);
			btnLearnMore.tabEnabled=true;
			btnLearnMore.tabIndex=31;
			btnLearnMore.x=(centerImg.x+centerImg.width/2)-btnLearnMore.width/2;
			btnLearnMore.y=centerImg.y+20;
			btnLearnMore.addEventListener(MouseEvent.CLICK, hideCast);
			btnLearnMore.addEventListener(MouseEvent.ROLL_OVER, moverPause);
			btnLearnMore.addEventListener(MouseEvent.ROLL_OUT, moverPlay);
			btnLearnMore.filters=[dsf];
			
			for(var iCast:int=0;iCast<arrCastMemberCls.length;iCast++)
			{
				if(boolViewed==false)
				{
					castImg=new focusableImg();
					
					castImg.id=""+xmlCallerData.caller[iCast].@callerType;
					
					castImg.visible=true;
					castImg.width=arrCastAttributes[0][2];
					castImg.height=arrCastAttributes[0][3];
					castImg.buttonMode=false;
					castImg.mouseEnabled=false;
					castImg.accessibilityName="Caller image";
					castImg.accessibilityDescription=""+xmlCallerData.caller[iCast].@callerNm;
					castImg.alpha=1;
					castImg.source=arrCastMemberCls[iCast][0];
					castImg.tabEnabled=false;
					castImg.tabIndex=32+iCast;
					castImg.y=btnLearnMore.y+btnLearnMore.height;
					grpCast.addElement(castImg);
					
					objCastImg=castImg;
					arrCastMember.push(objCastImg);
				}
				xPosCast();							
			}
			
			arrCastMember[0].tabEnabled=true;
			
			grpCast.addElement(retCallerNm);
			grpCast.addElement(btnLearnMore);
			
			FlexGlobals.topLevelApplication.mover.target=btnLearnMore;
			FlexGlobals.topLevelApplication.mover.play();
			
			for(var iCastMem:int=0;iCastMem<arrCastMember.length;iCastMem++)
			{
				if(arrCastMember[iCastMem].x!=arrCallerXPos[1]||arrCastMember[iCastMem].x!=arrCallerXPos[2]||arrCastMember[iCastMem].x!=arrCallerXPos[3])
				{
					arrCastMember[iCastMem].alpha=0;					
				}
				if(arrCastMember[iCastMem].x==arrCallerXPos[2])
				{
					arrCastMember[iCastMem].alpha=1;					
				}
				if(arrCastMember[iCastMem].x==arrCallerXPos[1]||arrCastMember[iCastMem].x==arrCallerXPos[3])
				{
					arrCastMember[iCastMem].alpha=.5;					
				}
			}
			
			boolViewed=true;
			
			btnNavRight.id="btnNavRight";
			btnNavRight.visible=true;
			btnNavRight.width=116;
			btnNavRight.height=144;
			btnNavRight.label="";
			btnNavRight.buttonMode=true;
			btnNavRight.mouseEnabled=true;
			btnNavRight.accessibilityName="Select arrow to view the next caller: Available";
			btnNavRight.setStyle("skinClass", skins.btnArrowRightSkin);
			btnNavRight.tabEnabled=true;
			btnNavRight.tabIndex=41;
			btnNavRight.x=FlexGlobals.topLevelApplication.stageWidth-(btnNavRight.width+45);
			btnNavRight.y=(grpNav.height/2)-(btnNavRight.height/2);
			btnNavRight.addEventListener(MouseEvent.CLICK, navCast);
			
			btnNavLeft.id="btnNavLeft";
			btnNavLeft.visible=true;
			btnNavLeft.width=116;
			btnNavLeft.height=144;
			btnNavLeft.label="";
			btnNavLeft.buttonMode=true;
			btnNavLeft.mouseEnabled=true;
			btnNavLeft.accessibilityName="Select arrow to view the previous caller: Available";
			btnNavLeft.setStyle("skinClass", skins.btnArrowLeftSkin);
			btnNavLeft.tabEnabled=true;
			btnNavLeft.tabIndex=40;
			btnNavLeft.x=45;
			btnNavLeft.y=btnNavRight.y;
			btnNavLeft.addEventListener(MouseEvent.CLICK, navCast);
			grpNav.addElement(btnNavLeft);
			grpNav.addElement(btnNavRight);
			
			grpCast.mask=grpMaskInfo;
			setUpBtn();			
		}
		
		/*******************************************************************************
		 ** Function: moverPause(mouseEvent)
		 ** Input:  None
		 ** Output:  Pauses the motion of the "Learn More" button
		 *******************************************************************************/
		public function moverPause(event:MouseEvent):void
		{
			FlexGlobals.topLevelApplication.mover.pause();
			btnLearnMore.y=centerImg.y+27;			
		}
		
		/*******************************************************************************
		 ** Function: moverPlay(mouseEvent)
		 ** Input:  None
		 ** Output:  Activates the motion of the "Learn More" button
		 *******************************************************************************/
		public function moverPlay(event:MouseEvent):void
		{
			FlexGlobals.topLevelApplication.mover.play();
		}
		
		/*******************************************************************************
		 ** Function: setUpBtn()
		 ** Input:  None
		 ** Output:  Set up for the caller navigation buttons
		 *******************************************************************************/
		public function setUpBtn():void
		{
			if(arrCastMember.length==1)
			{
				btnNavLeft.visible=false;
				btnNavLeft.buttonMode=false;
				btnNavLeft.mouseEnabled=false;
				btnNavLeft.tabEnabled=false;
				btnNavLeft.accessibilityName="Select arrow to view the previous caller: Disabled";
				btnNavLeft.tabIndex=0;
				btnNavLeft.removeEventListener(MouseEvent.CLICK, navCast);
				btnNavLeft.enabled=false;
				btnNavRight.visible=false;
				btnNavRight.buttonMode=false;
				btnNavRight.mouseEnabled=false;
				btnNavRight.tabEnabled=false;
				btnNavRight.tabIndex=0;
				btnNavRight.removeEventListener(MouseEvent.CLICK, navCast);
				btnNavRight.accessibilityName="Select arrow to view the next caller: Disabled";
				btnNavRight.enabled=false;
			}
			
			if(arrCastMember.length>=2)
			{
//				btnNavLeft.alpha=.5;
				btnNavLeft.visible=true;
				btnNavLeft.buttonMode=false;
				btnNavLeft.mouseEnabled=false;
				btnNavLeft.tabEnabled=false;
				btnNavLeft.tabIndex=0;
				btnNavLeft.removeEventListener(MouseEvent.CLICK, navCast);
				btnNavLeft.accessibilityName="Select arrow to view the previous caller: Disabled";
				btnNavLeft.enabled=false;
//				btnNavRight.alpha=1;
				btnNavRight.visible=true;
				btnNavRight.buttonMode=true;
				btnNavRight.mouseEnabled=true;
				btnNavRight.tabEnabled=true;
				btnNavRight.tabIndex=41;
				btnNavRight.accessibilityName="Select arrow to view the next caller: Available";
				btnNavRight.addEventListener(MouseEvent.CLICK, navCast);
				btnNavRight.enabled=true;
			}
		}
		
		/*******************************************************************************
		 ** Function: showCastMembers()
		 ** Input:  None
		 ** Output:  Displays cast members; calls createCast() function
		 *******************************************************************************/
		public function showCastMembers():void
		{						
			createCast();
			FlexGlobals.topLevelApplication.grpCallers.addElement(grpCast);
			FlexGlobals.topLevelApplication.grpCallers.addElement(grpMaskInfo);
			FlexGlobals.topLevelApplication.grpCallers.addElement(grpNav);
			grpCast.alpha=0;
			grpCast.visible=true;				
			grpMaskInfo.alpha=0;
			grpNav.alpha=0;
			
			var showTimer:Timer=new Timer(200,1);
			showTimer.start();
			showTimer.addEventListener(TimerEvent.TIMER_COMPLETE, showCast);
			function showCast():void
			{
				showTimer.stop();
				if(grpCast.alpha!=1)
				{					
					FlexGlobals.topLevelApplication.fadeMenuIn.targets=[grpCast,grpNav,grpMaskInfo];
					FlexGlobals.topLevelApplication.fadeMenuIn.play();					
				}
			}
		}
		
		/*******************************************************************************
		 ** Function: hideCast(mouseEvent)
		 ** Input:  None
		 ** Output:  Hides cast members
		 *******************************************************************************/
		public function hideCast(event:MouseEvent):void
		{
			FlexGlobals.topLevelApplication.getCallerInfo.showCallerInfo();
			FlexGlobals.topLevelApplication.focusManager.setFocus(FlexGlobals.topLevelApplication.getCallerInfo.imgCaller01);
		}
		
		/*******************************************************************************
		 ** Function: drawCast()
		 ** Input:  None
		 ** Output:  Adds cast members to the top level grpCallers
		 *******************************************************************************/
		public function drawCast():void
		{
			FlexGlobals.topLevelApplication.grpCallers.addElement(grpCast);
			grpCast.visible=true;				
			grpCast.alpha=1;
		}
		
		/*******************************************************************************
		 ** Function: xPosCast()
		 ** Input:  None
		 ** Output:  Position of the  cast members
		 *******************************************************************************/
		public function xPosCast():void
		{
			arrCastMember[0].x=arrCallerXPos[2];
			if(arrCastMember.length>=2)
			{
				arrCastMember[1].x=arrCallerXPos[3];
			}
			if(arrCastMember.length>=3)
			{
				arrCastMember[2].x=arrCallerXPos[4];
			}
			if(arrCastMember.length>=4)
			{
				arrCastMember[3].x=arrCallerXPos[5];
			}
			if(arrCastMember.length>=5)
			{
				arrCastMember[4].x=arrCallerXPos[6];
			}						
		}
		
		/*******************************************************************************
		 ** Function: navCast(mouseEvent)
		 ** Input:  None
		 ** Output: Navigation functionality of cast member
		 *******************************************************************************/
		public function navCast(event:MouseEvent):void
		{
			var objCallerMove:Object=null;
			var arrCallerMove:Array=[];
			
			var iTargets:int;
			
			for(iTargets=0;iTargets<arrCastMember.length;iTargets++)
			{
				objCallerMove=arrCastMember[iTargets];
				arrCallerMove.push(objCallerMove);
				arrCastMember[iTargets].tabEnabled=false;
				arrCastMember[iTargets].tabIndex=0;				
			}
			
			switch(event.currentTarget.id)
			{
				case "btnNavLeft":					
					if(intCurrentCast!=0)
					{
						intCurrentCast=intCurrentCast-1;						
						
						FlexGlobals.topLevelApplication.moveCallerLeft.targets=arrCallerMove;						
						FlexGlobals.topLevelApplication.moveCallerLeft.play();	
						
						var fadeLeftTimer:Timer=new Timer(400,1);
						fadeLeftTimer.start();
						fadeLeftTimer.addEventListener(TimerEvent.TIMER_COMPLETE,fadeToLeft);
						
//						btnNavRight.alpha=.5;
						btnNavRight.buttonMode=false;
						btnNavRight.mouseEnabled=false;
						btnNavRight.tabEnabled=false;
						btnNavRight.tabIndex=0;
						btnNavRight.removeEventListener(MouseEvent.CLICK, navCast);
						btnNavRight.accessibilityName="Select arrow to view the next caller: Disabled";
						btnNavRight.enabled=false;
						
//						btnNavLeft.alpha=.5;
						btnNavLeft.buttonMode=false;
						btnNavLeft.mouseEnabled=false;
						btnNavLeft.tabEnabled=false;
						btnNavLeft.tabIndex=0;
						btnNavLeft.accessibilityName="Select arrow to view the previous caller: Disabled";
						btnNavLeft.removeEventListener(MouseEvent.CLICK, navCast);							
						btnNavLeft.enabled=false;
						
						function fadeToLeft():void
						{
							for(var iCastLeft:int=0;iCastLeft<arrCastMember.length;iCastLeft++)
							{
								switch(arrCastMember[iCastLeft].x)
								{
									case arrCallerXPos[0]:
										FlexGlobals.topLevelApplication.fadeCallerOut01.alphaTo=0;
										FlexGlobals.topLevelApplication.fadeCallerOut01.target=arrCastMember[iCastLeft];
										FlexGlobals.topLevelApplication.fadeCallerOut01.play();
										break;
									case arrCallerXPos[1]:
										FlexGlobals.topLevelApplication.fadeCallerOut02.alphaTo=.5;
										FlexGlobals.topLevelApplication.fadeCallerOut02.target=arrCastMember[iCastLeft];
										FlexGlobals.topLevelApplication.fadeCallerOut02.play();
										break;
									case arrCallerXPos[2]:
										FlexGlobals.topLevelApplication.fadeCallerOut03.alphaTo=1;
										FlexGlobals.topLevelApplication.fadeCallerOut03.target=arrCastMember[iCastLeft];
										FlexGlobals.topLevelApplication.fadeCallerOut03.play();
										break;
									case arrCallerXPos[3]:
										FlexGlobals.topLevelApplication.fadeCallerOut04.alphaTo=.5;
										FlexGlobals.topLevelApplication.fadeCallerOut04.target=arrCastMember[iCastLeft];
										FlexGlobals.topLevelApplication.fadeCallerOut04.play();
										break;
									case arrCallerXPos[4]:
										FlexGlobals.topLevelApplication.fadeCallerOut05.alphaTo=0;
										FlexGlobals.topLevelApplication.fadeCallerOut05.target=arrCastMember[iCastLeft];
										FlexGlobals.topLevelApplication.fadeCallerOut05.play();
										break;
									case arrCallerXPos[5]:
										FlexGlobals.topLevelApplication.fadeCallerOut06.alphaTo=0;
										FlexGlobals.topLevelApplication.fadeCallerOut06.target=arrCastMember[iCastLeft];
										FlexGlobals.topLevelApplication.fadeCallerOut06.play();
										break;
									case arrCallerXPos[6]:
										FlexGlobals.topLevelApplication.fadeCallerOut07.alphaTo=0;
										FlexGlobals.topLevelApplication.fadeCallerOut07.target=arrCastMember[iCastLeft];
										FlexGlobals.topLevelApplication.fadeCallerOut07.play();
										break;
								}
							}
							
							var navAccessLeftTimer:Timer=new Timer(500,1);
							navAccessLeftTimer.start();
							navAccessLeftTimer.addEventListener(TimerEvent.TIMER_COMPLETE,navAccessLeft);
							
							function navAccessLeft():void
							{
								if(intCurrentCast!=arrCastMember.length)
								{
									btnNavRight.buttonMode=true;
									btnNavRight.mouseEnabled=true;
									btnNavRight.tabEnabled=true;
									btnNavRight.tabIndex=40;
									btnNavRight.addEventListener(MouseEvent.CLICK, navCast);
									btnNavRight.accessibilityName="Select arrow to view the next caller: Available";
									btnNavRight.enabled=true;
									
/*									FlexGlobals.topLevelApplication.navFadeRight.alphaTo=1;
									FlexGlobals.topLevelApplication.navFadeRight.target=btnNavRight;
									FlexGlobals.topLevelApplication.navFadeRight.play();
*/								}
								
								if(intCurrentCast==0)
								{
									btnNavLeft.buttonMode=false;
									btnNavLeft.mouseEnabled=false;
									btnNavLeft.tabEnabled=false;
									btnNavLeft.tabIndex=0;
									btnNavLeft.removeEventListener(MouseEvent.CLICK, navCast);
									btnNavLeft.accessibilityName="Select arrow to view the previous caller: Disabled";
									btnNavLeft.enabled=false;
									
/*									FlexGlobals.topLevelApplication.navFadeLeft.alphaTo=.5;
									FlexGlobals.topLevelApplication.navFadeLeft.target=btnNavLeft;
									FlexGlobals.topLevelApplication.navFadeLeft.play();
*/									
								} else {
									btnNavLeft.buttonMode=true;
									btnNavLeft.mouseEnabled=true;
									btnNavLeft.tabEnabled=true;
									btnNavLeft.tabIndex=41;
									btnNavLeft.addEventListener(MouseEvent.CLICK, navCast);		
									btnNavLeft.accessibilityName="Select arrow to view the previous caller: Available";					
									btnNavLeft.enabled=true;
									
/*									FlexGlobals.topLevelApplication.navFadeLeft.alphaTo=1;
									FlexGlobals.topLevelApplication.navFadeLeft.target=btnNavLeft;
									FlexGlobals.topLevelApplication.navFadeLeft.play();
*/								}
							}
						}						
					}
					break;
				case "btnNavRight":					
					if(intCurrentCast<intAmtCast-1&&intCurrentCast<arrCastMember.length)
					{
						intCurrentCast=intCurrentCast+1;						
						FlexGlobals.topLevelApplication.moveCallerRight.targets=arrCallerMove;						
						FlexGlobals.topLevelApplication.moveCallerRight.play();
						
						var fadeRightTimer:Timer=new Timer(400,1);
						fadeRightTimer.start();
						fadeRightTimer.addEventListener(TimerEvent.TIMER_COMPLETE,fadeToRight);
						
//						btnNavLeft.alpha=.5;
						btnNavLeft.buttonMode=false;
						btnNavLeft.mouseEnabled=false;
						btnNavLeft.tabEnabled=false;
						btnNavLeft.tabIndex=0;
						btnNavLeft.removeEventListener(MouseEvent.CLICK, navCast);
						btnNavLeft.accessibilityName="Select arrow to view the previous caller: Disabled";
						btnNavLeft.enabled=false;
						
//						btnNavRight.alpha=.5;
						btnNavRight.buttonMode=false;
						btnNavRight.mouseEnabled=false;
						btnNavRight.tabEnabled=false;
						btnNavRight.tabIndex=0;
						btnNavRight.removeEventListener(MouseEvent.CLICK, navCast);
						btnNavRight.accessibilityName="Select arrow to view the next caller: Disabled";
						btnNavRight.enabled=false;
					
						function fadeToRight():void
						{
							for(var iCastRight:int=0;iCastRight<arrCastMember.length;iCastRight++)
							{
								switch(arrCastMember[iCastRight].x)
								{
									case arrCallerXPos[0]:
										FlexGlobals.topLevelApplication.fadeCaller01.alphaTo=0;
										FlexGlobals.topLevelApplication.fadeCaller01.target=arrCastMember[iCastRight];
										FlexGlobals.topLevelApplication.fadeCaller01.play();
										break;
									case arrCallerXPos[1]:
										FlexGlobals.topLevelApplication.fadeCallerOut01.alphaTo=.5;
										FlexGlobals.topLevelApplication.fadeCallerOut01.target=arrCastMember[iCastRight];
										FlexGlobals.topLevelApplication.fadeCallerOut01.play();
										break;
									case arrCallerXPos[2]:
										FlexGlobals.topLevelApplication.fadeCallerOut02.alphaTo=1;
										FlexGlobals.topLevelApplication.fadeCallerOut02.target=arrCastMember[iCastRight];
										FlexGlobals.topLevelApplication.fadeCallerOut02.play();
										break;
									case arrCallerXPos[3]:
										FlexGlobals.topLevelApplication.fadeCallerOut03.alphaTo=.5;
										FlexGlobals.topLevelApplication.fadeCallerOut03.target=arrCastMember[iCastRight];
										FlexGlobals.topLevelApplication.fadeCallerOut03.play();
										break;
									case arrCallerXPos[4]:
										FlexGlobals.topLevelApplication.fadeCallerOut04.alphaTo=0;
										FlexGlobals.topLevelApplication.fadeCallerOut04.target=arrCastMember[iCastRight];
										FlexGlobals.topLevelApplication.fadeCallerOut04.play();
										break;
									case arrCallerXPos[5]:
										FlexGlobals.topLevelApplication.fadeCallerOut05.alphaTo=0;
										FlexGlobals.topLevelApplication.fadeCallerOut05.target=arrCastMember[iCastRight];
										FlexGlobals.topLevelApplication.fadeCallerOut05.play();
										break;
								}
							}
							
							var navAccessRightTimer:Timer=new Timer(500,1);
							navAccessRightTimer.start();
							navAccessRightTimer.addEventListener(TimerEvent.TIMER_COMPLETE,navAccessRight);
							
							function navAccessRight():void
							{
								if((intCurrentCast+1)>1)
								{
									btnNavLeft.buttonMode=true;
									btnNavLeft.mouseEnabled=true;
									btnNavLeft.tabEnabled=true;
									btnNavLeft.tabIndex=40;
									btnNavLeft.accessibilityName="Select arrow to view the previous caller: Available";
									btnNavLeft.addEventListener(MouseEvent.CLICK, navCast);
									btnNavLeft.enabled=true;
									
/*									FlexGlobals.topLevelApplication.navFadeLeft.alphaTo=1;
									FlexGlobals.topLevelApplication.navFadeLeft.target=btnNavLeft;
									FlexGlobals.topLevelApplication.navFadeLeft.play();
*/								}
								if((intCurrentCast+1)==arrCastMember.length)
								{
									btnNavRight.buttonMode=false;
									btnNavRight.mouseEnabled=false;
									btnNavRight.tabEnabled=false;
									btnNavRight.tabIndex=0;
									btnNavRight.removeEventListener(MouseEvent.CLICK, navCast);
									btnNavRight.accessibilityName="Select arrow to view the next caller: Unavailable";
									btnNavRight.enabled=false;
									
/*									FlexGlobals.topLevelApplication.navFadeRight.alphaTo=.5;
									FlexGlobals.topLevelApplication.navFadeRight.target=btnNavRight;
									FlexGlobals.topLevelApplication.navFadeRight.play();
*/								} else {
									btnNavRight.buttonMode=true;
									btnNavRight.mouseEnabled=true;
									btnNavRight.tabEnabled=true;
									btnNavRight.tabIndex=41;
									btnNavRight.addEventListener(MouseEvent.CLICK, navCast);
									btnNavRight.accessibilityName="Select arrow to view the next caller: Available";
									btnNavRight.enabled=true;
									
/*									FlexGlobals.topLevelApplication.navFadeRight.alphaTo=1;
									FlexGlobals.topLevelApplication.navFadeRight.target=btnNavRight;
									FlexGlobals.topLevelApplication.navFadeRight.play();
*/								}
							}
						}
					}
					break;
			}
			
			arrCastMember[intCurrentCast].tabEnabled=true;
			arrCastMember[intCurrentCast].tabIndex=20;
			
			strCallerNm=""+xmlCallerData.caller[intCurrentCast].@callerNm;
			retCallerNm.textFlow = TextConverter.importToFlow(strCallerNm,TextConverter.TEXT_FIELD_HTML_FORMAT);
			retCallerNm.alpha=0;
			imgArrow.alpha=0;
			var showNm:Timer=new Timer(500,1);
			showNm.start();
			showNm.addEventListener(TimerEvent.TIMER_COMPLETE, showName);
			function showName():void
			{
				FlexGlobals.topLevelApplication.fadeMenuIn.targets=[retCallerNm,imgArrow];
				FlexGlobals.topLevelApplication.fadeMenuIn.play();
				FlexGlobals.topLevelApplication.focusManager.setFocus(retCallerNm);
			}
			
		}	
		
		/*******************************************************************************
		 ** Function: tabOn()
		 ** Input:  None
		 ** Output: Reset the tab order and access for this class
		 *******************************************************************************/
		public function tabOn():void
		{
			retCallerNm.tabEnabled=true;
			retCallerNm.tabIndex=30;
			retCallerNm.accessibilityEnabled=true;
			btnLearnMore.tabEnabled=true;
			btnLearnMore.tabIndex=31;
			btnLearnMore.accessibilityEnabled=true;
			for(var iCast:int=0;iCast<arrCastMember.length;iCast++)
			{
				arrCastMember[iCast].visible=true;
			}
			btnNavRight.tabEnabled=true;
			btnNavRight.tabIndex=41;
			btnNavRight.accessibilityEnabled=true;
			btnNavLeft.tabEnabled=true;
			btnNavLeft.tabIndex=40;
			btnNavLeft.accessibilityEnabled=true;
		}
		
		/*******************************************************************************
		 ** Function: tabOff()
		 ** Input:  None
		 ** Output: Turns off the tab order and access for this class
		 *******************************************************************************/
		public function tabOff():void
		{
			retCallerNm.tabEnabled=false;
			retCallerNm.tabIndex=0;
			retCallerNm.accessibilityEnabled=false;
			btnLearnMore.tabEnabled=false;
			btnLearnMore.tabIndex=0;
			btnLearnMore.accessibilityEnabled=false;
			for(var iCast:int=0;iCast<arrCastMember.length;iCast++)
			{
				arrCastMember[iCast].visible=false;
			}
			btnNavRight.tabEnabled=false;
			btnNavRight.tabIndex=0;
			btnNavRight.accessibilityEnabled=false;
			btnNavLeft.tabEnabled=false;
			btnNavLeft.tabIndex=0;
			btnNavLeft.accessibilityEnabled=false;
		}		
	}
}
