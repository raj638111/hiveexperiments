package a40_UDF.a15_GenericUDF;

import java.util.List;

import org.apache.hadoop.hive.ql.exec.UDFArgumentException;
import org.apache.hadoop.hive.ql.exec.UDFArgumentLengthException;
import org.apache.hadoop.hive.ql.exec.UDFArgumentTypeException;
import org.apache.hadoop.hive.ql.metadata.HiveException;
import org.apache.hadoop.hive.ql.udf.generic.GenericUDF;
import org.apache.hadoop.hive.serde2.objectinspector.ListObjectInspector;
import org.apache.hadoop.hive.serde2.objectinspector.ObjectInspector;
import org.apache.hadoop.hive.serde2.objectinspector.primitive.IntObjectInspector;
import org.apache.hadoop.hive.serde2.objectinspector.primitive.PrimitiveObjectInspectorFactory;
import org.apache.hadoop.io.Text;

/*
 * Used to calculate the Total from the Array
 * Example : array(50, 60, 60)
 * 
add jar /Users/raj/gitws/hiveexperiments/target/hivetests-0.0.1-SNAPSHOT.jar;
create temporary function totalmarks as 'a40_UDF.a15_GenericUDF.a11_Evaluate';
 */
public class a11_Evaluate extends GenericUDF{
	
	ListObjectInspector mListOI;
	IntObjectInspector mIntOI;

	@Override
	public ObjectInspector initialize(ObjectInspector[] arguments) 
								throws UDFArgumentException {
		ObjectInspector oi = null;
		
		if(arguments.length != 1) {
			throw new UDFArgumentLengthException("Expected no of arguments -> 1" +
						", Given no of arguments -> " + arguments.length);
		}
		
		oi = arguments[0];
		//Ensure that we are passing a List
		if(!(oi instanceof ListObjectInspector)) {
			throw new UDFArgumentTypeException(0, 
					"First argument should be List, but has " + 
					oi.getTypeName());
		}else {
			mListOI = (ListObjectInspector)oi;
		}
		
		//Ensure that the list Contain Integer
		oi = mListOI.getListElementObjectInspector();
		if(!(oi instanceof IntObjectInspector)) {
			throw new UDFArgumentTypeException(0, 
						"List should contain only Integer, but has " +
						mListOI.getListElementObjectInspector().getTypeName());
		}else {
			mIntOI = (IntObjectInspector)oi;
		}
		
		//Indicates we are returning a Hadoop 'Text' object
		return PrimitiveObjectInspectorFactory.writableStringObjectInspector;
	}

	@Override
	public Object evaluate(DeferredObject[] arguments) 
								throws HiveException {
		Integer total = 0;
		
		System.out.println("Argument length -> " + arguments.length);
		List<Object> markList = (List<Object>)mListOI.getList(arguments[0].get());
		System.out.println("List size -> " + markList.size());
		if(markList != null) {
			System.out.println("markList is not NULL");
			for(Object element : markList) {
				Integer mark = Integer.parseInt(element.toString());
				System.out.println("Mark -> " +mark);
				total = total + mark;
			}
		}
		Text result = new Text(total.toString()); //??? : What if I give a wrong return type here
		return result;
	}

	@Override
	public String getDisplayString(String[] children) {
		assert(children.length > 0); //?? : What is the use of assert statement?
		StringBuilder sb = new StringBuilder();
		sb.append("totalmarks+(");
		sb.append(children[0]);
		sb.append(")");
		return sb.toString();
	}

}
