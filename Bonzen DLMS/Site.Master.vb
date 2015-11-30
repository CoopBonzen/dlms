Public Class Site
    Inherits System.Web.UI.MasterPage

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Dim username As String = Session("Username")
        Dim fullname As String = Session("UserFullname")
        If username <> "" And fullname <> "" Then
            lbl_loginname.Text = "" & username & "(" & fullname.ToUpper & ")"
            imb_logout.Visible = True
        Else
            lbl_loginname.Text = ""
            imb_logout.Visible = False
        End If
        'เช็คสิทธิ์
        ASPxMenu1.Items(3).Visible = IsUserRole(Session("Username"), PrivManageUserAndUserGroup)
    End Sub
    'comment
    Private Sub imb_logout_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles imb_logout.Click
        Session("UserFullname") = ""
        Session("Username") = ""
        Session.Clear()
        Response.Redirect("~/Login.aspx")
    End Sub
End Class