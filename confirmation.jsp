<%@ include file="master.jsp" %>
<%@ include file="do/connect.jsp" %>

	<style>
		.modified {
			margin-top:5px;
		}
	</style>

	<div class="container">
		
		<div class="row" style="margin-top:60px;">
			
			<div class="span6">
				<form class="form-horizontal">
					<legend>Hotel Summary Order</legend>
					<%
					
					String curUserID = (String)session.getAttribute("userid");
					String query = "SELECT mhc.hotelid, hotelname, mhc.hotelclassid, hotelclassname, mc.cityname, mco.countryname, address, pricepernight, hotelclassurl, tph.startdate, tph.enddate, tph.paymenthotelid FROM mshotelclass AS mhc, mshotel as mh, mscity as mc, mscountry as mco, trpaymenthotel as tph WHERE mc.cityid=mh.cityid AND mhc.hotelid = mh.hotelid AND mco.countryid = mc.countryid AND tph.hotelid = mh.hotelid AND tph.hotelclassid = mhc.hotelclassid AND tph.userid = " + curUserID;

					ResultSet rs = st.executeQuery(query);
					while(rs.next()) {
					
					DateFormat old = new SimpleDateFormat("yyyy-MM-dd");
					Date dateoldstart = old.parse(rs.getDate("startdate").toString());
					Date dateoldend = old.parse(rs.getDate("enddate").toString());
					
					DateFormat df = new SimpleDateFormat("EEEE, dd MMMM yyyy");
					String startdate = df.format(dateoldstart);
					String enddate = df.format(dateoldend);
				
					Integer qty = 10;
					Integer price = rs.getInt("pricepernight");
					Integer night = 2;
					Integer total = qty * price * night;
					
					// ambil paymentid nya, soalnya mau di update
					%>
					<input type="hidden" name="totalhoteltemp" value="<%=total%>" />
					
						<div class="control-group">
							<label class="control-label">Room Hotel Preview :</label>
							<div class="controls form-text modified">
								<span>
									<img src="<%=rs.getString("hotelclassurl")%>" style="width:350px;height:175px;">
								</span>
							</div>
						</div>
						
						<div class="control-group">
							<label class="control-label">Hotel Name : </label>
							<div class="controls form-text modified">
								<span><%=rs.getString("hotelname")%></span>
							</div>
						</div>
						<div class="control-group">
							<label class="control-label">Address : </label>
							<div class="controls form-text modified">
								<span><%=rs.getString("address")%>,
									&nbsp;<%=rs.getString("cityname")%>, &nbsp;
									<%=rs.getString("countryname")%>
								</span>
							</div>
						</div>
						<div class="control-group">
							<label class="control-label">Hotel Room Class : </label>
							<div class="controls form-text modified">
								<span><%=rs.getString("hotelclassname")%></span>
							</div>
						</div>
						<div class="control-group">
							<label class="control-label">Price/night : </label>
							<div class="controls form-text modified">
								<span>Rp. <%=price%></span>
							</div>
						</div>
						<div class="control-group">
							<label class="control-label">Day in Hotel : </label>
							<div class="controls form-text modified">
								<span><%=startdate%> - <%=enddate%> (<%=night%> day(s))</span>
							</div>
						</div>
						<div class="control-group">
							<label class="control-label">Quantity of Room : </label>
							<div class="controls form-text modified">
								<span><%=qty%></span>
							</div>
						</div>
						<div class="control-group">
							<label class="control-label"><b>Grand Total : </b></label>
							<div class="controls form-text modified">
								<span><b>Rp. <%=total%> </b></span>
							</div>
						</div>
					<% } %>
				</form>
			</div>
			
			<div class="span6">
				<form id="formConfirmation" class="form-horizontal">
					<legend>Confirmation</legend>
					<div class="control-group">
						<label class="control-label">Bank</label>
						<div class="controls">
							<select name="ddlBank">
								<option value="1">BCA</option>
								<option value="2">BNI</option>
								<option value="3">MANDIRI</option>
							</select>
						</div>
					</div>
					<div class="control-group ">
						<label class="control-label">Account Name</label>
						<div class="controls">
							<input type="text" class="validate[required] text-input" data-prompt-position="topRight:-70" name="searchhotel" />
						</div>
					</div>
					
					<div class="control-group ">
						<label class="control-label">Account Number</label>
						<div class="controls">
							<input type="text" class="validate[required] text-input" data-prompt-position="topRight:-70" name="searchhotel" />
						</div>
					</div>
					
					<div class="control-group ">
						<label class="control-label">Total</label>
						<div class="controls">
							<input type="text" class="validate[required, custom[integer]] text-input" data-prompt-position="topRight:-70" name="total" />
						</div>
					</div>
					
					<div class="control-group ">
						<label class="control-label">Transfer Date</label>
						<div class="controls">
							<input type="text" class="dateinput validate[required] text-input" data-prompt-position="topRight:-70" name="searchhotel" />
						</div>
					</div>
					
					<div class="controls">
						<button type="submit" class="btn btn-primary">Confirm</button>
					</div>
				</form>
			</div>
			
			<!--
				-1 = rejected by admin
				0 = just recently bookind
				1 = had paid, but still not confirmed by admin
				2 - accepted by admin
			-->
		
		</div> <!-- /row -->
		
    </div> <!-- /container -->


<%@ include file="footer.jsp" %>

<script type="text/javascript">
	$(document).ready(function(){
		$(".dateinput").on('mouseover',function(data){
			$(".dateinput").datepicker({format:'yyyy-mm-dd'});
		});
		var totalhotel = $("[name='totalhoteltemp']").val();
		$("[name='totalhotel']").val(totalhotel);
		$("#formConfirmation").validationEngine();
	});
</script>