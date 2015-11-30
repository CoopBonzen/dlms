<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.Master" CodeBehind="Report.aspx.vb" Inherits="Bonzen_DLMS.Report" %>
<%@ Register assembly="Microsoft.ReportViewer.WebForms, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a" namespace="Microsoft.Reporting.WebForms" tagprefix="rsweb" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <rsweb:ReportViewer ID="ReportViewer1" runat="server" Font-Names="Verdana" 
        Font-Size="8pt" InteractiveDeviceInfos="(Collection)" 
        WaitMessageFont-Names="Verdana" WaitMessageFont-Size="14pt" Width="100%" Height="1200">
        <LocalReport ReportPath="Report\QuotationReport.rdlc"><%--../images/trash.gif ~\Report\QuotationReport.rdlc--%>
            <DataSources>
                <rsweb:ReportDataSource DataSourceId="sds_report" Name="Quotation_DataSet" />
            </DataSources>
        </LocalReport>
    </rsweb:ReportViewer>
    <asp:SqlDataSource ID="sds_report" runat="server" ConnectionString="<%$ ConnectionStrings:DLMSConnectionString %>">
    </asp:SqlDataSource>
</asp:Content>
