<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.Master" CodeBehind="User.aspx.vb" Inherits="Bonzen_DLMS.User" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <h2>
        Create User
    </h2>
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <table width="100%" cellpadding="0" cellspacing="0">
                <tr>
                    <td colspan="2">
                        <asp:Label runat="server" ID="lbl_UserGroup" Text="User Group :"></asp:Label>&nbsp;
                        <asp:DropDownList ID="ddl_UserGroup" runat="server" AutoPostBack="True" Width="150px">
                        </asp:DropDownList>
                        <%--&nbsp;<asp:LinqDataSource ID="lds_UserGroup" runat="server" ContextTypeName="WebApplication_1.DlmsDataContext"
                            OrderBy="display_order" TableName="UserGroups">
                        </asp:LinqDataSource>--%>
                    </td>
                </tr>
                <tr>
                    <td>
                        &nbsp;
                    </td>
                </tr>
                <tr>
                    <td valign="top" style="width: 35%">
                        <asp:ListView ID="lv_User" runat="server" DataKeyNames="user_id" DataSourceID="sds_User">
                            <LayoutTemplate>
                                <table width="95%">
                                    <tr>
                                        <td>
                                            <table class="bordercolor" cellspacing="1" cellpadding="4" width="100%">
                                                <thead>
                                                    <tr style="font-family: Sans-Serif,Tahoma; font-size: 9pt; background-color: #CCCCCC;
                                                        text-align: center; font-weight: bold; padding: 4px 4px 4px 4px;">
                                                        <th>
                                                            <asp:Label runat="server" ID="lbl_Username" Text="User name"></asp:Label>
                                                        </th>
                                                        <%--<th>
                                                            <asp:Label runat="server" ID="lbl_Password" Text="Password"></asp:Label>
                                                        </th>--%>
                                                        <th>
                                                            <asp:Label runat="server" ID="lbl_active" Text="Active"></asp:Label>
                                                        </th>
                                                        <th>
                                                        </th>
                                                    </tr>
                                                </thead>
                                                <tbody id="itemPlaceHolder" runat="server">
                                                </tbody>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td id="Td1" runat="server" style="text-align: center; background-color: #CCCCCC;
                                            font-family: Verdana, Arial, Helvetica, sans-serif; color: #000000;">
                                        </td>
                                    </tr>
                                </table>
                            </LayoutTemplate>
                            <ItemTemplate>
                                <tr id="table_row" runat="server" onmouseover="this.className='over'" onmouseout="this.className='out'">
                                    <td id="Td2" runat="server">
                                        <asp:Label ID="user_nameLabel" runat="server" Text='<%# Eval("user_name") %>' />
                                    </td>
                                    <%--<td id="Td3" runat="server">
                                        <asp:Label ID="passwordLabel" runat="server" Text='<%# Eval("password") %>' />
                                    </td>--%>
                                    <td id="Td4" runat="server" align="center">
                                        <asp:CheckBox ID="chk_activeLv" runat="server" Enabled="false" Checked='<%# Eval("active") %>' />
                                    </td>
                                    <td id="Td5" runat="server">
                                        <asp:Button ID="SelectButton" runat="server" CommandName="Select" Text="Select" Style="display: none" />
                                        <asp:ImageButton ID="DeleteButton" runat="server" CommandName="Delete" AlternateText="Delete"
                                            ImageUrl="../images/trash.gif" BorderStyle="Outset" BorderWidth="1px" BackColor="White" />
                                    </td>
                                </tr>
                            </ItemTemplate>
                            <InsertItemTemplate>
                                <tr id="Tr1" runat="server">
                                    <td id="Td6" runat="server">
                                        <asp:TextBox ID="user_nameTextBox" runat="server" Text='<%# Bind("user_name") %>'
                                            MaxLength="100" />
                                    </td>
                                    <%--<td id="Td7" runat="server">
                                        <asp:TextBox ID="passwordTextBox" runat="server" Text='<%# Bind("password") %>' />
                                    </td>--%>
                                    <td id="Td8" runat="server" align="center">
                                        <asp:CheckBox ID="chk_activeLv" runat="server" Enabled="false" Checked='<%# Eval("active") %>' />
                                    </td>
                                    <td id="Td9" runat="server">
                                        <br />
                                        <asp:Button ID="InsertButton" runat="server" CommandName="Insert" Text="Insert" Width="75px" />
                                        <asp:ImageButton ID="CancelButton" runat="server" CommandName="Cancel" AlternateText="Cancel"
                                            ImageUrl="../images/cancel.gif" BorderStyle="Outset" BorderWidth="1px" Visible="False" />
                                    </td>
                                </tr>
                            </InsertItemTemplate>
                            <SelectedItemTemplate>
                                <tr id="table_row" runat="server">
                                    <td id="Td10" runat="server">
                                        <asp:Label ID="user_nameLabel" runat="server" Text='<%# Eval("user_name") %>' />
                                    </td>
                                    <%--<td id="Td11" runat="server">
                                        <asp:Label ID="passwordLabel" runat="server" Text='<%# Eval("password") %>' />
                                    </td>--%>
                                    <td id="Td12" runat="server" align="center">
                                        <asp:CheckBox ID="chk_activeLv" runat="server" Enabled="false" Checked='<%# Eval("active") %>' />
                                    </td>
                                    <td id="Td13" runat="server">
                                        <asp:Button ID="SelectButton" runat="server" CommandName="Select" Text="Select" Style="display: none" />
                                        <asp:ImageButton ID="DeleteButton" runat="server" CommandName="Delete" AlternateText="Delete"
                                            ImageUrl="../images/trash.gif" BorderStyle="Outset" BorderWidth="1px" BackColor="White" />
                                    </td>
                                </tr>
                            </SelectedItemTemplate>
                            <EmptyDataTemplate>
                                <table>
                                    <tr>
                                        <td>
                                        </td>
                                    </tr>
                                </table>
                            </EmptyDataTemplate>
                            <EditItemTemplate>
                                <tr id="Tr2" runat="server">
                                    <td id="Td14" runat="server">
                                        <asp:TextBox ID="user_nameTextBox" runat="server" Text='<%# Bind("user_name") %>'
                                            MaxLength="100" />
                                    </td>
                                    <%--<td id="Td15" runat="server">
                                        <asp:TextBox ID="passwordTextBox" runat="server" Text='<%# Bind("password") %>' />
                                    </td>--%>
                                    <td id="Td16" runat="server" align="center">
                                        <asp:CheckBox ID="chk_activeLv" runat="server" Enabled="false" Checked='<%# Eval("active") %>' />
                                    </td>
                                    <td id="Td17" runat="server">
                                        <asp:ImageButton ID="UpdateButton" runat="server" CommandName="Update" AlternateText="Update"
                                            ImageUrl="../images/disk.png" BorderStyle="Outset" BorderWidth="1px" />
                                        <asp:ImageButton ID="CancelButton" runat="server" CommandName="Cancel" AlternateText="Cancel"
                                            ImageUrl="../images/cancel.gif" BorderStyle="Outset" BorderWidth="1px" />
                                    </td>
                                </tr>
                            </EditItemTemplate>
                        </asp:ListView>
                        <asp:SqlDataSource runat="server" ID="sds_User" ConnectionString="<%$ ConnectionStrings:DLMSConnectionString %>"
                            SelectCommand="SELECT * FROM [User] WHERE (user_group_id = @UserGroupID)" DeleteCommand="DELETE FROM [User] WHERE (user_name = @UserName)">
                            <SelectParameters>
                                <asp:ControlParameter ControlID="ddl_UserGroup" DefaultValue="-1" Name="UserGroupID"
                                    PropertyName="SelectedValue" Type="Int32" />
                            </SelectParameters>
                            <DeleteParameters>
                                <asp:Parameter Name="UserName" Type="String" />
                            </DeleteParameters>
                        </asp:SqlDataSource>
                    </td>
                    <td valign="top" style="width: 65%">
                        <table cellpadding="0" cellspacing="0" border="0" bgcolor="#cccccc" width="100%">
                            <tr>
                                <td>
                                    <asp:Panel ID="Pnl_TopUser" runat="server" BackColor="WhiteSmoke" ForeColor="Black"
                                        BorderColor="#CDCDCD" EnableTheming="True" Font-Bold="True">
                                        <br />
                                        <table width="100%">
                                            <tr>
                                                <td style="width: 140px;">
                                                </td>
                                                <td>
                                                    <table width="100%">
                                                        <tr>
                                                            <td>
                                                                <div style="height: 25px; text-align: left;">
                                                                    <asp:CheckBox ID="chk_Active" runat="server" Text="Active" Checked="true" TextAlign="Left" />
                                                                </div>
                                                            </td>
                                                            <td>
                                                                <div style="height: 25px; text-align: right;">
                                                                    <%--<asp:Button ID="btn_Reset" runat="server" Text="Reset Session" Width="100px" />--%>
                                                                </div>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </td>
                                            </tr>
                                        </table>
                                        <table width="100%">
                                            <tr>
                                                <td>
                                                    <div style="width: 30%; float: left; height: 130px">
                                                        <div style="height: 25px;">
                                                            <asp:Label ID="lbl_UserName" runat="server" Text="Username :"></asp:Label>
                                                        </div>
                                                        <%--<div style="height: 25px">
                                                            <asp:Label ID="lbl_Password" runat="server" Text="Password :"></asp:Label>
                                                        </div>--%>
                                                        <div style="height: 25px">
                                                            <asp:Label ID="lbl_FullName" runat="server" Text="Full Name :"></asp:Label>
                                                        </div>
                                                        <div style="height: 25px" id="div_ChooseUserGroup" runat="server">
                                                            <asp:Label ID="lbl_ChooseUserGroup" runat="server" Text="User Group :"></asp:Label>
                                                        </div>
                                                    </div>
                                                    <div style="width: 65%; float: left; height: 130px">
                                                        <div style="height: 25px;">
                                                            <asp:TextBox ID="txt_UserName" runat="server" Width="170px"></asp:TextBox>
                                                        </div>
                                                        <%--<div style="height: 25px">
                                                            <asp:TextBox ID="txt_Password" runat="server" Width="170px" TextMode="Password"></asp:TextBox>
                                                        </div>--%>
                                                        <div style="height: 25px">
                                                            <asp:TextBox ID="txt_FullName" runat="server" Width="170px"></asp:TextBox>
                                                        </div>
                                                        <div style="height: 25px" id="div_DdlGroupUser" runat="server">
                                                            <asp:DropDownList ID="ddl_GroupUser" runat="server" AutoPostBack="True" Width="176px">
                                                            </asp:DropDownList>
                                                        </div>
                                                    </div>
                                                    <div id="dv_BTNUpdateAndInsert" runat="server">
                                                        <br />
                                                        <asp:Button ID="btn_Update" runat="server" Text="Update" Width="60px" />
                                                        <asp:Button ID="btn_Insert" runat="server" Text="Insert" Width="60px" />
                                                    </div>
                                                </td>
                                            </tr>
                                        </table>
                                        <hr />
                                        <br />
                                    </asp:Panel>
                                    <asp:Panel ID="Pnl_MiddleUser" runat="server" BackColor="WhiteSmoke" ForeColor="Black"
                                        BorderColor="#CDCDCD" EnableTheming="True" Font-Bold="True">
                                        <table width="100%">
                                            <tr>
                                                <td>
                                                    <div style="width: 30%; float: left">
                                                        <div style="height: 25px">
                                                            <asp:Label ID="lbl_Password" runat="server" Text="Password :"></asp:Label>
                                                        </div>
                                                        <div style="height: 25px">
                                                            <asp:Label ID="lbl_ConfirmPassword" runat="server" Text="Confirm Password :"></asp:Label>
                                                        </div>
                                                    </div>
                                                    <div style="width: 65%; float: left">
                                                        <div style="height: 25px">
                                                            <asp:TextBox ID="txt_Password" runat="server" TextMode="Password"></asp:TextBox>
                                                        </div>
                                                        <div style="height: 25px">
                                                            <asp:TextBox ID="txt_ConfirmPassword" runat="server" TextMode="Password"></asp:TextBox>
                                                        </div>
                                                    </div>
                                                    <br />
                                                    <div>
                                                        <asp:Button ID="btn_ChangePassWord" runat="server" Text="Change Password" />
                                                    </div>
                                                </td>
                                            </tr>
                                        </table>
                                        <hr />
                                    </asp:Panel>
                                    <asp:Panel ID="Pnl_CreateAndDeleted" runat="server" BackColor="WhiteSmoke" ForeColor="Black"
                                        BorderColor="#CDCDCD" EnableTheming="True" Font-Bold="True" meta:resourcekey="Pnl_CreateAndDeletedResource1">
                                        <table width="100%">
                                            <tr>
                                                <td>
                                                    <asp:Button ID="CreateMemberButton" runat="server" Text="Create" Width="60px" />
                                                </td>
                                                <td align="right">
                                                    <asp:Button ID="DeleteMemberButton" runat="server" Text="Delete" Width="60px" />
                                                </td>
                                            </tr>
                                        </table>
                                    </asp:Panel>
                                </td>
                            </tr>
                        </table>
                        <asp:LinqDataSource ID="lds_User" runat="server" ContextTypeName="WebApplication_1.DlmsDataContext"
                            EnableDelete="True" EnableInsert="True" EnableUpdate="True" TableName="Users">
                        </asp:LinqDataSource>
                    </td>
                </tr>
                <tr>
                    <td colspan="2" align="center">
                        <asp:Label ID="lbl_Error" runat="server" ForeColor="Red"></asp:Label>
                    </td>
                </tr>
            </table>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
