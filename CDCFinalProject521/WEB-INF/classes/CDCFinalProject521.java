//********************************************************************************
//         File: CDCFinalProject521.java
//       Author: Andrew Steele
//         Date: 12/13/2018
//      Purpose: The Purpose is to connect to the db and handle the information sent from the html form to print the information from the db in the form of a table.
//
//********************************************************************************

/** Description of CDCFinalProject521
 *
 * @author Andrew Steele
 * @version 3.0 5-10-19
 */
import java.io.*;
import java.sql.*;
import java.util.*;
import java.lang.*;
import java.net.URL;
import java.text.DecimalFormat;
import oracle.jdbc.pool.OracleDataSource;
import oracle.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;
import com.google.gson.*;

public class CDCFinalProject521 extends HttpServlet {

/**
* Values used to log into oracle
*
*/
private static final String USERNAME = "astee461";
private static final String PASSWORD = "sPa4r7es";

private static Statement stmnt;
private static Connection con;


public void init(ServletConfig config)  throws ServletException
{
	super.init(config);
	// Set up JDBC stuff
	try { // Get a connection
	}
	catch (Exception e) {
		e.printStackTrace();
	}
}
/////this is how I reed in the information from the json url 
 static String readUrl(String urlString) throws Exception {
    BufferedReader reader = null;
    try {
        URL url = new URL(urlString);/** establishes a link to the URL*/
        reader = new BufferedReader(new InputStreamReader(url.openStream())); /** Opens the bufferedreader and established the inputsteam connection to the url*/
        StringBuffer buffer = new StringBuffer();/**each string*/
        int read;
        char[] chars = new char[1024];
        while ((read = reader.read(chars)) != -1)
            buffer.append(chars, 0, read); 

        return buffer.toString();
    } finally {
        if (reader != null)
            reader.close();
    }
}

	/** 
	*Class to sort the values within the json file
	 */
static class DeeperData1 {
	String _113_cause_name;
	String aadr;
	String cause_name;
	String deaths;
	String state;
	String year;
}
	/** Description of doGet(HttpServletRequest request, HttpServletResponse response)
	 * 
	 * @param STATE/2		Grabs the state user wants from the initial form
	 * @param YEARS/2		Grabs the year user wants from the initial form
	 * @param CAUSENAME/2	Grabs the cause name user wants from the initial form
	 *@param Options 		Grabs the option user wants from the initial form if they select it. Otherwise ignored.
	 */
public void doGet(HttpServletRequest request, HttpServletResponse response)throws IOException, ServletException
{
	PrintWriter out=response.getWriter();
	String STATE=request.getParameter("State");
	String YEARS=request.getParameter("Year");
	String CAUSENAME=request.getParameter("Cause_Name");
	String STATE2=request.getParameter("State2");
	String YEARS2=request.getParameter("Year2");
	String CAUSENAME2=request.getParameter("Cause_Name2");
	String OPTIONS=request.getParameter("Options");
    Cookie k1=new Cookie("ST",STATE);
    Cookie k2=new Cookie("Y",YEARS);
	Cookie k3=new Cookie("CN",CAUSENAME);
    Cookie k4=new Cookie("ST2",STATE2);
    Cookie k5=new Cookie("Y2",YEARS2);
	Cookie k6=new Cookie("CN2",CAUSENAME2);
	response.setContentType("text/html");
    response.addCookie(k1);
    response.addCookie(k2);
	response.addCookie(k3);
    response.addCookie(k4);
	response.addCookie(k5);
    response.addCookie(k6);

    //Adding the cookies to response header

	response.setContentType("text/html");
	out.print("<!DOCTYPE html>");
	out.print("<br>");
	out.print("<html>");
	out.print("<br>");
	out.print("<head>");
	out.print("<br>");
	out.print("<title>Final Project</title>");
	out.print("<br>");
	out.print("<link href='FP.css' rel='styleSheet' type='text/css' media='screen'>");
	out.print("<br>");

	out.print("</head>");
	out.print("<br>");
	out.print("<body>");
	out.print("<br>");
	out.print("<center><h1>Results Table</h1></center>");
	out.print("<table id='CDC'><tr><th>113Cause Name</th><th>ADJ-Death Rate</th><th>Cause Name</th><th>Deaths</th><th>State</th><th>Year</th></tr>");
	try{
	/** Description of OracleConnection()
	 * Takes the username and password values from above and calls them down here to get a connection
	 *using that connection it makes statements in the oracle DBMS that allows it to manipulate it directly.
	 *@param deleteTable Deletes the table
	 *@param createTable Creates a table if non existed.
	 *@param json,gson,DeeperData[] All used to parse, sort, and insert information into the oracle table.
	 
	 */
		Connection con = new OracleConnection().getConnection(USERNAME,PASSWORD);
		Statement stmt = con.createStatement();
		String deleteTable= "DROP TABLE ALLSTATES521";
		stmt.executeUpdate(deleteTable);	
		String createTable = "CREATE TABLE ALLSTATES521(SciCauseName VARCHAR2(100),AADR FLOAT,CAUSENAME VARCHAR2(100),DEATHS FLOAT,STATE VARCHAR2(100),YEARS FLOAT)";
		stmt.executeUpdate(createTable);
		//biggest update that now is pulling directly from URL instead of txt file.
		String json = readUrl("https://data.cdc.gov/resource/u4d7-xz8k.json");//calling readURL to process the json at this link.
		Gson gson = new Gson();        
		DeeperData1[] dd = gson.fromJson(json, DeeperData1[].class);
	////creates string that'll be used to display the results from the buffer. Also call upon GSON to parse the data of the JSON.
		
			int i=0;
			while(i<dd.length){
				//While theres still lines keep inputing data. Also if any string contains a "r's" REPLACE them with just "rs" since the single ' interferes with the input query.
				String insertTable = ("INSERT INTO ALLSTATES521 VALUES ('"+dd[i]._113_cause_name+"',"+dd[i].aadr+",'"+dd[i].cause_name+"',"+dd[i].deaths+",'"+dd[i].state+"',"+dd[i].year+")");
				String insertTable2 = insertTable.replaceAll("r's","rs");
				stmt.executeUpdate(insertTable2);
				i++;
			}
			

		out.print("<tr><td>");
		out.print("QUERY1");
		out.print("</td></tr>");
		
	/** 
	 * After table creation feed in the values the user asked for and insert them into a proper Oracle DB query.
	 *Populate the table if a value is found. Otherwise throw and error message.
	 */
		ResultSet rs1=stmt.executeQuery("SELECT * FROM ALLSTATES521 WHERE CAUSENAME='"+CAUSENAME+"' AND STATE='"+STATE+"' AND YEARS="+YEARS);
		if(!rs1.isBeforeFirst()){//if there's no values in the search print this message.
			out.print("<tr bgcolor='#FF0000'><td>");
			out.print("no value for:"+CAUSENAME+","+STATE+","+YEARS);
			out.print("</td></tr>");
		}
		else{
			while(rs1.next()){

				out.print("<tr><td>");
				out.print(rs1.getString(1));
				out.print("</td>");
				out.print("<td>");
				out.print(rs1.getString(2));
				out.print("</td>");
				out.print("<td>");
				out.print(rs1.getString(3));
				out.print("</td>");
				out.print("<td>");
				out.print(rs1.getString(4));
				out.print("</td>");
				out.print("<td>");
				out.print(rs1.getString(5));
				out.print("</td>");
				out.print("<td>");
				out.print(rs1.getString(6));
				out.print("</td>");
				out.print("</tr>");
				
			}
		}
		out.print("<tr><td>");
		out.print("QUERY2");
		out.print("</td></tr>");
		//Sets up the 2nd query.
		ResultSet rs2=stmt.executeQuery("SELECT * FROM ALLSTATES521 WHERE CAUSENAME='"+CAUSENAME2+"' AND STATE='"+STATE2+"' AND YEARS="+YEARS2);
		if(!rs2.isBeforeFirst()){//if there's no values in the search print this message.
			out.print("<tr bgcolor='#FF0000'><td>");
			out.print("no value for:"+CAUSENAME2+","+STATE2+","+YEARS2);
			out.print("</td></tr>");
			}
	
		else{
			while(rs2.next()){

				
				out.print("<tr><td>");
				out.print(rs2.getString(1));
				out.print("</td>");
				out.print("<td>");
				out.print(rs2.getString(2));
				out.print("</td>");
				out.print("<td>");
				out.print(rs2.getString(3));
				out.print("</td>");
				out.print("<td>");
				out.print(rs2.getString(4));
				out.print("</td>");
				out.print("<td>");
				out.print(rs2.getString(5));
				out.print("</td>");
				out.print("<td>");
				out.print(rs2.getString(6));
				out.print("</td>");
				out.print("</tr>");
				
			}
		}
			/**
			*Only executed if options in asked for. Access the oracle DB and does a cross join to compare values in the search ONLY if they returned proper values in the 1st place.
	 
	 */
		if(OPTIONS.equalsIgnoreCase("Combo")){
			ResultSet rs3=stmt.executeQuery("SELECT ABS((t1.AADR + t2.AADR)/2),ABS(t1.DEATHS + t2.DEATHS) FROM ALLSTATES521 t1 CROSS JOIN ALLSTATES521 t2  WHERE (t1.CAUSENAME='"+CAUSENAME+"' AND t1.STATE='"+STATE+"' AND t1.YEARS="+YEARS+") AND (t2.CAUSENAME='"+CAUSENAME2+"' AND t2.STATE='"+STATE2+"' AND t2.YEARS="+YEARS2+")");
			
			if(!rs3.isBeforeFirst()){
				out.print("<tr bgcolor='#FF0000'><td>");
				out.print("Need 2 proper Queries");
				out.print("</td></tr>");
				}
		
			else{
				while(rs3.next()){

					
					out.print("<tr><td>");
					out.print("Total Combination:");
					out.print("</td>");
					out.print("<td>");
					out.print(rs3.getString(1));
					out.print("</td>");
					out.print("<td>");
					out.print("</td>");
					out.print("<td>");
					out.print(rs3.getString(2));
					out.print("</td>");
					out.print("<td>");
					out.print("</td>");
					out.print("<td>");
					out.print("</td>");
					out.print("</tr>");
					
				}
			}
		}		
		//If the user selected Combination the values for the AADR and Deathts are totaled between the two with AADR being divided by 2 since its combining and average.
		//If the user selected Differential the values for the AADR and Deathts are subtracted between the two with AADR being divided by 2 since its combining and average. Then both values are processed to their absolutes.
		else if(OPTIONS.equalsIgnoreCase("Differ")){
			ResultSet rs3=stmt.executeQuery("SELECT ABS((t1.AADR- t2.AADR)/2),ABS(t1.DEATHS - t2.DEATHS) FROM ALLSTATES521 t1 CROSS JOIN ALLSTATES521 t2  WHERE (t1.CAUSENAME='"+CAUSENAME+"' AND t1.STATE='"+STATE+"' AND t1.YEARS="+YEARS+") AND (t2.CAUSENAME='"+CAUSENAME2+"' AND t2.STATE='"+STATE2+"' AND t2.YEARS="+YEARS2+")");
			
			if(!rs3.isBeforeFirst()){
				out.print("<tr bgcolor='#FF0000'><td>");
				out.print("Need 2 proper Queries");
				out.print("</td></tr>");
				}
		
			else{
				while(rs3.next()){

					
					out.print("<tr><td>");
					out.print("Total Differential:");
					out.print("</td>");
					out.print("<td>");
					out.print(rs3.getString(1));
					out.print("</td>");
					out.print("<td>");
					out.print("</td>");
					out.print("<td>");
					out.print(rs3.getString(2));
					out.print("</td>");
					out.print("<td>");
					out.print("</td>");
					out.print("<td>");
					out.print("</td>");
					out.print("</tr>");
					
				}
			}
		}

	}

	catch(Exception e){
		out.print(e.getMessage()+"1");
		
		}
		
		 

	out.print("</table>");
	out.print("<br>");
	out.print("<br>");
	out.print("<a href='http://astee461.kutztown.edu:8080/CDCFinalProject521/TopKills.jsp'>Back</a>");
	out.print("<br>");
	
	out.print("</body>");
	out.print("<br>");
	out.print("</html>");




	} 

}  // class



