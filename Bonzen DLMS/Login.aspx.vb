Public Class Login
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub

    Private Sub Login_Authenticate(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.AuthenticateEventArgs) Handles Login.Authenticate
        Dim Username As String = ""
        Dim Password As String = ""
        Username = Login.UserName
        Password = Login.Password
        Dim authen As New DataAccessModule
        Dim user As New User
        user = authen.Authenticate(Username, Password)
        If user IsNot Nothing Then
            Session("UserFullname") = user.full_name
            Session("Username") = user.user_name
            Response.Redirect("~/Document/SearchDocument.aspx")
        Else
            Login.FailureText = "ไม่สามารถเข้าสู่ระบบได้ กรุณาลองใหม่อีกครั้ง"
        End If
    End Sub
End Class