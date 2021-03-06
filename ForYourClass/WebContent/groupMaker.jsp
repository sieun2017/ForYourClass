<%@page import="java.io.FileReader"%>
<%@page import="java.io.BufferedReader"%>
<%@page import="java.util.StringTokenizer"%>
<%@ page import="java.net.URLEncoder"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
	request.setCharacterEncoding("UTF-8");
	int groupNum=Integer.parseInt(request.getParameter("groupNum"));
	
	String[] name=new String[20];
	int stuCnt=0;
	String str="";
	String result="";
	
	BufferedReader reader=null;

	try{
		String filePath = application.getRealPath("/WEB-INF/studentCnt.txt");
		reader=new BufferedReader(new FileReader(filePath));
		
		while(true){
			str=reader.readLine();
			if(str==null) break;
			out.println("");
			stuCnt=Integer.parseInt(str);
		}
		
	}catch(Exception e){
		out.println("파일을 읽을 수 없습니다.");
	}
	
	//학생 얻어오는 부분
	try{
		String filePath = application.getRealPath("/WEB-INF/classInfo.txt");
		reader=new BufferedReader(new FileReader(filePath));
		String csvStr="";
		String tmpStr="";
		
		do{
			tmpStr=reader.readLine();
			if(tmpStr!=null){
				csvStr+=tmpStr+" ";
			}
		}while(tmpStr!=null);
		StringTokenizer parse=new StringTokenizer(csvStr," ");
		for(int i=0;i<stuCnt;i++){
			name[i]=parse.nextToken();
			parse.nextToken();
			parse.nextToken();
		}
		
	}catch(Exception e){
		out.println("파일을 읽을 수 없습니다.");
	}
	
	for(int i=0;i<100;i++){
		int randNum1=(int)(Math.random()*stuCnt);
		int randNum2=(int)(Math.random()*stuCnt);
		String tmp=name[randNum1];
		name[randNum1]=name[randNum2];
		name[randNum2]=tmp;
	}
	
	if(groupNum<2||groupNum>stuCnt){
		result="2부터 "+stuCnt+"까지의 숫자를 입력해주세요";
	}else{
		int nmj=0;
		int cnt=0;
		if(stuCnt%groupNum>0){
			nmj=stuCnt%groupNum;
		}
		
		for(int i=0;i<groupNum;i++){
			result+=("<br>"+(i+1)+"조 : ");
			for(int j=0;j<(stuCnt/groupNum);j++){
				result+=(name[cnt++]+" ");
			}
			if(nmj>0)result+=(name[19-nmj--]+" ");
			result+="<br>";
		}
		result+="<br>";
	}
	String r=java.net.URLEncoder.encode(result);
	
	response.setContentType("text/html; charset=utf-8");
	response.sendRedirect("groupOrganize.jsp?RESULT="+r);
%>
</body>
</html>