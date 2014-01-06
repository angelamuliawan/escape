<%@ include file="master.jsp" %>
<%@ include file="do/connect.jsp" %>
<div class="container">
		<!-- your content goes here -->
	<%
		String id = request.getParameter("hotelid");
		Integer hotelid = 0;
		if(id != null) hotelid = Integer.parseInt(id);

		String query = "SELECT * FROM MsHotelClass where HotelID ="+hotelid;
		Integer i =1;
		ResultSet rs = st.executeQuery(query);
		while(rs.next())
		{
	%>
		<div class="span11 tour-content">
			<div class="span3">
				<img src="assets/img/tourimage/1.jpg" style="width:200px;height:200px;"/>
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
		$("#txtDescription"+id).slideToggle();
	});
</script>