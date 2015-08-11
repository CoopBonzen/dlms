Imports System.Data.SqlClient
Imports System.Globalization

'Imports Bonzen_DLMS.DataAccessModule

Public Class AddNewDocument
    Inherits System.Web.UI.UserControl

    Private _dataaccess As New DataAccessModule
    Public Property DataAccess() As DataAccessModule
        Get
            Return _dataaccess
        End Get
        Set(ByVal value As DataAccessModule)
            _dataaccess = value
        End Set
    End Property

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If String.IsNullOrEmpty(Session("Username")) Then Response.Redirect("~/Login.aspx")
        cmb_DocumentType.JSProperties("cpRunNo") = String.Empty
        cb_PopupInit.JSProperties("cpRefreshData") = False
    End Sub

#Region "Gen Id"
    Public Function FindNextQRunningNo(ByVal ctx As DlmsDataContext)
        Dim qRunningNo As Integer
        qRunningNo = (From q In ctx.QuotationProposals Where CDate(q.Q_CreateDate).Year = Now.Year
                      Select CType(q.Q_RunningNo, Integer?)).Max.GetValueOrDefault + 1
        Return qRunningNo
    End Function

    'Public Function FindNextPRunningNo(ByVal ctx As DlmsDataContext)
    '    Dim pRunningNo As Integer
    '    pRunningNo = (From p In ctx.ProposalFiles Join q In ctx.QuotationProposals _
    '                  On p.P_ID Equals q.P_ID Where CDate(q.Q_CreateDate).Year = Now.Year _
    '                  Select CType(p.P_RunningNo, Integer?)).Max.GetValueOrDefault + 1
    '    Return pRunningNo
    'End Function

    Public Function FindNextPIDForQuotationProposal() As String
        Using ctx As New DlmsDataContext
            Dim maxPID As String = (From p In ctx.QuotationProposals Where p.Q_CreateDate.Year = Now.Year Select p.P_ID).Max
            Dim nexPNo As Integer = 1
            If Not String.IsNullOrWhiteSpace(maxPID) Then
                nexPNo = CInt(maxPID.Replace("BZ-P" & (Now.Year Mod 100), "")) + 1
            End If
            Dim nextPID As String = "BZ-P" & (Now.Year Mod 100) & nexPNo.ToString("D3")
            Return nextPID
        End Using
    End Function

    Public Function FindNextGRunningNo(ByVal ctx As DlmsDataContext)
        Dim gRunningNo As Integer
        gRunningNo = (From g In ctx.Generals Where CDate(g.G_CreateDate).Year = Now.Year
                      Select CType(g.G_RunningNo, Integer?)).Max.GetValueOrDefault + 1
        Return gRunningNo
    End Function
#End Region

    Private Sub cmb_DocumentType_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles cmb_DocumentType.SelectedIndexChanged

    End Sub

    Private Sub cb_PopupInit_Callback(ByVal source As Object, ByVal e As DevExpress.Web.ASPxCallback.CallbackEventArgs) Handles cb_PopupInit.Callback
        Dim ctx As New DlmsDataContext
        Dim genQId As String = String.Empty
        Dim genPId As String = String.Empty
        Dim genGId As String = String.Empty
        If cmb_DocumentType.Value = "quotation" Then
            genQId = "Q" & CStr(Now.Year).Substring(2, 2) & CStr(FindNextQRunningNo(ctx)).PadLeft(3, "0")
            cb_PopupInit.JSProperties("cpRunNo") = genQId
            cb_PopupInit.JSProperties("cpQName") = Session("UserFullname")
        ElseIf cmb_DocumentType.Value = "proposal" Then
            'genPId = "BZ-P" & CStr(Now.Year).Substring(2, 2) & CStr(FindNextPRunningNo(ctx)).PadLeft(3, "0")
            genPId = FindNextPIDForQuotationProposal()
            cb_PopupInit.JSProperties("cpRunNo") = genPId
        ElseIf cmb_DocumentType.Value = "general" Then
            genGId = "BZ-G" & CStr(Now.Year).Substring(2, 2) & CStr(FindNextGRunningNo(ctx)).PadLeft(3, "0")
            cb_PopupInit.JSProperties("cpRunNo") = genGId
            cb_PopupInit.JSProperties("cpGName") = Session("UserFullname")
        End If

        Select Case CStr(e.Parameter)
            Case "ClickBtnQ_Ok"
                CreateQuotation(genQId)
                cb_PopupInit.JSProperties("cpRefreshData") = True
            Case "ClickBtnP_Ok"
                Dim QIdFromCbb As String = String.Empty
                QIdFromCbb = cbb_QId.SelectedItem.Value
                AddProposalNumber(QIdFromCbb, genPId)
                'CreateProposalFile(QIdFromCbb, genPId)
                cb_PopupInit.JSProperties("cpRefreshData") = True
            Case "ClickBtnG_Ok"
                CreateGeneral(genGId)
                cb_PopupInit.JSProperties("cpRefreshData") = True
        End Select
    End Sub

    Public Sub CreateQuotation(ByVal QId As String)
        Using ctx As New DlmsDataContext
            Dim q As New QuotationProposal
            'Dim qDate As Date
            'Dim strDate As String = Q_Date.Text.Trim
            'qDate = Date.Parse(strDate, New CultureInfo("th-TH"))
            'strDate = qDate.ToString(New CultureInfo("th-TH"))
            With q
                .Q_ID = QId
                .Title = txtb_QTitle.Text.Trim
                .Q_Date = Q_Date.Text.Trim
                .BookingBy = Session("UserFullname")
                .Q_CreateDate = Now
                .Q_RunningNo = FindNextQRunningNo(ctx)
            End With
            Dim newQId As String = DataAccess.InsertQuotation(q)
        End Using
    End Sub

    Public Sub CreateGeneral(ByVal GId As String)
        Using ctx As New DlmsDataContext
            Dim g As New General
            With g
                .G_ID = GId
                .ContactCom = cmb_company.Value
                .ContactName = cmb_attn.Value
                .Title = txtb_GTitle.Text.Trim
                .G_Date = G_Date.Text.Trim
                .BookingBy = Session("UserFullname")
                .G_CreateDate = Now
                .G_RunningNo = FindNextGRunningNo(ctx)
            End With
            Dim newGId As String = DataAccess.InsertGeneral(g)
        End Using
    End Sub

    Public Sub AddProposalNumber(ByVal QId As String, ByVal PId As String)
        Using ctx As New DlmsDataContext
            Dim q As New QuotationProposal
            q.Q_ID = QId
            q.P_ID = PId
            DataAccess.UpdateQuotation(q)
        End Using
    End Sub

    'Public Sub CreateProposalFile(ByVal QId As String, ByVal PId As String)
    '    Using ctx As New DlmsDataContext
    '        Dim p As New ProposalFile
    '        With p
    '            '.P_ID = PId
    '            .P_RunningNo = FindNextPRunningNo(ctx)
    '        End With
    '        DataAccess.InsertProposalFile(QId, p)
    '        AddProposalNumber(QId, PId)
    '    End Using
    'End Sub

    'Public Sub CreateGeneralFile(ByVal QId As String, ByVal PId As String)
    '    Using ctx As New DlmsDataContext
    '        Dim g As New GeneralFile
    '        With g
    '            .G_ID = GId
    '            .P_RunningNo = FindNextPRunningNo(ctx)
    '        End With
    '        DataAccess.InsertProposalFile(p)
    '        AddProposalNumber(QId, PId)
    '    End Using
    'End Sub

    Private Sub cmb_attn_Callback(ByVal sender As Object, ByVal e As DevExpress.Web.ASPxClasses.CallbackEventArgsBase) Handles cmb_attn.Callback
        cmb_attn.DataBind()
    End Sub
End Class