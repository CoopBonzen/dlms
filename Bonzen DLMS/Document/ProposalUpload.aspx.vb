Imports System.Data
Imports System.Data.SqlClient
Imports DevExpress.Web.ASPxUploadControl
Imports System.IO
Imports System.Web.Configuration

Public Class ProposalUpload
    Inherits System.Web.UI.Page

    Public Property ProposalCode() As String
        Get
            Return ViewState("ProposalCode")
        End Get
        Set(ByVal value As String)
            ViewState("ProposalCode") = value
        End Set
    End Property

    Public ReadOnly Property UploadDirectory() As String
        Get
            'set upload path
            Return WebConfigurationManager.AppSettings("ProposalUploadFolder")
        End Get
    End Property

    'Private Const UploadDirectory As String = "D:\Bonzen Webapps\DLMS\ProposalFile\"

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If String.IsNullOrEmpty(Session("Username")) Then Response.Redirect("~/Login.aspx")

        'Dim RequestId = Request.QueryString("pId")
        ProposalCode = Request.QueryString("pId")

        lbl_PNo.Text = ProposalCode
        lbl_PCompanyName.Text = GetCompanyBypId(ProposalCode)
        gv_PFile.DataBind()
        If Not IsPostBack Then
            GetFiles()
        End If

        ulc_ProposalFile.Enabled = IsUserRole(Session("Username"), PrivUploadFileProposal)

    End Sub

    Public Function GetNextPFileId() As Integer
        Dim ctx As New DlmsDataContext
        Dim nextId As Integer = (From pf In ctx.ProposalFiles Select CType(pf.P_FileID, Integer?)).Max.GetValueOrDefault + 1
        Return nextId
    End Function

    Public Function GetCompanyBypId(ByVal pId As String)
        Using ctx As New DlmsDataContext
            Dim companyName As String
            companyName = (From qp In ctx.QuotationProposals Join q In ctx.Quotations _
                           On qp.Q_ID Equals q.quotation_no Where qp.P_ID = pId _
                           Select q.company_name).SingleOrDefault
            Return companyName
        End Using
    End Function

    Protected Sub UploadControl_FileUploadComplete(ByVal sender As Object, ByVal e As FileUploadCompleteEventArgs)
        Dim pFileId As Integer = GetNextPFileId()
        'Dim dateNow As DateTime = System.DateTime.Now
        If ProposalCode Is Nothing Then ProposalCode = Request.QueryString("pId")

        Dim uploadControl As ASPxUploadControl = TryCast(sender, ASPxUploadControl)
        If uploadControl.UploadedFiles IsNot Nothing AndAlso uploadControl.UploadedFiles.Length > 0 Then
            For i As Integer = 0 To uploadControl.UploadedFiles.Length - 1
                Dim file As UploadedFile = uploadControl.UploadedFiles(i)

                'Dim fileExtension = file.FileName.Split(".")
                If file.ContentLength > 0 Then
                    Dim path = UploadDirectory & ProposalCode
                    If Not IO.Directory.Exists(path) Then
                        IO.Directory.CreateDirectory(path)
                    End If
                    file.SaveAs(path & "\" & file.FileName)
                    Dim propFile As New ProposalFile
                    With propFile
                        .P_ID = ProposalCode
                        .P_FileID = pFileId
                        .P_FileName = file.FileName
                        .P_FileDate = Now
                    End With
                    Using ctx As New DlmsDataContext
                        ctx.ProposalFiles.InsertOnSubmit(propFile)
                        ctx.SubmitChanges()
                    End Using
                    'Response.Redirect("../Document/ProposalUpload.aspx?pId=" & ProposalCode)
                End If
            Next i
        End If
    End Sub

    Protected Sub Updatepanel1_Refresh(sender As Object, e As System.EventArgs)
        Response.Redirect("../Document/ProposalUpload.aspx?pId=" & ProposalCode)
    End Sub

    Public Sub GetFiles()
        Dim dt As New DataTable
        dt.Columns.Add("filename", GetType(String))
        dt.Columns.Add("link", GetType(String))

        Dim proposalList As List(Of ProposalFile)
        proposalList = GetProposalFile(ProposalCode)

        Try
            Dim Path = UploadDirectory & ProposalCode
            If IO.Directory.Exists(Path) Then
                Dim dirs As New IO.DirectoryInfo(Path)
                For Each f As IO.FileInfo In dirs.GetFiles
                    Dim fname As String = f.Name
                    Dim fpath As String = "DownloadFile.aspx?FilePath=" & Web.HttpUtility.UrlEncode(Path & "\" & f.Name)
                    For Each i In proposalList
                        If i.P_FileName = fname Then
                            dt.Rows.Add(fname, fpath)
                        End If
                    Next
                Next
            End If
        Catch ex As Exception
            dt.Clear()
        End Try
        gv_PFile.DataSource = dt
        gv_PFile.DataBind()
    End Sub

    Public Function GetProposalFile(code As String) As List(Of ProposalFile)
        Using ctx = New DlmsDataContext
            Dim Proposals = (From p In ctx.ProposalFiles Where p.P_ID = code).ToList
            Return Proposals
        End Using
    End Function

End Class