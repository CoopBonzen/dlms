Public Class ManageCompany
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If String.IsNullOrEmpty(Session("Username")) Then Response.Redirect("~/Login.aspx")
    End Sub

    Private Sub sds_salesApp_Selecting(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.SqlDataSourceSelectingEventArgs) Handles sds_salesApp.Selecting
        Dim sql = "Select Distinct p.prospect_id, p.prospect_nameTH,  p.prospect_nameEN, p.short_name, " & _
                "p.tel_number, p.fax, p.mail from SalesApp_db.dbo.prospect p " & _
                "Order By prospect_id DESC"
        e.Command.CommandText = sql
    End Sub
    'p.prospect_nameTH, c.c_name, p.prospect_nameEN, p.short_name, p.tel_number, p.fax, p.mail
End Class