<%@ include file="master.jsp" %>
<%@ include file="do/connect.jsp" %>
	<style>
		.modified {
			margin-top:5px;
		}
	</style>
	
	<div class="container">
		<%
		
		if(session.getAttribute("username") == null || session.getAttribute("username") == "")
			response.sendRedirect("index.jsp");
		
		/* If user role is admin */
		String role = (String)session.getAttribute("role");
		if(role != null)
			if(role.compareTo("admin") == 0) {
		%>
		<div class="row" style="margin-top:60px;">
			<div class="span12">
				<table class="table table-bordered table-condensed">
					<thead>
						<tr>
							<th>No.</th>
							<th>Category</th>
							<th>Bank</th>
							<th>Account Name</th>
							<th>Account Number</th>
							<th>Transfer Date</th>
							<th>Total</th>
							<th style="text-align:center;">Action</th>
						</tr>
					</thead>
					<tbody>
						<%
							Integer no = 1;
							String query =  "SELECT 'Hotel' AS Category, PaymentHotelID AS ID, Bank, AccountName, AccountNumber, TransferDate, DATEDIFF('d', StartDate, EndDate) * NumberOfRoom * PaymentPrice AS Total FROM TrPaymentHotel WHERE HasConfirm = 1 UNION" +
											" SELECT 'Flight' AS Category, PaymentFlightID AS ID, Bank, AccountName, AccountNumber, TransferDate, PaymentPrice * Quantity AS Total FROM TrPaymentFlight WHERE HasConfirm = 1 UNION" + 
											" SELECT 'Tour' AS Category, PaymentTourID AS ID, Bank, AccountName, AccountNumber, TransferDate, PaymentPrice * Quantity AS Total FROM TrPaymentTour WHERE HasConfirm = 1";
							ResultSet rs4 = st2.executeQuery(query);
							/* Category is needed to specify order type */
							while(rs4.next()) {
							String category = rs4.getString("Category");
							String id = rs4.getString("ID");
						%>
						<tr>
							<td><%=no%></td>
							<!--<td><a data-toggle="modal" data-target="#modal<%=category%><%=id%>" style="cursor:pointer;"><%=category%></a></td>-->
							<td><%=category%></td>
							<td><%=rs4.getString("Bank")%></td>
							<td><%=rs4.getString("AccountName")%></td>
							<td><%=rs4.getString("AccountNumber")%></td>
							<td><%=rs4.getString("TransferDate")%></td>
							<td>Rp. <%=rs4.getString("Total")%></td>
							<td style="text-align:center;">
								<a href="do/doacceptorder.jsp?id=<%=id%>&&type=<%=category%>"><input type="button" class="btn btn-success" value="Accept" /></a>
								<a href="do/dorejectorder.jsp?id=<%=id%>&&type=<%=category%>"><input type="button" class="btn btn-danger" value="Reject" /></a>
							</td>
							<!--
							<div style="display: block;" id="modal<%=category%><%=id%>" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="false">
								<div class="modal-header">
									<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
									<h3 id="myModalLabel"><%=category%> Detail</h3>
								</div>
								<div class="modal-body">
									<p></p>
								</div>
								<div class="modal-footer">
								  <button class="btn" data-dismiss="modal">Close</button>
								</div>
							</div>
							-->
						</tr>
						
						<%
							no++;
							}
						%>
					</tbody>
				</table>
			</div>
		</div>
		<%
			} 
			/* user role is member */
			else {
		%>
			<!-- HOTEL -->
			<%
				String curUserID = (String)session.getAttribute("userid");
				String query = "SELECT mhc.hotelid, hotelname, mhc.hotelclassid, hotelclassname, mc.cityname, mco.countryname, address, pricepernight, hotelclassurl, tph.startdate, tph.enddate, tph.numberofroom, tph.paymenthotelid FROM mshotelclass AS mhc, mshotel as mh, mscity as mc, mscountry as mco, trpaymenthotel as tph WHERE mc.cityid=mh.cityid AND mhc.hotelid = mh.hotelid AND mco.countryid = mc.countryid AND tph.hotelid = mh.hotelid AND tph.hotelclassid = mhc.hotelclassid AND tph.hasConfirm = 0 AND tph.userid = " + curUserID;
				Integer index = 0;
				
				ResultSet rs = st.executeQuery(query);
				while(rs.next()) {
				
					DateFormat old = new SimpleDateFormat("yyyy-MM-dd");
					Date dateoldstart = old.parse(rs.getDate("startdate").toString());
					Date dateoldend = old.parse(rs.getDate("enddate").toString());
					
					DateFormat df = new SimpleDateFormat("EEEE, dd MMMM yyyy");
					String startdate = df.format(dateoldstart);
					String enddate = df.format(dateoldend);
				
					Integer qty = rs.getInt("numberofroom");;
					Integer price = rs.getInt("pricepernight");
					Integer night = 2;
					Integer total = qty * price * night;
			%>
			
			<div class="row" style="margin-top:60px;">
				<!-- Left content display summary order -->
				<div class="span6">
					<form class="form-horizontal">
						<legend>Hotel Summary Order</legend>
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
					</form>
				</div>
				
				<!-- Right content display form confirmation -->
				<div class="span6">
					<form id="formConfirmationHotel<%=index%>" class="form-horizontal" action="do/doconfirmationhotel.jsp" method="POST">
						<legend>Confirmation</legend>
						<input type="hidden" name="paymenthotelid" value="<%=rs.getString("paymenthotelid")%>" />
						<div class="control-group">
							<label class="control-label">Bank</label>
							<div class="controls">
								<select name="ddlBank">
									<option value="BCA">BCA</option>
									<option value="BNI">BNI</option>
									<option value="MANDIRI">MANDIRI</option>
								</select>
							</div>
						</div>
						<div class="control-group ">
							<label class="control-label">Account Name</label>
							<div class="controls">
								<input type="text" class="validate[required] text-input" data-prompt-position="topRight:-70" name="accountname" />
							</div>
						</div>
						
						<div class="control-group ">
							<label class="control-label">Account Number</label>
							<div class="controls">
								<input type="text" class="validate[required] text-input" data-prompt-position="topRight:-70" name="accountnumber" />
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
								<input type="text" readonly class="dateinput validate[required] text-input" data-prompt-position="topRight:-70" name="transferdate" />
							</div>
						</div>
						
						<div class="controls">
							<button type="submit" class="btn btn-primary">Confirm</button>
						</div>
					</form>
				</div>
			</div> <!-- /row -->
			
			<%
				index++;
				}
			%>
			
			<!-- FLIGHT -->
			<%	
				String query2 = "SELECT ma.airlineid, ma.airlinename,  airlineimage, tpf.flightid, mf.cityfromid, mcf.cityname AS CityFrom, citydestinationid, mcd.cityname AS CityDestination, date, FORMAT(date,'Long Date') as convDate, time, ticketprice, capacity, ispromo, tpf.quantity, tpf.paymentflightid FROM msflight mf, msairline ma, mscity mcf, mscity mcd, trpaymentflight tpf where mf.airlineid=ma.airlineid AND mcf.cityid=mf.cityfromid AND mcd.cityid=mf.citydestinationid AND mf.flightid = tpf.flightid AND tpf.hasconfirm = 0 AND tpf.userid = " + curUserID;
				ResultSet rs2 = st.executeQuery(query2);
				index = 0;
				while(rs2.next()) {
				
				String oldticketPrice = rs2.getString("ticketprice");
				Integer ticketPrice = Integer.parseInt(oldticketPrice.replace(".",""));
				Integer ticketquantity = rs2.getInt("quantity");
				Integer total = ticketquantity * ticketPrice;
			%>
			
			<div class="row" style="margin-top:60px;">
				<!-- Left content display summary order -->
				<div class="span6">
					<form class="form-horizontal">
						<legend>Flight Summary Order</legend>
							<div class="control-group">
								<label class="control-label">Airlines :</label>
								<div class="controls form-text modified">
									<span>
										<img src="<%=rs2.getString("airlineimage")%>" style="width:170px;height:50px;">
									</span>
								</div>
							</div>
							
							<div class="control-group">
								<label class="control-label">Price :</label>
								<div class="controls form-text modified">
									<span>Rp. <%=oldticketPrice%></span>
								</div>
							</div>
							
							<div class="control-group">
								<label class="control-label">Route :</label>
								<div class="controls form-text modified">
									<span><%=rs2.getString("CityFrom")%> - <%=rs2.getString("CityDestination")%></span>
								</div>
							</div>
							
							<div class="control-group">
								<label class="control-label">Flight Date :</label>
								<div class="controls form-text modified">
									<span><%=rs2.getString("convDate")%></span>
								</div>
							</div>
							
							<div class="control-group">
								<label class="control-label">Flight Time :</label>
								<div class="controls form-text modified">
									<span><%=rs2.getString("time")%></span>
								</div>
							</div>
							
							<div class="control-group">
								<label class="control-label">Quantity :</label>
								<div class="controls form-text modified">
									<span><%=ticketquantity%></span>
								</div>
							</div>
							
							<div class="control-group">
								<label class="control-label"><b>Grand Total :</b></label>
								<div class="controls form-text modified">
									<span><b>Rp. <%=total%></b></span>
								</div>
							</div>
					</form>
				</div>
				
				<!-- Right content display form confirmation -->
				<div class="span6">
					<form id="formConfirmationFlight<%=index%>" class="form-horizontal" action="do/doconfirmationflight.jsp" method="POST">
						<legend>Confirmation</legend>
						<input type="hidden" name="paymentflightid" value="<%=rs2.getString("paymentflightid")%>" />
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
								<input type="text" class="validate[required] text-input" data-prompt-position="topRight:-70" name="accountname" />
							</div>
						</div>
						
						<div class="control-group ">
							<label class="control-label">Account Number</label>
							<div class="controls">
								<input type="text" class="validate[required] text-input" data-prompt-position="topRight:-70" name="accountnumber" />
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
								<input type="text" class="dateinput validate[required] text-input" data-prompt-position="topRight:-70" name="transferdate" />
							</div>
						</div>
						
						<div class="controls">
							<button type="submit" class="btn btn-primary">Confirm</button>
						</div>
					</form>
				</div>
			</div> <!-- /row -->
			
			<%
				index++;
				}
			%>
			
			<!-- TOUR -->
			<%	
				index = 0;
				String query3 = "SELECT mt.tourid, mt.tourimage, mt.cityfromid, mcf.cityname AS CityFromName, mcd.cityname AS CityDestinationName, mt.startdate, mt.enddate, FORMAT(mt.startdate,'Long Date') as convStartDate, FORMAT(mt.enddate,'Long Date') as convEndDate, mt.capacity, mt.description, mt.price, mt.isPromo, tpt.quantity, tpt.paymenttourid FROM mstour AS mt, mscity AS mcf, mscity AS mcd, trpaymenttour AS tpt WHERE tpt.userid = '" + curUserID + "' AND mcf.cityid=mt.cityfromid AND mcd.cityid=mt.citydestinationid AND mt.tourid = tpt.tourid AND tpt.hasConfirm = 0";
				ResultSet rs3 = st.executeQuery(query3);
				
				while(rs3.next()) {
				String oldtourPrice = rs3.getString("price");
				String image = rs3.getString("tourimage");
				Integer tourprice = Integer.parseInt(oldtourPrice.replace(".",""));
				Integer quantity = rs3.getInt("quantity");
				Integer total = 2 * tourprice;
			%>
			
			<div class="row" style="margin-top:60px;">
				<!-- Left content display summary order -->
				<div class="span6">
					<form class="form-horizontal">
						<legend>Tour Summary Order</legend>
							<div class="control-group">
								<label class="control-label">Tour Scene Preview :</label>
								<div class="controls form-text modified">
									<span>
										<img src="<%=image%>" style="width:350px;height:175px;">
									</span>
								</div>
							</div>
							
							<div class="control-group">
								<label class="control-label">Price : </label>
								<div class="controls form-text modified">
									<span>Rp. <%=oldtourPrice%></span>
								</div>
							</div>
							
							<div class="control-group">
								<label class="control-label">Tour City : </label>
								<div class="controls form-text modified">
									<span>
									<%=rs3.getString("CityFromName")%> &nbsp;-&nbsp;<%=rs3.getString("CityDestinationName")%> 
									</span>
								</div>
							</div>
							
							<div class="control-group">
								<label class="control-label">Quantity :</label>
								<div class="controls form-text modified">
									<span><%=quantity%></span>
								</div>
							</div>
							
							<div class="control-group">
								<label class="control-label">Total :</label>
								<div class="controls form-text modified">
									<span><b>Rp. <%=total%></b></span>
								</div>
							</div>
					</form>
				</div>
				
				<!-- Right content display form confirmation -->
				<div class="span6">
					<form id="formConfirmationTour<%=index%>" class="form-horizontal" action="do/doconfirmationtour.jsp" method="POST">
						<legend>Confirmation</legend>
						<input type="hidden" name="paymenttourid" value="<%=rs3.getString("paymenttourid")%>" />
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
								<input type="text" class="validate[required] text-input" data-prompt-position="topRight:-70" name="accountname" />
							</div>
						</div>
						
						<div class="control-group ">
							<label class="control-label">Account Number</label>
							<div class="controls">
								<input type="text" class="validate[required] text-input" data-prompt-position="topRight:-70" name="accountnumber" />
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
								<input type="text" class="dateinput validate[required] text-input" data-prompt-position="topRight:-70" name="transferdate" />
							</div>
						</div>
						
						<div class="controls">
							<button type="submit" class="btn btn-primary">Confirm</button>
						</div>
					</form>
				</div>
			</div> <!-- /row -->
			
		<%
				index++;
				}
			}
		%>
		
		<!-- has confirm status
			0 = just recently booking
			1 = had paid, but still not confirmed by admin
			2 - accepted by admin
			3 = rejected by admin
		-->
    </div> <!-- /container -->


<%@ include file="footer.jsp" %>

<script type="text/javascript">
	$(document).ready(function(){
		/* Initialize datepicker component */
		$(".dateinput").on('mouseover',function(data){
			$(".dateinput").datepicker({format:'yyyy-mm-dd'});
		});
		var totalhotel = $("[name='totalhoteltemp']").val();
		$("[name='totalhotel']").val(totalhotel);
		
		/* bind form with validation engine */
		for(var i = 0; i < 100; i++) {
			$("#formConfirmationHotel" + i).validationEngine();
			$("#formConfirmationFlight" + i).validationEngine();
			$("#formConfirmationTour" + i).validationEngine();
		}
	});
</script>