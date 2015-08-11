Imports System.Data.SqlClient
Public Class ManageUser

    '    Inherits System.Web.UI.Page
    '    Dim _updateUser As User

    '#Region "Method"
    '    Private Sub ClearInput()
    '        txt_FullName.Text = ""
    '        txt_Password.Text = ""
    '        txt_UserName.Text = ""
    '        chk_Active.Checked = True
    '        lv_User.SelectedIndex = -1
    '    End Sub

    '    Private Function CheckValidateUser() As Boolean
    '        If txt_UserName.Text.Trim = String.Empty Then
    '            lbl_Error.Text = "กรุณากรอก Username"
    '            lbl_Error.Visible = True
    '            Return False
    '        ElseIf txt_Password.Text.Trim = String.Empty Then
    '            lbl_Error.Text = "กรุณากรอก Password"
    '            lbl_Error.Visible = True
    '            Return False
    '        ElseIf txt_Password.Text.Trim <> txt_ConfirmPassword.Text.Trim Then
    '            lbl_Error.Text = "ยืนยันรหัสผ่านไม่ถูกต้อง"
    '            lbl_Error.Visible = True
    '            Return False
    '        Else
    '            Return True
    '        End If
    '    End Function

    '    Public Function GetUser(ByVal user_id As Integer?) As User
    '        Dim ctx As New DlmsDataContext
    '        Dim userId As Integer = -1
    '        If user_id.HasValue Then userId = user_id
    '        Dim User = (From u In ctx.Users _
    '            Where u.User_ID = userId).SingleOrDefault
    '        Return User
    '    End Function

    '    Public Function GetUserId(ByVal userName As String) As Integer?
    '        Dim ctx As New DlmsDataContext
    '        Dim User = (From u In ctx.Users _
    '            Where u.user_name.ToLower = userName.ToLower).SingleOrDefault
    '        If User Is Nothing Then Return Nothing
    '        Return User.user_id
    '    End Function

    '    Public Function GetUserName(ByVal userName As String) As Boolean
    '        Dim ctx As New DlmsDataContext
    '        Dim User = (From u In ctx.Users _
    '            Where u.user_name.ToLower = userName.ToLower Select u.user_name).ToList
    '        If User.Count > 0 Then
    '            Return False
    '        Else
    '            Return True
    '        End If
    '    End Function

    '    Private Sub UserDataBound()
    '        Dim txtUser As TextBox = txt_UserName
    '        Dim btnChangepassword As Button = btn_ChangePassWord
    '        Dim btnDelete As Button = DeleteMemberButton
    '        Dim ctx As New DlmsDataContext
    '        ddl_GroupUser.DataTextField = "user_group_name"
    '        ddl_GroupUser.DataValueField = "user_group_id"
    '        ddl_GroupUser.DataSource = (From g In ctx.UserGroups Order By g.display_order)
    '        ddl_GroupUser.DataBind()
    '        Dim DdlUserGroupRole As DropDownList = ddl_GroupUser
    '        If DdlUserGroupRole IsNot Nothing Then
    '            DdlUserGroupRole.SelectedValue = ddl_UserGroup.SelectedValue
    '        End If

    '        If txtUser IsNot Nothing AndAlso CreateMemberButton IsNot Nothing _
    '            AndAlso btnDelete IsNot Nothing Then
    '            Dim UserID As Integer = lv_User.SelectedValue

    '            If UserID <> 0 Then
    '                Pnl_TopUser.Visible = True
    '                Pnl_MiddleUser.Visible = True
    '                Dim UserName = txt_UserName.Text.Trim

    '                txt_UserName.Text = GetUser(UserID).user_name
    '                txt_Password.Text = GetUser(UserID).password
    '                txt_FullName.Text = GetUser(UserID).full_name
    '                chk_Active.Checked = GetUser(UserID).active
    '                Me.ViewState("Username") = GetUser(UserID).user_name

    '                Dim IsMySelf As Boolean = (UserName.ToLower = User.Identity.Name.ToLower)

    '                txtUser.Enabled = False
    '                div_DdlGroupUser.Visible = True
    '                div_ChooseUserGroup.Visible = True
    '                dv_BTNUpdateAndInsert.Visible = True
    '                CreateMemberButton.Visible = False
    '                btnChangepassword.Visible = True
    '                btnDelete.Visible = True
    '                Pnl_CreateAndDeleted.Enabled = Not IsMySelf
    '                btnDelete.OnClientClick = "return confirm('คุณต้องการลบ User Account นี้หรือไม่?');"
    '                btnDelete.Enabled = Not IsMySelf
    '                btnChangepassword.OnClientClick = "return confirm('คุณต้องการเปลี่ยนรหัสผ่านหรือไม่?');"
    '            Else
    '                txtUser.Enabled = True
    '                Pnl_TopUser.Visible = True
    '                Pnl_MiddleUser.Visible = True
    '                Pnl_CreateAndDeleted.Enabled = True
    '                Pnl_CreateAndDeleted.Visible = True
    '                dv_BTNUpdateAndInsert.Visible = False
    '                div_DdlGroupUser.Visible = False
    '                div_ChooseUserGroup.Visible = False
    '                CreateMemberButton.Enabled = True
    '                CreateMemberButton.Visible = True
    '                btnDelete.Visible = False
    '                btnChangepassword.Visible = False
    '            End If
    '        End If
    '    End Sub

    '    Private Sub CreateUser()
    '        If GetUserName(txt_UserName.Text.Trim) Then
    '            Dim ctx As New DlmsDataContext
    '            Dim maxId = (From u In ctx.Users Select CType(u.User_ID, Integer?)).Max
    '            Dim UserID As Integer = IIf(maxId.HasValue, maxId + 1, 1)

    '            Dim TbUser As New User
    '            TbUser.user_id = UserID
    '            TbUser.user_group_id = ddl_UserGroup.SelectedValue
    '            TbUser.full_name = txt_FullName.Text.Trim
    '            TbUser.user_name = txt_UserName.Text.Trim
    '            TbUser.password = txt_Password.Text.Trim
    '            TbUser.active = chk_Active.Checked
    '            ctx.Users.InsertOnSubmit(TbUser)
    '            ctx.SubmitChanges()
    '        Else
    '            lbl_Error.Text = "ชื่อผู้ใช้งานนี้ถูกใช้แล้ว กรุณาใช้ชื่อผู้ใช้งานอื่น"
    '            lbl_Error.Visible = True
    '        End If
    '    End Sub

    '    Private Sub UpdateUser(ByRef u As User)
    '        Dim ctx As New DlmsDataContext
    '        With u
    '            .user_name = txt_UserName.Text.Trim
    '            .full_name = txt_FullName.Text.Trim
    '            .user_group_id = ddl_GroupUser.SelectedValue
    '            .active = chk_Active.Checked
    '        End With
    '    End Sub

    '    Private Sub DeleteUser()
    '        Dim UserName As String = txt_UserName.Text.Trim
    '        If UserName IsNot Nothing Then
    '            Dim ctx As New DlmsDataContext
    '            Dim UserId As Integer = lv_User.SelectedValue
    '            Dim ColumnUser = From u In ctx.Users _
    '                   Where u.User_ID = UserId
    '            ctx.Users.DeleteAllOnSubmit(ColumnUser)

    '            Dim oldvalue As New OrderedDictionary

    '            oldvalue.Add("UserId", UserId)
    '            oldvalue.Add("UserGroupID", ddl_GroupUser.SelectedValue.ToString)
    '            oldvalue.Add("UserName", UserName)
    '            ctx.SubmitChanges()
    '        End If
    '    End Sub

    '    Private Sub ChangePassword()
    '        Dim UserName As String = txt_UserName.Text.Trim
    '        Dim Password As String = txt_Password.Text.Trim
    '        If UserName IsNot Nothing Then
    '            Dim ctx As New DlmsDataContext
    '            Dim dataForm = (From u In ctx.Users Where u.User_ID = CInt(lv_User.SelectedValue)).SingleOrDefault
    '            With dataForm
    '                .password = txt_Password.Text.Trim
    '            End With
    '            ctx.SubmitChanges()
    '        End If
    '    End Sub

    '    Private Sub SetUserGroup()
    '        Dim ctx As New DlmsDataContext
    '        ddl_UserGroup.DataTextField = "User_Group_Name"
    '        ddl_UserGroup.DataValueField = "User_GroupID"
    '        ddl_UserGroup.DataSource = (From g In ctx.UserGroups Order By g.display_order)
    '        ddl_UserGroup.DataBind()

    '        Pnl_TopUser.Visible = (ddl_UserGroup.Items.Count <> 0)
    '        Pnl_MiddleUser.Visible = (ddl_UserGroup.Items.Count <> 0)
    '        Pnl_CreateAndDeleted.Visible = (ddl_UserGroup.Items.Count <> 0)
    '    End Sub
    '#End Region

    '    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
    '        lbl_Error.Visible = False
    '        If Not IsPostBack Then
    '            SetUserGroup()
    '        End If
    '    End Sub

    '    Private Sub lv_User_DataBound(ByVal sender As Object, ByVal e As System.EventArgs) Handles lv_User.DataBound
    '        UserDataBound()
    '    End Sub

    '    Private Sub lv_User_ItemDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.ListViewItemEventArgs) Handles lv_User.ItemDataBound
    '        If e.Item.ItemType = ListViewItemType.DataItem Then
    '            Dim item As ListViewDataItem = e.Item
    '            Dim tr As HtmlTableRow = item.FindControl("table_row")
    '            Dim btnDelete As ImageButton = item.FindControl("DeleteButton")
    '            Dim btnSelect As Button = item.FindControl("SelectButton")
    '            Dim UserName As Label = item.FindControl("user_nameLabel")
    '            If tr IsNot Nothing AndAlso btnSelect IsNot Nothing Then
    '                tr.Attributes("onclick") = _
    '                    Page.ClientScript.GetPostBackEventReference(btnSelect, "")
    '            End If
    '            If tr IsNot Nothing AndAlso btnDelete IsNot Nothing Then
    '                btnDelete.OnClientClick = "return confirm('คุณต้องการลบข้อมูล row นี้หรือไม่?');"

    '                If ("" & UserName.Text.ToLower).ToLower = User.Identity.Name.ToLower Then
    '                    btnDelete.Visible = False
    '                End If
    '            End If
    '        End If
    '    End Sub

    '    Private Sub lv_User_ItemDeleted(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.ListViewDeletedEventArgs) Handles lv_User.ItemDeleted
    '        Dim oldvalue As New OrderedDictionary
    '        oldvalue.Add("UserId", Nothing)
    '        oldvalue.Add("UserGrouID", Nothing)
    '        oldvalue.Add("UserName", Nothing)

    '        Dim ctx As New DlmsDataContext
    '        If e.Exception IsNot Nothing AndAlso TypeOf e.Exception Is SqlClient.SqlException Then
    '            lbl_Error.Text = e.Exception.Message
    '            lbl_Error.Visible = True
    '        Else
    '            Dim UserName As String = Me.ViewState("Username")

    '            If UserName IsNot Nothing Then
    '                Dim UserID As Integer = GetUserId(UserName)
    '                Dim value As New OrderedDictionary
    '                value.Add("UserId", UserID)
    '                value.Add("UserGrouID", ddl_GroupUser.SelectedValue.ToString)
    '                value.Add("UserName", UserName)

    '                If GetUser(UserID) IsNot Nothing Then
    '                    Dim ColumnUser = From u In ctx.Users Where u.user_name = UserName
    '                    ctx.Users.DeleteAllOnSubmit(ColumnUser)
    '                    ctx.SubmitChanges()
    '                End If
    '            End If
    '        End If
    '        Me.ViewState.Remove("UserName")
    '    End Sub

    '    Private Sub lv_User_ItemDeleting(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.ListViewDeleteEventArgs) Handles lv_User.ItemDeleting
    '        Dim UserID As Integer = e.Keys("UserId")
    '        Me.ViewState("Username") = GetUser(UserID).user_name
    '    End Sub

    '    Private Sub ddl_UserGroup_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles ddl_UserGroup.SelectedIndexChanged
    '        lv_User.DataBind()
    '        ClearInput()
    '    End Sub

    '    Private Sub CreateMemberButton_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles CreateMemberButton.Click
    '        If Not CheckValidateUser() Then Exit Sub
    '        CreateUser()
    '        lv_User.DataBind()
    '    End Sub

    '    Private Sub DeleteMemberButton_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles DeleteMemberButton.Click
    '        DeleteUser()
    '        ClearInput()
    '    End Sub

    '    Private Sub btn_Insert_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btn_Insert.Click
    '        ClearInput()
    '    End Sub

    '    Private Sub btn_Update_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btn_Update.Click
    '        Try
    '            Dim ctx As New DlmsDataContext
    '            Dim dataForm = (From u In ctx.Users Where u.User_ID = CInt(lv_User.SelectedValue)).SingleOrDefault
    '            UpdateUser(dataForm)            ctx.SubmitChanges()
    '            ClearInput()
    '            lv_User.DataBind()

    '            ScriptManager.RegisterStartupScript(Page, Page.GetType, "UpdateCompleted", _
    '              <script language="javascript">alert('<%= ("textUpdateCompleted") %>');</script>.ToString, False)

    '        Catch ex As Exception
    '            ScriptManager.RegisterStartupScript(Page, Page.GetType, "UpdateNotCompleted", _
    '              <script language="javascript">alert('<%= ("textUpdateNotCompleted") %>');</script>.ToString, False)
    '        End Try
    '    End Sub

    '    Private Sub btn_ChangePassWord_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btn_ChangePassWord.Click
    '        CheckValidateUser()
    '        ChangePassword()
    '    End Sub
End Class