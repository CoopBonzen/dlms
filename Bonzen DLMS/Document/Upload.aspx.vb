Imports System.Data
Imports System.Data.SqlClient
Imports DevExpress.Web.ASPxUploadControl
Imports System.IO
Imports System.Web.Configuration

Public Class About
    Inherits System.Web.UI.Page

    Private Const UploadDirectory As String = "D:\ContractFile\"

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub

    Protected Sub UploadControl_FileUploadComplete(ByVal sender As Object, ByVal e As FileUploadCompleteEventArgs)
        Dim contractId As Integer = 50 'test

        Dim uploadControl As ASPxUploadControl = TryCast(sender, ASPxUploadControl)
        If uploadControl.UploadedFiles IsNot Nothing AndAlso uploadControl.UploadedFiles.Length > 0 Then
            For i As Integer = 0 To uploadControl.UploadedFiles.Length - 1
                Dim file As UploadedFile = uploadControl.UploadedFiles(i)
                If file.FileName <> "" Then
                    file.SaveAs(UploadDirectory + file.FileName)

                    Dim objConn As New SqlConnection
                    Dim objCmd As New SqlCommand
                    Dim strConnString, strSQL As String
                    strConnString = WebConfigurationManager.ConnectionStrings("dlms_dbConnectionString").ConnectionString
                    objConn.ConnectionString = strConnString
                    objConn.Open()

                    'strSQL = "INSERT INTO ContractFile (contract_id,cFile_name) VALUES ('" & Request.QueryString("contract_id") & "','" & file.FileName & "')"
                    strSQL = "INSERT INTO ContractFile (contract_id, cFile_name) VALUES ('" & contractId & "','" & file.FileName & "')"
                    With objCmd
                        .Connection = objConn
                        .CommandText = strSQL
                        .CommandType = CommandType.Text
                    End With

                    Try
                        objCmd.ExecuteNonQuery()
                    Catch ex As Exception
                        e.ErrorText = "Record can not insert Error (" & ex.Message & ")"
                    End Try
                    objConn.Close()
                    objConn = Nothing
                End If
            Next i
        End If
    End Sub
End Class