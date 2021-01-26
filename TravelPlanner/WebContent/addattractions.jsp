<%@page import="java.sql.*"%>
<%@include file="appvars.jsp" %>
<%@page import="java.io.File"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="org.apache.commons.fileupload.FileItem"%>
<%@page import="java.util.Iterator"%>
<%@page import="org.apache.commons.fileupload.FileUploadException"%>
<%@page import="java.util.List"%>
<%@page import="org.apache.commons.fileupload.disk.DiskFileItemFactory"%>
<%@page import="org.apache.commons.fileupload.FileItemFactory"%>
<%@page import="org.apache.commons.fileupload.servlet.ServletFileUpload"%>
<!DOCTYPE html>
<html lang="en" dir="ltr">

	<!-- START head -->
	<head>
		<!-- Site meta charset -->
		<meta charset="UTF-8">
		
		<!-- title -->
		<title>Add Attraction</title>
		
		<!-- meta description -->
		<meta name="description" content="YOUR META DESCRIPTION GOES HERE" />
		
		<!-- meta keywords -->
		<meta name="keywords" content="YOUR META KEYWORDS GOES HERE" />
		
		<!-- meta viewport -->
		<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />
		
		<!-- favicon -->
		<link rel="icon" href="favicon.html" type="image/x-icon" />
		<link rel="shortcut icon" href="favicon.html" type="image/x-icon" />
		
		<!-- bootstrap 3 stylesheets -->
		<link rel="stylesheet" type="text/css" href="bs3/css/bootstrap.css" media="all" />
		<!-- template stylesheet -->
		<link rel="stylesheet" type="text/css" href="css/styles.css" media="all" />
		<!-- responsive stylesheet -->
		<link rel="stylesheet" type="text/css" href="css/responsive.css" media="all" />
		<!-- Load Fonts via Google Fonts API -->
		<link rel="stylesheet" type="text/css" href="http://fonts.googleapis.com/css?family=Karla:400,700,400italic,700italic" />
		<!-- color scheme -->
		<link rel="stylesheet" type="text/css" href="css/colors/color1.css" title="color1" />
		<link rel="alternate stylesheet" type="text/css" href="css/colors/color2.css" title="color2" />
		<link rel="alternate stylesheet" type="text/css" href="css/colors/color3.css" title="color3" />
		<link rel="alternate stylesheet" type="text/css" href="css/colors/color4.css" title="color4" />
	</head>
	<!-- END head -->

	<!-- START body -->
	<body>
		<!-- START #wrapper -->
		<div id="wrapper">
			<!-- START header -->
			<%@include file="header1.jsp" %>
			
			<!-- START #page-header -->
			<div id="header-banner">
				<div class="banner-overlay">
					<div class="container">
						<div class="row">
							<section class="col-sm-6">
								<h1 class="text-upper">Add Attraction</h1>
							</section>
							
							<!-- breadcrumbs -->
							<section class="col-sm-6">
								<ol class="breadcrumb">
                                                                    <li class="home"><a href="index.jsp">Home</a></li>
									<li><a href="adminpanel.jsp">Admin Panel</a></li>
									<li class="active">Add Attraction</li>
								</ol>
							</section>
						</div>
					</div>
				</div>
			</div>
			<!-- END #page-header -->
			
			<!-- START .main-contents -->
			<div class="main-contents">
				<div class="container">
					<!-- START #page -->
					<div id="page">
						
						<!-- START #contactForm -->
						<section id="signup-form">
							<h2 class="ft-heading text-upper">Add Attraction</h2>
                                                        <form action="" method="post" enctype="multipart/form-data">
								<fieldset>
									<ul class="formFields list-unstyled">
                                                                             <li class="row">
											<div class="col-md-6">
												<% 
      Connection myconnection=null;
        Class.forName(MYSQL_DRIVER_NAME);
      myconnection=DriverManager.getConnection(path+place,uname,pass);


boolean isMultipart = ServletFileUpload.isMultipartContent(request);
          
String name="",description="",filename="",category="",state="";
if(isMultipart)
    {
    FileItemFactory factory = new DiskFileItemFactory();
    ServletFileUpload upload = new ServletFileUpload(factory);
    List items = null;
   try
   {
   items = upload.parseRequest(request);
   }
   catch (FileUploadException e)
   {
       e.printStackTrace();
   }
   Iterator itr = items.iterator();
   while (itr.hasNext())
   {

   FileItem item = (FileItem) itr.next();
        if (item.isFormField())
        {
             String itemName1 = item.getFieldName();
            String value=item.getString();
            
            if(itemName1.equals("name")) //control's name - textbox name
           {    
                name=value;//variable name
                //out.println(uname);
           }
             if(itemName1.equals("description")) //control's name - textbox name
           {    
                description=value;//variable name
                //out.println(uname);
           }
             if(itemName1.equals("category")) //control's name - textbox name
           {    
                category=value;//variable name
                //out.println(uname);
           }
              if(itemName1.equals("state")) //control's name - textbox name
           {    
                state=value;//variable name
                //out.println(uname);
           }


        }
         else
        {
                String type=item.getContentType();
                long size=item.getSize(); //bytes
                if(size>0)
                {
                if(type.equals("image/pjpeg") || type.equals("image/jpeg")
                        || type.equals("image/png") || type.equals("image/x-png")
                        || type.equals("image/gif"))
                    {
                java.util.Date obj=new java.util.Date();
                SimpleDateFormat myformat=new SimpleDateFormat("ddMMyyyyhhmmss");
                String newdate=myformat.format(obj);
                
                filename=newdate+item.getName();
                String Path=config.getServletContext().getRealPath("/") + "\\uploads\\" + filename;
                File savefile=new File(Path);
                item.write(savefile);
               // out.println("<center><img src='images/" + filename + "' width=300px height=200px></center>");
                }
                else
                    {
                        out.println("Sorry only images are allowed to upload");
                    }
                        }
                else
                {
                 filename="default.jpg";
                        }
        }
                        
   }

   
try
{
          myconnection=DriverManager.getConnection(path+place,uname,pass);
          String q="insert into attractions(name,description,pic,category,stateid)  values(?,?,?,?,?)";
        PreparedStatement mystatement=myconnection.prepareStatement(q);
       mystatement.setString(1,name);
      
         mystatement.setString(2,description);
       mystatement.setString(3,filename);
       mystatement.setString(4,category);
        mystatement.setString(5,state);
              int a=mystatement.executeUpdate();
              if(a==1)
          {out.println("<font color='green'>Attraction added successfully</font>");
          }
              }

catch(Exception e)
              { out.println("not successful due to ");
              out.print(e.getMessage());
          }

             finally
              {myconnection.close();
               }
         }


%>
                      
       
											</div>
										</li>
										<li class="row">
											<div class="col-md-6">
												<label>Attraction Name <span class="required small">(Required)</span></label>
												<input type="text" class="form-control" name="name" value="" required/>
											</div></li>
                                                                                <li class="row">
                                                                                    <div class="col-md-6">
												<label>Description </label>
												<textarea name="description" id="address2" cols="45" rows="8" class="form-control" required></textarea>
											</div>
                                                                                    </li>
                                                                                    <li class="row">
                                                                                     <div class="col-md-6">
												<label>Image </label>
												 <input type="file" name="image" id="image" class="form-control" />
											</div>
                                                                                        </li>
                                                                                        <li class="row">
                                                                                    <div class="col-md-6">
												<label>Category </label>
												  <select name="category" id="category" class="form-control">
                                                                                                    <option>Choose Category</option>
                                                                                                    <option>Beaches</option>
                                                                                                    <option>Hill Stations</option>
                                                                                                    <option>Religious Places</option>
                                                                                                    <option>Tourist Spots</option>
                                                                                                  </select>
											</div>
                                                                                        </li>
                                                                                        <li class="row">
                                                                                     <div class="col-md-6">
												<label>State </label>
                                                                                    <select name="state" id="state" class="form-control">
                  <option>Choose State</option>
                   <%
        
          
    
        Class.forName(MYSQL_DRIVER_NAME);
      try
                      {myconnection=DriverManager.getConnection(path+place,uname,pass);
          String query="select * from statetable";
          PreparedStatement mystatement=myconnection.prepareStatement(query);


                 ResultSet myresult = mystatement.executeQuery();
                 if(myresult.next())
                     { do
                           {out.println("<option value="+myresult.getString("stateid")+">"+myresult.getString("statename")+"</option>");
                   }
                       while(myresult.next());
                  }
                 else
                     {out.println("invalid result");
                     }
                }
      catch(Exception e)
              { out.println("<script type='text/javascript'> alert('no states added yet')</script>");
          }








%>
                </select></li>
              
                                                                                   
											
										
										
										
										
										<li class="row">
											<div class="col-md-12">
												<input type="submit" class="btn btn-primary btn-lg text-upper" name="submit" value="Add Attraction" />
												
											</div>
										</li>
                                                                               
                                                                               
									</ul>
								</fieldset>
							</form>
						</section>
						<!-- END #contactForm -->
					</div>
					<!-- END #page -->
				</div>
			</div>
			<!-- END .main-contents -->
                          <div class="table-responsive"> 
				<% 
                                                                                                  
             try{

        Class.forName(MYSQL_DRIVER_NAME);
      myconnection=DriverManager.getConnection(path+place,uname,pass);
     try
                  {
                    String q1="select * from attractions";
                    PreparedStatement mystatement=myconnection.prepareStatement(q1);
                 
                    ResultSet myresult=mystatement.executeQuery();

                    if(myresult.next())
                    {
                        out.println("<table align='center' width='1024px' border='1px' cellspacing='0' cellpadding='5' class='.table-hover'>");
                        out.println("<tr bgcolor='yellow'><td width=150px>Name of Attraction</td><td>Description</td><td>Category</td></tr>");
                        do
                        {
                           
                                out.println("<tr>");
                            
                            out.println("<td>" + myresult.getString("name") + "</td>");
                           out.println("<td>" + myresult.getString("description") + "</td>");
                             
                            
                            out.println("<td>" + myresult.getString("category") + "</td>");
                           
 
                            
                            out.println("</tr>");                            
                        }
                        while(myresult.next());
                        out.println("</table>");
                    }
                    else
                    {
                         out.println("<h3 align='center'>No Events added yet</h3>");
                    }
                  }
                      catch(Exception e)
                    {
                        out.println("Error in Query " + e.getMessage());
                    }
                  finally
                  {
                      myconnection.close();
                  }
              }
              catch(Exception e)
              {
                  out.println("Error in Connection " + e.getMessage());
              }

                                                                                                


%>
                          </div>
			<!-- START footer -->
			<%@include file="footer.jsp" %>
			<!-- END footer -->
		</div>
		<!-- END #wrapper -->

	
		<!-- javascripts -->
		<script type="text/javascript" src="js/modernizr.custom.17475.js"></script>

		<script type="text/javascript" src="js/jquery.min.js"></script>
		<script type="text/javascript" src="bs3/js/bootstrap.min.js"></script>
		<script type="text/javascript" src="js/script.js"></script>
		<script src="js/styleswitcher.js"></script>
		<!--[if lt IE 9]>
			<script type="text/javascript" src="js/html5shiv.js"></script>
		<![endif]-->

		
	</body>
</html>