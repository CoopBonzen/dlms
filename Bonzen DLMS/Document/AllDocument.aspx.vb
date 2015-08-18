Imports DevExpress.Web.ASPxGridView
Imports DevExpress.Web.ASPxEditors

Public Class AllDocument
    Inherits System.Web.UI.Page

    Private _dataaccess As New DataAccessModule


    Public Property DataAccess() As DataAccessModule
        Get
            Return _dataaccess
        End Get
        Set(ByVal value As DataAccessModule)
            _dataaccess = value
        End Set
    End Property
    '...
    Public Property Quota_ID() As String
        Get
            Return ViewState("Quota_ID")
        End Get
        Set(ByVal value As String)
            ViewState("Quota_ID") = value
        End Set
    End Property

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If String.IsNullOrEmpty(Session("Username")) Then Response.Redirect("~/Login.aspx")
        Dim username = Session("Username")
        Dim user As New User

        user = DataAccess.GetUserByUsername(username)

        'user.user_group_id

    End Sub

    Private Sub gv_general_HtmlRowPrepared(ByVal sender As Object, ByVal e As DevExpress.Web.ASPxGridView.ASPxGridViewTableRowEventArgs) Handles gv_generalAll.HtmlRowPrepared
        If e.RowType = GridViewRowType.Data Then
            With CType(sender, ASPxGridView)
                Dim hpl_G_ID As DevExpress.Web.ASPxEditors.ASPxHyperLink = CType(.FindRowCellTemplateControl(e.VisibleIndex, .Columns("G_ID"), "hpl_G_ID"), DevExpress.Web.ASPxEditors.ASPxHyperLink)
                If hpl_G_ID IsNot Nothing Then hpl_G_ID.ClientSideEvents.Click = "function(s, e) {window.location = 'GeneralUpload.aspx?G_Id=" & e.GetValue("G_ID") & "';}"
            End With
        End If
    End Sub

    Private Sub gv_quotationProposal_CustomCallback(ByVal sender As Object, ByVal e As DevExpress.Web.ASPxGridView.ASPxGridViewCustomCallbackEventArgs) Handles gv_quotationProposalAll.CustomCallback
        gv_quotationProposalAll.DataBind()
    End Sub

    Protected Sub ListItem_Command(ByVal sender As Object, ByVal e As CommandEventArgs)
        Select Case e.CommandName
            Case "OpenCreateQuotation"
                'Session("IsEditing") = True
                Response.Redirect("../Document/CreateQuotation.aspx?qId=" & e.CommandArgument)
            Case "OpenUploadProposalFile"
                Response.Redirect("../Document/ProposalUpload.aspx?pId=" & e.CommandArgument)
            Case "OpenUploadGeneralFile"
                Response.Redirect("../Document/GeneralUpload.aspx?gId=" & e.CommandArgument)
            Case "PrintQuotation"
                Response.Redirect("../Report/Report.aspx?quotaId=" & e.CommandArgument)
        End Select
    End Sub


    Protected Sub cmb_searchYear_Load(ByVal sender As Object, ByVal e As EventArgs)
        cmb_searchYearQ = CType(sender, ASPxComboBox)
    End Sub

    Private Sub cmb_searchYear_Callback(ByVal sender As Object, ByVal e As DevExpress.Web.ASPxClasses.CallbackEventArgsBase) Handles cmb_searchYearQ.Callback
        cmb_searchYearQ.DataBind()
    End Sub
End Class