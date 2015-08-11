Imports DevExpress.Web.ASPxGridView
Imports Bonzen_DLMS.DataAccessModule

Public Class SearchDocument
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

    Private Sub gv_general_CustomCallback(ByVal sender As Object, ByVal e As DevExpress.Web.ASPxGridView.ASPxGridViewCustomCallbackEventArgs) Handles gv_general.CustomCallback
        gv_general.DataBind()
    End Sub

    'Protected Sub ListItem_Command(ByVal sender As Object, ByVal e As CommandEventArgs)
    '    Select Case e.CommandName
    '        Case "OpenForUpload"
    '            Response.Redirect("../SearchDoc/GUpload.aspx?G_Id=" & e.CommandArgument)
    '    End Select
    'End Sub

    Private Sub gv_general_HtmlRowPrepared(sender As Object, e As DevExpress.Web.ASPxGridView.ASPxGridViewTableRowEventArgs) Handles gv_general.HtmlRowPrepared
        If e.RowType = GridViewRowType.Data Then
            With CType(sender, ASPxGridView)
                Dim hpl_G_ID As DevExpress.Web.ASPxEditors.ASPxHyperLink = CType(.FindRowCellTemplateControl(e.VisibleIndex, .Columns("G_ID"), "hpl_G_ID"), DevExpress.Web.ASPxEditors.ASPxHyperLink)
                If hpl_G_ID IsNot Nothing Then hpl_G_ID.ClientSideEvents.Click = "function(s, e) {window.location = 'GeneralUpload.aspx?G_Id=" & e.GetValue("G_ID") & "';}"
            End With
        End If
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

    Private Sub gv_quotationProposal_CustomCallback(ByVal sender As Object, ByVal e As DevExpress.Web.ASPxGridView.ASPxGridViewCustomCallbackEventArgs) Handles gv_quotationProposal.CustomCallback
        gv_quotationProposal.DataBind()
    End Sub
End Class