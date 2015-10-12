<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="PreviewControl.ascx.vb"
    Inherits="Bonzen_DLMS.PreviewControl" %>
<%@ Register Assembly="DevExpress.Web.v13.1, Version=13.1.8.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
    Namespace="DevExpress.Web.ASPxCallback" TagPrefix="dx" %>
<%@ Register Assembly="DevExpress.Web.v13.1, Version=13.1.8.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
    Namespace="DevExpress.Web.ASPxPopupControl" TagPrefix="dx" %>
<%@ Register Assembly="DevExpress.Web.v13.1, Version=13.1.8.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
    Namespace="DevExpress.Web.ASPxEditors" TagPrefix="dx" %>
<%@ Register Assembly="DevExpress.Web.v13.1, Version=13.1.8.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
    Namespace="DevExpress.Web.ASPxGridView" TagPrefix="dx" %>
<%@ Register Assembly="DevExpress.Web.v13.1, Version=13.1.8.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
    Namespace="DevExpress.Web.ASPxEditors" TagPrefix="dx" %>
<%@ Register Assembly="DevExpress.Web.v13.1, Version=13.1.8.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
    Namespace="DevExpress.Web.ASPxUploadControl" TagPrefix="dx" %>
<style type="text/css">
    .auto-style1
    {
        width: 262px;
        text-align: left;
    }
    
    .auto-style4
    {
        width: 153px;
        text-align: left;
    }
    
    .auto-style5
    {
        width: 153px;
    }
    
    .auto-style6
    {
        width: 194px;
    }
    
    .auto-style7
    {
        width: 159px;
    }
</style>
<dx:ASPxButton ID="btn_PreviewQuotation" runat="server" Text="Preview" AutoPostBack="false"
    ClientInstanceName="CIN_btn_PreviewQuotation" Width="69px">
    <%--<ClientSideEvents Click ="function (s,e){CIN_pop_AddDocument.Show();}" />‏--%>
    <ClientSideEvents Click="function (s,e){ CIN_pop_PreviewQuotation.Show();}" />
</dx:ASPxButton>
<dx:ASPxPopupControl ID="pop_PreviewQuotation" runat="server" ClientInstanceName="CIN_pop_PreviewQuotation"
    HeaderText="Preview Quotation" PopupVerticalAlign="WindowCenter" AllowResize="True"
    CloseAction="CloseButton" Modal="True" AllowDragging="True" PopupHorizontalAlign="WindowCenter"
    ShowFooter="false" Width="500px" Height="200px">
    <HeaderStyle HorizontalAlign="Center" BackColor="#5066AC" ForeColor="White" Font-Bold="True" />
    <ContentCollection>
        <dx:PopupControlContentControl>
            <table>
                <tr>
                    <td class="auto-style4" style="width: 50%">
                        <dx:ASPxLabel ID="lbl_QNewUpload" runat="server" Text="New Upload">
                        </dx:ASPxLabel>
                        &nbsp;&nbsp;
                        <dx:ASPxLabel ID="lbl_QNo" runat="server">
                        </dx:ASPxLabel>
                    </td>
                </tr>
                <tr>
                    <td class="auto-style4" style="width: 50%">
                        <dx:ASPxLabel ID="lbl_QuotationNumber" runat="server" Text="Company : ">
                        </dx:ASPxLabel>
                        &nbsp;&nbsp;
                        <dx:ASPxLabel ID="lbl_QCompanyName" runat="server">
                        </dx:ASPxLabel>
                    </td>
                </tr>
                <tr>
                    <td>
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
            </table>
        </dx:PopupControlContentControl>
    </ContentCollection>
</dx:ASPxPopupControl>
