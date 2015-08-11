Imports DevExpress.Web.ASPxGridView

Public Class ModuleQuotation
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If String.IsNullOrEmpty(Session("Username")) Then Response.Redirect("~/Login.aspx")
    End Sub

    Private Sub DataSource_QuotationDescription_Selecting(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.SqlDataSourceSelectingEventArgs) Handles DataSource_QuotationDescription.Selecting
        Dim q As String
        q = "SELECT     qds.ID_Q_Detail_Sub, qds.Q_Detail_Sub, qds.Price, qds.ID_Q_Detail_main, qdd.Q_Detail_Main " & _
            "FROM         QuotationDescriptionSub AS qds  " & _
            "LEFT OUTER JOIN QuotationDescription AS qdd ON qds.ID_Q_Detail_main = qdd.ID_Q_Detail_Main " & _
            " order by  qds.ID_Q_Detail_main "
        e.Command.CommandText = q
    End Sub
End Class