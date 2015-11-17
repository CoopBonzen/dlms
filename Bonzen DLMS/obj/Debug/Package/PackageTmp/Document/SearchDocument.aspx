<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.Master"
    Culture="en-GB" CodeBehind="SearchDocument.aspx.vb" Inherits="Bonzen_DLMS.SearchDocument" %>

<%@ Register Assembly="DevExpress.Web.v13.1, Version=13.1.8.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
    Namespace="DevExpress.Web.ASPxCallbackPanel" TagPrefix="dx" %>
<%@ Register Assembly="DevExpress.Web.v13.1, Version=13.1.8.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
    Namespace="DevExpress.Web.ASPxPopupControl" TagPrefix="dx" %>
<%@ Register Assembly="DevExpress.Web.v13.1, Version=13.1.8.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
    Namespace="DevExpress.Web.ASPxGridView" TagPrefix="dx" %>
<%@ Register Assembly="DevExpress.Web.v13.1, Version=13.1.8.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
    Namespace="DevExpress.Web.ASPxEditors" TagPrefix="dx" %>
<%@ Register Assembly="DevExpress.Web.v13.1, Version=13.1.8.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
    Namespace="DevExpress.Web.ASPxNavBar" TagPrefix="dx" %>
<%@ Register Assembly="DevExpress.Web.v13.1, Version=13.1.8.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
    Namespace="DevExpress.Web.ASPxRoundPanel" TagPrefix="dx" %>
<%@ Register Assembly="DevExpress.Web.v13.1, Version=13.1.8.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
    Namespace="DevExpress.Web.ASPxPanel" TagPrefix="dx" %>
<%@ Register Assembly="DevExpress.Web.v13.1, Version=13.1.8.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
    Namespace="DevExpress.Web.ASPxCallback" TagPrefix="dx" %>
<%@ Register Assembly="DevExpress.Web.v13.1, Version=13.1.8.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
    Namespace="DevExpress.Web.Data.WebDataRow" TagPrefix="dx" %>
<%@ Register Src="../UserControl/AddNewDocument.ascx" TagName="AddNewDocument" TagPrefix="uc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <style type="text/css">
        .style4
        {
            font-size: 1.6em;
        }
        .style5
        {
            width: 248px;
        }
        .style6
        {
            width: 300px;
        }
    </style>
</asp:Content>
<asp:content id="Content2" contentplaceholderid="MainContent" runat="server">
    <script type="text/javascript">
        function btn_PreviewQuotation_Click(s, e) {
            CIN_pop_PreviewQuotation.Show();
        }
     

    </script>
    <div class="jumbotron">
        <uc1:addnewdocument id="AddNewDocument" runat="server" />
    </div>
    <div class="jumbotron">
        <dx:ASPxPopupControl ID="pop_PreviewQuotation" runat="server" ClientInstanceName="CIN_pop_PreviewQuotation"
            HeaderText="Preview Quotation" PopupVerticalAlign="WindowCenter" AllowResize="True"
            CloseAction="CloseButton" Modal="True" AllowDragging="True" PopupHorizontalAlign="WindowCenter"
            ShowFooter="false" Width="500px" Height="200px">
            <HeaderStyle HorizontalAlign="Center" BackColor="#5066AC" ForeColor="White" Font-Bold="True" />
            <ContentCollection>
                <dx:PopupControlContentControl>
                    <dx:ASPxCallbackPanel ID="cbp_PreviewQuotation" runat="server" Width="440px" ClientInstanceName="CIN_cbp_PreviewQuotation">
                        <PanelCollection>
                            <dx:PanelContent>
                                <table>
                                    <tr>
                                        <td class="style6">
                                            <dx:ASPxLabel ID="lbl_QNewUpload" runat="server" Text="หมายเลข Quotation">
                                            </dx:ASPxLabel>
                                            &nbsp;&nbsp;
                                            <dx:ASPxLabel ID="lbl_QNo" runat="server">
                                            </dx:ASPxLabel>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="style6">
                                            <dx:ASPxLabel ID="lbl_QuotationNumber" runat="server" Text="Company : ">
                                            </dx:ASPxLabel>
                                            &nbsp;&nbsp;
                                            <dx:ASPxLabel ID="lbl_QCompanyName" runat="server">
                                            </dx:ASPxLabel>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="style6">
                                            <dx:ASPxGridView ID="gv_QFile" runat="server" AutoGenerateColumns="False" KeyFieldName="Q_FileID"
                                                Width="148%">
                                                <columns>
                                                    <dx:GridViewDataColumn ShowInCustomizationForm="True" VisibleIndex="0">
                                                        <DataItemTemplate>
                                                            <asp:HyperLink ID="Link" runat="server" ForeColor="#6798de" NavigateUrl='<%#Eval("link") %>'
                                                                ToolTip='<%#Eval("filename")%>'><%#Eval("filename")%></asp:HyperLink>
                                                        </DataItemTemplate>
                                                    </dx:GridViewDataColumn>
                                                    <dx:GridViewDataDateColumn FieldName="Q_FileDate" ShowInCustomizationForm="True"
                                                        SortIndex="0" SortOrder="Descending" Visible="False">
                                                    </dx:GridViewDataDateColumn>
                                                </columns>
                                                <settings showcolumnheaders="False" />
                                            </dx:ASPxGridView>
                                        </td>
                                    </tr>
                                </table>
                            </dx:PanelContent>
                        </PanelCollection>
                    </dx:ASPxCallbackPanel>
                </dx:PopupControlContentControl>
            </ContentCollection>
        </dx:ASPxPopupControl>
    </div>
    <div class="jumbotron">
        <h3 class="style4">
            Latest Quotation &amp; Proposal (last 30 days)</h3>
        <%--<p>
               &nbsp;&nbsp;&nbsp;<span class="style3">Latest Quotation &amp; Proposal (last 30 days)</span></p>--%>
        <p class="lead">
            <dx:ASPxGridView ID="gv_quotationProposal" ClientInstanceName="gv_quotationProposal"
                runat="server" AutoGenerateColumns="False" DataSourceID="Quo_Prop" KeyFieldName="Q_ID"
                Width="894px">
                <Columns>
                    <dx:GridViewDataTextColumn Caption="หมายเลข Quotation" FieldName="Q_ID" ReadOnly="True"
                        VisibleIndex="0" CellStyle-HorizontalAlign="Center" Width="8%" SortOrder="Descending">
                        <DataItemTemplate>
                            <asp:linkbutton id="lnk_QId" runat="server" text='<%# Eval("Q_ID") %>' commandname="OpenCreateQuotation"
                                commandargument='<%# Eval("Q_ID") %>' oncommand="ListItem_Command">
                            </asp:linkbutton>
                        </DataItemTemplate>
                        <CellStyle HorizontalAlign="Center">
                        </CellStyle>
                        <Settings AutoFilterCondition="Contains" />
                    </dx:GridViewDataTextColumn>
                    <dx:GridViewDataDateColumn Caption="วันที่ในจดหมาย" FieldName="Q_Date" VisibleIndex="2"
                        Width="8%">
                        <Settings AutoFilterCondition="Contains" />
                    </dx:GridViewDataDateColumn>
                    <dx:GridViewDataTextColumn Caption="ผู้รับ (บริษัท)" FieldName="company_name" VisibleIndex="4"
                        Width="20%">
                        <Settings AutoFilterCondition="Contains" />
                    </dx:GridViewDataTextColumn>
                    <dx:GridViewDataTextColumn Caption="ผู้รับ (ชื่อ)" FieldName="attn" VisibleIndex="5"
                        Width="20%">
                        <Settings AutoFilterCondition="Contains" />
                    </dx:GridViewDataTextColumn>
                    <dx:GridViewDataTextColumn Caption="เรื่อง" FieldName="Title" VisibleIndex="6" Width="20%">
                        <Settings AutoFilterCondition="Contains" />
                    </dx:GridViewDataTextColumn>
                    <dx:GridViewDataTextColumn Caption="ผู้จอง" FieldName="BookingBy" VisibleIndex="7"
                        Width="8%">
                        <Settings AutoFilterCondition="Contains" />
                    </dx:GridViewDataTextColumn>
                    <dx:GridViewDataTextColumn Caption="หมายเลข Proposal" FieldName="P_ID" VisibleIndex="1"
                        ReadOnly="True" CellStyle-HorizontalAlign="Center" Width="8%">
                        <DataItemTemplate>
                            <asp:linkbutton id="lnk_PId" runat="server" text='<%# Eval("P_ID") %>' commandname="OpenUploadProposalFile"
                                commandargument='<%# Eval("P_ID") %>' oncommand="ListItem_Command">
                            </asp:linkbutton>
                        </DataItemTemplate>
                        <CellStyle HorizontalAlign="Center">
                        </CellStyle>
                        <Settings AutoFilterCondition="Contains" />
                    </dx:GridViewDataTextColumn>
                    <%--   <dx:GridViewDataTextColumn Caption="พิมพ์ใบเสนอราคา" Name="Print" VisibleIndex="8"
                        ReadOnly="True" CellStyle-HorizontalAlign="Center" Width="8%">
                        <DataItemTemplate>
                            <asp:LinkButton ID="lnk_Print" runat="server" Text="Print" CommandName="PrintQuotation"
                                OnCommand="ListItem_Command" CommandArgument='<%# Eval("Quota_ID") %>' Visible='<%# Eval("Show") %>'>
                            </asp:LinkButton>
                        </DataItemTemplate>
                        <CellStyle HorizontalAlign="Center">
                        </CellStyle>
                    </dx:GridViewDataTextColumn>--%>
                    <dx:GridViewDataTextColumn Caption="สถานะ" Name="Status" ReadOnly="True" VisibleIndex="8"
                        Width="8%">
                        <%--<DataItemTemplate>
                             <dx:ASPxLabel ID="lbl_statusType" runat="server" Text='<%#CType(Eval("quota_status"), QuotationStatusEnum).ToString %>'>
                            </dx:ASPxLabel>
                        </DataItemTemplate>--%>
                        <CellStyle HorizontalAlign="Center">
                        </CellStyle>
                    </dx:GridViewDataTextColumn>
                    <dx:GridViewDataColumn Caption="Preview" Name="Preview" VisibleIndex="9">
                        <DataItemTemplate>
                            <dx:ASPxButton ID="btn_PreviewQuotation" runat="server" Text="Preview" AutoPostBack="false"
                                ClientInstanceName="CIN_btn_PreviewQuotation" Width="65px" Visible='<%# Eval("ShowQF") %>' />
                        </DataItemTemplate>
                    </dx:GridViewDataColumn>
                </Columns>
                <SettingsEditing Mode="Inline" />
            </dx:ASPxGridView>
            <asp:sqldatasource id="Quo_Prop" runat="server" connectionstring="<%$ ConnectionStrings:DLMSConnectionString %>"
                deletecommand="DELETE FROM [QuotationProposal] WHERE [Q_ID] = @Q_ID" insertcommand="INSERT INTO [QuotationProposal] ([Q_ID], [Q_Date], [DateSend], [ContactCom], [ContactName], [Title], [BookingBy], [P_ID]) VALUES (@Q_ID, @Q_Date, @DateSend, @ContactCom, @ContactName, @Title, @BookingBy, @P_ID)"
                selectcommand="SELECT DISTINCT QuotationProposal.*, Quotation.Quota_ID, CASE WHEN Quotation.Quota_ID Is NULL THEN 'False' ELSE 'True' END As ShowQ, Quotation.company_name, Quotation.attn, QuotationFile.Q_ID, CASE WHEN QuotationFile.Q_ID Is NULL THEN 'False' ELSE 'True' END As ShowQF FROM QuotationProposal LEFT OUTER JOIN Quotation ON QuotationProposal.Q_ID = Quotation.quotation_no	LEFT OUTER JOIN QuotationFile ON QuotationProposal.Q_ID = QuotationFile.Q_ID WHERE Q_Date >= DATEADD(day, -30, getdate()) ORDER BY Q_Date DESC"
                updatecommand="UPDATE [QuotationProposal] SET [Q_Date] = @Q_Date, [DateSend] = @DateSend, [ContactCom] = @ContactCom, [ContactName] = @ContactName, [Title] = @Title, [BookingBy] = @BookingBy, [P_ID] = @P_ID WHERE [Q_ID] = @Q_ID">
                <deleteparameters>
                    <asp:Parameter Name="Q_ID" Type="String" />
                </deleteparameters>
                <insertparameters>
                    <asp:Parameter Name="Q_ID" Type="String" />
                    <asp:Parameter DbType="Date" Name="Q_Date" />
                    <asp:Parameter DbType="Date" Name="DateSend" />
                    <asp:Parameter Name="ContactCom" Type="String" />
                    <asp:Parameter Name="ContactName" Type="String" />
                    <asp:Parameter Name="Title" Type="String" />
                    <asp:Parameter Name="BookingBy" Type="String" />
                    <asp:Parameter Name="P_ID" Type="String" />
                </insertparameters>
                <updateparameters>
                    <asp:Parameter Name="Title" Type="String" />
                    <%--<asp:Parameter DbType="Date" Name="Q_Date" />
                    <asp:Parameter DbType="Date" Name="DateSend" />
                    <asp:Parameter Name="ContactCom" Type="String" />
                    <asp:Parameter Name="ContactName" Type="String" />
                    <asp:Parameter Name="BookingBy" Type="String" />
                    <asp:Parameter Name="P_ID" Type="String" />
                    <asp:Parameter Name="Q_ID" Type="String" />--%>
                </updateparameters>
            </asp:sqldatasource>
            <%--<asp:SqlDataSource ID="Quo_Prop" runat="server" ConnectionString="<%$ ConnectionStrings:DLMSConnectionString %>"
                DeleteCommand="DELETE FROM [QuotationProposal] WHERE [Q_ID] = @Q_ID" InsertCommand="INSERT INTO [QuotationProposal] ([Q_ID], [Q_Date], [DateSend], [ContactCom], [ContactName], [Title], [BookingBy], [P_ID]) VALUES (@Q_ID, @Q_Date, @DateSend, @ContactCom, @ContactName, @Title, @BookingBy, @P_ID)"
                
                SelectCommand="SELECT QuotationProposal.*, Quotation.Quota_ID FROM QuotationProposal LEFT OUTER JOIN Quotation ON QuotationProposal.Q_ID = Quotation.quotation_no" 
                UpdateCommand="UPDATE [QuotationProposal] SET [Q_Date] = @Q_Date, [DateSend] = @DateSend, [ContactCom] = @ContactCom, [ContactName] = @ContactName, [Title] = @Title, [BookingBy] = @BookingBy, [P_ID] = @P_ID WHERE [Q_ID] = @Q_ID">
                <DeleteParameters>
                    <asp:Parameter Name="Q_ID" Type="String" />
                </DeleteParameters>
                <InsertParameters>
                    <asp:Parameter Name="Q_ID" Type="String" />
                    <asp:Parameter DbType="Date" Name="Q_Date" />
                    <asp:Parameter DbType="Date" Name="DateSend" />
                    <asp:Parameter Name="ContactCom" Type="String" />
                    <asp:Parameter Name="ContactName" Type="String" />
                    <asp:Parameter Name="Title" Type="String" />
                    <asp:Parameter Name="BookingBy" Type="String" />
                    <asp:Parameter Name="P_ID" Type="String" />
                </InsertParameters>
                <UpdateParameters>
                    <asp:Parameter DbType="Date" Name="Q_Date" />
                    <asp:Parameter DbType="Date" Name="DateSend" />
                    <asp:Parameter Name="ContactCom" Type="String" />
                    <asp:Parameter Name="ContactName" Type="String" />
                    <asp:Parameter Name="Title" Type="String" />
                    <asp:Parameter Name="BookingBy" Type="String" />
                    <asp:Parameter Name="P_ID" Type="String" />
                    <asp:Parameter Name="Q_ID" Type="String" />
                </UpdateParameters>
            </asp:SqlDataSource>--%>
        </p>
        <div>
            <h3 class="style4">
                Latest General document</h3>
            <%--<p>
               &nbsp;&nbsp;&nbsp;<span class="style3">Latest General document</span></p>--%>
            <p class="lead">
                <dx:ASPxGridView ID="gv_general" ClientInstanceName="gv_general" runat="server" AutoGenerateColumns="False"
                    DataSourceID="General" KeyFieldName="G_ID" Width="894px">
                    <Columns>
                        <dx:GridViewDataTextColumn Caption="หมายเลขจดหมาย" FieldName="G_ID" ReadOnly="True"
                            SortOrder="Descending" VisibleIndex="0" CellStyle-HorizontalAlign="Center" EditCellStyle-HorizontalAlign="Center"
                            Width="8%">
                            <EditCellStyle HorizontalAlign="Center">
                            </EditCellStyle>
                            <DataItemTemplate>
                                <asp:linkbutton id="lnk_GId" runat="server" text='<%# Eval("G_ID") %>' commandname="OpenUploadGeneralFile"
                                    commandargument='<%# Eval("G_ID") %>' oncommand="ListItem_Command">
                                </asp:linkbutton>
                            </DataItemTemplate>
                            <EditItemTemplate>
                                <asp:label id="lbl_GId" runat="server" text='<%# Eval("G_ID") %>'></asp:label>
                            </EditItemTemplate>
                            <CellStyle HorizontalAlign="Center">
                            </CellStyle>
                            <Settings AutoFilterCondition="Contains" />
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataDateColumn Caption="วันที่ในจดหมาย" FieldName="G_Date" VisibleIndex="1"
                            Width="8%">
                            <EditItemTemplate>
                                <asp:label id="lbl_GDate" runat="server" text='<%# Eval("G_Date", "{0:d/MM/yyyy}") %>'>
                                </asp:label>
                            </EditItemTemplate>
                            <Settings AutoFilterCondition="Contains" />
                        </dx:GridViewDataDateColumn>
                        <dx:GridViewDataTextColumn Caption="ผู้รับ (บริษัท)" FieldName="ContactCom" VisibleIndex="3"
                            Width="25%" EditCellStyle-HorizontalAlign="Center">
                            <EditCellStyle HorizontalAlign="Center">
                            </EditCellStyle>
                            <EditItemTemplate>
                                <asp:label id="lbl_ContactCompany" runat="server" text='<%# Eval("ContactCom") %>'>
                                </asp:label>
                            </EditItemTemplate>
                            <Settings AutoFilterCondition="Contains" />
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn Caption="ผู้รับ (ชื่อ)" FieldName="ContactName" VisibleIndex="4"
                            Width="25%" EditCellStyle-HorizontalAlign="Center">
                            <EditCellStyle HorizontalAlign="Center">
                            </EditCellStyle>
                            <EditItemTemplate>
                                <asp:label id="lbl_ContactName" runat="server" text='<%# Eval("ContactName") %>'>
                                </asp:label>
                            </EditItemTemplate>
                            <Settings AutoFilterCondition="Contains" />
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn Caption="เรื่อง" FieldName="Title" VisibleIndex="5" Width="18%">
                            <EditItemTemplate>
                                <asp:textbox id="txt_Note" runat="server" text='<%# Bind("Title") %>'>
                                </asp:textbox>
                            </EditItemTemplate>
                            <Settings AutoFilterCondition="Contains" />
                        </dx:GridViewDataTextColumn>
                        <%-- <dx:GridViewDataTextColumn Caption="หมายเหตุ" FieldName="Note" VisibleIndex="6" Width="8%">
                            <EditItemTemplate>
                                <asp:TextBox ID="txt_Note" runat="server"></asp:TextBox>
                            </EditItemTemplate>
                        </dx:GridViewDataTextColumn>--%>
                        <dx:GridViewDataTextColumn Caption="ผู้จอง" FieldName="BookingBy" VisibleIndex="7"
                            Width="8%">
                            <EditItemTemplate>
                                <asp:label id="lbl_BookingBy" runat="server" text='<%# Eval("BookingBy") %>'></asp:label>
                            </EditItemTemplate>
                            <Settings AutoFilterCondition="Contains" />
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewCommandColumn ButtonType="Image" VisibleIndex="8" ShowInCustomizationForm="True"
                            Width="8%" Caption="Edit Tiile">
                            <EditButton Visible="True">
                                <Image AlternateText="Edit" Url="../images/edit.png">
                                </Image>
                            </EditButton>
                            <UpdateButton Visible="True">
                                <Image AlternateText="Update" Url="../images/disk.png">
                                </Image>
                            </UpdateButton>
                            <CancelButton Visible="True">
                                <Image AlternateText="Cancel" Url="../images/cancel.gif">
                                </Image>
                            </CancelButton>
                        </dx:GridViewCommandColumn>
                    </Columns>
                    <SettingsEditing Mode="Inline" />
                </dx:ASPxGridView>
                <asp:sqldatasource id="General" runat="server" connectionstring="<%$ ConnectionStrings:DLMSConnectionString %>"
                    deletecommand="DELETE FROM [General] WHERE [G_ID] = @G_ID" insertcommand="INSERT INTO [General] ([G_ID], [G_Date], [DateSend], [ContactCom], [ContactName], [Title], [Note], [BookingBy]) VALUES (@G_ID, @G_Date, @DateSend, @ContactCom, @ContactName, @Title, @Note, @BookingBy)"
                    selectcommand="SELECT TOP 10 General.* FROM [General] ORDER BY [G_ID] DESC "
                    updatecommand="UPDATE [General] SET [Title] = @Title WHERE [G_ID] = @G_ID">
                    <deleteparameters>
                        <asp:Parameter Name="G_ID" Type="String" />
                    </deleteparameters>
                    <insertparameters>
                        <asp:Parameter Name="G_ID" Type="String" />
                        <asp:Parameter DbType="Date" Name="G_Date" />
                        <asp:Parameter DbType="Date" Name="DateSend" />
                        <asp:Parameter Name="ContactCom" Type="String" />
                        <asp:Parameter Name="ContactName" Type="String" />
                        <asp:Parameter Name="Title" Type="String" />
                        <asp:Parameter Name="Note" Type="String" />
                        <asp:Parameter Name="BookingBy" Type="String" />
                    </insertparameters>
                    <updateparameters>
                        <asp:Parameter Name="Title" Type="String" />
                        <%--<asp:Parameter Name="Note" Type="String" />
                        <asp:Parameter DbType="Date" Name="DateSend" />
                        <asp:Parameter Name="ContactCom" Type="String" />
                        <asp:Parameter Name="ContactName" Type="String" />
                        <asp:Parameter Name="BookingBy" Type="String" />
                        <asp:Parameter Name="G_ID" Type="String" />--%>
                    </updateparameters>
                </asp:sqldatasource>
            </p>
        </div>
    </div>
</asp:content>
