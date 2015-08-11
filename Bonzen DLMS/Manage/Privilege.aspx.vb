Imports System.Data
Imports System.Data.SqlClient
Imports System.Web.Configuration

Public Class Privilege
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If String.IsNullOrEmpty(Session("Username")) Then Response.Redirect("~/Login.aspx")
    End Sub

#Region "Method"
    Public Sub UpdateActive(ByVal displayorder As Integer, ByVal ChkSelected As Boolean)
        Dim ctx As New DlmsDataContext
        Dim UserGroupByID = (From g In ctx.UserGroups _
                    Where g.display_order = displayorder).SingleOrDefault
        UserGroupByID.active = ChkSelected
        ctx.SubmitChanges()
    End Sub

    Public Function GetChkGroupRole(ByVal UserGroupRoleID As Integer?, ByVal RoleName As String) As Boolean
        Dim ctx As New DlmsDataContext
        Dim ChkGroupRole = (From r In ctx.UserGroupRoles _
                    Where r.user_group_id = UserGroupRoleID And r.role_name = RoleName).SingleOrDefault
        If ChkGroupRole IsNot Nothing Then
            Return True
        Else
            Return False
        End If
    End Function

    Protected Function CanDelectGroup(ByVal GroupID As Object) As Boolean
        Dim CanDelete As Boolean = True
        If Not IsDBNull(GroupID) OrElse GroupID IsNot Nothing Then
            Dim ctx As New DlmsDataContext
            Dim q = (From u In ctx.Users Where u.user_group_id = CInt(GroupID))
            If q.FirstOrDefault IsNot Nothing Then CanDelete = False
        End If
        Return CanDelete
    End Function
#End Region

#Region "User Group"

    Private Sub lds_UserGroup_Inserting(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.LinqDataSourceInsertEventArgs) Handles lds_UserGroup.Inserting
        Dim item As Global.Bonzen_DLMS.UserGroup = e.NewObject
        If item IsNot Nothing Then
            Dim ctx As New DlmsDataContext
            Dim maxId = (From g In ctx.UserGroups Select CType(g.user_group_id, Integer?)).Max
            Dim maxOrder = (From g In ctx.UserGroups Select CType(g.display_order, Integer?)).Max
            item.user_group_id = IIf(maxId.HasValue, maxId + 1, 1)
            item.display_order = IIf(maxOrder.HasValue, maxOrder + 1, 1)
        Else

            e.Cancel = True
        End If


    End Sub

    Private Sub lv_UserGroup_ItemCreated(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.ListViewItemEventArgs) Handles lv_UserGroup.ItemCreated
        If e.Item.ItemType = ListViewItemType.InsertItem Then
            Dim lb As Label = e.Item.FindControl("lbl_DisplayOrder")
            Dim ctx As New DlmsDataContext
            Dim maxOrder = (From g In ctx.UserGroups Select CType(g.display_order, Integer?)).Max
            lb.Text = IIf(maxOrder.HasValue, maxOrder + 1, 1)
        End If
    End Sub

    Private Sub lv_UserGroup_ItemDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.ListViewItemEventArgs) Handles lv_UserGroup.ItemDataBound
        If e.Item.ItemType = ListViewItemType.DataItem Then
            Dim item As ListViewDataItem = e.Item
            Dim tr As HtmlTableRow = item.FindControl("table_row")
            Dim bsel As Button = item.FindControl("SelectButton")
            Dim bedit As Button = item.FindControl("EditButton")
            Dim bdelete As ImageButton = item.FindControl("DeleteButton")

            If tr IsNot Nothing AndAlso bsel IsNot Nothing Then
                tr.Attributes("onclick") = _
                    Page.ClientScript.GetPostBackEventReference(bsel, "")
            End If
            If tr IsNot Nothing AndAlso bedit IsNot Nothing Then
                tr.Attributes("ondblclick") = _
                    Page.ClientScript.GetPostBackEventReference(bedit, "")
            End If
            If tr IsNot Nothing AndAlso bdelete IsNot Nothing Then
                bdelete.OnClientClick = "return confirm('คุณต้องการลบข้อมูล row นี้หรือไม่?');"
            End If
        End If
    End Sub

    Private Sub lv_UserGroup_ItemDeleted(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.ListViewDeletedEventArgs) Handles lv_UserGroup.ItemDeleted
        If e.Exception IsNot Nothing AndAlso TypeOf e.Exception Is SqlClient.SqlException Then
            lbl_Error.Text = e.Exception.Message
            lbl_Error.Visible = True
        Else
            Dim ctx As New DlmsDataContext
            Dim q = From r In ctx.UserGroups
            Dim dis As New DisplayOrderManager(Of UserGroup)(q)
            dis.ReOrder()
            ctx.SubmitChanges()
        End If
        lv_UserGroup.EditIndex = -1
    End Sub

    Private Sub lv_UserGroup_ItemDeleting(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.ListViewDeleteEventArgs) Handles lv_UserGroup.ItemDeleting
        Dim ctx As New DlmsDataContext
        ctx.ExecuteCommand("Delete From UserGroupRole Where user_group_id = " & CInt(e.Keys.Item(0)))
    End Sub

    Private Sub lv_UserGroup_ItemInserted(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.ListViewInsertedEventArgs) Handles lv_UserGroup.ItemInserted
        If e.Exception IsNot Nothing Then
            If TypeOf e.Exception Is SqlClient.SqlException Then
                With CType(e.Exception, SqlClient.SqlException)
                    lbl_Error.Text = e.Exception.Message
                    lbl_Error.Visible = True
                End With
            End If
        End If
        lv_UserGroup.EditIndex = -1
    End Sub

    Private Sub lv_UserGroup_ItemUpdated(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.ListViewUpdatedEventArgs) Handles lv_UserGroup.ItemUpdated
        If e.Exception IsNot Nothing AndAlso TypeOf e.Exception Is SqlClient.SqlException Then
            lbl_Error.Text = e.Exception.Message
            lbl_Error.Visible = True
            e.KeepInEditMode = True
        End If
    End Sub

    Private Sub lv_UserGroup_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles lv_UserGroup.SelectedIndexChanged
        pnl_Priv.Visible = True
        PnlGroupPrivilegesDataBound()
    End Sub

    Private Sub btn_UserGroupUp_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btn_UserGroupUp.Click
        If lv_UserGroup.Items.Count > 0 AndAlso lv_UserGroup.SelectedIndex > 0 Then
            Dim ctx As New DlmsDataContext
            Dim q = From r In ctx.UserGroups
            Dim dis As New DisplayOrderManager(Of UserGroup)(q)
            dis.MoveUpByKey(lv_UserGroup.SelectedDataKey.Values)
            ctx.SubmitChanges()
            lv_UserGroup.SelectedIndex -= 1
            lv_UserGroup.EditIndex = -1
        End If
    End Sub

    Private Sub btn_UserGroupDown_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btn_UserGroupDown.Click
        If lv_UserGroup.Items.Count > 0 AndAlso lv_UserGroup.SelectedIndex >= 0 AndAlso lv_UserGroup.SelectedIndex < lv_UserGroup.Items.Count - 1 Then
            Dim ctx As New DlmsDataContext
            Dim q = From r In ctx.UserGroups
            Dim dis As New DisplayOrderManager(Of UserGroup)(q)
            dis.MoveDownByKey(lv_UserGroup.SelectedDataKey.Values)
            ctx.SubmitChanges()
            lv_UserGroup.SelectedIndex += 1
            lv_UserGroup.EditIndex = -1
        End If
    End Sub

#End Region

#Region "User Privilege"
    Private Sub PnlGroupPrivilegesDataBound()
        Dim Ckl As CheckBoxList = CType(ckl_GroupRole, CheckBoxList)
        If Ckl IsNot Nothing Then
            Dim StaffGroupId As Integer = lv_UserGroup.SelectedValue
            Ckl.DataTextField = "Text"
            Ckl.DataValueField = "Name"
            CreatePrivilege()
            Ckl.DataSource = UserPrivilege
            Ckl.DataBind()

            For Each chk As ListItem In Ckl.Items
                chk.Selected = GetChkGroupRole(StaffGroupId, chk.Value.ToLower)
            Next
        End If
    End Sub

    Private Sub UserGroupRoleSaveAndDelete()
        Dim Ckl As CheckBoxList = CType(ckl_GroupRole, CheckBoxList)
        If Ckl IsNot Nothing Then
            Dim UserGroupId As Integer = lv_UserGroup.SelectedValue
            For Each chk As ListItem In Ckl.Items
                SaveUserGroupRole(UserGroupId, chk.Value.ToLower, chk.Selected)
            Next
        End If
    End Sub

    Public Sub SaveUserGroupRole(ByVal UserGroupRoleID As Integer?, ByVal RoleName As String, _
                                  ByVal ChkSelected As Boolean)
        Dim ctx As New DlmsDataContext
        Dim ChkGroupRole = GetChkGroupRole(UserGroupRoleID, RoleName)
        If ChkSelected <> ChkGroupRole Then
            If ChkSelected = True And ChkGroupRole = False Then
                Dim TbUserGroupRole As New UserGroupRole
                TbUserGroupRole.user_group_id = UserGroupRoleID
                TbUserGroupRole.role_name = RoleName
                ctx.UserGroupRoles.InsertOnSubmit(TbUserGroupRole)

            Else
                Dim ColumnUserGroupRole = From g In ctx.UserGroupRoles _
                    Where g.role_name = RoleName And g.user_group_id = UserGroupRoleID
                ctx.UserGroupRoles.DeleteAllOnSubmit(ColumnUserGroupRole)
            End If
            ctx.SubmitChanges()
        End If
    End Sub
#End Region

    Private Sub ChangeRoleButton_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles ChangeRoleButton.Click
        UserGroupRoleSaveAndDelete()
        chk_AllGroupRole.Checked = False
    End Sub

    Protected Sub chk_AllGroupRoleOnCheckedChanged(ByVal sender As Object, ByVal e As System.EventArgs)
        Dim Ckl As CheckBoxList = CType(ckl_GroupRole, CheckBoxList)
        If Ckl IsNot Nothing Then
            For Each chk As ListItem In Ckl.Items
                'chk.Selected = sender.checked
                chk.Selected = chk_AllGroupRole.Checked
            Next
        End If
    End Sub

    Protected Sub chk_SelectedActiveOnCheckedChanged(ByVal sender As Object, ByVal e As System.EventArgs)
        Dim index As Integer = lv_UserGroup.SelectedIndex
        Dim ItemByIndex = lv_UserGroup.Items(index)
        Dim displayorderLabel As Label = ItemByIndex.FindControl("lbl_DisplayOrder")
        Dim CheckActive As Boolean
        If ViewState("CheckActive") IsNot Nothing Then
            CheckActive = ViewState("CheckActive")
        Else
            CheckActive = sender.checked
        End If
        CheckActive = sender.checked
        UpdateActive(CInt(displayorderLabel.Text), CheckActive)
    End Sub
End Class