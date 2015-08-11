Imports System.Data.SqlClient
Imports System.IO.StreamReader
Imports Microsoft.Reporting.WebForms

Public Class Report
    Inherits System.Web.UI.Page

    'Public ReadOnly Property ConnString() As String
    '    Get
    '        Return Web.Configuration.WebConfigurationManager.ConnectionStrings("DLMSConnectionString").ConnectionString
    '    End Get
    'End Property

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If String.IsNullOrEmpty(Session("Username")) Then Response.Redirect("~/Login.aspx")
        'If Not IsPostBack Then
        '    Dim QuotaID As Integer = CInt(Request.QueryString("quotaId"))
        '    Session("QuotaID") = QuotaID
        'End If

        'Dim QuotaID As Integer = 2
        'GetData_PCM3(QuotaID)
        'ApplyReport()
    End Sub


    Private Sub sds_report_Init(sender As Object, e As System.EventArgs) Handles sds_report.Init
        If Not IsPostBack Then
            Dim QuotaID As Integer = CInt(Request.QueryString("quotaId"))
            Session("QuotaID") = QuotaID
        End If
        'sds_report.ConnectionString = Web.Configuration.WebConfigurationManager.ConnectionStrings("DLMSConnectionString").ConnectionString
        'Dim Sql = "SELECT     q.Quota_ID, q.company_name, q.attn, q.tel, q.fax, q.email, q.quotation_no, q.quotation_date, q.quotation_from, q.bonzen_tel, q.bonzen_email, q.total_amount, " & _
        '            "qi.QItem_ID, qi.ID_Q_Detail_Sub, qi.price, qi.unit, qi.amount, qds.Q_Detail_Sub,qd.ID_Q_Detail_Main, qd.Q_Detail_Main " & _
        '            "FROM         Quotation AS q " & _
        '            " INNER JOIN  QuotationItem AS qi ON q.Quota_ID = qi.Quota_ID " & _
        '            " left outer JOIN  QuotationDescriptionSub AS qds ON qi.ID_Q_Detail_Sub = qds.ID_Q_Detail_Sub " & _
        '            " left outer JOIN  QuotationDescription AS qd ON qds.ID_Q_Detail_Main = qd.ID_Q_Detail_Main " & _
        '            " where q.Quota_ID = " & 1 & _
        '            " Order By qd.ID_Q_Detail_main asc "
        Dim Sql = " 	;With QuotData As (				 " & _
                    " 		Select q.*, qi.QItem_ID, qi.ID_Q_Detail_Sub, qi.price, qi.unit, qi.amount, 			 " & _
                    " 			   qds.Q_Detail_Sub, qd.ID_Q_Detail_main, qd.Q_Detail_Main		 " & _
                    " 		From Quotation q			 " & _
                    " 		Left Join QuotationItem qi On qi.Quota_ID = q.Quota_ID			 " & _
                    " 		Left Join QuotationDescriptionSub qds ON qds.ID_Q_Detail_Sub = qi.ID_Q_Detail_Sub			 " & _
                    " 		Left Join QuotationDescription qd On qd.ID_Q_Detail_Main = qds.ID_Q_Detail_Main			 " & _
                    " 		Where q.Quota_ID =" & CInt(Session("QuotaID")) & ")" & _
                    " 	Select row_group_no, qd.*				 " & _
                    " 	From (Select ROW_NUMBER() Over (Order By ID_Q_Detail_main) row_group_no, ID_Q_Detail_main				 " & _
                    " 		  From QuotData			 " & _
                    " 		  Group By ID_Q_Detail_main			 " & _
                    " 		 ) qdrnum			 " & _
                    " 	Left Join QuotData qd On qd.ID_Q_Detail_main = qdrnum.ID_Q_Detail_main				 "

        sds_report.SelectCommand = Sql
    End Sub
End Class

