<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.Master"
    CodeBehind="SearchDocument.aspx.vb" Inherits="Bonzen_DLMS.SearchDocument" %>

<%@ Register Assembly="DevExpress.Web.v13.1, Version=13.1.8.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
    Namespace="DevExpress.Web.ASPxGridView" TagPrefix="dx" %>
<%@ Register Assembly="DevExpress.Web.v13.1, Version=13.1.8.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
    Namespace="DevExpress.Web.ASPxEditors" TagPrefix="dx" %>
<%@ Register Src="../UserControl/AddNewDocument.ascx" TagName="AddNewDocument" TagPrefix="uc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="jumbotron">
        <uc1:AddNewDocument ID="AddNewDocument" runat="server" />
    </div>
    <div class="jumbotron">
        <h3>
            Quotation & Proposal</h3>
        <p class="lead">
            <dx:ASPxGridView ID="gv_quotationProposal" ClientInstanceName="gv_quotationProposal" runat="server" AutoGenerateColumns="False"
                DataSourceID="Quo_Prop" KeyFieldName="Q_ID">
                <Columns>
                    <dx:GridViewDataTextColumn Caption="หมายเลข Quotation" FieldName="Q_ID" ReadOnly="True"
                        VisibleIndex="0" CellStyle-HorizontalAlign="Center" Width="8%" SortOrder="Descending">
                        <DataItemTemplate>
                            <asp:LinkButton ID="lnk_QId" runat="server" Text='<%# Eval("Q_ID") %>' CommandName="OpenCreateQuotation"
                                CommandArgument='<%# Eval("Q_ID") %>' OnCommand="ListItem_Command">
                            </asp:LinkButton>
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
                            <asp:LinkButton ID="lnk_PId" runat="server" Text='<%# Eval("P_ID") %>' CommandName="OpenUploadProposalFile"
                                CommandArgument='<%# Eval("P_ID") %>' OnCommand="ListItem_Command">
                            </asp:LinkButton>
                        </DataItemTemplate>
                        <CellStyle HorizontalAlign="Center">
                        </CellStyle>
                        <Settings AutoFilterCondition="Contains" />
                    </dx:GridViewDataTextColumn>
                    <dx:GridViewDataTextColumn Caption="พิมพ์ใบเสนอราคา" Name="Print" VisibleIndex="8" ReadOnly="True"
                        CellStyle-HorizontalAlign="Center" Width="8%">
                        <DataItemTemplate>
                            <asp:LinkButton ID="lnk_Print" runat="server" Text="Print" CommandName="PrintQuotation"
                                OnCommand="ListItem_Command" CommandArgument='<%# Eval("Quota_ID") %>' Visible='<%# Eval("Show") %>'>
                            </asp:LinkButton>
                        </DataItemTemplate>
                        <CellStyle HorizontalAlign="Center">
                        </CellStyle>
                    </dx:GridViewDataTextColumn>
                    <%--<dx:GridViewDataTextColumn Name="Quota_ID" FieldName="Quota_ID" Visible="false"></dx:GridViewDataTextColumn>--%>
                </Columns>
                <SettingsEditing Mode="Inline" />
                <Settings ShowFilterRow="True" />
            </dx:ASPxGridView>
            <asp:SqlDataSource ID="Quo_Prop" runat="server" ConnectionString="<%$ ConnectionStrings:DLMSConnectionString %>"
                DeleteCommand="DELETE FROM [QuotationProposal] WHERE [Q_ID] = @Q_ID" InsertCommand="INSERT INTO [QuotationProposal] ([Q_ID], [Q_Date], [DateSend], [ContactCom], [ContactName], [Title], [BookingBy], [P_ID]) VALUES (@Q_ID, @Q_Date, @DateSend, @ContactCom, @ContactName, @Title, @BookingBy, @P_ID)"
                SelectCommand="SELECT QuotationProposal.*, Quotation.Quota_ID, CASE WHEN Quotation.Quota_ID Is NULL THEN 'False' ELSE 'True' END As Show,  Quotation.company_name, Quotation.attn FROM QuotationProposal LEFT OUTER JOIN Quotation ON QuotationProposal.Q_ID = Quotation.quotation_no  WHERE DATEDIFF(day,Q_Date,getdate()) between 0 and 30 ORDER BY Q_Date DESC"
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
        <br />
        <div>
            <h3>
                General</h3>
            <p class="lead">
                <dx:ASPxGridView ID="gv_general" ClientInstanceName="gv_general" runat="server" AutoGenerateColumns="False" DataSourceID="General"
                    KeyFieldName="G_ID">
                    <Columns>
                        <dx:GridViewDataTextColumn Caption="หมายเลขจดหมาย" FieldName="G_ID" ReadOnly="True" SortOrder="Descending"
                            VisibleIndex="0" CellStyle-HorizontalAlign="Center" EditCellStyle-HorizontalAlign="Center" Width="8%">
                            <DataItemTemplate>
                                <asp:LinkButton ID="lnk_GId" runat="server" Text='<%# Eval("G_ID") %>' CommandName="OpenUploadGeneralFile"
                                    CommandArgument='<%# Eval("G_ID") %>' OnCommand="ListItem_Command">
                                </asp:LinkButton>
                            </DataItemTemplate>
                            <EditItemTemplate>
                                <asp:Label ID="lbl_GId" runat="server" Text='<%# Eval("G_ID") %>'></asp:Label>
                            </EditItemTemplate>
                            <CellStyle HorizontalAlign="Center">
                            </CellStyle>
                            <Settings AutoFilterCondition="Contains" />
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataDateColumn Caption="วันที่ในจดหมาย" FieldName="G_Date" VisibleIndex="1"
                            Width="8%">
                            <EditItemTemplate>
                                <asp:Label ID="lbl_GDate" runat="server" Text='<%# Eval("G_Date", "{0:d/MM/yyyy}") %>'></asp:Label>
                            </EditItemTemplate>
                            <Settings AutoFilterCondition="Contains" />
                        </dx:GridViewDataDateColumn>
                        <dx:GridViewDataTextColumn Caption="ผู้รับ (บริษัท)" FieldName="ContactCom" VisibleIndex="3"
                            Width="25%" EditCellStyle-HorizontalAlign="Center">
                            <EditItemTemplate>
                                <asp:Label ID="lbl_ContactCompany" runat="server" Text='<%# Eval("ContactCom") %>'></asp:Label>
                            </EditItemTemplate>
                            <Settings AutoFilterCondition="Contains" />
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn Caption="ผู้รับ (ชื่อ)" FieldName="ContactName" VisibleIndex="4"
                            Width="25%" EditCellStyle-HorizontalAlign="Center">
                            <EditItemTemplate>
                                <asp:Label ID="lbl_ContactName" runat="server" Text='<%# Eval("ContactName") %>'></asp:Label>
                            </EditItemTemplate>
                            <Settings AutoFilterCondition="Contains" />
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn Caption="เรื่อง" FieldName="Title" VisibleIndex="5" Width="18%">
                            <EditItemTemplate>
                                <asp:TextBox ID="txt_Note" runat="server" Text='<%# Bind("Title") %>'></asp:TextBox>
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
                                <asp:Label ID="lbl_BookingBy" runat="server" Text='<%# Eval("BookingBy") %>'></asp:Label>
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
                    <Settings ShowFilterRow="True" />
                </dx:ASPxGridView>
                <asp:SqlDataSource ID="General" runat="server" ConnectionString="<%$ ConnectionStrings:DLMSConnectionString %>"
                    DeleteCommand="DELETE FROM [General] WHERE [G_ID] = @G_ID" InsertCommand="INSERT INTO [General] ([G_ID], [G_Date], [DateSend], [ContactCom], [ContactName], [Title], [Note], [BookingBy]) VALUES (@G_ID, @G_Date, @DateSend, @ContactCom, @ContactName, @Title, @Note, @BookingBy)"
                    SelectCommand="SELECT * FROM [General]WHERE DATEDIFF(day,G_Date,getdate()) between 0 and 30 ORDER BY [G_ID], [G_Date] DESC " UpdateCommand="UPDATE [General] SET [Title] = @Title WHERE [G_ID] = @G_ID">
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
    </div>
</asp:Content>
