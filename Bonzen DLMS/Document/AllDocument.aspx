<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.Master"
    Culture="en-GB" CodeBehind="AllDocument.aspx.vb" Inherits="Bonzen_DLMS.AllDocument" %>

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
<%@ Register Src="../Preview/PreviewControl.ascx" TagName="PreviewControl" TagPrefix="uc1" %>
<%@ Import Namespace="Bonzen_DLMS" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <style type="text/css">
        .style2
        {
            width: 74px;
        }
        .style3
        {
            width: 65px;
            height: 24px;
        }
        .style4
        {
            height: 24px;
        }
        .style6
        {
            width: 102%;
        }
        .style7
        {
            width: 135%;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <script type="text/javascript">
        function btn_PreviewQuotation_Click(s, e) {
            CIN_pop_PreviewQuotation.Show();
        }

    </script>
    <div class="jumbotron">
        <dx:ASPxPopupControl ID="pop_PreviewQuotation" runat="server" ClientInstanceName="CIN_pop_PreviewQuotation"
            HeaderText="Preview Quotation" PopupVerticalAlign="WindowCenter" AllowResize="True"
            CloseAction="CloseButton" Modal="True" AllowDragging="True" PopupHorizontalAlign="WindowCenter"
            ShowFooter="false" Width="412px" Height="200px">
            <HeaderStyle HorizontalAlign="Center" BackColor="#5066AC" ForeColor="White" Font-Bold="True" />
            <ContentCollection>
                <dx:PopupControlContentControl>
                    <dx:ASPxCallbackPanel ID="cbp_PreviewQuotation" runat="server" Width="422px" ClientInstanceName="CIN_cbp_PreviewQuotation">
                        <PanelCollection>
                            <dx:PanelContent>
                                <table>
                                    <tr>
                                        <td class="style7">
                                            <dx:ASPxLabel ID="lbl_QNewUpload" runat="server" Text="หมายเลข Quotation">
                                            </dx:ASPxLabel>
                                            &nbsp;&nbsp;
                                            <dx:ASPxLabel ID="lbl_QNo" runat="server">
                                            </dx:ASPxLabel>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="style7">
                                            <dx:ASPxLabel ID="lbl_QuotationNumber" runat="server" Text="Company : ">
                                            </dx:ASPxLabel>
                                            &nbsp;&nbsp;
                                            <dx:ASPxLabel ID="lbl_QCompanyName" runat="server">
                                            </dx:ASPxLabel>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="style7">
                                            <dx:ASPxGridView ID="gv_QFile" runat="server" AutoGenerateColumns="False" KeyFieldName="Q_FileID"
                                                Width="100%">
                                                <Columns>
                                                    <dx:GridViewDataColumn ShowInCustomizationForm="True" VisibleIndex="0">
                                                        <DataItemTemplate>
                                                            <asp:HyperLink ID="Link" runat="server" ForeColor="#6798de" NavigateUrl='<%#Eval("link") %>'
                                                                ToolTip='<%#Eval("filename")%>'><%#Eval("filename")%></asp:HyperLink>
                                                        </DataItemTemplate>
                                                    </dx:GridViewDataColumn>
                                                    <dx:GridViewDataDateColumn FieldName="Q_FileDate" ShowInCustomizationForm="True"
                                                        SortIndex="0" SortOrder="Descending" Visible="False">
                                                    </dx:GridViewDataDateColumn>
                                                </Columns>
                                                <Settings ShowColumnHeaders="False" />
                                            </dx:ASPxGridView>
                                        </td>
                                    </tr>
                                    <br />
                                    <tr>
                                        <td class="style7">
                                            <dx:ASPxLabel ID="lbl_Total" runat="server" Text="Total : ">
                                            </dx:ASPxLabel>
                                            <dx:ASPxLabel ID="lbl_QTotal" runat="server">
                                            </dx:ASPxLabel>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="style7">
                                            <dx:ASPxLabel ID="lbl_Remark" runat="server" Text="Remark : ">
                                            </dx:ASPxLabel>
                                            &nbsp;&nbsp;
                                            <dx:ASPxLabel ID="lbl_QRemarke" runat="server">
                                            </dx:ASPxLabel>
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
    <h3>
        <strong>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Quotation & Proposal</strong></h3>
    <p class="lead">
        <dx:ASPxRoundPanel ID="ASPxRoundPanel2" runat="server" Width="920px" HeaderText="">
            <PanelCollection>
                <dx:PanelContent runat="server" SupportsDisabledAttribute="True">
                    <table style="width: 100%;">
                        <tr>
                            <td class="style3">
                                &nbsp;&nbsp;&nbsp; Year :
                            </td>
                            <td class="style4">
                                <dx:ASPxComboBox ID="cmb_searchYearQ" runat="server" DataSourceID="Quo_Year" ValueField="ayear"
                                    TextField="ayear" ValueType="System.Int32" Height="17px" Width="97px" SelectedIndex="0">
                                    <ClientSideEvents SelectedIndexChanged="function(s, e) { CIN_gv_quotationProposalAll.PerformCallback(); }">
                                    </ClientSideEvents>
                                </dx:ASPxComboBox>
                                <asp:SqlDataSource ID="Quo_Year" runat="server" ConnectionString="<%$ ConnectionStrings:DLMSConnectionString %>"
                                    SelectCommand="SELECT distinct(YEAR(QuotationProposal.Q_Date)) as ayear FROM [QuotationProposal] ORDER BY ayear DESC">
                                </asp:SqlDataSource>
                            </td>
                        </tr>
                    </table>
                    <dx:ASPxGridView ID="gv_quotationProposalAll" runat="server" AutoGenerateColumns="False"
                        ClientInstanceName="CIN_gv_quotationProposalAll" DataSourceID="Quo_Prop" KeyFieldName="Q_ID"
                        Width="888px" Style="text-align: center" Enabled="True">
                        <Columns>
                            <dx:GridViewDataTextColumn Caption="หมายเลข Quotation" FieldName="Q_ID" ReadOnly="True"
                                VisibleIndex="0" CellStyle-HorizontalAlign="Center" Width="8%" SortOrder="Descending">
                                <EditCellStyle HorizontalAlign="Center">
                                </EditCellStyle>
                                <DataItemTemplate>
                                    <asp:LinkButton ID="lnk_QId" runat="server" Text='<%# Eval("Q_ID") %>' CommandName="OpenCreateQuotation"
                                        CommandArgument='<%# Eval("Q_ID") %>' OnCommand="ListItem_Command" Enabled="True">
                                    </asp:LinkButton>
                                </DataItemTemplate>
                                <EditItemTemplate>
                                    <asp:Label ID="lbl_QId" runat="server" Text='<%# Eval("Q_ID") %>'></asp:Label>
                                </EditItemTemplate>
                                <CellStyle HorizontalAlign="Center">
                                </CellStyle>
                                <Settings AutoFilterCondition="Contains" />
                            </dx:GridViewDataTextColumn>
                            <dx:GridViewDataDateColumn Caption="วันที่ในจดหมาย" FieldName="Q_Date" VisibleIndex="2"
                                Width="8%">
                                <EditItemTemplate>
                                    <asp:Label ID="lbl_QDate" runat="server" Text='<%# Eval("Q_Date", "{0:d/MM/yyyy}") %>'>
                                    </asp:Label>
                                </EditItemTemplate>
                                <Settings AutoFilterCondition="Contains" />
                            </dx:GridViewDataDateColumn>
                            <dx:GridViewDataTextColumn Caption="ผู้รับ (บริษัท)" FieldName="company_name" VisibleIndex="4"
                                Width="20%">
                                <EditCellStyle HorizontalAlign="Center">
                                </EditCellStyle>
                                <EditItemTemplate>
                                    <asp:Label ID="lbl_ContactCompany" runat="server" Text='<%# Eval("company_name") %>'>
                                    </asp:Label>
                                </EditItemTemplate>
                                <Settings AutoFilterCondition="Contains" />
                            </dx:GridViewDataTextColumn>
                            <dx:GridViewDataTextColumn Caption="ผู้รับ (ชื่อ)" FieldName="attn" VisibleIndex="5"
                                Width="20%">
                                <EditCellStyle HorizontalAlign="Center">
                                </EditCellStyle>
                                <EditItemTemplate>
                                    <asp:Label ID="lbl_ContactName" runat="server" Text='<%# Eval("attn") %>'></asp:Label>
                                </EditItemTemplate>
                                <Settings AutoFilterCondition="Contains" />
                            </dx:GridViewDataTextColumn>
                            <dx:GridViewDataTextColumn Caption="เรื่อง" FieldName="Title" VisibleIndex="6" Width="20%">
                                <EditItemTemplate>
                                    <asp:TextBox ID="txt_Note" runat="server" Text='<%# Bind("Title") %>'>
                                    </asp:TextBox>
                                </EditItemTemplate>
                                <Settings AutoFilterCondition="Contains" />
                            </dx:GridViewDataTextColumn>
                            <dx:GridViewDataTextColumn Caption="ผู้จอง" FieldName="BookingBy" VisibleIndex="7"
                                Width="8%">
                                <EditItemTemplate>
                                    <asp:Label ID="lbl_BookingBy" runat="server" Text='<%# Eval("BookingBy") %>'></asp:Label>
                                </EditItemTemplate>
                                <Settings AutoFilterCondition="Contains" />
                            </dx:GridViewDataTextColumn>
                            <dx:GridViewDataTextColumn Caption="หมายเลข Proposal" FieldName="P_ID" VisibleIndex="1"
                                ReadOnly="True" CellStyle-HorizontalAlign="Center" Width="8%">
                                <EditCellStyle HorizontalAlign="Center">
                                </EditCellStyle>
                                <DataItemTemplate>
                                    <asp:LinkButton ID="lnk_PId" runat="server" Text='<%# Eval("P_ID") %>' CommandName="OpenUploadProposalFile"
                                        CommandArgument='<%# Eval("P_ID") %>' OnCommand="ListItem_Command">
                                    </asp:LinkButton>
                                </DataItemTemplate>
                                <EditItemTemplate>
                                    <asp:Label ID="lbl_PId" runat="server" Text='<%# Eval("P_ID") %>'></asp:Label>
                                </EditItemTemplate>
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
                            <dx:GridViewCommandColumn ButtonType="Image" VisibleIndex="8" ShowInCustomizationForm="True"
                                Width="8%" Caption="แก้ไข">
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
                            <dx:GridViewDataTextColumn Caption="สถานะ" Name="Status" ReadOnly="True" VisibleIndex="8"
                                Width="8%">
                                <EditCellStyle HorizontalAlign="Center">
                                </EditCellStyle>
                                <DataItemTemplate>
                                    <dx:ASPxLabel ID="lbl_statusType" runat="server" Text='<%#CType(Eval("quota_status"), QuotationStatusEnum).ToString %>'>
                                    </dx:ASPxLabel>
                                </DataItemTemplate>
                                <EditItemTemplate>
                                    <dx:ASPxLabel ID="lbl_statusType" runat="server" Text='<%#CType(Eval("quota_status"), QuotationStatusEnum).ToString %>'>
                                    </dx:ASPxLabel>
                                </EditItemTemplate>
                                <CellStyle HorizontalAlign="Center">
                                </CellStyle>
                            </dx:GridViewDataTextColumn>
                            <dx:GridViewDataColumn Caption="Preview" Name="Preview" VisibleIndex="9">
                                <EditCellStyle HorizontalAlign="Center">
                                </EditCellStyle>
                                <DataItemTemplate>
                                    <dx:ASPxButton ID="btn_PreviewQuotation" runat="server" Text="Preview" AutoPostBack="false"
                                        ClientInstanceName="CIN_btn_PreviewQuotation" Width="65px" Visible='<%# Eval("ShowQF") %>' />
                                </DataItemTemplate>
                                <EditItemTemplate>
                                    <dx:ASPxButton ID="btn_PreviewQuotation" runat="server" Text="Preview" AutoPostBack="false"
                                        ClientInstanceName="CIN_btn_PreviewQuotation" Width="65px" Visible='<%# Eval("ShowQF") %>' />
                                </EditItemTemplate>
                            </dx:GridViewDataColumn>
                        </Columns>
                        <SettingsEditing Mode="Inline" />
                        <Settings ShowFilterRow="True" />
                    </dx:ASPxGridView>
                    <asp:SqlDataSource ID="Quo_Prop" runat="server" ConnectionString="<%$ ConnectionStrings:DLMSConnectionString %>"
                        DeleteCommand="DELETE FROM [QuotationProposal] WHERE [Q_ID] = @Q_ID" InsertCommand="INSERT INTO [QuotationProposal] ([Q_ID], [Q_Date], [DateSend], [ContactCom], [ContactName], [Title], [BookingBy], [P_ID]) VALUES (@Q_ID, @Q_Date, @DateSend, @ContactCom, @ContactName, @Title, @BookingBy, @P_ID)"
                        SelectCommand=" SELECT DISTINCT QuotationProposal.Q_ID, QuotationProposal.P_ID, QuotationProposal.Q_Date, Quotation.company_name, Quotation.attn, QuotationProposal.Title, QuotationProposal.BookingBy, Quotation.Quota_ID, QuotationFile.Q_ID, 
                                        CASE WHEN QuotationFile.Q_ID Is NULL THEN 'False' ELSE 'True' END As ShowQF, 
                                        CASE WHEN Quotation.quota_status is null THEN 1 ELSE Quotation.quota_status END AS quota_status
                                        FROM QuotationProposal 
                                        LEFT OUTER JOIN Quotation ON QuotationProposal.Q_ID = Quotation.quotation_no	
                                        LEFT OUTER JOIN QuotationFile ON QuotationProposal.Q_ID = QuotationFile.Q_ID 
                                        WHERE YEAR(QuotationProposal.Q_Date) = @ayear " UpdateCommand="UPDATE [QuotationProposal] SET [Q_Date] = @Q_Date, [DateSend] = @DateSend, [ContactCom] = @ContactCom, [ContactName] = @ContactName, [Title] = @Title, [BookingBy] = @BookingBy, [P_ID] = @P_ID WHERE [Q_ID] = @Q_ID">
                        <SelectParameters>
                            <asp:ControlParameter ControlID="cmb_searchYearQ" Name="ayear" PropertyName="Value" />
                            <%--<asp:Parameter Name="ayear" Type="Int32" />--%>
                        </SelectParameters>
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
                            <asp:Parameter Name="Title" Type="String" />
                            <%--<asp:Parameter DbType="Date" Name="Q_Date" />
                    <asp:Parameter DbType="Date" Name="DateSend" />
                    <asp:Parameter Name="ContactCom" Type="String" />
                    <asp:Parameter Name="ContactName" Type="String" />
                    <asp:Parameter Name="BookingBy" Type="String" />
                    <asp:Parameter Name="P_ID" Type="String" />
                    <asp:Parameter Name="Q_ID" Type="String" />--%>
                        </UpdateParameters>
                    </asp:SqlDataSource>
                </dx:PanelContent>
            </PanelCollection>
        </dx:ASPxRoundPanel>
        <%--<asp:Parameter Name="Note" Type="String" />
                        <asp:Parameter DbType="Date" Name="DateSend" />
                        <asp:Parameter Name="ContactCom" Type="String" />
                        <asp:Parameter Name="ContactName" Type="String" />
                        <asp:Parameter Name="BookingBy" Type="String" />
                        <asp:Parameter Name="G_ID" Type="String" />--%>
    </p>
    <div>
        <h3>
            <strong>&nbsp;&nbsp;&nbsp;&nbsp; General</strong></h3>
        <p class="lead">
            <dx:ASPxRoundPanel ID="ASPxRoundPanel1" runat="server" Width="919px" Height="265px"
                HeaderText="">
                <PanelCollection>
                    <dx:PanelContent runat="server" SupportsDisabledAttribute="True">
                        <table style="width: 100%;">
                            <tr>
                                <td class="style2">
                                    &nbsp;&nbsp; Year :
                                </td>
                                <td>
                                    <dx:ASPxComboBox ID="cmb_searchYearG" runat="server" DataSourceID="Gen_Year" ValueField="ayear"
                                        TextField="ayear" ValueType="System.Int32" Height="17px" Width="97px" SelectedIndex="0">
                                        <ClientSideEvents SelectedIndexChanged="function(s, e) { CIN_gv_generalAll.PerformCallback(); }">
                                        </ClientSideEvents>
                                    </dx:ASPxComboBox>
                                    <asp:SqlDataSource ID="Gen_Year" runat="server" ConnectionString="<%$ ConnectionStrings:DLMSConnectionString %>"
                                        SelectCommand="select distinct(YEAR(General.G_Date)) as ayear from [General] order by ayear DESC">
                                    </asp:SqlDataSource>
                                </td>
                            </tr>
                        </table>
                        <dx:ASPxGridView ID="gv_generalAll" runat="server" AutoGenerateColumns="False" ClientInstanceName="CIN_gv_generalAll"
                            DataSourceID="SqlDataSource1" KeyFieldName="G_ID" Width="879px" Style="text-align: center">
                            <Columns>
                                <dx:GridViewDataTextColumn Caption="หมายเลขจดหมาย" FieldName="G_ID" ReadOnly="True"
                                    ShowInCustomizationForm="True" SortIndex="0" SortOrder="Descending" VisibleIndex="0"
                                    Width="8%">
                                    <Settings AutoFilterCondition="Contains" />
                                    <EditCellStyle HorizontalAlign="Center">
                                    </EditCellStyle>
                                    <DataItemTemplate>
                                        <asp:LinkButton ID="lnk_GId" runat="server" CommandArgument='<%# Eval("G_ID") %>'
                                            CommandName="OpenUploadGeneralFile" OnCommand="ListItem_Command" Text='<%# Eval("G_ID") %>'>
                                        </asp:LinkButton>
                                    </DataItemTemplate>
                                    <EditItemTemplate>
                                        <asp:Label ID="lbl_GId" runat="server" Text='<%# Eval("G_ID") %>'></asp:Label>
                                    </EditItemTemplate>
                                    <CellStyle HorizontalAlign="Center">
                                    </CellStyle>
                                </dx:GridViewDataTextColumn>
                                <dx:GridViewDataDateColumn Caption="วันที่ในจดหมาย" FieldName="G_Date" ShowInCustomizationForm="True"
                                    VisibleIndex="1" Width="8%">
                                    <Settings AutoFilterCondition="Contains" />
                                    <EditItemTemplate>
                                        <asp:Label ID="lbl_GDate" runat="server" Text='<%# Eval("G_Date", "{0:d/MM/yyyy}") %>'></asp:Label>
                                    </EditItemTemplate>
                                </dx:GridViewDataDateColumn>
                                <dx:GridViewDataTextColumn Caption="ผู้รับ (บริษัท)" FieldName="ContactCom" ShowInCustomizationForm="True"
                                    VisibleIndex="3" Width="25%">
                                    <Settings AutoFilterCondition="Contains" />
                                    <EditCellStyle HorizontalAlign="Center">
                                    </EditCellStyle>
                                    <EditItemTemplate>
                                        <asp:Label ID="lbl_ContactCompany" runat="server" Text='<%# Eval("ContactCom") %>'></asp:Label>
                                    </EditItemTemplate>
                                </dx:GridViewDataTextColumn>
                                <dx:GridViewDataTextColumn Caption="ผู้รับ (ชื่อ)" FieldName="ContactName" ShowInCustomizationForm="True"
                                    VisibleIndex="4" Width="25%">
                                    <Settings AutoFilterCondition="Contains" />
                                    <EditCellStyle HorizontalAlign="Center">
                                    </EditCellStyle>
                                    <EditItemTemplate>
                                        <asp:Label ID="lbl_ContactName" runat="server" Text='<%# Eval("ContactName") %>'></asp:Label>
                                    </EditItemTemplate>
                                </dx:GridViewDataTextColumn>
                                <dx:GridViewDataTextColumn Caption="เรื่อง" FieldName="Title" ShowInCustomizationForm="True"
                                    VisibleIndex="5" Width="18%">
                                    <Settings AutoFilterCondition="Contains" />
                                    <EditItemTemplate>
                                        <asp:TextBox ID="txt_Note" runat="server" Text='<%# Bind("Title") %>'></asp:TextBox>
                                    </EditItemTemplate>
                                </dx:GridViewDataTextColumn>
                                <dx:GridViewDataTextColumn Caption="ผู้จอง" FieldName="BookingBy" ShowInCustomizationForm="True"
                                    VisibleIndex="7" Width="8%">
                                    <Settings AutoFilterCondition="Contains" />
                                    <EditItemTemplate>
                                        <asp:Label ID="lbl_BookingBy" runat="server" Text='<%# Eval("BookingBy") %>'></asp:Label>
                                    </EditItemTemplate>
                                </dx:GridViewDataTextColumn>
                                <dx:GridViewCommandColumn ButtonType="Image" Caption="แก้ไข" ShowInCustomizationForm="True"
                                    VisibleIndex="8" Width="8%">
                                    <EditButton Visible="True">
                                        <Image AlternateText="Edit" Url="../images/edit.png">
                                        </Image>
                                    </EditButton>
                                    <CancelButton>
                                        <Image AlternateText="Cancel" Url="../images/cancel.gif">
                                        </Image>
                                    </CancelButton>
                                    <UpdateButton>
                                        <Image AlternateText="Update" Url="../images/disk.png">
                                        </Image>
                                    </UpdateButton>
                                </dx:GridViewCommandColumn>
                            </Columns>
                            <SettingsEditing Mode="Inline" />
                            <Settings ShowFilterRow="True" />
                        </dx:ASPxGridView>
                        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DLMSConnectionString %>"
                            DeleteCommand="DELETE FROM [General] WHERE [G_ID] = @G_ID" InsertCommand="INSERT INTO [General] ([G_ID], [G_Date], [DateSend], [ContactCom], [ContactName], [Title], [Note], [BookingBy]) VALUES (@G_ID, @G_Date, @DateSend, @ContactCom, @ContactName, @Title, @Note, @BookingBy)"
                            SelectCommand="SELECT General.* FROM [General] WHERE YEAR(General.G_Date) = @ayear"
                            UpdateCommand="UPDATE [General] SET [Title] = @Title WHERE [G_ID] = @G_ID">
                            <SelectParameters>
                                <asp:ControlParameter ControlID="cmb_searchYearG" Name="ayear" PropertyName="Value" />
                            </SelectParameters>
                            <DeleteParameters>
                                <asp:Parameter Name="G_ID" Type="String" />
                            </DeleteParameters>
                            <InsertParameters>
                                <asp:Parameter Name="G_ID" Type="String" />
                                <asp:Parameter DbType="Date" Name="G_Date" />
                                <asp:Parameter DbType="Date" Name="DateSend" />
                                <asp:Parameter Name="ContactCom" Type="String" />
                                <asp:Parameter Name="ContactName" Type="String" />
                                <asp:Parameter Name="Title" Type="String" />
                                <asp:Parameter Name="Note" Type="String" />
                                <asp:Parameter Name="BookingBy" Type="String" />
                            </InsertParameters>
                            <UpdateParameters>
                                <asp:Parameter Name="Title" Type="String" />
                                <%--<asp:Parameter Name="Note" Type="String" />
                        <asp:Parameter DbType="Date" Name="DateSend" />
                        <asp:Parameter Name="ContactCom" Type="String" />
                        <asp:Parameter Name="ContactName" Type="String" />
                        <asp:Parameter Name="BookingBy" Type="String" />
                        <asp:Parameter Name="G_ID" Type="String" />--%>
                            </UpdateParameters>
                        </asp:SqlDataSource>
                    </dx:PanelContent>
                </PanelCollection>
            </dx:ASPxRoundPanel>
        </p>
    </div>
</asp:Content>
