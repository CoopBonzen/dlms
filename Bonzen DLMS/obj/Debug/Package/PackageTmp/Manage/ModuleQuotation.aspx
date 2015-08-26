<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.Master" CodeBehind="ModuleQuotation.aspx.vb" Inherits="Bonzen_DLMS.ModuleQuotation" %>

<%@ Register assembly="DevExpress.Web.v13.1, Version=13.1.8.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web.ASPxGridView" tagprefix="dx" %>
<%@ Register assembly="DevExpress.Web.v13.1, Version=13.1.8.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web.ASPxEditors" tagprefix="dx" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <div class="jumbotron">

        <dx:ASPxGridView ID="gv_QuotationDescription" 
            ClientInstanceName="CIN_gv_QuetationDescription" runat="server" DataSourceID="DataSource_QuotationDescription"
            KeyFieldName="ID_QuotationDescriptionSub"
            Width="100%" SettingsPager-PageSize="100" AutoGenerateColumns="False" SettingsBehavior-AutoExpandAllGroups="true"
            SettingsBehavior-AllowSort="false">

            <Columns>
                <%--<dx:GridViewCommandColumn ShowDeleteButton="True" ShowNewButtonInHeader="True" VisibleIndex="3" />--%>
                
                <dx:GridViewDataColumn Settings-AutoFilterCondition="Contains" FieldName="Q_Detail_Main" GroupIndex="0" VisibleIndex="1" Caption="รายการ"/>
                <dx:GridViewDataColumn Settings-AutoFilterCondition="Contains" FieldName="Q_Detail_Sub" VisibleIndex="1" Caption="รายการ" Width="70%"/>
                <dx:GridViewDataColumn Settings-AutoFilterCondition="Contains" FieldName="Price" VisibleIndex="2" Caption="ราคา" Width="20%"/>
                <dx:GridViewCommandColumn VisibleIndex="3" Width="10%">
                    <DeleteButton Visible="True" />
                    <ClearFilterButton Visible="True" />
                </dx:GridViewCommandColumn>
            </Columns>

            <SettingsBehavior AllowSort="False" AutoExpandAllGroups="True" />
            <SettingsPager PageSize="100"></SettingsPager>
            <SettingsEditing Mode="Inline" />
            <Settings ShowFilterRow="True" />
            

        </dx:ASPxGridView>

        <asp:SqlDataSource ID="DataSource_QuotationDescription" runat="server"
            ConnectionString="<%$ ConnectionStrings:DLMSConnectionString %>"
            SelectCommand="dummy">
<%--                    <UpdateParameters>
            <asp:Parameter Name="Q_Detail_Main" />
            <asp:Parameter Name="Q_Detail_Sub" />
            <asp:Parameter Name="Price" />
        </UpdateParameters>--%>
        </asp:SqlDataSource>

    </div>

</asp:Content>
