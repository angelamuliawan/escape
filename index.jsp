<%@ include file="master.jsp" %>
<%@ include file="do/connect.jsp" %>
	<div class="container">
		
		<div class="row" style="margin-top:60px;">
		
			<div class="span4">
				<div class="tabbable" style="margin-bottom: 18px;">
					<ul class="nav nav-tabs">
						<li class="active"><a href="#tab1" data-toggle="tab">Flight</a></li>
						<li><a href="#tab2" data-toggle="tab">Hotel</a></li>
						<li><a href="#tab3" data-toggle="tab">Tour</a></li>
					</ul>
					  
					<div class="tab-content" style="padding-bottom: 9px; border-bottom: 1px solid #ddd;">
						<!-- Start Of Tab Flight -->
						<div class="tab-pane active" id="tab1">
							<form method="GET" action="flight.jsp">
								<div class="control-group ">
									From
									<div class="controls">

										<select name="ddlCityFrom" id="ddlCityFrom">
	<%
		//To get data from database and insert to dropdown
		
		String query = "SELECT mci.CityID, mci.CityName, mco.CountryName FROM MsCity as mci, MsCountry as mco WHERE mco.CountryID = mci.CountryID ORDER BY mci.CountryID";
		
		ResultSet rs = st.executeQuery(query);
		while(rs.next())
		{
	%>
											<option value="<%=rs.getInt("CityID")%>">
												<%=rs.getString("CityName")%> - <strong><%=rs.getString("CountryName")%></strong>
											</option>
	<%
		}
	%>
										</select>		
									</div>
								</div>
								<div class="control-group ">
									Destination
									<div class="controls">

										<select name="ddlCityDestination" id="ddlCityDestination">
	<%
		//To get data from database and insert to dropdown
		
		String query2 = "SELECT mci.CityID, mci.CityName, mco.CountryName FROM MsCity as mci, MsCountry as mco WHERE mco.CountryID = mci.CountryID ORDER BY mci.CountryID";
		
		ResultSet rs2 = st.executeQuery(query2);
		while(rs2.next())
		{
	%>
											<option value="<%=rs2.getInt("CityID")%>">
												<%=rs2.getString("CityName")%> - <b><%=rs2.getString("CountryName")%></b>
											</option>
	<%
		}
	%>
										</select>		
									</div>
								</div>
								<div class="control-group ">
									<label class="control-label">Date</label>
									<div class="controls">
										<input type="date" name="dateFlight" placeholder="Date" />
									</div>
								</div>
								<div align="center" style="margin-left:-80px;">
									<input type="submit" class="btn btn-primary" value="Find Flight" />
								</div>
							</form>
						</div>
						<!-- End Of Tab Flight -->
						
						<!-- Start Of Tab Hotel -->
						<div class="tab-pane" id="tab2">
									<form method="get" action="hotel.jsp">					
							<div class="control-group ">
								<label class="control-label">Search</label>
								<div class="controls">
									<input type="text" name="searchhotel"  placeholder="Search by Hotel Name" />
								</div>
							</div>
							<div class="control-group ">
								Select City
								<div class="controls">

									<select name="ddlCityHotel" id="ddlCityHotel">
<%
	//To get data from database and insert to dropdown
	
	String queryh = "SELECT mci.CityID, mci.CityName, mco.CountryName FROM MsCity as mci, MsCountry as mco WHERE mco.CountryID = mci.CountryID ORDER BY mci.CountryID";
	
	ResultSet rsh = st.executeQuery(queryh);
	while(rsh.next())
	{
%>
										<option value="<%=rsh.getInt("CityID")%>">
											<%=rsh.getString("CityName")%> - <b><%=rsh.getString("CountryName")%></b>
										</option>
<%
	}
%>
									</select>		
								</div>
							</div>
							<div class="control-group">
								Stars
								<div class="controls">
									<select name="ddlStars">
										<option value="0"> All </option>
										<option value="1">1</option>
										<option value="2">2</option>
										<option value="3">3</option>
										<option value="4">4</option>
										<option value="5">5</option>
									</select>
								</div>
							</div>
							<div align="center" style="margin-left:-80px;">
								<input type="submit" class="btn btn-primary" value="Find Hotel" />
							</div>
						</form>
						</div>
						<!-- End Of Tab Flight -->
						
						<!-- Start Of Tab Tour -->
						<div class="tab-pane" id="tab3">
							<div class="control-group ">
								From
								<div class="controls">

									<select name="ddlCityFromT" id="ddlCityFromT">
<%
	//To get data from database and insert to dropdown
	
	String query3 = "SELECT mci.CityID, mci.CityName, mco.CountryName FROM MsCity as mci, MsCountry as mco WHERE mco.CountryID = mci.CountryID ORDER BY mci.CountryID";
	
	ResultSet rs3 = st.executeQuery(query3);
	while(rs3.next())
	{
%>
										<option value="<%=rs3.getInt("CityID")%>">
											<%=rs3.getString("CityName")%> - <strong><%=rs3.getString("CountryName")%></strong>
										</option>
<%
	}
%>
									</select>		
								</div>
							</div>
							<div class="control-group ">
								Destination
								<div class="controls">

									<select name="ddlCityDestinationT" id="ddlCityDestinationT">
<%
	//To get data from database and insert to dropdown
	
	String query4 = "SELECT mci.CityID, mci.CityName, mco.CountryName FROM MsCity as mci, MsCountry as mco WHERE mco.CountryID = mci.CountryID ORDER BY mci.CountryID";
	
	ResultSet rs4 = st.executeQuery(query4);
	while(rs4.next())
	{
%>
										<option value="<%=rs4.getInt("CityID")%>">
											<%=rs4.getString("CityName")%> - <b><%=rs4.getString("CountryName")%></b>
										</option>
<%
	}
%>
									</select>		
								</div>
							</div>
							<div class="control-group ">
								<label class="control-label">Date</label>
								<div class="controls">
									<input type="date" name="dateT" placeholder="Date" />
								</div>
							</div>
							<div align="center" style="margin-left:-80px;">
								<input type="button" class="btn btn-primary" value="Find Tour" />
							</div>
						</div>
						<!-- End Of Tab Tour -->
					</div>
				</div> 
			</div>  <!-- /tabbable -->
		
		<div class="span8">

			 <!-- Carousel
          ================================================== -->
          <section id="carousel">
            
            <div id="myCarousel" class="carousel slide">
                <ol class="carousel-indicators">
                  <li data-target="#myCarousel" data-slide-to="0" class="active"></li>
                  <li data-target="#myCarousel" data-slide-to="1"></li>
                  <li data-target="#myCarousel" data-slide-to="2"></li>
                </ol>
                <div class="carousel-inner">
                  <div class="item active">
                    <img src="assets/img/airasia2.jpg" alt="">
                    <div class="carousel-caption">
                      <h4>Air Asia Promo IDR 99.000* </h4>
                      <p><br><br>*Terms and Conditions Apply</p>
                    </div>
                  </div>
                  <div class="item">
                    <img src="assets/img/hotel.jpg" alt="">
                    <div class="carousel-caption">
                      <h4>Hotel at Barcelona</h4>
                      <p>Starts from IDR 1.990.000*
                         <br><br>
                         *Terms and Conditions Apply</p>
                    </div>
                  </div>
                  <div class="item">
                    <img src="assets/img/uss.JPG" alt="">
                    <div class="carousel-caption">
                      <h4>Universal Studio Singapore</h4>
                      <p> 3 Days 2 Nights : Starts from IDR 3.500.000* 
                      <br><br>
                      *Terms and Conditions Apply</p>
                    </div>
                  </div>
                </div>
                <a class="left carousel-control" href="#myCarousel" data-slide="prev">&lsaquo;</a>
                <a class="right carousel-control" href="#myCarousel" data-slide="next">&rsaquo;</a>
            </div>
            

          </section>
		
		</div>
		</div> <!-- /container -->
    </div> <!-- /container -->


<%@ include file="footer.jsp" %>

<!-- Le javascript
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster -->
    <script type="text/javascript" src="http://platform.twitter.com/widgets.js"></script>
    <script src="assets/js/jquery.js"></script>
    <script src="assets/js/bootstrap-transition.js"></script>
    <script src="assets/js/bootstrap-alert.js"></script>
    <script src="assets/js/bootstrap-modal.js"></script>
    <script src="assets/js/bootstrap-dropdown.js"></script>
    <script src="assets/js/bootstrap-scrollspy.js"></script>
    <script src="assets/js/bootstrap-tab.js"></script>
    <script src="assets/js/bootstrap-tooltip.js"></script>
    <script src="assets/js/bootstrap-popover.js"></script>
    <script src="assets/js/bootstrap-button.js"></script>
    <script src="assets/js/bootstrap-collapse.js"></script>
    <script src="assets/js/bootstrap-carousel.js"></script>
    <script src="assets/js/bootstrap-typeahead.js"></script>
    <script src="assets/js/bootstrap-affix.js"></script>

    <script src="assets/js/holder/holder.js"></script>
    <script src="assets/js/google-code-prettify/prettify.js"></script>

    <script src="assets/js/application.js"></script>
	
	<script>
		/*$(document).ready(function(){
			$("#ddlCityFrom").change(function(){
				//var id = $("#ddlCityFrom").val();
				//alert($(this).siblings("#ddlCityDestination option:selected").val());
				
			});
		});*/
	</script>