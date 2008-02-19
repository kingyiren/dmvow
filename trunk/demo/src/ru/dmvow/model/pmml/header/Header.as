package ru.dmvow.model.pmml.header
{
	import mx.collections.ArrayCollection;
	
	import ru.dmvow.model.pmml.common.Extendable;
	import ru.dmvow.model.pmml.common.Timestamp;
	
	/**
	 * <p>XSD Schema part:</p>
	 * 
	 * <p>
	 * <code>
	 * <xs:element name="Header">
	 *     <xs:complexType>
	 *         <xs:sequence>
	 *             <xs:element ref="Extension" minOccurs="0" maxOccurs="unbounded"/>
	 *             <xs:element minOccurs="0" ref="Application"/>
	 *             <xs:element minOccurs="0" maxOccurs="unbounded" ref="Annotation"/>
	 *             <xs:element minOccurs="0" ref="Timestamp"/>
	 *         </xs:sequence>
	 *         <xs:attribute name="copyright" type="xs:string" use="required"/>
	 *         <xs:attribute name="description" type="xs:string"/>
	 *     </xs:complexType>
	 * </xs:element>
	 * </code>
	 * </p>
	 * 
	 * <p>XML node sample:</p>
	 * 
	 * <p>
	 * <code>
	 * <Header copyright="www.dmg.org" description="example model for association rules"/>
	 * </code>
	 * </p>
	 */
	public class Header extends Extendable
	{
		[Bindable]
		public var copyright:String;
		[Bindable]
		public var description:String;
		/** Optional. */
		[Bindable]
		public var application:Application;
		/** Array of Annotation objects. Can be empty. */
		[Bindable]
		public var annotations:ArrayCollection = new ArrayCollection();
		/** Array of Annotation objects. Can be empty. */
		[Bindable]
		public var timestamp:Timestamp;
	}
}