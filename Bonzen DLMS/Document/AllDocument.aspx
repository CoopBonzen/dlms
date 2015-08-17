<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.Master"
    CodeBehind="AllDocument.aspx.vb" Inherits="Bonzen_DLMS.AllDocument" %>

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
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <style type="text/css">
        .style2
        {
            width: 122px;
        }
        .style3
        {
            width: 132px;
            height: 24px;
        }
        .style4
        {
            height: 24px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <h3>
        <strong>Quotation & Proposal</strong></h3>
    <p class="lead">
        <dx:ASPxRoundPanel ID="ASPxRoundPanel2" runat="server" Width="920px" HeaderText="">
            <PanelCollection>
                <dx:PanelContent runat="server" SupportsDisabledAttribute="True">
                    <table style="width: 100%;">
                        <tr>
                            <td class="style3">
                                &nbsp; YEAR :
                            </td>
                            <td class="style4">
                                <dx:ASPxComboBox ID="cmb_searchYear" runat="server">
                                </dx:ASPxComboBox>
                            </td>
                        </tr>
                        <tr>
                            <td class="style3">
                                &nbsp; Search Quotation&nbsp; :&nbsp;
                            </td>
                            <td class="style4">
                                <dx:ASPxComboBox ID="cmb_searchQuotation" runat="server" Height="16px" Width="74px"
                                    IncrementalFilteringMode="Contains" ValueField="Q_ID" TextField="Q_ID" ValueType="System.String"
                                    DataSourceID="Quo_Prop" AutoPostBack="True" OnLoad="cmb_searchQuotation_Load">
                                    <ClientSideEvents SelectedIndexChanged="function(s, e) { gv_quotationProposal.PerformCallback(s.GetValue()); }">
                                    </ClientSideEvents>
                                </dx:ASPxComboBox>
                            </td>
                        </tr>
                    </table>
                    <dx:ASPxGridView ID="gv_quotationProposal" runat="server" AutoGenerateColumns="False"
                        ClientInstanceName="gv_quotationProposal" DataSourceID="Quo_Prop" KeyFieldName="Q_ID"
                        Width="888px">
                        <Columns>
                            <dx:GridViewDataTextColumn Caption="หมายเลข Quotation" FieldName="Q_ID" ReadOnly="True"
                                ShowInCustomizationForm="True" SortIndex="0" SortOrder="Descending" VisibleIndex="0"
                                Width="8%">
                                <Settings AutoFilterCondition="Contains" />
                                <DataItemTemplate>
                                    <asp:LinkButton ID="lnk_QId" runat="server" CommandArgument='<%# Eval("Q_ID") %>'
                                        CommandName="OpenCreateQuotation" OnCommand="ListItem_Command" Text='<%# Eval("Q_ID") %>'>
                                    </asp:LinkButton>
                                </DataItemTemplate>
                                <CellStyle HorizontalAlign="Center">
                                </CellStyle>
                            </dx:GridViewDataTextColumn>
                            <dx:GridViewDataDateColumn Caption="วันที่ในจดหมาย" FieldName="Q_Date" ShowInCustomizationForm="True"
                                VisibleIndex="2" Width="8%">
                                <Settings AutoFilterCondition="Contains" />
                            </dx:GridViewDataDateColumn>
                            <dx:GridViewDataTextColumn Caption="ผู้รับ (บริษัท)" FieldName="company_name" ShowInCustomizationForm="True"
                                VisibleIndex="4" Width="20%">
                                <Settings AutoFilterCondition="Contains" />
                            </dx:GridViewDataTextColumn>
                            <dx:GridViewDataTextColumn Caption="ผู้รับ (ชื่อ)" FieldName="attn" ShowInCustomizationForm="True"
                                VisibleIndex="5" Width="20%">
                                <Settings AutoFilterCondition="Contains" />
                            </dx:GridViewDataTextColumn>
                            <dx:GridViewDataTextColumn Caption="เรื่อง" FieldName="Title" ShowInCustomizationForm="True"
                                VisibleIndex="6" Width="20%">
                                <Settings AutoFilterCondition="Contains" />
                            </dx:GridViewDataTextColumn>
                            <dx:GridViewDataTextColumn Caption="ผู้จอง" FieldName="BookingBy" ShowInCustomizationForm="True"
                                VisibleIndex="7" Width="8%">
                                <Settings AutoFilterCondition="Contains" />
                            </dx:GridViewDataTextColumn>
                            <dx:GridViewDataTextColumn Caption="หมายเลข Proposal" FieldName="P_ID" ReadOnly="True"
                                ShowInCustomizationForm="True" VisibleIndex="1" Width="8%">
                                <Settings AutoFilterCondition="Contains" />
                                <DataItemTemplate>
                                    <asp:LinkButton ID="lnk_PId" runat="server" CommandArgument='<%# Eval("P_ID") %>'
                                        CommandName="OpenUploadProposalFile" OnCommand="ListItem_Command" Text='<%# Eval("P_ID") %>'>
                                    </asp:LinkButton>
                                </DataItemTemplate>
                                <CellStyle HorizontalAlign="Center">
                                </CellStyle>
                            </dx:GridViewDataTextColumn>
                            <dx:GridViewDataTextColumn Caption="พิมพ์ใบเสนอราคา" Name="Print" ReadOnly="True"
                                ShowInCustomizationForm="True" VisibleIndex="8" Width="8%">
                                <DataItemTemplate>
                                    <asp:LinkButton ID="lnk_Print" runat="server" CommandArgument='<%# Eval("Quota_ID") %>'
                                        CommandName="PrintQuotation" OnCommand="ListItem_Command" Text="Print" Visible='<%# Eval("Show") %>'>
                                    </asp:LinkButton>
                                </DataItemTemplate>
                                <CellStyle HorizontalAlign="Center">
                                </CellStyle>
                            </dx:GridViewDataTextColumn>
                        </Columns>
                        <SettingsEditing Mode="Inline" />
                        <Settings ShowFilterRow="True" />
                    </dx:ASPxGridView>
                </dx:PanelContent>
            </PanelCollection>
        </dx:ASPxRoundPanel>
        <asp:SqlDataSource ID="Quo_Prop" runat="server" ConnectionString="<%$ ConnectionStrings:DLMSConnectionString %>"
            DeleteCommand="DELETE FROM [QuotationProposal] WHERE [Q_ID] = @Q_ID" InsertCommand="INSERT INTO [QuotationProposal] ([Q_ID], [Q_Date], [DateSend], [ContactCom], [ContactName], [Title], [BookingBy], [P_ID]) VALUES (@Q_ID, @Q_Date, @DateSend, @ContactCom, @ContactName, @Title, @BookingBy, @P_ID)"
            SelectCommand="SELECT QuotationProposal.*, Quotation.Quota_ID, CASE WHEN Quotation.Quota_ID Is NULL THEN 'False' ELSE 'True' END As Show,  Quotation.company_name, Quotation.attn FROM QuotationProposal LEFT OUTER JOIN Quotation ON QuotationProposal.Q_ID = Quotation.quotation_no"
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
        <h3>
            <strong>General</strong></h3>
        <p class="lead">
            <dx:ASPxRoundPanel ID="ASPxRoundPanel1" runat="server" Width="919px" Height="265px"
                HeaderText="">
                <PanelCollection>
                    <dx:PanelContent runat="server" SupportsDisabledAttribute="True">
                        <table style="width: 100%;">
                            <tr>
                                <td class="style2">
                                    &nbsp; Search General&nbsp; :&nbsp;
                                </td>
                                <td>
                                    <dx:ASPxComboBox ID="cmb_searchGeneral" runat="server" Height="16px" Width="74px">
                                    </dx:ASPxComboBox>
                                </td>
                            </tr>
                        </table>
                        <dx:ASPxGridView ID="gv_general" runat="server" AutoGenerateColumns="False" ClientInstanceName="gv_general"
                            DataSourceID="General" KeyFieldName="G_ID" Width="879px">
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
                                <dx:GridViewCommandColumn ButtonType="Image" Caption="Edit Tiile" ShowInCustomizationForm="True"
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
                    </dx:PanelContent>
                </PanelCollection>
            </dx:ASPxRoundPanel>
            <asp:SqlDataSource ID="General" runat="server" ConnectionString="<%$ ConnectionStrings:DLMSConnectionString %>"
                DeleteCommand="DELETE FROM [General] WHERE [G_ID] = @G_ID" InsertCommand="INSERT INTO [General] ([G_ID], [G_Date], [DateSend], [ContactCom], [ContactName], [Title], [Note], [BookingBy]) VALUES (@G_ID, @G_Date, @DateSend, @ContactCom, @ContactName, @Title, @Note, @BookingBy)"
                SelectCommand="SELECT * FROM [General] ORDER BY [G_ID]" UpdateCommand="UPDATE [General] SET [Title] = @Title WHERE [G_ID] = @G_ID">
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
        </p>
    </div>
</asp:Content>
