<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.Master"
    CodeBehind="ProposalUpload.aspx.vb" Inherits="Bonzen_DLMS.ProposalUpload" %>

<%@ Register Assembly="DevExpress.Web.v13.1, Version=13.1.8.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
    Namespace="DevExpress.Web.ASPxGridView" TagPrefix="dx" %>
<%@ Register Assembly="DevExpress.Web.v13.1, Version=13.1.8.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
    Namespace="DevExpress.Web.ASPxEditors" TagPrefix="dx" %>
<%@ Register Assembly="DevExpress.Web.v13.1, Version=13.1.8.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
    Namespace="DevExpress.Web.ASPxUploadControl" TagPrefix="dx" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <script language="javascript" type="text/javascript">
        function OnFileUploadComplete(s, e) {
            btnUpdate.DoClick();
        }
    </script>
    <table width="50%">
        <tr>
            <td class="auto-style4" style="width: 50%">
                <dx:ASPxLabel ID="lbl_PNewUpload" runat="server" Text="New Upload" />
                &nbsp;&nbsp;
                <dx:ASPxLabel ID="lbl_PNo" runat="server" />
            </td>
        </tr>
        <tr>
            <td>
                <asp:UpdatePanel ID="Updatepanel1" runat="server">
                    <ContentTemplate>
                        <dx:ASPxButton ID="btnUpdate" runat="server" ClientInstanceName="btnUpdate" ClientVisible="false"
                            OnClick="Updatepanel1_Refresh">
                        </dx:ASPxButton>
                    </ContentTemplate>
                    <Triggers>
                        <asp:AsyncPostBackTrigger ControlID="btnUpdate" EventName="Click" />
                    </Triggers>
                </asp:UpdatePanel>

                <dx:ASPxUploadControl ID="ulc_ProposalFile" runat="server" ShowUploadButton="True"
                    ShowProgressPanel="True" OnFileUploadComplete="UploadControl_FileUploadComplete"
                    Width="280px">
                    <ValidationSettings AllowedFileExtensions=".pdf" ShowErrors="false" />
                    <ClientSideEvents FileUploadComplete="OnFileUploadComplete" />
                </dx:ASPxUploadControl>
            </td>
        </tr>
        <tr>
            <td class="auto-style4" style="width: 50%">
                <dx:ASPxLabel ID="lbl_ProposalNumber" runat="server" Text="Company : " />
                &nbsp;&nbsp;
                <dx:ASPxLabel ID="lbl_PCompanyName" runat="server" />
            </td>
        </tr>
        <tr>
            <td>
                <dx:ASPxGridView ID="gv_PFile" runat="server" Width="100%" KeyFieldName="P_FileID">
                    <Settings ShowColumnHeaders="false" />
                    <Columns>
                        <dx:GridViewDataColumn>
                            <DataItemTemplate>
                                <asp:HyperLink ID="Link" runat="server" NavigateUrl='<%#Eval("link") %>' ForeColor="#6798de"
                                    ToolTip='<%#Eval("filename")%>'><%#Eval("filename")%>
                                </asp:HyperLink>
                            </DataItemTemplate>
                        </dx:GridViewDataColumn>
                        <dx:GridViewDataDateColumn FieldName="P_FileDate" Visible="false" SortOrder="Descending">
                        </dx:GridViewDataDateColumn>
                    </Columns>
                </dx:ASPxGridView>
            </td>
        </tr>
    </table>
</asp:Content>
