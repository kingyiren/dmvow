package ru.dmvow.model.sql
{
	import flash.events.ErrorEvent;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	import ru.dmvow.control.boundary.sqlParser.SQLParser;
	import ru.dmvow.model.DataModel;
	
	public class SampleSQLMiningModel extends EventDispatcher
	{
		protected var sqlParser:SQLParser;
		public var ready:Boolean = false;
		public var data:SQLMiningModel; 

		public function SampleSQLMiningModel()
		{
			super();
			
			initialize();
		}
		
		protected function initialize():void
		{
			data = new SQLMiningModel();
			
			data.name = "Sample SQL Model";
			data.source = DataModel.FROM_SQL;
			
			sqlParser = new SQLParser();
			sqlParser.addEventListener(Event.COMPLETE, onParserComplete);
			sqlParser.addEventListener(ErrorEvent.ERROR, onParserError);
			sqlParser.parseFromString(sample);
		}
		
		protected function onParserComplete(event:Event):void
		{
			data.data = sqlParser.result;
			
			ready = true;
			var newEvent:Event = new Event(Event.COMPLETE);
			dispatchEvent(newEvent);
		}
		
		protected function onParserError(event:Event):void
		{
			throw new Error(event.toString());
		}
		
		protected var sample:String = 
'MODEL_CATALOG	MODEL_SCHEMA	MODEL_NAME	ATTRIBUTE_NAME	NODE_NAME	NODE_UNIQUE_NAME	NODE_TYPE	NODE_GUID	NODE_CAPTION	CHILDREN_CARDINALITY	PARENT_UNIQUE_NAME	NODE_DESCRIPTION	NODE_RULE	MARGINAL_RULE	NODE_PROBABILITY	MARGINAL_PROBABILITY	NODE_DISTRIBUTION	NODE_SUPPORT	MSOLAP_MODEL_COLUMN	MSOLAP_NODE_SCORE	MSOLAP_NODE_SHORT_CAPTION' + "\r\n" +
'Analysis Services Project2		Process Events		0	0	1		Association Rules Model	12		Association Rules Model; ITEMSET_COUNT=8; RULE_COUNT=4; MIN_SUPPORT=9742; MAX_SUPPORT=58512; MIN_ITEMSET_SIZE=0; MAX_ITEMSET_SIZE=2; MIN_PROBABILITY=0.402122641509434; MAX_PROBABILITY=0.988633085223011; MIN_LIFT=0.450098098216189; MAX_LIFT=2.64998892579834			0	0	NODE_DISTRIBUTION	164118		0' + "\r\n" +	
'Analysis Services Project2		Process Events		6	6	7		Process = HPBPRO.EXE	0	0	Process = HPBPRO.EXE			0,35652396446459256	0,35652396446459256	NODE_DISTRIBUTION	58512		1	' + "\r\n" +
'Analysis Services Project2		Process Events		5	5	7		Process = klnagent.exe	0	0	Process = klnagent.exe			0,21765437063576207	0,21765437063576207	NODE_DISTRIBUTION	35721		1	' + "\r\n" +
'Analysis Services Project2		Process Events		4	4	7		Parent = svchost.exe	0	0	Parent = svchost.exe			0,19262360009261628	0,19262360009261628	NODE_DISTRIBUTION	31613		1	' + "\r\n" +
'Analysis Services Project2		Process Events		3	3	7		User Domain Name = ACH	0	0	User Domain Name = ACH			0,16229176568079065	0,16229176568079065	NODE_DISTRIBUTION	26635		1	' + "\r\n" +
'Analysis Services Project2		Process Events		8	8	7		Parent = svchost.exe, Process = HPBPRO.EXE	0	0	Parent = svchost.exe, Process = HPBPRO.EXE			0,14336635835191752	0,14336635835191752	NODE_DISTRIBUTION	23529		0,47901704656462946' + "\r\n" +	
'Analysis Services Project2		Process Events		2	2	7		Parent = Explorer.EXE	0	0	Parent = Explorer.EXE			0,10560084817021899	0,10560084817021899	NODE_DISTRIBUTION	17331		1' + "\r\n" +
'Analysis Services Project2		Process Events		7	7	7		Parent = Explorer.EXE, User Domain Name = ACH	0	0	Parent = Explorer.EXE, User Domain Name = ACH			0,10440049232869034	0,10440049232869034	NODE_DISTRIBUTION	17134		0,16415773263766678' + "\r\n" +	
'Analysis Services Project2		Process Events		1	1	7		Duration = 30083 - 37171	0	0	Duration = 30083 - 37171			0,059359728975493242	0,059359728975493242	NODE_DISTRIBUTION	9742		1' + "\r\n" +
'Analysis Services Project2		Process Events		1008	1008	8		Parent = Explorer.EXE -> User Domain Name = ACH	0	0	Parent = Explorer.EXE -> User Domain Name = ACH	<AssocRule support="17134" confidence="0.988633" length="2" LHS_ID="2" rule="Parent = Explorer.EXE -> User Domain Name = ACH"/>		0,98863308522301074	0,98863308522301074	NODE_DISTRIBUTION	17134	2	1,1838888575235345' + "\r\n" +	
'Analysis Services Project2		Process Events		1009	1009	8		Parent = svchost.exe -> Process = HPBPRO.EXE	0	0	Parent = svchost.exe -> Process = HPBPRO.EXE	<AssocRule support="23529" confidence="0.744282" length="2" LHS_ID="4" rule="Parent = svchost.exe -> Process = HPBPRO.EXE"/>		0,74428241546199347	0,74428241546199347	NODE_DISTRIBUTION	23529	4	0,45009809821618868' + "\r\n" +
'Analysis Services Project2		Process Events		1010	1010	8		User Domain Name = ACH -> Parent = Explorer.EXE	0	0	User Domain Name = ACH -> Parent = Explorer.EXE	<AssocRule support="17134" confidence="0.643289" length="2" LHS_ID="3" rule="User Domain Name = ACH -> Parent = Explorer.EXE"/>		0,64328890557537077	0,64328890557537077	NODE_DISTRIBUTION	17134	3	2,6499889257983407' + "\r\n" +
'Analysis Services Project2		Process Events		1011	1011	8		Process = HPBPRO.EXE -> Parent = svchost.exe	0	0	Process = HPBPRO.EXE -> Parent = svchost.exe	<AssocRule support="23529" confidence="0.402123" length="2" LHS_ID="6" rule="Process = HPBPRO.EXE -> Parent = svchost.exe"/>		0,40212264150943394	0,40212264150943394	NODE_DISTRIBUTION	23529	6	0,72037893361250249	';
	}
}