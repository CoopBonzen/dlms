<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.Master"
    CodeBehind="CreateQuotation.aspx.vb" Inherits="Bonzen_DLMS.CreateQuotation" %>

<%@ Register Assembly="DevExpress.Web.v13.1, Version=13.1.8.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
    Namespace="DevExpress.Web.ASPxUploadControl" TagPrefix="dx" %>
<%@ Register Assembly="DevExpress.Web.v13.1, Version=13.1.8.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
    Namespace="DevExpress.Web.ASPxPanel" TagPrefix="dx" %>
<%@ Register Assembly="DevExpress.Web.v13.1, Version=13.1.8.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
    Namespace="DevExpress.Web.ASPxCallbackPanel" TagPrefix="dx" %>
<%@ Register Assembly="DevExpress.Web.v13.1, Version=13.1.8.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
    Namespace="DevExpress.Web.ASPxGridView" TagPrefix="dx" %>
<%@ Register Assembly="DevExpress.Web.v13.1, Version=13.1.8.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
    Namespace="DevExpress.Web.ASPxEditors" TagPrefix="dx" %>
<%@ Register Assembly="DevExpress.Web.ASPxScheduler.v13.1, Version=13.1.8.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
    Namespace="DevExpress.Web.ASPxScheduler.Controls" TagPrefix="dxwschsc" %>
<%@ Register Assembly="DevExpress.Web.v13.1, Version=13.1.8.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
    Namespace="DevExpress.Web.ASPxGridView" TagPrefix="dx1" %>
<%@ Register Assembly="DevExpress.Web.v13.1, Version=13.1.8.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
    Namespace="DevExpress.Web.ASPxPopupControl" TagPrefix="dx" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <style type="text/css">
        .style1
        {
            width: 100px;
        }
        .style2
        {
            width: 361px;
        }
        .style3
        {
            width: 351px;
        }
    </style>
</asp:Content>
<asp:content id="Content2" contentplaceholderid="MainContent" runat="server">
    <script language="javascript" type="text/javascript">
        function OnQuotationChanged(cmb_QuotationDescription) {
            txt_selectedsub.SetText('');
            //lb_QuotationDescriptionSub.PerformCallback(cmb_QuotationDescription.GetSelectedItem().value.toString());
            lb_QuotationDescriptionSub.PerformCallback(cmb_QuotationDescription.GetValue());
        }


        function OnCompanyChanged(cmb_company) {
            cbp_company.PerformCallback(cmb_company.GetValue());

        }

        function OnFileUploadComplete(s, e) {
            btnUpdate.DoClick();
        }

        //check box
        function IsStringContain(str, substr) {
            return str.indexOf(substr) != -1;
        }

        function RemoveItemFromStrList(strList, item) {
            if (IsStringContain(strList, ',' + item.toString())) strList = strList.replace(',' + item.toString(), '');
            else if (IsStringContain(strList, item.toString() + ',')) strList = strList.replace(item.toString() + ',', '');
            else strList = strList.replace(item.toString(), '');
            return strList
        }

        function AddQfileList(qFileID) {
            var qFileList = CIN_txt_qFile.GetText();
            if (!IsStringContain(qFileList, qFileID.toString())) {
                if (qFileList != '') qFileList += ',';
                CIN_txt_qFile.SetText(qFileList + qFileID.toString());
            }
        }

        function RemoveQfileList(qFileID) {
            var qFileList = CIN_txt_qFile.GetText();
            var newQfileList = RemoveItemFromStrList(qFileList, qFileID.toString());
            CIN_txt_qFile.SetText(newQfileList);
            //CIN_cbp_requestTime.PerformCallback();
        }

       
    </script>
    <dx:ASPxPopupControl ID="pop_Update" runat="server" ClientInstanceName="CIN_pop_Update"
        HeaderText="" PopupVerticalAlign="WindowCenter" AllowResize="True" CloseAction="CloseButton"
        Modal="True" AllowDragging="True" PopupHorizontalAlign="WindowCenter" ShowFooter="false"
        Width="378px" Height="162px">
        <HeaderStyle HorizontalAlign="Center" BackColor="#5066AC" ForeColor="White" Font-Bold="True" />
        <ContentCollection>
            <dx:PopupControlContentControl>
                <br />
                <br />
                <br />
                <table class="dxflInternalEditorTable">
                    <tr>
                        <td class="style1">
                        </td>
                        <td>
                            <h3>
                                <dx:ASPxLabel ID="ASPxLabelPopUp" runat="server" style="text-align: center; font-size: large;"
                                    Text="Update Complete">
                                </dx:ASPxLabel>
                            </h3>
                        </td>
                        <td class="style1">
                        </td>
                    </tr>
                </table>
            </dx:PopupControlContentControl>
        </ContentCollection>
    </dx:ASPxPopupControl>
    <dx:ASPxCallbackPanel ID="cbp_company" ClientInstanceName="cbp_company" runat="server">
        <PanelCollection>
            <dx:PanelContent ID="pnc_Header" runat="server">
                <table class="dxflInternalEditorTable">
                    <tr>
                        <td class="style1">
                            <%--<dx:aspxbutton id="btn_test" runat="server" text="test rele" >
                        </dx:aspxbutton>--%>
                            <dx:ASPxLabel ID="ASPxLabel2" runat="server" Text="Company">
                            </dx:ASPxLabel>
                        </td>
                        <td class="style2">
                            <dx:ASPxComboBox ID="cmb_company" ClientInstanceName="CIN_cmb_company" runat="server"
                                Height="20px" Width="360px" DropDownStyle="DropDown" IncrementalFilteringMode="Contains"
                                DataSourceID="lds_Company" TextField="prospect_nameTH" ValueField="prospect_id"
                                EnableCallbackMode="True" CallbackPageSize="20">
                                <clientsideevents selectedindexchanged="function(s, e) { OnCompanyChanged(s); }" />
                            </dx:ASPxComboBox>
                            <asp:linqdatasource id="lds_Company" runat="server" contexttypename="Bonzen_DLMS.DlmsDataContext"
                                select="new (prospect_id, prospect_nameTH, prospect_nameEN, tel_number, fax, mail)"
                                tablename="vw_Companies">
                            </asp:linqdatasource>
                        </td>
                        <td class="style1">
                            <dx:ASPxLabel ID="ASPxLabel6" runat="server" Text="Quotation No">
                            </dx:ASPxLabel>
                        </td>
                        <td class="style2">
                            <dx:ASPxTextBox ID="txt_quotation" runat="server" Width="360px" Height="20px">
                            </dx:ASPxTextBox>
                        </td>
                    </tr>
                    <tr>
                        <td class="style1">
                            <dx:ASPxLabel ID="ASPxLabel1" runat="server" Text="Attn">
                            </dx:ASPxLabel>
                        </td>
                        <td class="style2">
                            <dx:ASPxComboBox ID="cmb_attn" ClientInstanceName="CIN_cmb_attn" runat="server" Height="20px"
                                Width="360px" IncrementalFilteringMode="Contains" DataSourceID="lds_Attn" TextField="cp_name"
                                ValueField="cp_id" DropDownStyle="DropDown">
                            </dx:ASPxComboBox>
                            <%--Select="new (Company_ID_Attn, Company_Attn, Company_ID)" --%>
                            <asp:linqdatasource id="lds_Attn" runat="server" contexttypename="Bonzen_DLMS.DlmsDataContext"
                                tablename="vw_ContactPersons" where="prospect_id == @Company_ID">
                                <whereparameters>
                                    <asp:ControlParameter Name="Company_ID" Type="String" ControlID="cmb_company" PropertyName="Value"
                                        DefaultValue="1" />
                                </whereparameters>
                            </asp:linqdatasource>
                        </td>
                        <td class="style1">
                            <dx:ASPxLabel ID="ASPxLabel7" runat="server" Text="Date">
                            </dx:ASPxLabel>
                        </td>
                        <td class="style2">
                            <dx:ASPxDateEdit ID="dte_quotationDate" runat="server" Height="20px" Width="360px">
                            </dx:ASPxDateEdit>
                        </td>
                    </tr>
                    <tr>
                        <td class="style1">
                            <dx:ASPxLabel ID="ASPxLabel3" runat="server" Text="Tel">
                            </dx:ASPxLabel>
                        </td>
                        <td class="style2">
                            <dx:ASPxTextBox ID="txt_tel" runat="server" Width="360px" Height="20px">
                            </dx:ASPxTextBox>
                        </td>
                        <td class="style1">
                            <dx:ASPxLabel ID="ASPxLabel8" runat="server" Text="From">
                            </dx:ASPxLabel>
                        </td>
                        <td class="style2">
                            <dx:ASPxTextBox ID="txt_from" Text="บริษัท บนเส้น จำกัด" runat="server" Width="360px"
                                Height="20px">
                            </dx:ASPxTextBox>
                        </td>
                    </tr>
                    <tr>
                        <td class="style1">
                            <dx:ASPxLabel ID="ASPxLabel4" runat="server" Text="Fax">
                            </dx:ASPxLabel>
                        </td>
                        <td class="style2">
                            <dx:ASPxTextBox ID="txt_fax" runat="server" Width="360px" Height="20px">
                            </dx:ASPxTextBox>
                        </td>
                        <td class="style1">
                            <dx:ASPxLabel ID="ASPxLabel9" runat="server" Text="Tel">
                            </dx:ASPxLabel>
                        </td>
                        <td class="style2">
                            <dx:ASPxTextBox ID="txt_bonzentel" runat="server" Text="0-2642-6201" Width="360px"
                                Height="20px">
                            </dx:ASPxTextBox>
                        </td>
                    </tr>
                    <tr>
                        <td class="style1">
                            <dx:ASPxLabel ID="ASPxLabel5" runat="server" Text="E-mail">
                            </dx:ASPxLabel>
                        </td>
                        <td class="style2">
                            <dx:ASPxTextBox ID="txt_email" runat="server" Width="360px" Height="20px">
                            </dx:ASPxTextBox>
                        </td>
                        <td class="style1">
                            <dx:ASPxLabel ID="ASPxLabel10" runat="server" Text="E-mail">
                            </dx:ASPxLabel>
                        </td>
                        <td class="style2">
                            <dx:ASPxTextBox ID="txt_bonzenemail" runat="server" Text="Sales@bonzen.co.th" Width="360px"
                                Height="20px">
                            </dx:ASPxTextBox>
                        </td>
                    </tr>
                </table>
            </dx:PanelContent>
        </PanelCollection>
    </dx:ASPxCallbackPanel>
    <p>
    </p>
    <p>
    </p>
    <td colspan="2" align="center">
        <dx:ASPxLabel ID="lbl_Error" runat="server" Text="" Visible="true" ClientInstanceName="lbl_Error"
            ForeColor="Red" Style="text-align: center">
        </dx:ASPxLabel>
    </td>
    <%--  <h2>
        Select Main Detail
    </h2>
    <table width="100%">
        <tr>
            <td>
                <dx:ASPxComboBox ID="cmb_QuotationDescription" runat="server" DropDownStyle="DropDownList"
                    IncrementalFilteringMode="StartsWith" DataSourceID="LinqDataSource_QuotationDescription"
                    TextField="Q_Detail_Main" ValueField="ID_Q_Detail_Main" EnableSynchronization="False">
                    <ClientSideEvents SelectedIndexChanged="function(s, e) { OnQuotationChanged(s); }" />
                </dx:ASPxComboBox>
                <asp:LinqDataSource ID="LinqDataSource_QuotationDescription" runat="server" ContextTypeName="Bonzen_DLMS.DlmsDataContext"
                    Select="new (ID_Q_Detail_Main, Q_Detail_Main)" TableName="QuotationDescriptions">
                </asp:LinqDataSource>
            </td>
        </tr>
        <tr>
            <td>
                <dx:ASPxListBox ID="lb_QuotationDescriptionSub" runat="server" SelectionMode="CheckColumn"
                    Width="100%" Height="139px" ClientInstanceName="lb_QuotationDescriptionSub" ValueType="System.String"
                    DataSourceID="LinqDataSource_QuotationDescriptionSub" ValueField="ID_Q_Detail_Sub"
                    OnCallback="lb_QuotationDescriptionSub_Callback">
                    <ClientSideEvents SelectedIndexChanged="function(s, e) {
                                                        //สั่งให้ดึงค่าจาก listbox มาแสดงใน textbox
                                                        var values = s.GetSelectedValues();
                                                        txt_selectedsub.SetText(values.join());
                                                    }" />
                    <Columns>
                        <dx:ListBoxColumn FieldName="Q_Detail_Sub" Caption="Name" Width="400px" />
                        <dx:ListBoxColumn FieldName="Price" Caption="Price" Width="70px" />
                    </Columns>
                </dx:ASPxListBox>
                <asp:LinqDataSource ID="LinqDataSource_QuotationDescriptionSub" runat="server" ContextTypeName="Bonzen_DLMS.DlmsDataContext"
                    Select="new (ID_Q_Detail_Sub, Q_Detail_Sub, Price, ID_Q_Detail_Main)" TableName="QuotationDescriptionSubs"
                    Where="ID_Q_Detail_Main == @ID_Q_Detail_Main">
                    <WhereParameters>
                        <asp:SessionParameter DefaultValue="1" Name="ID_Q_Detail_Main" SessionField="ID_Q_Detail_Main"
                            Type="Int32" />
                    </WhereParameters>
                </asp:LinqDataSource>
            </td>
        </tr>
    </table>
    <p>
        <div style="clear: left; margin-top: 5px;">
           <div
    style="float: left; width: 200px;">
    <dx:aspxtextbox id="txt_selectedsub" clientinstancename="txt_selectedsub" runat="server"
        clientvisible="false" width="100%" />
</div>
           
<div style="float: right; margin-left: 5px;">
    <dx:aspxbutton id="btn_Add" runat="server" text="Add to table" autopostback="false">
                    <ClientSideEvents Click="function(s, e) { cbp_subData.PerformCallback('Add Detail'); }" />
                </dx:aspxbutton>
</div>
           
<br />
        </div>
       
<br />
       
<div style="clear: both;">
    <dx:aspxgridview id="gv_addmodule" clientinstancename="gv_addmodule" keyfieldname="ID_Q_Detail_Sub"
        runat="server" width="100%">
                <SettingsBehavior AllowSort="false" />
                <ClientSideEvents EndCallback="function(s, e) {
                                               if (s.cpStrAllSubData) {
                                                   var cmdInfo = s.cpStrAllSubData.split(':');
                                                   txt_subData.SetText(cmdInfo[1]);
                                                   gv_addmodule.PerformCallback('Bind data');
                                               }
                                           }" />
                <Columns>
                    <dx:GridViewDataColumn FieldName="Q_Detail_Main" Caption="MainDetail" Width="30%" />
                    <dx:GridViewDataColumn FieldName="Q_Detail_Sub" Caption="Detail" Width="30%" />
                    <dx:GridViewDataColumn FieldName="Price" Caption="Price" Width="20%">
                        <DataItemTemplate>
                            <dx:ASPxSpinEdit ID="spe_Price" runat="server" NumberType="Float" DecimalPlaces="2" Number='<%# Eval("Price") %>' 
                                DisplayFormatString="{0:n2}" Increment="0.25" MinValue="0" Width="100%" />
                        </DataItemTemplate>
                    </dx:GridViewDataColumn>
                    <dx:GridViewDataColumn Caption="Unit" Width="10%">
                        <DataItemTemplate>
                           <dx:ASPxSpinEdit ID="spe_Unit" runat="server" NumberType="Float" DecimalPlaces="1" Number='<%# Bind("Unit") %>' MinValue="0" Increment="0.5" Width="100%" />
                        </DataItemTemplate>
                    </dx:GridViewDataColumn>
                    <dx:GridViewCommandColumn Width="20%">
                        <CustomButtons>
                            <dx:GridViewCommandColumnCustomButton ID="btn_Delete" Text="Delete"  />
                        </CustomButtons>
                    </dx:GridViewCommandColumn>
                </Columns>
            </dx:aspxgridview>
</div>
       
<br />
       
<div>
    <asp:label id="lbl_remark" runat="server" text="remark"></asp:label>
    <dx:aspxmemo id="memo_remark" runat="server" width="845px" rows="7">
            </dx:aspxmemo>
</div>
       
<br />
       
<div>
    <asp:label id="lbl_condition" runat="server" text="condition"></asp:label>
    <dx:aspxmemo id="memo_condition" runat="server" width="845px" rows="7">
            </dx:aspxmemo>
</div>
       
<br />
       
<div style="margin-top: 5px; margin-bottom: 0px;">
    <div style="float: left; width: 400px;">
        <dx:aspxcallbackpanel id="cbp_subData" clientinstancename="cbp_subData" runat="server"
            width="100%">
                    <ClientSideEvents EndCallback="function(s, e) { gv_addmodule.PerformCallback('Bind data'); }" />
                    <PanelCollection>
                        <dx:PanelContent ID="pnc_subData" runat="server">
                            <dx:ASPxTextBox ID="txt_subData" ClientInstanceName="txt_subData" runat="server"
                                Width="100%" ClientVisible="true" />
                        </dx:PanelContent>
                    </PanelCollection>
                </dx:aspxcallbackpanel>
    </div>
</div>--%>
    <h2>
        Upload Quotation
    </h2>
    <p>
        <table width="50%">
            <tr>
                <td class="auto-style4" style="width: 50%">
                    <dx:ASPxLabel ID="lbl_QNewUpload" runat="server" Text="หมายเลข Quotation" />
                    &nbsp;&nbsp;
                    <dx:ASPxLabel ID="lbl_QNo" runat="server" />
                </td>
            </tr>
            <tr>
                <td>
                    <asp:updatepanel id="Updatepanel1" runat="server">
                        <contenttemplate>
                            <dx:ASPxButton ID="btnUpdate" runat="server" ClientInstanceName="btnUpdate" ClientVisible="false"
                                OnClick="Updatepanel1_Refresh">
                            </dx:ASPxButton>
                        </contenttemplate>
                        <triggers>
                            <asp:AsyncPostBackTrigger ControlID="btnUpdate" EventName="Click" />
                        </triggers>
                    </asp:updatepanel>
                    <dx:ASPxUploadControl ID="ulc_QuotationFile" runat="server" ShowUploadButton="True"
                        ShowProgressPanel="True" OnFileUploadComplete="UploadControl_FileUploadComplete"
                        Width="280px">
                        <ValidationSettings AllowedFileExtensions=".pdf,.doc,.docx,.xlsx,.xls" ShowErrors="false" />
                        <ClientSideEvents FileUploadComplete="OnFileUploadComplete" />
                    </dx:ASPxUploadControl>
                </td>
            </tr>
            <tr>
                <td>
                    <dx:ASPxTextBox ID="txt_qFile" runat="server" ClientInstanceName="CIN_txt_qFile"
                        ClientVisible="false">
                    </dx:ASPxTextBox>
                </td>
            </tr>
            <tr>
                <td class="auto-style4" style="width: 50%">
                    <dx:ASPxLabel ID="lbl_QuotationNumber" runat="server" Text="Company : " />
                    &nbsp;&nbsp;
                    <dx:ASPxLabel ID="lbl_QCompanyName" runat="server" />
                </td>
            </tr>
            <tr>
                <td>
                    <dx:ASPxGridView ID="gv_QFile" runat="server" Width="100%" KeyFieldName="Q_FileID">
                        <Settings ShowColumnHeaders="false" />
                        <Columns>
                            <dx:GridViewDataColumn Caption="  #" FieldName="Q_FileID" Width="40px">
                                <CellStyle HorizontalAlign="Center" />
                                <DataItemTemplate>
                                    <dx:ASPxCheckBox ID="chk_selected" runat="server" ClientInstanceName="CIN_chk_selected"
                                        CheckState="Unchecked" />
                                </DataItemTemplate>
                            </dx:GridViewDataColumn>
                            <dx:GridViewDataColumn Caption="File Name">
                                <DataItemTemplate>
                                    <asp:hyperlink id="Link" runat="server" navigateurl='<%#Eval("link") %>' forecolor="#6798de"
                                        tooltip='<%#Eval("filename")%>'>
                                        <%#Eval("filename")%>
                                    </asp:hyperlink>
                                </DataItemTemplate>
                            </dx:GridViewDataColumn>
                            <dx:GridViewDataDateColumn FieldName="Q_FileDate" Visible="false" SortOrder="Descending">
                            </dx:GridViewDataDateColumn>
                        </Columns>
                    </dx:ASPxGridView>
                    <br />
                    <dx:ASPxButton ID="btnDeleteSelectedRows" runat="server" OnClick="btnDeleteSelectedRows_Click"
                        Text="Delete selected rows" Width="137px">
                    </dx:ASPxButton>
                </td>
            </tr>
        </table>
    </p>
    <table>
        <tr>
            <td class="style1">
                <dx:ASPxLabel ID="ASPxLabel11" runat="server" Text="ราคารวม">
                </dx:ASPxLabel>
            </td>
            <td class="style3">
                <dx:ASPxTextBox ID="txt_totalamount" ClientInstanceName="txt_totalamount" BackColor="LightGray"
                    runat="server" Width="360px" Height="20px">
                    <MaskSettings Mask="$&lt;0..99999999999999999g&gt;" />
                </dx:ASPxTextBox>
            </td>
            <td>
                <dx:ASPxButton ID="btn_edit" runat="server" Text="Edit" AutoPostBack="false">
                    <ClientSideEvents Click="function(s, e) { txt_totalamount.SetEnabled(true); 
                                    txt_totalamount.GetMainElement().style.backgroundColor='white';
                                    txt_totalamount.GetInputElement().style.backgroundColor='white';}" />
                </dx:ASPxButton>
            </td>
        </tr>
        <tr>
            <td class="style1">
                <dx:ASPxLabel ID="ASPxLabel15" runat="server" Text="Remark">
                </dx:ASPxLabel>
            </td>
            <td class="style3">
                <dx:ASPxMemo ID="memo_remark" ClientInstanceName="memo_remark" BackColor="LightGray"
                    runat="server" Height="102px" Width="359px">
                </dx:ASPxMemo>
            </td>
            <td>
                <dx:ASPxButton ID="btn_editRemark" runat="server" Text="Edit" AutoPostBack="false">
                    <ClientSideEvents Click="function(s, e) { memo_remark.SetEnabled(true); 
                                    memo_remark.GetMainElement().style.backgroundColor='white';
                                    memo_remark.GetInputElement().style.backgroundColor='white';}" />
                </dx:ASPxButton>
            </td>
        </tr>
    </table>
    <div style="float: right; margin-left: 5px;">
        <dx:ASPxButton ID="btn_AddQuotation" runat="server" Text="Add Quotation">
        </dx:ASPxButton>
    </div>
    <div style="float: right; margin-left: 5px;">
        <dx:ASPxButton ID="btn_SaveQuotation" runat="server" Text="Update" AutoPostBack="false"
            ClientInstanceName="CIN_btn_SaveQuotation">
            <%--<ClientSideEvents Click="function(s, e) { CIN_pop_Update.Show(); }" />--%>
        </dx:ASPxButton>
    </div>
    <div style="float: right; margin-left: 5px;">
        <dx:ASPxButton ID="btn_ApproveQuotation" runat="server" Text="Approve">
        </dx:ASPxButton>
    </div>
    <br />
    <br />
</asp:content>
