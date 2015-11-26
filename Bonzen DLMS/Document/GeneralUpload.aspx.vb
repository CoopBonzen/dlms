Imports System.Data
Imports System.Data.SqlClient
Imports System.IO
Imports System.Web.Configuration
Imports DevExpress.Web.ASPxUploadControl

Public Class GeneralUpload
    Inherits System.Web.UI.Page

    Public Property GeneralCode() As String
        Get
            Return ViewState("GeneralCode")
        End Get
        Set(ByVal value As String)
            ViewState("GeneralCode") = value
        End Set
    End Property

    Public ReadOnly Property UploadDirectory() As String
        Get
            Return WebConfigurationManager.AppSettings("GeneralUploadFolder")
        End Get
    End Property

    'Private Const UploadDirectory As String = CStr(WebConfigurationManager.AppSettings("GeneralUploadFolder"))

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If String.IsNullOrEmpty(Session("Username")) Then Response.Redirect("~/Login.aspx")

        'Dim RequestId = Request.QueryString("gId")
        GeneralCode = Request.QueryString("gId")

        lbl_GNo.Text = GeneralCode
        lbl_GCompanyName.Text = GetCompanyBygId(GeneralCode)
        'gv_GFile.DataBind()
        'If Not IsPostBack Then
        '    GetFiles()
        'End If
        'Upload
        gv_GFile.DataBind()
        GetFiles()
    End Sub

    Public Function GetNextGFileId() As Integer
        Dim ctx As New DlmsDataContext
        Dim nextId As Integer = (From gf In ctx.GeneralFiles Select CType(gf.G_FileID, Integer?)).Max.GetValueOrDefault + 1
        Return nextId
    End Function

    Public Function GetCompanyBygId(ByVal gId As String)
        Using ctx As New DlmsDataContext
            Dim companyName As String
            companyName = (From g In ctx.Generals Where g.G_ID = gId _
                           Select g.ContactCom).SingleOrDefault
            Return companyName
        End Using
    End Function

    Protected Sub UploadControl_FileUploadComplete(ByVal sender As Object, ByVal e As FileUploadCompleteEventArgs)
        Dim gFileId As Integer = GetNextGFileId()
        'Dim dateNow As DateTime = System.DateTime.Now
        If GeneralCode Is Nothing Then GeneralCode = Request.QueryString("gId")

        Dim uploadControl As ASPxUploadControl = TryCast(sender, ASPxUploadControl)
        If uploadControl.UploadedFiles IsNot Nothing AndAlso uploadControl.UploadedFiles.Length > 0 Then
            For i As Integer = 0 To uploadControl.UploadedFiles.Length - 1
                Dim file As UploadedFile = uploadControl.UploadedFiles(i)

                'Dim fileExtension = file.FileName.Split(".")
                If file.ContentLength > 0 Then
                    Dim path = UploadDirectory & GeneralCode
                    If Not IO.Directory.Exists(path) Then
                        IO.Directory.CreateDirectory(path)
                    End If
                    file.SaveAs(path & "\" & file.FileName)
                    Dim generalFile As New GeneralFile
                    With generalFile
                        .G_ID = GeneralCode
                        .G_FileID = gFileId
                        .G_FileName = file.FileName
                        .G_FileDate = Now
                    End With
                    Using ctx As New DlmsDataContext
                        ctx.GeneralFiles.InsertOnSubmit(generalFile)
                        ctx.SubmitChanges()
                    End Using
                    'Response.Redirect("../Document/GeneralUpload.aspx?gId=" & GeneralCode)
                End If
            Next i
        End If
    End Sub

    Protected Sub Updatepanel1_Refresh(sender As Object, e As System.EventArgs)
        Response.Redirect("../Document/GeneralUpload.aspx?gId=" & GeneralCode)
    End Sub

    Public Sub GetFiles()
        Dim dt As New DataTable
        dt.Columns.Add("filename", GetType(String))
        dt.Columns.Add("link", GetType(String))

        Dim generalList As List(Of GeneralFile)
        generalList = GetGeneralFile(GeneralCode)

        Try
            Dim Path = UploadDirectory & GeneralCode
            If IO.Directory.Exists(Path) Then
                Dim dirs As New IO.DirectoryInfo(Path)
                For Each f As IO.FileInfo In dirs.GetFiles
                    Dim fname As String = f.Name
                    Dim fpath As String = "DownloadFile.aspx?FilePath=" & Web.HttpUtility.UrlEncode(Path & "\" & f.Name)
                    For Each i In generalList
                        If i.G_FileName = fname Then
                            dt.Rows.Add(fname, fpath)
                        End If
                    Next
                Next
            End If
        Catch ex As Exception
            dt.Clear()
        End Try
        gv_GFile.DataSource = dt
        gv_GFile.DataBind()
    End Sub

    Public Function GetGeneralFile(code As String) As List(Of GeneralFile)
        Using ctx = New DlmsDataContext
            Dim Generals = (From g In ctx.GeneralFiles Where g.G_ID = code).ToList
            Return Generals
        End Using
    End Function

End Class