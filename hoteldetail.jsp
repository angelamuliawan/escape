<%@ include file="master.jsp" %>
<%@ include file="do/connect.jsp" %>
<div class="container">
		<!-- your content goes here -->
	<%
		String id = request.getParameter("hotelid");
		Integer hotelid = 0;
		if(id != null) hotelid = Integer.parseInt(id);
	%>
	<div class="span11 hotel-content">
		<%
			String query = "SELECT hotelid, hotelname, phone, address, mh.cityid, mc.cityname, countryname, description, stars, hotelimage, ispromo, propertylocation, RoomDesription, RecreationSpa, FoodHall, BusinessFacility, AreaInformation FROM mshotel mh, mscity mc, mscountry mco where mh.cityid = mc.cityid AND mc.countryid = mco.countryid and HotelID ="+hotelid;
			ResultSet rs1 = st.executeQuery(query);
			Integer numstar = 0;
			Integer flag=1;
			while(rs1.next())
			{
			numstar = rs1.getInt("stars");
		%>
			<div class="span4">
				<img src="<%=rs1.getString("HotelImage")%>" style="width:300px;height:300px;"/>
			</div>
			<div class="span6">
					<h3 style="color:#ff9a25"><%=rs1.getString("hotelname")%></h3>
					<h5 style="color:#ff9a25">
						<%=rs1.getString("cityname")%> - <%=rs1.getString("countryname")%> 
						<%if(rs1.getInt("ispromo") == 1) out.print("<label style='color:red; display:inline;' class='blink'>IN PROMO</label>");%>
					</h5>
						<p>
							<%
								for(int j = 0; j<numstar; j++) out.print("<img src='assets/img/icon/Star.png' width='20' height='20' style='display:inline'>");
								
							%><br>
							<%=rs1.getString("description")%>
							
							
						
			</div>
			<div style="clear:both">
				<br>
				<h5 style="color:#ff9a25">
						Hotel Location	
					</h5>
					<p><%=rs1.getString("propertylocation")%></p>
					<h5 style="color:#ff9a25">
						Room Description
					</h5>
					<p><%=rs1.getString("RoomDesription")%></p>
					<h5 style="color:#ff9a25">
						Recreation, Spa And Premium Facility
					</h5>
					<p><%=rs1.getString("RecreationSpa")%></p>
					<h5 style="color:#ff9a25">
						Food Place
					</h5>
					<p><%=rs1.getString("FoodHall")%></p>
					<h5 style="color:#ff9a25">
						Facility Business
					</h5>
					<p><%=rs1.getString("BusinessFacility")%></p>
					<h5 style="color:#ff9a25">
						Area Information
					</h5>
					<p><%=rs1.getString("AreaInformation")%></p>
			</div>
		<%
			}
		%>
	</div>

	<%
		String query2 = "SELECT * FROM MsHotelClass where HotelID ="+hotelid;
		Integer i =1;
		ResultSet rs = st.executeQuery(query2);
		while(rs.next())
		{
	%>
		<div class="span11 tour-content">
			<div class="span3">
				<img src="<%=rs.getString("HotelClassURL")%>" style="width:200px;height:200px;"/>
			</div>
			<div class="span5">
				<h3 style="color:#FF9A25">
					<%=rs.getString("HotelClassName")%>
				</h3>
				<a style="cursor:pointer;" class="btnViewDesc" id="<%=i%>">View Description Of This Hotel Class<span style="size:16px;">&nbsp;^</span></a>
				<p style="text-align:justify; display:none;" id="txtDescription<%=i%>" ><%=rs.getString("Description")%></p>
			</div>	
			<div class="span2">
				<h5> $<%=rs.getString("PricePerNight")%> /night</h5>
				<p>include Tax</p>
				<input type="button" class="btn btn-primary" value="Booking" />
			</div>
		</div>
	<%
		i++;
		}
	%>
</div> <!-- </container> end of content -->

<%@ include file="footer.jsp" %>

<script type="text/javascript">
	$(".btnViewDesc").click(function(){
		var id = $(this).attr("id");
		$("#txtDescription"+id).stop().slideToggle();
	});
</script>