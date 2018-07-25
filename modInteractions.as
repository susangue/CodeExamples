package com
{
	import mx.core.FlexGlobals;
	
	public class modInteractions
	{
		/**-- Array variables --**/
		public var arrModInteractions:Array=new Array();
				
		/**-- Interaction variables --**/
		public var getMatchKC:matchKC=new matchKC();
		public var getAppeals:appeals=new appeals();
		public var getAppealsProcess:appealsProcess=new appealsProcess();
		public var getRemandProcess:remandProcess=new remandProcess();
		public var getAppealFAQ:appealFAQ=new appealFAQ();
	
		/*******************************************************************************
		 ** Function: modInteractions()
		 ** Input:  None
		 ** Output: Declares the name of each interaction; sets array for interactions
		 *******************************************************************************/
		public function modInteractions()
		{
			getMatchKC.name="matchKC";
			getAppeals.name="appeals";
			getAppealsProcess.name="appealsProcess";
			getRemandProcess.name="remandProcess";
			getAppealFAQ.name="appealFAQ";
			
			arrModInteractions[0]=[getMatchKC.name,getMatchKC];
			arrModInteractions[1]=[getAppeals.name,getAppeals];
			arrModInteractions[2]=[getAppealsProcess.name,getAppealsProcess];
			arrModInteractions[3]=[getRemandProcess.name,getRemandProcess];
			arrModInteractions[4]=[getAppealFAQ.name,getAppealFAQ];
		}
		
		public function removePlayer():void
		{
			if(FlexGlobals.topLevelApplication.setLessonData.strPgType=="phoneCall")
			{
				FlexGlobals.topLevelApplication.getCallShowTry.showCallShowTry();
				FlexGlobals.topLevelApplication.mediaPlayer.hideCtrls();
			}
			else if(FlexGlobals.topLevelApplication.setLessonData.interactionID=="appealFAQ")
			{					
				FlexGlobals.topLevelApplication.moduleInteraction.getAppealFAQ.drawQuestion();
				FlexGlobals.topLevelApplication.mediaPlayer.hideCtrls();
			}
			
			else if(FlexGlobals.topLevelApplication.setLessonData.strPgType=="imgCenter")
			{
				FlexGlobals.topLevelApplication.mediaPlayer.hideCtrls();

			}

				FlexGlobals.topLevelApplication.mediaPlayer.mediaPlayerElement.stop();										
				FlexGlobals.topLevelApplication.mediaPlayer.stopVid();
		}
	}
}
