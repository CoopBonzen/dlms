<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="AddNewDocument.ascx.vb"
    Inherits="Bonzen_DLMS.AddNewDocument" %>
<%@ Register Assembly="DevExpress.Web.v13.1, Version=13.1.8.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
    Namespace="DevExpress.Web.ASPxCallback" TagPrefix="dx" %>
<%@ Register Assembly="DevExpress.Web.v13.1, Version=13.1.8.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
    Namespace="DevExpress.Web.ASPxPopupControl" TagPrefix="dx" %>
<%@ Register Assembly="DevExpress.Web.v13.1, Version=13.1.8.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
    Namespace="DevExpress.Web.ASPxEditors" TagPrefix="dx" %>
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
    .style1
    {
        width: 30%;
        text-align: left;
        height: 18px;
    }
    .style2
    {
        width: 70%;
        height: 18px;
    }
</style>
<dx:aspxbutton id="btn_AddDocument" runat="server" text="Add New Document" autopostback="false"
    clientinstancename="CIN_btn_AddDocument">
    <%--<ClientSideEvents Click ="function (s,e){CIN_pop_AddDocument.Show();}" />‏--%>
    <ClientSideEvents Click="function (s,e){ CIN_pop_AddDocument.Show();}" />
</dx:aspxbutton>
<dx:aspxpopupcontrol id="pop_AddDocument" runat="server" clientinstancename="CIN_pop_AddDocument"
    headertext="Add New Document" popupverticalalign="WindowCenter" allowresize="True"
    closeaction="CloseButton" modal="True" allowdragging="True" popuphorizontalalign="WindowCenter"
    showfooter="false" width="500px">
    <HeaderStyle HorizontalAlign="Center" BackColor="#5066AC" ForeColor="White" Font-Bold="True" />
    <ContentCollection>
        <dx:PopupControlContentControl>
            <table>
                <tr>
                    <td style="width: 150px">
                        <dx:ASPxLabel ID="lbl_DocumentType" runat="server" Text="New Doucument Type : ">
                        </dx:ASPxLabel>
                    </td>
                    <td>
                        <br />
                        <dx:ASPxComboBox ID="cmb_DocumentType" runat="server" ValueType="System.String" ClientInstanceName="CIN_cmb_DocumentType">
                            <Items>
                                <dx:ListEditItem Text="Quotation" Value="quotation" />
                                <dx:ListEditItem Text="Proposal" Value="proposal" />
                                <dx:ListEditItem Text="General" Value="general" />
                            </Items>
                            <%--<ClientSideEvents SelectedIndexChanged="function (s,e){var SelectedIndex = CIN_cmb_DocumentType.GetSelectedIndex(); 
                                                                                   //alert(SelectedIndex);
                                                                                   CIN_pop_AddDocument.Hide();
                                                                                           switch (SelectedIndex) {
                                                                                            case 0:
                                                                                                CIN_pop_quotation.Show();
                                                                                                break;
                                                                                            case 1:
                                                                                                CIN_pop_proposal.Show();
                                                                                                break;
                                                                                            case 2:
                                                                                                CIN_pop_general.Show();
                                                                                                break;
                                                                                            default: alert('No matched value');
                                                                                        }
                                                                                    }"
                                              EndCallback="function(s, e) {
                                                               if (s.cpQNo) lbl_QNo.SetText(s.cpQNo);
                                                           }"
                              />--%>
                            <ClientSideEvents SelectedIndexChanged="function(s, e) {
                                                                          var SelectedIndex = CIN_cmb_DocumentType.GetSelectedIndex();
                                                                          CIN_pop_AddDocument.Hide();
                                                                          cb_PopupInit.PerformCallback(SelectedIndex);
                                                                          
                                                                      }" />
                        </dx:ASPxComboBox>
                        <br />
                    </td>
                </tr>
            </table>
        </dx:PopupControlContentControl>
    </ContentCollection>
</dx:aspxpopupcontrol>
<dx:aspxcallback id="cb_PopupInit" clientinstancename="cb_PopupInit" runat="server">
    <ClientSideEvents EndCallback="function(s, e) {
                                       if (s.cpRunNo.indexOf('Q') == 0) {
                                           CIN_pop_quotation.Show();
                                           lbl_QNo.SetText(s.cpRunNo);
                                           lbl_QName.SetText(s.cpQName);
                                           txtb_QTitle.SetText();
                                           Q_Date.SetText();
                                       }
                                       else if (s.cpRunNo.indexOf('BZ-P') == 0) {
                                           CIN_pop_proposal.Show();
                                           CIN_cbb_QId.PerformCallback();
                                           lbl_PNo.SetText(s.cpRunNo);
                                       }
                                       else if (s.cpRunNo.indexOf('BZ-G') == 0) {
                                           CIN_pop_general.Show();
                                           lbl_GNo.SetText(s.cpRunNo);
                                           lbl_GName.SetText(s.cpGName);
                                           txtb_GTitle.SetText();
                                           G_Date.SetText();
                                           
                                       }
                                       if (s.cpRefreshData) {
                                           CIN_pop_general.Hide();
                                           CIN_pop_proposal.Hide();
                                           CIN_pop_quotation.Hide();
                                           gv_quotationProposal.PerformCallback('Bind data');
                                           gv_general.PerformCallback('Bind data');
                                       }
                                   }" />
</dx:aspxcallback>
<dx:aspxpopupcontrol id="pop_quotation" runat="server" clientinstancename="CIN_pop_quotation"
    headertext="Quotation" popupverticalalign="WindowCenter" allowresize="True" closeaction="CloseButton"
    modal="True" allowdragging="True" popuphorizontalalign="WindowCenter" showfooter="false"
    width="500px">
    <HeaderStyle HorizontalAlign="Center" BackColor="#5066AC" ForeColor="White" Font-Bold="True" />
    <ContentCollection>
        <dx:PopupControlContentControl>
            <table width="100%">
                <tr>
                    <td class="auto-style4" style="width: 30%">
                        <dx:ASPxLabel ID="lbl_Q" runat="server" Text="Quotation Number : " />
                    </td>
                    <td style="width: 70%">
                        <dx:ASPxLabel ID="lbl_QNo" ClientInstanceName="lbl_QNo" runat="server" />
                    </td>
                </tr>
                <tr>
                    <td style="width: 30%">
                        <dx:ASPxLabel ID="lbl_QTitle" runat="server" Text="Title : " />
                    </td>
                    <td style="width: 70%">
                        <dx:ASPxTextBox ID="txtb_QTitle" runat="server" Width="300px" ClientInstanceName="txtb_QTitle">
                            <%--<ValidationSettings  RequiredField-IsRequired="true" RequiredField-ErrorText="กรุณาระบุหัวเรื่อง" ValidationGroup="entryQuotation"></ValidationSettings>--%>
                        </dx:ASPxTextBox>
                    </td>
                </tr>
                <tr>
                    <td style="width: 30%">
                        <dx:ASPxLabel ID="lbl_QDate" runat="server" Text="Date : ">
                        </dx:ASPxLabel>
                    </td>
                    <td style="width: 70%">
                        <dx:ASPxDateEdit ID="Q_Date" runat="server" ClientInstanceName="Q_Date" />
                    </td>
                </tr>
                <tr>
                    <td style="width: 30%">
                        <dx:ASPxLabel ID="lbl_QBookBy" runat="server" Text="Booking By : " />
                    </td>
                    <td style="width: 70%">
                        <dx:ASPxLabel ID="lbl_QName" ClientInstanceName="lbl_QName" runat="server" />
                    </td>
                </tr>
                <tr>
                    <td>
                    </td>
                    <td>
                    </td>
                </tr>
                <tr>
                    <td colspan="2" align="center">
                        <dx:ASPxLabel ID="lbl_Validate" runat="server" Text="" Visible="true" ClientInstanceName="lbl_Validate"
                            ForeColor="Red">
                        </dx:ASPxLabel>
                    </td>
                </tr>
                <tr>
                    <td>
                    </td>
                    <td align="center" style="width: 70%;">
                        <div style="float: left; clear: none; width: 100%;">
                            <div style="float: left; clear: none;">
                                <dx:ASPxButton ID="btnQ_OK" runat="server" Text="OK" AutoPostBack="false">
                                    <%--<ClientSideEvents Click="function(s, e) { cb_PopupInit.PerformCallback('ClickBtnQ_Ok'); 
                                                                              CIN_pop_quotation.Hide();  
                                                                              }" />--%>
                                    <ClientSideEvents Click="function(s, e) { Validation(e); }" />
                                </dx:ASPxButton>
                            </div>
                            <div style="float: left; clear: none; padding-left: 2px;">
                                <dx:ASPxButton ID="btnQ_Cencel" runat="server" Text="Cancel" AutoPostBack="false">
                                    <ClientSideEvents Click="function(s, e) { CIN_pop_quotation.Hide(); }" />
                                </dx:ASPxButton>
                            </div>
                            <script type="text/javascript">
                                function Validation(e) {
                                    var check = true;
                                    var DateValue = Q_Date.GetValue();
                                    if (DateValue == null) {
                                        lbl_Validate.SetVisible(true);
                                        lbl_Validate.SetValue("กรุณาระบุวันที่(Date)");
                                        check = false;
                                    }
                                    var TextValue = txtb_QTitle.GetValue();
                                    if (TextValue == null) {
                                        lbl_Validate.SetVisible(true);
                                        lbl_Validate.SetValue("กรุณาระบุชื่อเรื่อง(Title) ");
                                        check = false;
                                    }
                                    if (check) {
                                        cb_PopupInit.PerformCallback('ClickBtnQ_Ok');
                                        lbl_Validate.SetValue("");
                                        lbl_Validate.SetVisible(false);
                                        CIN_pop_quotation.Hide();
                                    }
                                }                                                 
                            </script>
                        </div>
                    </td>
                </tr>
            </table>
        </dx:PopupControlContentControl>
    </ContentCollection>
</dx:aspxpopupcontrol>
<dx:aspxpopupcontrol id="pop_proposal" runat="server" clientinstancename="CIN_pop_proposal"
    headertext="Proposal" popupverticalalign="WindowCenter" allowresize="True" closeaction="CloseButton"
    modal="True" allowdragging="True" popuphorizontalalign="WindowCenter" showfooter="false"
    width="500px">
    <HeaderStyle HorizontalAlign="Center" BackColor="#5066AC" ForeColor="White" Font-Bold="True" />
    <ContentCollection>
        <dx:PopupControlContentControl>
            <table width="100%">
                <tr>
                    <td class="auto-style4" style="width: 40%">
                        <dx:ASPxLabel ID="lbl_QNum" runat="server" Text="Choose Quotation Number : " />
                    </td>
                    <td style="width: 60%">
                        <%--<dx:ASPxDropDownEdit ID="dp_P" runat="server" />--%>
                        <dx:ASPxComboBox ID="cbb_QId" runat="server" ClientInstanceName="CIN_cbb_QId" IncrementalFilteringMode="Contains"
                            TextField="Q_ID" ValueField="Q_ID" DataSourceID="lds_Quotation">
                        </dx:ASPxComboBox>
                        <asp:LinqDataSource ID="lds_Quotation" runat="server" ContextTypeName="Bonzen_DLMS.DlmsDataContext"
                            OrderBy="Q_ID DESC" TableName="QuotationProposals" Where="P_ID == NULL">
                        </asp:LinqDataSource>
                        <%--<asp:SqlDataSource runat="server" ID="sds_Quotation" ConnectionString="<%$ ConnectionStrings:DLMSConnectionString %>"
                            SelectCommand="SELECT Q_ID FROM [QuotationProposal] WHERE [P_ID] IS NULL ORDER BY [Q_ID] DESC">
                        </asp:SqlDataSource>--%>
                    </td>
                </tr>
                <tr>
                    <td class="auto-style4" style="width: 40%">
                        <dx:ASPxLabel ID="lbl_P" runat="server" Text="Proposal Number : " />
                    </td>
                    <td style="width: 60%">
                        <dx:ASPxLabel ID="lbl_PNo" ClientInstanceName="lbl_PNo" runat="server" />
                    </td>
                </tr>
                <tr>
                    <td>
                    </td>
                    <td>
                    </td>
                </tr>
                <tr>
                    <td colspan="2" align="center">
                        <dx:ASPxLabel ID="lbl_ErrorProp" runat="server" Text="" Visible="true" ClientInstanceName="lbl_ErrorProp"
                            ForeColor="Red">
                        </dx:ASPxLabel>
                    </td>
                </tr>
                <tr>
                    <td>
                    </td>
                    <td align="center" style="width: 60%;">
                        <div style="float: left; clear: none; width: 100%;">
                            <div style="float: left; clear: none;">
                                <dx:ASPxButton ID="btn_POK" runat="server" Text="OK" AutoPostBack="false">
                                    <%--                                    <ClientSideEvents Click="function(s, e) { cb_PopupInit.PerformCallback('ClickBtnP_Ok'); 
                                                                              //CIN_pop_proposal.Hide();  
                                                                              }" />--%>
                                    <ClientSideEvents Click="function(s, e) { ValidationProposal(e); }" />
                                </dx:ASPxButton>
                            </div>
                            <div style="float: left; clear: none; padding-left: 2px;">
                                <dx:ASPxButton ID="btn_PCencel" runat="server" Text="Cancel" AutoPostBack="false">
                                    <ClientSideEvents Click="function(s, e) { CIN_pop_proposal.Hide(); }" />
                                </dx:ASPxButton>
                            </div>
                            <script type="text/javascript">
                                function ValidationProposal(e) {
                                    var check = true;
                                    var TextValue = CIN_cbb_QId.GetValue();
                                    if (TextValue == null) {
                                        lbl_ErrorProp.SetVisible(true);
                                        lbl_ErrorProp.SetValue("กรุณาเลือกหมายเลข Quotation");
                                        check = false;
                                    }
                                    if (check) {
                                        cb_PopupInit.PerformCallback('ClickBtnP_Ok');
                                        lbl_ErrorProp.SetValue("");
                                        lbl_ErrorProp.SetVisible(false);
                                        CIN_pop_proposal.Hide();
                                    }
                                }                                                 
                            </script>
                        </div>
                    </td>
                </tr>
            </table>
        </dx:PopupControlContentControl>
    </ContentCollection>
</dx:aspxpopupcontrol>
<dx:aspxpopupcontrol id="pop_general" runat="server" clientinstancename="CIN_pop_general"
    headertext="General" popupverticalalign="WindowCenter" allowresize="True" closeaction="CloseButton"
    modal="True" allowdragging="True" popuphorizontalalign="WindowCenter" showfooter="false"
    width="500px">
    <HeaderStyle HorizontalAlign="Center" BackColor="#5066AC" ForeColor="White" Font-Bold="True" />
    <ContentCollection>
        <dx:PopupControlContentControl>
            <table width="100%">
                <tr>
                    <td class="style1">
                        <dx:ASPxLabel ID="lbl_G" runat="server" Text="General Number : " />
                    </td>
                    <td class="style2">
                        <dx:ASPxLabel ID="lbl_GNo" ClientInstanceName="lbl_GNo" runat="server" Text="GNo" />
                    </td>
                </tr>
                <tr>
                    <td>
                        <dx:ASPxLabel ID="lbl_company" runat="server" Text="ผู้รับ (บริษัท)">
                        </dx:ASPxLabel>
                    </td>
                    <td>
                        <dx:ASPxComboBox ID="cmb_company" ClientInstanceName="CIN_cmb_company" runat="server" Height="20px" Width="360px" DropDownStyle="DropDown"
                            IncrementalFilteringMode="Contains" DataSourceID="lds_Company" TextField="prospect_nameTH"
                            ValueField="prospect_id" EnableCallbackMode="True" CallbackPageSize="20">
                            <ClientSideEvents SelectedIndexChanged="function(s, e) { CIN_cmb_attn.PerformCallback('Change Company'); }" />
                            <ClientSideEvents SelectedIndexChanged="function(s, e) { CIN_cmb_attn.PerformCallback(&#39;Change Company&#39;); }">
                            </ClientSideEvents>
                        </dx:ASPxComboBox>
                        <asp:LinqDataSource ID="lds_Company" runat="server" ContextTypeName="Bonzen_DLMS.DlmsDataContext"
                            Select="new (prospect_id, prospect_nameTH)" TableName="vw_Companies">
                        </asp:LinqDataSource>
                        <%-- <asp:LinqDataSource ID="lds_Company" runat="server" ContextTypeName="Bonzen_DLMS.DlmsDataContext"
                                Select="new (Company_ID, Company_Name_TH, Company_Name_EN, Company_Shortname, Company_Attn, 
                            Company_Address, Company_District, Company_Amphur, Company_Province, Company_Zipcode, 
                            Company_Tel, Company_Fex, Company_Email, Company_Website)" TableName="Companies">
                            </asp:LinqDataSource>--%>
                    </td>
                </tr>
                <tr>
                    <td>
                        <dx:ASPxLabel ID="lbl_name" runat="server" Text="ผู้รับ (ชื่อ)">
                        </dx:ASPxLabel>
                    </td>
                    <td>
                        <dx:ASPxComboBox ID="cmb_attn" ClientInstanceName="CIN_cmb_attn" runat="server" Height="20px"
                            Width="360px" IncrementalFilteringMode="Contains" DataSourceID="lds_Attn" TextField="cp_name"
                            ValueField="cp_id" DropDownStyle="DropDown">
                        </dx:ASPxComboBox>
                        <asp:LinqDataSource ID="lds_Attn" runat="server" ContextTypeName="Bonzen_DLMS.DlmsDataContext"
                            TableName="vw_ContactPersons" Where="prospect_id == @Company_ID">
                            <WhereParameters>
                                <asp:ControlParameter Name="Company_ID" Type="Int32" ControlID="cmb_company" PropertyName="Value"
                                    DefaultValue="1" />
                            </WhereParameters>
                        </asp:LinqDataSource>
                    </td>
                </tr>
                <tr>
                    <td style="width: 30%">
                        <dx:ASPxLabel ID="lbl_GTitle" runat="server" Text="Title : " />
                    </td>
                    <td style="width: 70%">
                        <dx:ASPxTextBox ID="txtb_GTitle" ClientInstanceName="txtb_GTitle" runat="server"
                            Width="300px" />
                    </td>
                </tr>
                <tr>
                    <td style="width: 30%">
                        <dx:ASPxLabel ID="lbl_GDate" runat="server" Text="Date : " />
                    </td>
                    <td style="width: 70%">
                        <dx:ASPxDateEdit ID="G_Date" ClientInstanceName="G_Date" runat="server" />
                    </td>
                </tr>
                <tr>
                    <td style="width: 30%">
                        <dx:ASPxLabel ID="lbl_GBookBy" runat="server" Text="Booking By : " />
                    </td>
                    <td style="width: 70%">
                        <dx:ASPxLabel ID="lbl_GName" ClientInstanceName="lbl_GName" runat="server" Text="Name" />
                    </td>
                </tr>
                <tr>
                    <td>
                    </td>
                    <td>
                    </td>
                </tr>
                <tr>
                    <td colspan="2" align="center">
                        <dx:ASPxLabel ID="lbl_ErrorGen" runat="server" Text="" Visible="true" ClientInstanceName="lbl_ErrorGen"
                            ForeColor="Red">
                        </dx:ASPxLabel>
                    </td>
                </tr>
                <tr>
                    <td>
                    </td>
                    <td align="center" style="width: 70%;">
                        <div style="float: left; clear: none; width: 100%;">
                            <div style="float: left; clear: none;">
                                <dx:ASPxButton ID="btn_GOK" runat="server" Text="OK" AutoPostBack="false">
                                    <%--                                    <ClientSideEvents Click="function(s, e) { cb_PopupInit.PerformCallback('ClickBtnG_Ok'); 
                                                                              //CIN_pop_general.Hide();  
                                                                              }" />--%>
                                    <ClientSideEvents Click="function(s, e) { ValidationGeneral(e); }"></ClientSideEvents>
                                </dx:ASPxButton>
                            </div>
                            <div style="float: left; clear: none; padding-left: 2px;">
                                <dx:ASPxButton ID="btn_GCencel" runat="server" Text="Cancel" AutoPostBack="false">
                                    <ClientSideEvents Click="function(s, e) { CIN_pop_general.Hide(); }"></ClientSideEvents>
                                </dx:ASPxButton>
                            </div>
                            <script type="text/javascript">
                                function ValidationGeneral(e) {
                                    var check = true;
                                    var DateValue = G_Date.GetValue();
                                    if (DateValue == null) {
                                        lbl_ErrorGen.SetVisible(true);
                                        lbl_ErrorGen.SetValue("กรุณาระบุวันที่(Date)");
                                        check = false;
                                    }
                                    var TitleValue = txtb_GTitle.GetValue();
                                    if (TitleValue == null) {
                                        lbl_ErrorGen.SetVisible(true);
                                        lbl_ErrorGen.SetValue("กรุณาระบุชื่อเรื่อง(Title)");
                                        check = false;
                                    }
                                    var attnValue = CIN_cmb_attn.GetValue();
                                    if (attnValue == null) {
                                        lbl_ErrorGen.SetVisible(true);
                                        lbl_ErrorGen.SetValue("กรุณาระบุผู้รับ(ชื่อ)");
                                        check = false;
                                    }
                                    var companyValue = CIN_cmb_company.GetValue();
                                    if (companyValue == null) {
                                        lbl_ErrorGen.SetVisible(true);
                                        lbl_ErrorGen.SetValue("กรุณาระบุผู้รับ(บริษัท)");
                                        check = false;
                                    }
                                    if (check) {
                                        cb_PopupInit.PerformCallback('ClickBtnG_Ok');
                                        lbl_ErrorGen.SetValue("");
                                        lbl_ErrorGen.SetVisible(false);
                                        CIN_pop_general.Hide();
                                    }
                                }                                                 
                            </script>
                        </div>
                    </td>
                </tr>
            </table>
        </dx:PopupControlContentControl>
    </ContentCollection>
</dx:aspxpopupcontrol>
<%--<dxe:ASPxPopupControl runat="server" ID="pop_ManualPost" ClientInstanceName="CIN_pop_ManualPost"
            HeaderText="Manual Post" PopupVerticalAlign="WindowCenter" AllowResize="True"
            CloseAction="CloseButton" Modal="True" AllowDragging="True" PopupHorizontalAlign="WindowCenter"
            ShowFooter="True" Width="330px">
            <HeaderStyle HorizontalAlign="Center" BackColor="#5066AC" ForeColor="White" Font-Bold="True" />
            <ContentCollection>
                <dxe:PopupControlContentControl>
                    <table>
                        <tr>
                            <td style="width: 70px">
                                <dxe:ASPxLabel ID="lbl_PostDate" runat="server" Text="Post Date" Width="65px">
                                </dxe:ASPxLabel>
                            </td>
                            <td>
                                <dxe:ASPxDateEdit ID="de_Postdate" runat="server" Width="200px" ClientInstanceName="CIN_de_Postdate"
                                    EditFormatString="dd/MM/yyyy" AllowNull="true">
                                    <ValidationSettings Display="Dynamic" ErrorDisplayMode="ImageWithTooltip" ValidationGroup="postDate">
                                        <RequiredField IsRequired="True" ErrorText="Required Field" />
                                    </ValidationSettings>
                                </dxe:ASPxDateEdit>
                            </td>
                        </tr>
                    </table>
                </dxe:PopupControlContentControl>
            </ContentCollection>
            <FooterTemplate>
                <table>
                    <tr>
                        <td style="width: 250px">
                        </td>
                        <td align="right">
                            <dxe:ASPxButton ID="btn_OkManualPost" runat="server" Text="Ok" AutoPostBack="true"
                                ValidationGroup="postDate" OnClick="btn_OkManualPost_onclick">
                                <ClientSideEvents Click="function(s, e) { ValidatePostDate(); }"></ClientSideEvents>
                            </dxe:ASPxButton>
                            <script type="text/javascript">
                                function ValidatePostDate() {
                                    var result = (CIN_de_Postdate.GetIsValid());
                                    if (result) {
                                        CIN_pop_ManualPost.Hide();
                                    }
                                }                                                     
                            </script>
                        </td>
                    </tr>
                </table>
            </FooterTemplate>
        </dxe:ASPxPopupControl>‏--%>
