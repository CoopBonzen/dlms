Imports System.IO

Public Class DownloadFile
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Dim fname As String = Request.QueryString("FilePath")
        'Dim FullPath As String = Server.UrlDecode(fname)

        If IO.File.Exists(fname) Then
            Dim stm As New FileStream(fname, IO.FileMode.Open)
            Dim buf(stm.Length) As Byte
            Try : stm.Read(buf, 0, stm.Length)
            Finally : stm.Close()
            End Try

            Dim f As New FileInfo(fname)
            Dim FileContentType As String = FileFunction.GetMimeType(fname)

            Response.ContentType = FileContentType

            'Response.AddHeader("Content-Disposition", "attachment;filename=" & f.Name)
            Response.AddHeader("Content-Disposition", "attachment;filename=" & Server.UrlEncode(f.Name))
            Response.BinaryWrite(buf)
        End If
        Response.Flush()
        Response.End()
    End Sub

End Class