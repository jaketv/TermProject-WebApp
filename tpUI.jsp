<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.*"%>
<%@ page import="java.io.*" %>
<%@ page import="java.lang.Math" %>





<head><title>118 Term Project</title></head>
<body background = "Shine.jpg">
</body>
<h1>EECS 118 Term Project</h1>
<h2>Welcome to the Rectangle in Circle Problem Solver!</h2>
<h3>(Results will be displayed at the bottom of the page)</h3>
<img src="RectInCirc.png" align= "right">
<b>Please Enter Parameters:</b><br>
Note: If left empty, Point A will have coordinates [0,0].<br>
<b>Points:</b>
<form method ="post">
	<input name="funcID" type="hidden" value="1">
		A.x: <input name = "axpos" type="test">
		A.y: <input name ="aypos" type="test"> <br>
		B.x: <input name = "bxpos" type="test">
		B.y: <input name ="bypos" type="test"> <br>
		C.x: <input name = "cxpos" type="test">
		C.y: <input name ="cypos" type="test"> <br>
		D.x: <input name = "dxpos" type="test">
		D.y: <input name ="dypos" type="test"> <br>
		E.x: <input name = "expos" type="test">
		E.y: <input name ="eypos" type="test"> <br>
		<b>Lengths:</b> <br>
		AB: <input name="lab" type="test">
		AC: <input name="lac" type="test">
		AD: <input name="lad" type="test"> <br>
		AE: <input name="lae" type="test">
		DC: <input name="ldc" type="test">
		EB: <input name="leb" type="test"><br>
		DE: <input name="lde" type="test">
		CB: <input name="lcb" type="test"><br>
		Radius: <input name="radius" type="test">
	<input type="submit" value="Go"/>
</form>

<%
//Variables used for input
String funcID = request.getParameter("funcID");

String radius = request.getParameter("radius");
String axpos = request.getParameter("axpos");
String aypos = request.getParameter("aypos");
String bxpos = request.getParameter("bxpos");
String bypos = request.getParameter("bypos");
String cxpos = request.getParameter("cxpos");
String cypos = request.getParameter("cypos");
String dxpos = request.getParameter("dxpos");
String dypos = request.getParameter("dypos");
String expos = request.getParameter("expos");
String eypos = request.getParameter("eypos");

String lab = request.getParameter("lab");
String lac = request.getParameter("lac");
String lad = request.getParameter("lad");
String lae = request.getParameter("lae");
String ldc = request.getParameter("ldc");
String leb = request.getParameter("leb");
String lde = request.getParameter("lde");
String lcb = request.getParameter("lcb");

%>

<%
class Point{
	
	public double xpos, ypos;
	
	public Point(double x, double y){
		xpos = x;
		ypos = y;
	}
	
	public double getX(){
		return xpos;
	}
	
	public double getY(){
		return ypos;
	}
	
	public void setX(double x){
		this.xpos = x;
	}
	
	public void setY(double y){
		this.ypos = y;
	}
	
	//Length
	public double distanceTo(Point x){
	return Math.sqrt((Math.pow((x.getX() - this.getX()),2.0))+(Math.pow((x.getY() - this.getY()),2.0)));
	}
	
	//Angle
	public double findAngle(Point x, Point y){
	return (Math.acos((Math.pow(this.distanceTo(x),2.0)+Math.pow(x.distanceTo(y),2.0)-Math.pow(this.distanceTo(y),2.0))/(2.0*this.distanceTo(x)*x.distanceTo(y))))*180/Math.PI;
	}
	
}
%>

<%
int options = 0;
double rad = 0;

double a_x = 0;
double a_y =0;
Point A;

double b_x = 0;
double b_y =0;
Point B;

double c_x = 0;
double c_y =0;
Point C;

double d_x = 0;
double d_y =0;
Point D;

double e_x = 0;
double e_y =0;
Point E;

double cArea;
double circum;
double rArea;
double rPerim;
double uArea;
boolean noPoints = false;
boolean inA = true, inB = true, inC = true, inD = true, inE = true, inRad = true;
boolean inAB = true,inAC = true,inAD = true,inAE = true,inDC = true,inEB = true,inDE = true,inCB = true;
double angDAE, angEAB, angBAC, angCAD;
double arcDE, arcEB, arcBC, arcCD;
double triDAE, triEAB, triBAC, triCAD;

double AB = 0,AC= 0,AD= 0,AE= 0,DC= 0,EB= 0,DE= 0,CB= 0;
int count = 0;

//Try to accept inputs
//Maybe add booleans here for if no input then false?

	try{
		options = Integer.parseInt(funcID);
		rad = Double.parseDouble(radius);}
	catch(Exception e){inRad = false;}
	try{
	    a_x = Double.parseDouble(axpos);
	    a_y = Double.parseDouble(aypos);}
	catch(Exception e){}
	try{
	    b_x = Double.parseDouble(bxpos);
	    b_y = Double.parseDouble(bypos);}
	catch(Exception e){inB = false;}	
	try{
	    c_x = Double.parseDouble(cxpos);
	    c_y = Double.parseDouble(cypos);}
	catch(Exception e){inC = false;}	
	try{
	    d_x = Double.parseDouble(dxpos);
	    d_y = Double.parseDouble(dypos);}
	catch(Exception e){inD = false;}	
	try{
	    e_x = Double.parseDouble(expos);
	    e_y = Double.parseDouble(eypos);}
	catch(Exception e){inE = false;}	

	if((inB & inC & inD & inE) ==false){
		noPoints = true;
	}
	
	//Check B
	if((inB == false) & (inD == true)){
		b_x = 2*a_x - d_x;
		b_y = 2*a_y - d_y;
		inB = true;
	}
	else if((inB == false) & (inE == true)){
		b_x = e_x;
		b_y = 2*a_y - e_y;
		inB = true;
	}
	else if((inB == false) & (inC == true)){
		b_x = 2*a_x - c_x;
		b_y = c_y;
		inB = true;
	}
	else{}
	
	//Check C
	if((inC == false) & (inB == true)){
		c_x = 2*a_x - b_x;
		c_y = b_y;
		inC = true;
	}
	else if((inC == false) & (inD == true)){
		c_x = d_x;
		c_y = 2*a_y - d_y;
		inC = true;
	}
	else if((inC == false) & (inE == true)){
		c_x = 2*a_x - e_x;
		c_y = 2*a_y - e_y;
		inC = true;
	}
	else{}	
	
	//Check D
	if((inD == false) & (inB == true)){
		d_x = 2*a_x - b_x;
		d_y = 2*a_y - b_y;
		inD = true;
	}
	else if((inD == false) & (inC == true)){
		d_x = c_x;
		d_y = 2*a_y - c_y;
		inD = true;
	}
	else if((inD == false) & (inE == true)){
		d_x = 2*a_x - e_x;
		d_y = e_y;
		inD = true;
	}
	else{}		
	
	//Check E
	if((inE == false) & (inB == true)){
		e_x = b_x;
		e_y = 2*a_y - b_y;
		inE = true;
	}
	else if((inE == false) & (inD == true)){
		e_x = 2*a_x - d_x;
		e_y = d_y;
		inE = true;
	}
	else if((inE == false) & (inC == true)){
		e_x = 2*a_x - c_x;
		e_y = 2*a_y - c_y;
		inE = true;
	}
	else{}	
	
			A = new Point(a_x,a_y);
			B = new Point(b_x,b_y);
			C = new Point(c_x,c_y);
			D = new Point(d_x,d_y);
			E = new Point(e_x,e_y);
	
	try{
	    AB = Double.parseDouble(lab);}
	catch(Exception e){
		try{if(inB){AB = A.distanceTo(B);
		inAB = true;}
		else{inAB = false;}}
		catch(Exception d){inAB = false;}
	}
	
	try{
	    AC = Double.parseDouble(lac);}
	catch(Exception e){
		try{if(inC){AC = A.distanceTo(C);
		inAC = true;}
		else{inAC = false;}}
		catch(Exception d){inAC = false;}
	}
	
	try{
	    AD = Double.parseDouble(lad);}
	catch(Exception e){
		try{if(inD){AD = A.distanceTo(D);
		inAD = true;}
		else{inAD = false;}}
		catch(Exception d){inAD = false;}
	}
	
	try{
	    AE = Double.parseDouble(lae);}
	catch(Exception e){
		try{if(inE){AE = A.distanceTo(E);
		inAE = true;}
		else{inAE = false;}}
		catch(Exception d){inAE = false;}
	}
	
	try{
	    DC = Double.parseDouble(ldc);}
	catch(Exception e){
		try{if(inD & inC){DC = D.distanceTo(C);
		inDC = true;}
		else{inDC = false;}}
		catch(Exception d){inDC = false;}
	}
	
	try{
	    EB = Double.parseDouble(leb);}
	catch(Exception e){
		try{if(inE& inB){EB = E.distanceTo(B);
		inEB = true;}
		else{inEB = false;}}
		catch(Exception d){inEB = false;}
	}
	
	try{
	    DE = Double.parseDouble(lde);}
	catch(Exception e){
		try{if(inE & inD){DE = D.distanceTo(E);
		inDE = true;}
		else{inDE = false;}}
		catch(Exception d){inDE = false;}
	}
	
	try{
	    CB = Double.parseDouble(lcb);}
	catch(Exception e){
		try{if(inC & inB){CB = C.distanceTo(B);
		inCB = true;}
		else{inCB = false;}}
		catch(Exception d){inCB = false;}
	}

	//Try to replace missing values and punish inconsistencies
	
	//Find rad given any diagonal
	if(inRad == false){
	if(inAB){rad = AB;inRad =true;}
	else if(inAC){rad = AC; inRad =true;}
	else if(inAD){rad = AD;inRad =true;}
	else if(inAE){rad = AE;inRad =true;}
	else{}}
	
	//Find diagonals if given rad
	if(inRad & !inAB & !inAC & !inAE & !inAD){
		AB = rad;AC = rad;AD = rad;AE = rad;
		inAB = true;inAC = true;inAE = true;inAD = true;
	}
	
	//Find diagonals if given diagonal
	if(inAB & !inAC & !inAD & !inAE){AC = AB;AD = AB;AE = AB;
	inAC = true;inAE = true;inAD = true;}
	if(inAC & !inAB & !inAD & !inAE){AB = AC;AD = AC;AE = AC;
	inAB = true;inAE = true;inAD = true;}
	if(inAD & !inAC & !inAB & !inAE){AC = AD;AB = AD;AE = AD;
	inAC = true;inAE = true;inAB = true;}
	if(inAE & !inAC & !inAD & !inAB){AC = AE;AD = AE;AB = AE;
	inAC = true;inAB = true;inAD = true;}
	
	//Given diagonals find lengths of sides
	if(inAD & inAE){
		DE = Math.sqrt((Math.pow((AD),2.0))+(Math.pow((AE),2.0)));
		inDE = true;}
	if(inAE & inAB){
		EB = Math.sqrt((Math.pow((AB),2.0))+(Math.pow((AE),2.0)));
		inEB = true;}
	if(inAB & inAC){
		CB = Math.sqrt((Math.pow((AB),2.0))+(Math.pow((AC),2.0)));
		inCB = true;}
	if(inAC & inAD){
		DC = Math.sqrt((Math.pow((AD),2.0))+(Math.pow((AC),2.0)));
		inDC = true;}
		
	//Given one side find opposite side
	if(inDC & !inEB){
		EB = DC;inEB = true;}
	if(inEB & !inDC){
		DC = EB;inDC = true;}
	if(inCB & !inDE){
		DE = CB;inDE = true;}
	if(inDE & !inCB){
		CB = DE;inCB = true;}
	
	//Check valid locations for inputs
	if((a_x >= b_x)&inB){options = 5;}
	if((a_y <= b_y)&inB){options = 5;}
	if((a_x <= c_x)&inB){options = 5;}
	if((a_y <= c_y)&inB){options = 5;}
	if((a_x >= e_x)&inB){options = 5;}
	if((a_y >= e_y)&inB){options = 5;}
	if((a_x <= d_x)&inB){options = 5;}
	if((a_y >= d_y)&inB){options = 5;}
	
	//Begin checking for properties of a rectangle
	if((d_y != e_y)||(d_x != c_x)||(e_x != b_x)||(c_y != b_y)){
		options = 2; //Bad Point x-y values
	}
	if(((AB != AC)&inAB & inAC)||((AB != AD)&inAB & inAD)||((AB != AE)&inAB & inAE)||((AB != rad)&inAB & inRad)){
		options = 3; //Radius-diagonal inconsistency
		}
	if(((AC != AB)&inAB & inAC)||((AC != AD)&inAC & inAD)||((AC != AE)&inAC & inAE)||((AC != rad)&inAC & inRad)){
		options = 3; //Radius-diagonal inconsistency
		}
	if(((AD != AC)&inAD & inAC)||((AD != AB)&inAB & inAD)||((AD != AE)&inAE & inAD)||((AD != rad)&inAD & inRad)){
		options = 3; //Radius-diagonal inconsistency
		}
	if(((AE != AC)&inAE & inAC)||((AE != AD)&inAE & inAD)||((AB != AE)&inAB & inAE)||((AE != rad)&inAE & inRad)){
		options = 3; //Radius-diagonal inconsistency
		}	
	if((DC != EB)&inDC & inEB){
		options = 4; //Inconsistent side lengths
	}
	if((CB != DE)&inCB & inDE){
		options = 4; //Inconsistent side lengths
	}
	
	//Print out tables depending on how well the program was able to solve for missing variables
	
	switch(options){
		
		//Run the input
		case 1:

			//Used to initialize points here
			
			out.println("<table style=\"display: inline-block\" align=\"left\" border=\"1\">");
			out.println("<caption> Inputs </caption>");

			out.println("<tr>");
			out.println("<th>Radius: </th>");
			if(inRad == true){
			out.println("<th>"+rad+"</th>");}
			else{
			out.println("<th>?</th>");}
			out.println("</tr>");

			//Point Information
			out.println("<tr>");
			out.println("<th>A [x,y]: </th>");
			if(inA == true){
			out.println("<th>["+A.getX()+","+A.getY()+"]</th>");}
			else{out.println("<th>?</th>");}
			out.println("</tr>");
			
			out.println("<tr>");
			out.println("<th>B [x,y]: </th>");
			if(inB == true){
			out.println("<th>["+B.getX()+","+B.getY()+"]</th>");}
			else{out.println("<th>?</th>");}
			out.println("</tr>");

			out.println("<tr>");
			out.println("<th>C [x,y]: </th>");
			if(inC == true){
			out.println("<th>["+C.getX()+","+C.getY()+"]</th>");}
			else{out.println("<th>?</th>");}
			out.println("</tr>");			

			out.println("<tr>");
			out.println("<th>D [x,y]: </th>");
			if(inD == true){
			out.println("<th>["+D.getX()+","+D.getY()+"]</th>");}
			else{out.println("<th>?</th>");}
			out.println("</tr>");			

			out.println("<tr>");
			out.println("<th>E [x,y]: </th>");
			if(inE == true){
			out.println("<th>["+E.getX()+","+E.getY()+"]</th>");}
			else{out.println("<th>?</th>");}
			out.println("</tr>");

			//Length Information
			out.println("<tr>");
			out.println("<th>Length AB: </th>");
			if(inAB == true){
			out.println("<th>"+AB+"</th>");}
			else{
			out.println("<th>?</th>");}
			out.println("</tr>");
			
			out.println("<tr>");
			out.println("<th>Length AC: </th>");
			if(inAC == true){
			out.println("<th>"+AC+"</th>");}
			else{
			out.println("<th>?</th>");}
			out.println("</tr>");
			
			out.println("<tr>");
			out.println("<th>Length AD: </th>");
			if(inAD == true){
			out.println("<th>"+AD+"</th>");}
			else{
			out.println("<th>?</th>");}
			out.println("</tr>");
			
			out.println("<tr>");
			out.println("<th>Length AE: </th>");
			if(inAE == true){
			out.println("<th>"+AE+"</th>");}
			else{
			out.println("<th>?</th>");}
			out.println("</tr>");
			
			out.println("<tr>");
			out.println("<th>Length DC: </th>");
			if(inDC == true){
			out.println("<th>"+DC+"</th>");}
			else{
			out.println("<th>?</th>");}
			out.println("</tr>");
			
			out.println("<tr>");
			out.println("<th>Length EB: </th>");
			if(inEB == true){
			out.println("<th>"+EB+"</th>");}
			else{
			out.println("<th>?</th>");}
			out.println("</tr>");
			
			out.println("<tr>");
			out.println("<th>Length DE: </th>");
			if(inDE == true){
			out.println("<th>"+DE+"</th>");}
			else{
			out.println("<th>?</th>");}
			out.println("</tr>");
			
			out.println("<tr>");
			out.println("<th>Length CB: </th>");
			if(inCB == true){
			out.println("<th>"+CB+"</th>");}
			else{
			out.println("<th>?</th>");}
			out.println("</tr>");
			out.println("</table>");
			
			//Arcs and Angles
			out.println("<table style=\"display: inline-block\" align=\"left\" border=\"1\">");
			out.println("<caption> Arcs and Angles </caption>");
			
			out.println("<tr>");
			out.println("<th>Angle DAE: </th>");
			if(inAD & inAE){angDAE =(Math.acos((Math.pow(AD,2.0)+Math.pow(AE,2.0)-Math.pow(DE,2.0))/(2.0*AD*AE)))*180/Math.PI;}
			else{angDAE = D.findAngle(A,E);}
			out.println("<th>"+angDAE+"</th>");
			out.println("</tr>");
			
			out.println("<tr>");
			out.println("<th>Angle EAB: </th>");
			if(inAB & inAE){angEAB =(Math.acos((Math.pow(AB,2.0)+Math.pow(AE,2.0)-Math.pow(EB,2.0))/(2.0*AB*AE)))*180/Math.PI;}
			else{angEAB = E.findAngle(A,B);}
			out.println("<th>"+angEAB+"</th>");
			out.println("</tr>");
			
			out.println("<tr>");
			out.println("<th>Angle BAC: </th>");
			if(inAB & inAC){angBAC =(Math.acos((Math.pow(AB,2.0)+Math.pow(AC,2.0)-Math.pow(CB,2.0))/(2.0*AB*AC)))*180/Math.PI;}
			else{angBAC = B.findAngle(A,C);}
			out.println("<th>"+angBAC+"</th>");
			out.println("</tr>");
			
			out.println("<tr>");
			out.println("<th>Angle CAD: </th>");
			if(inAC & inAD){angCAD =(Math.acos((Math.pow(AD,2.0)+Math.pow(AC,2.0)-Math.pow(DC,2.0))/(2.0*AD*AC)))*180/Math.PI;}
			else{angCAD = C.findAngle(A,D);}
			out.println("<th>"+angCAD+"</th>");
			out.println("</tr>");
			
			out.println("<tr>");
			out.println("<th>Arc DE: </th>");
			arcDE = (angDAE/360)*2*Math.PI*rad;
			out.println("<th>"+arcDE+"</th>");
			out.println("</tr>");
			
			out.println("<tr>");
			out.println("<th>Arc EB: </th>");
			arcEB = (angEAB/360)*2*Math.PI*rad;
			out.println("<th>"+arcEB+"</th>");
			out.println("</tr>");
			
			out.println("<tr>");
			out.println("<th>Arc BC: </th>");
			arcBC = (angBAC/360)*2*Math.PI*rad;
			out.println("<th>"+arcBC+"</th>");
			out.println("</tr>");
			
			out.println("<tr>");
			out.println("<th>Arc CD: </th>");
			arcCD = (angCAD/360)*2*Math.PI*rad;
			out.println("<th>"+arcCD+"</th>");
			out.println("</tr>");
			out.println("</table>");
			
			//Circle and Rectangle Information
			out.println("<table style=\"display: inline-block\" align=\"left\" border=\"1\">");
			out.println("<caption> Areas </caption>");
			
			out.println("<tr>");
			out.println("<th>Circle Area: </th>");
			cArea = rad*rad*Math.PI;
			out.println("<th>"+cArea+"</th>");
			out.println("</tr>");				
			
			out.println("<tr>");
			out.println("<th>Circle Circumference: </th>");
			circum = 2*Math.PI*rad;
			out.println("<th>"+circum+"</th>");
			out.println("</tr>");	
			
			out.println("<tr>");
			out.println("<th>Rectangle Area: </th>");
			rArea = DE*EB;
			out.println("<th>"+rArea+"</th>");
			out.println("</tr>");
			
			out.println("<tr>");
			out.println("<th>Rectangle Perimeter: </th>");
			rPerim = DE+EB+CB+DC;
			out.println("<th>"+rPerim+"</th>");
			out.println("</tr>");
			
			out.println("<tr>");
			out.println("<th>Unshaded Area: </th>");
			uArea = cArea-rArea;
			out.println("<th>"+uArea+"</th>");
			out.println("</tr>");
			
			out.println("<tr>");
			out.println("<th>Triangle DAE Area: </th>");
			if(!inE){out.println("<th>?</th>");}
			else{triDAE = Math.abs(((E.getY() - A.getY())*DE)/2.0);
			out.println("<th>"+triDAE+"</th>");}
			out.println("</tr>");
			
			out.println("<tr>");
			out.println("<th>Triangle EAB Area: </th>");
			if(!inE){out.println("<th>?</th>");}
			else{triEAB = Math.abs(((E.getX() - A.getX())*EB)/2.0);
			out.println("<th>"+triEAB+"</th>");}
			out.println("</tr>");
			
			out.println("<tr>");
			out.println("<th>Triangle BAC Area: </th>");
			if(!inC){out.println("<th>?</th>");}
			else{triBAC = Math.abs(((C.getY() - A.getY())*CB)/2.0);
			out.println("<th>"+triBAC+"</th>");}
			out.println("</tr>");
			
			out.println("<tr>");
			out.println("<th>Triangle CAD Area: </th>");
			if(!inC){out.println("<th>?</th>");}
			else{triCAD = Math.abs(((C.getX() - A.getX())*DC)/2.0);
			out.println("<th>"+triCAD+"</th>");}
			out.println("</tr>");
			
			out.println("</table>");
			break;
			
			case 2:
			out.println("<caption> There was an inconsistency error! The coordinates of at least of your Points conflicted with the rules of a rectangle! </caption><br>");
			out.println("<caption> Please note that inputs must satisfy rules of a rectangle. (i.e. D.y = E.y, D.x = C.x, etc.)</caption><br>");
			break;
			
			case 3:
			out.println("<caption> There was an inconsistency error! One of your diagonals/radius conflicted! </caption>");
			break;
			
			case 4:
			out.println("<caption> There was an inconsistency error! The sides of your rectangle are inconsistent! </caption><br>");
			out.println("<caption> Please note that inputs must satisfy rules of a rectangle. (i.e. DC = EB, CB = DE, etc.)</caption><br>");
			break;
			
			case 5:
			out.println("<caption> There was an inconsistency error! The coordinates of your Points were inconsistent with their relative locations! </caption><br>");
			out.println("<caption> Please try to keep Points in the same areas as in the diagram. (i.e. B.x greater than A.x, B.x less than A.x, etc.)</caption><br>");
			break;
	}
	
%>