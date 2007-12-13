package ru.dmvow.model
{
	public class DebugXml
	{
		public static var xml:XML =
			<PMML version="3.2" xmlns="http://www.dmg.org/PMML-3_2" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
			    <Header copyright="www.dmg.org" description="Example model for association rules describing the PMML Association Rules format."/>
			    <DataDictionary numberOfFields="2" >
			      <DataField name="transaction" optype="categorical" dataType="string" />
			      <DataField name="item" optype="categorical" dataType="string" />
			    </DataDictionary>
			    <AssociationModel
			         functionName="associationRules"
			         numberOfTransactions="4" numberOfItems="7"
			         minimumSupport="0.5"     minimumConfidence="0.05"
			         numberOfItemsets="4"     numberOfRules="4">
			      <MiningSchema>
			        <MiningField name="transaction" usageType="group" />
			        <MiningField name="item" usageType="predicted"/>
			      </MiningSchema>
			
			      <!-- We have three items i n our input data -->
			      <Item id="1" value="Cracker">
			      	<Extension name="className" value="Food"></Extension>
			      </Item>
			      <Item id="2" value="Sandwich">
			      	<Extension name="className" value="Food"></Extension>
			      </Item>
			      <Item id="3" value="Butter">
			      	<Extension name="className" value="Food"></Extension>
			      </Item>
			      <Item id="4" value="Coke">
			      	<Extension name="className" value="Drink"></Extension>
			      </Item>
			      <Item id="5" value="Sprite">
			      	<Extension name="className" value="Drink"></Extension>
			      </Item>
			      <Item id="6" value="Pepsi">
			      	<Extension name="className" value="Drink"></Extension>
			      </Item>
			      <Item id="7" value="Water">
			      	<Extension name="className" value="Drink"></Extension>
			      </Item>
			
			      <Itemset id="10" support="0.4" numberOfItems="3">
			        <ItemRef itemRef="1" />
			        <ItemRef itemRef="2" />
			        <ItemRef itemRef="3" />
			      </Itemset>
			      <Itemset id="12" support="0.3" numberOfItems="3">
			        <ItemRef itemRef="4" />
			      </Itemset>
			      <Itemset id="13" support="0.7" numberOfItems="4">
			        <ItemRef itemRef="3" />
			        <ItemRef itemRef="5" />
			        <ItemRef itemRef="6" />
			      </Itemset>
			
			      <!-- and one frequent itemset with two items. -->
			      <Itemset id="14" support="0.1" numberOfItems="2">
			        <ItemRef itemRef="7" />
			      </Itemset>
			
			      <!-- Two rules satisfy the requirements -->
			      <AssociationRule support="0.9" confidence="0.7" antecedent="10" consequent="12" />
			      <AssociationRule support="0.5" confidence="0.05" antecedent="10" consequent="13" />
			      <AssociationRule support="0.8" confidence="0.2" antecedent="14" consequent="12" />
			    </AssociationModel>
			  </PMML>;
	}
}