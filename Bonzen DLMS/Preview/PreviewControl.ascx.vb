Imports System.Data
Imports System.Data.DataTable
Imports System.Data.SqlClient
Imports DevExpress.Web.ASPxClasses
Imports DevExpress.Web.ASPxEditors
Imports DevExpress.Web.ASPxGridView
Imports DevExpress.Web.ASPxUploadControl
Imports System.IO
Imports System.Web.Configuration

Public Class PreviewControl
    Inherits System.Web.UI.UserControl

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
       

        QuotationCode = Request.QueryString("qId")

        lbl_QNo.Text = QuotationCode
        lbl_QCompanyName.Text = GetCompanyBygId(QuotationCode)
        gv_QFile.DataBind()
        If Not IsPostBack Then
            GetFiles()
        End If

    End Sub

    'เพิ่มUpload'
    Public Function GetNextQFileId() As Integer
        Dim ctx As New DlmsDataContext
        Dim nextId As Integer = (From qf In ctx.QuotationFiles Select CType(qf.Q_FileID, Integer?)).Max.GetValueOrDefault + 1
        Return nextId
    End Function

    Public Function GetCompanyBygId(ByVal qId As String)
        Using ctx As New DlmsDataContext
            Dim companyName As String
            companyName = (From q In ctx.QuotationProposals Where q.Q_ID = qId _
                           Select q.ContactCom).SingleOrDefault
            Return companyName
        End Using
    End Function

    Protected Sub UploadControl_FileUploadComplete(ByVal sender As Object, ByVal e As FileUploadCompleteEventArgs)
        Dim qFileId As Integer = GetNextQFileId()
        'Dim dateNow As DateTime = System.DateTime.Now
        If QuotationCode Is Nothing Then QuotationCode = Request.QueryString("qId")

        Dim uploadControl As ASPxUploadControl = TryCast(sender, ASPxUploadControl)
        If uploadControl.UploadedFiles IsNot Nothing AndAlso uploadControl.UploadedFiles.Length > 0 Then
            For i As Integer = 0 To uploadControl.UploadedFiles.Length - 1
                Dim file As UploadedFile = uploadControl.UploadedFiles(i)

                'Dim fileExtension = file.FileName.Split(".")
                If file.ContentLength > 0 Then
                    Dim path = UploadDirectory & QuotationCode
                    If Not IO.Directory.Exists(path) Then
                        IO.Directory.CreateDirectory(path)
                    End If
                    file.SaveAs(path & "\" & file.FileName)
                    Dim quotationFile As New QuotationFile
                    With quotationFile
                        .Q_ID = QuotationCode
                        .Q_FileID = qFileId
                        .Q_FileName = file.FileName
                        .Q_FileDate = Now
                    End With
                    Using ctx As New DlmsDataContext
                        ctx.QuotationFiles.InsertOnSubmit(quotationFile)
                        ctx.SubmitChanges()
                    End Using
                    'Response.Redirect("../Document/CreateQuotation.aspx?gId=" & QuotationCode)
                End If
            Next i
        End If
    End Sub

    Protected Sub Updatepanel1_Refresh(ByVal sender As Object, ByVal e As System.EventArgs)
        Response.Redirect("../Document/CreateQuotation.aspx?qId=" & QuotationCode)
    End Sub

    Public Sub GetFiles()
        Dim dt As New DataTable
        dt.Columns.Add("filename", GetType(String))
        dt.Columns.Add("link", GetType(String))

        Dim quotationList As List(Of QuotationFile)
        quotationList = GetQuotationFile(QuotationCode)

        Try
            Dim Path = UploadDirectory & QuotationCode
            If IO.Directory.Exists(Path) Then
                Dim dirs As New IO.DirectoryInfo(Path)
                For Each f As IO.FileInfo In dirs.GetFiles
                    Dim fname As String = f.Name
                    Dim fpath As String = "DownloadFile.aspx?FilePath=" & Web.HttpUtility.UrlEncode(Path & "\" & f.Name)
                    For Each i In quotationList
                        If i.Q_FileName = fname Then
                            dt.Rows.Add(fname, fpath)
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