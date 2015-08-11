<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.Master"
    CodeBehind="ManageCompany.aspx.vb" Inherits="Bonzen_DLMS.ManageCompany" %>

<%@ Register Assembly="DevExpress.Web.v13.1, Version=13.1.8.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
    Namespace="DevExpress.Web.ASPxGridView" TagPrefix="dx" %>
<%@ Register Assembly="DevExpress.Web.v13.1, Version=13.1.8.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
    Namespace="DevExpress.Web.ASPxEditors" TagPrefix="dx" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <dx:ASPxLabel ID="lbl_Company" runat="server" Text="Manage Company">
    </dx:ASPxLabel>
    <dx:ASPxGridView ID="gv_Company" runat="server" AutoGenerateColumns="False" DataSourceID="sds_salesApp"
        KeyFieldName="prospect_id">
        <Columns>
            <%--<dx:GridViewCommandColumn VisibleIndex="19" Caption="Edit" Width="9%">
                <DeleteButton Visible="True">
                </DeleteButton>
            </dx:GridViewCommandColumn>--%>
            <dx:GridViewDataTextColumn FieldName="prospect_nameTH" VisibleIndex="1" Width="25%"
                Caption="Company Name (TH)">
                <Settings AutoFilterCondition="Contains" />
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="prospect_nameEN" VisibleIndex="2" Width="20%"
                Caption="Company Name (EN)">
                <Settings AutoFilterCondition="Contains" />
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="tel_number" VisibleIndex="13" Width="15%"
                Caption="Telephone">
                <Settings AutoFilterCondition="Contains" />
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="fax" VisibleIndex="14" Caption="Fax" 
                Width="15%">
                <Settings AutoFilterCondition="Contains" />
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="mail" VisibleIndex="15" Caption="Email" Width="15%">
                <Settings AutoFilterCondition="Contains" />
            </dx:GridViewDataTextColumn>
        </Columns>
        <Settings ShowFilterRow="True" />
    </dx:ASPxGridView>
     <asp:SqlDataSource ID="sds_salesApp" runat="server" SelectCommand="dummy"
        ConnectionString="<%$ ConnectionStrings:DLMSConnectionString %>" >
    </asp:SqlDataSource>
</asp:Content>