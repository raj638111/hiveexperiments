package a40_UDF.a15_GenericUDF;

import org.apache.hadoop.hive.ql.exec.UDFArgumentException;
import org.apache.hadoop.hive.ql.exec.UDFArgumentLengthException;
import org.apache.hadoop.hive.ql.exec.UDFArgumentTypeException;
import org.apache.hadoop.hive.serde2.objectinspector.ObjectInspector;
import org.apache.hadoop.hive.serde2.objectinspector.ObjectInspectorFactory;
import org.apache.hadoop.hive.serde2.objectinspector.primitive.PrimitiveObjectInspectorFactory;
import org.apache.hadoop.hive.serde2.objectinspector.primitive.WritableStringObjectInspector;
import org.junit.Rule;
import org.junit.Test;
import org.junit.rules.ExpectedException;

public class a12_EvaluateTest {

	@Rule //?? : What is the use of this annotation
	public ExpectedException exception = ExpectedException.none();

	a11_Evaluate myudf = new a11_Evaluate();

	@Test
	public void checkHappyPath_initialize() throws UDFArgumentException{
		//Check no of arguments
		ObjectInspector intOI = PrimitiveObjectInspectorFactory.javaIntObjectInspector;
		ObjectInspector listOI = ObjectInspectorFactory.getStandardListObjectInspector(intOI);
		
		WritableStringObjectInspector result = (WritableStringObjectInspector) 
								myudf.initialize(new ObjectInspector[]{listOI}); 
	}
	
	@Test
	public void checkErrorPath_initialize() throws UDFArgumentException{
		WritableStringObjectInspector 	result = null;
		ObjectInspector 				listOI = null;
		
		//Check no of arguments
		ObjectInspector stringOI = PrimitiveObjectInspectorFactory.javaStringObjectInspector;
		ObjectInspector intOI = PrimitiveObjectInspectorFactory.javaIntObjectInspector;
		listOI = ObjectInspectorFactory.getStandardListObjectInspector(stringOI);
		
		//There should not be more than 1 arguments for initialize() method
		//whereas here we are passing 2 arguments
		exception.expect(UDFArgumentLengthException.class);
		result = (WritableStringObjectInspector) 
								myudf.initialize(new ObjectInspector[]{listOI, stringOI});
		//exception = ExpectedException.none();
		
		//The argument should be a ListObjectInspector, whereas 
		//here we are passing StringObjectInspector
		//exception.expect(UDFArgumentTypeException.class);
		result = (WritableStringObjectInspector) 
				myudf.initialize(new ObjectInspector[]{stringOI});
		
		
		//The ListObjectInspector should contain IntObjectInspector whereas here
		//the ListObjectInspector contain StringObjectInspector
		//exception.equals(UDFArgumentTypeException.class);
		//result = (WritableStringObjectInspector)
		//			myudf.initialize(new ObjectInspector[] {listOI});

		/*listOI = ObjectInspectorFactory.getStandardListObjectInspector(intOI);
		exception.equals(UDFArgumentTypeException.class);
		result = (WritableStringObjectInspector)
					myudf.initialize(new ObjectInspector[] {listOI});*/

	}
	
	//http://stackoverflow.com/questions/156503/how-do-you-assert-that-a-certain-exception-is-thrown-in-junit-4-tests
}
