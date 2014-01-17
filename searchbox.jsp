<%@ include file="do/connect.jsp" %>
<div class="tabbable" style="margin-bottom: 18px;">
	<ul class="nav nav-tabs">
		<li class="active"><a href="#tab1" data-toggle="tab">Flight</a></li>
		<li><a href="#tab2" data-toggle="tab">Hotel</a></li>
		<li><a href="#tab3" data-toggle="tab">Tour</a></li>
	</ul>
	  
	<div class="tab-content" style="padding-bottom: 9px; border-bottom: 1px solid #ddd;">
		<!-- Tab Flight -->
		<div class="tab-pane active" id="tab1">
			<form method="post" action="do/SearchFlightFromIndex.jsp">
				<div class="control-group ">
					From
					<div class="controls">
						<select name="ddlCityFrom" id="ddlCityFrom">
						<%
							// To get data from database and insert to dropdown
							
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
							// To get data from database and insert to dropdown
							
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
		
		<!-- Tab Hotel -->
		<div class="tab-pane" id="tab2">				
			<div class="control-group ">
				<label class="control-label">Search</label>
				<div class="controls">
					<input type="text" name="searchhotel"  placeholder="Search by Hotel Name or Class" />
				</div>
			</div>
			<div class="control-group ">
				Select City
				<div class="controls">
					<select name="ddlCityHotel" id="ddlCityHotel">
					<%
						// To get data from database and insert to dropdown
						
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
				Rate Per Night
				<div class="controls">
					<select name="ddlPriceHotel">
						<option value="1"> All </option>
						<option value="500000"> <500,000 </option>
						<option value="1000000"> 500,000 - 1,000,000 </option>
						<option value="2000000"> 1,000,000 - 2,000,000 </option>
						<option value="2">2,000,000</option>
					</select>
				</div>
			</div>
			<div align="center" style="margin-left:-80px;">
				<input type="button" class="btn btn-primary" value="Find Hotel" />
			</div>
		</div>
		<!-- End Of Tab Hotel -->
		
		<!-- Tab Tour -->
		<div class="tab-pane" id="tab3">
			<div class="control-group ">
				From
				<div class="controls">
					<select name="ddlCityFromT" id="ddlCityFromT">
					<%
						// To get data from database and insert to dropdown
						
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
						// To get data from database and insert to dropdown
						
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
			<div class="control-group ">
				<label class="control-label">Date</label>
				<div class="controls">
				</div>
			</div>
		</div>
		<!-- End Of Tab Tour -->
	</div>
</div>