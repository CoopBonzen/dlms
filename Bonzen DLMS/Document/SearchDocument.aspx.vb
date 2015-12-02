Imports DevExpress.Web.ASPxGridView
Imports Bonzen_DLMS.DataAccessModule
Imports System.Web.Configuration
Imports DevExpress.Web.ASPxEditors
Imports DevExpress.Web.ASPxClasses.Internal

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

    'pop-up
    Public Property QuotationCode() As String
        Get
            Return ViewState("QuotationCode")
        End Get
        Set(ByVal value As String)
            ViewState("QuotationCode") = value
        End Set
    End Property

    Public ReadOnly Property UploadDirectory() As String
        Get
            Return WebConfigurationManager.AppSettings("QuotationUploadFolder")
        End Get

    End Property


    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If String.IsNullOrEmpty(Session("Username")) Then Response.Redirect("~/Login.aspx")
        Dim username = Session("Username")
        Dim user As New User

        user = DataAccess.GetUserByUsername(username)

        'user.user_group_id
        'gv_general.DataBind()
        gv_quotationProposal.DataBind()

        'pop-up
        'lbl_QNo.Text = QuotationCode
        'lbl_QCompanyName.Text = GetCompanyBygId(QuotationCode)
        'gv_QFile.DataBind()
        If Not IsPostBack Then
            GetFiles(qID:=QuotationCode)
        End If

        'เช็คสิทธ
        'gv_quotationProposal.Enabled = IsUserRole(Session("Username"), PrivViewQPQ)
        'gv_general.Enabled = IsUserRole(Session("Username"), PrivViewQPQ)
        AddNewDocument.Visible = IsUserRole(Session("Username"), PrivAddNewDocument)
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

    Private Sub gv_general_HtmlRowPrepared(ByVal sender As Object, ByVal e As DevExpress.Web.ASPxGridView.ASPxGridViewTableRowEventArgs) Handles gv_general.HtmlRowPrepared
        If e.RowType = GridViewRowType.Data Then
            With CType(sender, ASPxGridView)
                'Dim hpl_G_ID As DevExpress.Web.ASPxEditors.ASPxHyperLink = CType(.FindRowCellTemplateControl(e.VisibleIndex, .Columns("G_ID"), "hpl_G_ID"), DevExpress.Web.ASPxEditors.ASPxHyperLink)
                'If hpl_G_ID IsNot Nothing Then hpl_G_ID.ClientSideEvents.Click = "function(s, e) {window.location = 'GeneralUpload.aspx?G_Id=" & e.GetValue("G_ID") & "';}"

                Dim lnk_GId As LinkButton = CType(.FindRowCellTemplateControl(e.VisibleIndex, .Columns("G_ID"), "lnk_GId"), LinkButton)
                Dim username = Session("Username")
                If lnk_GId IsNot Nothing Then
                    If Not IsUserRole(username, PrivViewQPQ) Then
                        lnk_GId.Enabled = False
                    End If
                End If
            End With
        End If
    End Sub

    Protected Sub ListItem_Command(ByVal sender As Object, ByVal e As CommandEventArgs)
        Select Case e.CommandName
            Case "OpenCreateQuotation"
                Response.Redirect("../Document/CreateQuotation.aspx?qId=" & e.CommandArgument)
            Case "OpenUploadProposalFile"
                Response.Redirect("../Document/ProposalUpload.aspx?pId=" & e.CommandArgument)
            Case "OpenUploadGeneralFile"
                Response.Redirect("../Document/GeneralUpload.aspx?gId=" & e.CommandArgument)
                'Case "PrintQuotation"
                '    Response.Redirect("../Report/Report.aspx?quotaId=" & e.CommandArgument)
        End Select
    End Sub

    Private Sub gv_quotationProposal_CustomCallback(ByVal sender As Object, ByVal e As DevExpress.Web.ASPxGridView.ASPxGridViewCustomCallbackEventArgs) Handles gv_quotationProposal.CustomCallback
        gv_quotationProposal.DataBind()
    End Sub

    'pop-up
    Private Sub gv_quotationProposalAll_HtmlRowPrepared(ByVal sender As Object, ByVal e As DevExpress.Web.ASPxGridView.ASPxGridViewTableRowEventArgs) Handles gv_quotationProposal.HtmlRowPrepared
        Dim btn_PreviewQuotation As ASPxButton = CType(gv_quotationProposal.FindRowCellTemplateControl(e.VisibleIndex, gv_quotationProposal.Columns("Preview"), "btn_PreviewQuotation"), ASPxButton)
        If btn_PreviewQuotation IsNot Nothing Then
            btn_PreviewQuotation.ClientSideEvents.Click = "function(s, e) { CIN_pop_PreviewQuotation.Show();" & _
                                                                           " CIN_cbp_PreviewQuotation.PerformCallback('" & e.GetValue("Q_ID") & "');}"
        End If

        If e.RowType = GridViewRowType.Data Then
            With CType(sender, ASPxGridView)
                Dim lnk_QId As LinkButton = CType(.FindRowCellTemplateControl(e.VisibleIndex, .Columns("Q_ID"), "lnk_QId"), LinkButton)
                Dim lnk_PId As LinkButton = CType(.FindRowCellTemplateControl(e.VisibleIndex, .Columns("P_ID"), "lnk_PId"), LinkButton)

                Dim username = Session("Username")
                If lnk_QId IsNot Nothing Then
                    If Not IsUserRole(username, PrivViewQPQ) Then
                        lnk_QId.Enabled = False
                        lnk_PId.Enabled = False
                        btn_PreviewQuotation.Enabled = False
                    End If
                End If
            End With
        End If
    End Sub

    Private Sub gv_quotationProposal_CommandButtonInitialize(ByVal sender As Object, ByVal e As DevExpress.Web.ASPxGridView.ASPxGridViewCommandButtonEventArgs) Handles gv_quotationProposal.CommandButtonInitialize
        If e.ButtonType = ColumnCommandButtonType.Edit Then
            Dim username = Session("Username")
            If IsUserRole(username, PrivViewQPQ) Then
                Dim QID = gv_quotationProposal.GetRowValues(e.VisibleIndex, "Q_ID")
                Dim qta As QuotationStatusEnum = CType(DataAccess.getQuotation(QID).quota_status, QuotationStatusEnum)
                If qta = QuotationStatusEnum.Approve Then
                    e.Enabled = False
                Else
                    e.Enabled = True
                End If
            Else
                e.Enabled = False
            End If
        End If
    End Sub

    Private Sub gv_general_CommandButtonInitialize(ByVal sender As Object, ByVal e As DevExpress.Web.ASPxGridView.ASPxGridViewCommandButtonEventArgs) Handles gv_general.CommandButtonInitialize
        If e.ButtonType = ColumnCommandButtonType.Edit Then
            Dim username = Session("Username")
            If IsUserRole(username, PrivViewQPQ) Then
                e.Enabled = True
            Else
                e.Enabled = False
            End If
        End If
    End Sub

    Private Sub cbp_PreviewQuotation_Callback(ByVal sender As Object, ByVal e As DevExpress.Web.ASPxClasses.CallbackEventArgsBase) Handles cbp_PreviewQuotation.Callback
        If Not e.Parameter Is Nothing Then
            Dim quota As New Quotation
            Dim qID = e.Parameter
            quota = chkQuotationByNO(qID)
            With quota
                lbl_QNo.Text = .quotation_no
                lbl_QCompanyName.Text = GetCompanyBygId(qID)
                lbl_QTotal.Text = .total_amount
                lbl_QRemarke.Text = .remark
            End With
            QuotationCode = qID
            GetFiles(qID)
            gv_QFile.DataBind()


            Return
        End If
    End Sub

    Public Function chkQuotationByNO(ByVal qno As String) As Quotation
        Dim quotation As New Quotation
        Using ctx = New DlmsDataContext
            quotation = (From q In ctx.Quotations Where q.quotation_no = qno).SingleOrDefault
        End Using
        Return quotation
    End Function

    'Public Function GetNextQFileId() As Integer
    '    Dim ctx As New DlmsDataContext
    '    Dim nextId As Integer = (From qf In ctx.QuotationFiles Select CType(qf.Q_FileID, Integer?)).Max.GetValueOrDefault + 1
    '    Return nextId
    'End Function

    Public Function GetCompanyBygId(ByVal qID As String)
        Using ctx As New DlmsDataContext
            Dim companyName As String
            companyName = (From q In ctx.QuotationProposals Where q.Q_ID = qID _
                           Select q.ContactCom).SingleOrDefault
            Return companyName
        End Using
    End Function


    Public Sub GetFiles(ByVal qID)
        Dim dt As New DataTable
        dt.Columns.Add("Q_FileID", GetType(String))
        dt.Columns.Add("filename", GetType(String))
        dt.Columns.Add("link", GetType(String))

        Dim quotationList As List(Of QuotationFile)
        quotationList = GetQuotationFile(qID)

        Try
            Dim Path = UploadDirectory & qID
            If IO.Directory.Exists(Path) Then
                Dim dirs As New IO.DirectoryInfo(Path)
                For Each f As IO.FileInfo In dirs.GetFiles
                    Dim fname As String = f.Name
                    Dim fpath As String = "DownloadFile.aspx?FilePath=" & Web.HttpUtility.UrlEncode(Path & "\" & f.Name)
                    For Each i In quotationList
                        If i.Q_FileName = fname Then
                            dt.Rows.Add(i.Q_FileID, fname, fpath)
                        End If
                    Next
                Next
            End If
        Catch ex As Exception
            dt.Clear()
        End Try
        gv_QFile.DataSource = dt
        gv_QFile.DataBind()
    End Sub

    Public Function GetQuotationFile(ByVal code As String) As List(Of QuotationFile)
        Using ctx = New DlmsDataContext
            Dim Quotations = (From g In ctx.QuotationFiles Where g.Q_ID = code).ToList
            Return Quotations
        End Using
    End Function

End Class