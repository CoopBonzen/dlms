<%@ Page Title="Upload File" Language="vb" MasterPageFile="~/Site.Master" AutoEventWireup="false"
    CodeBehind="Upload.aspx.vb" Inherits="WebApplication_1.About" %>

<%@ Register Assembly="DevExpress.Web.v13.1, Version=13.1.8.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
    Namespace="DevExpress.Web.ASPxUploadControl" TagPrefix="dx" %>

<asp:Content ID="HeaderContent" runat="server" ContentPlaceHolderID="HeadContent">
</asp:Content>
<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="MainContent">
    <h2>
        Upload File
    </h2>
    <dx:ASPxUploadControl ID="ASPxUploadControl1" runat="server" ShowUploadButton="True" ShowProgressPanel="True"
        OnFileUploadComplete="UploadControl_FileUploadComplete" Width="280px">
    </dx:ASPxUploadControl>
</asp:Content>
 