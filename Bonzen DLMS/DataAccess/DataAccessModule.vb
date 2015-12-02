Public Class DataAccessModule

    Public Function Authenticate(ByVal username As String, ByVal password As String) As User
        Dim user As New User
        Using ctx = New DlmsDataContext
            user = (From u In ctx.Users Where u.user_name.ToLower = username.ToLower _
                    And u.password = password).SingleOrDefault
        End Using
        Return user
    End Function

    Public Function GetUserByUsername(ByVal username As String) As User
        Dim user As New User
        Using ctx = New DlmsDataContext
            user = (From u In ctx.Users Where u.user_name.ToLower = username.ToLower).SingleOrDefault
        End Using
        Return user
    End Function


    Public Function InsertQuotation(ByVal NewQ As QuotationProposal)
        Using ctx As New DlmsDataContext
            If ctx.Connection.State = ConnectionState.Closed Then ctx.Connection.Open()
            Try
                Dim NewQId = NewQ.Q_ID
                With NewQ
                    .Q_ID = NewQId
                    .Title = NewQ.Title
                    .Q_Date = NewQ.Q_Date
                    .BookingBy = NewQ.BookingBy
                    .Q_CreateDate = NewQ.Q_CreateDate
                    .Q_RunningNo = NewQ.Q_RunningNo
                End With
                ctx.QuotationProposals.InsertOnSubmit(NewQ)
                ctx.SubmitChanges()
                Return NewQId

            Catch ex As Exception
                Throw New Exception("Error while create new quotation.")
            End Try
        End Using
    End Function

    Public Sub UpdateQuotation(ByVal UpdateQ As QuotationProposal)
        Using ctx As New DlmsDataContext
            If ctx.Connection.State = ConnectionState.Closed Then ctx.Connection.Open()
            Try
                Dim currentQId = UpdateQ.Q_ID
                Dim selectQId = (From q In ctx.QuotationProposals Where q.Q_ID = currentQId).SingleOrDefault
                If selectQId IsNot Nothing Then
                    selectQId.P_ID = UpdateQ.P_ID
                End If
                ctx.SubmitChanges()
            Catch ex As Exception
                Throw New Exception("Error while update proposal number in table quotation.")
            End Try
        End Using
    End Sub

    Public Sub InsertProposalFile(ByVal NewP As ProposalFile)
        Using ctx As New DlmsDataContext
            If ctx.Connection.State = ConnectionState.Closed Then ctx.Connection.Open()
            Try
                Dim NewPId = NewP.P_ID
                With NewP
                    .P_ID = NewPId
                    '.P_RunningNo = NewP.P_RunningNo
                End With
                ctx.ProposalFiles.InsertOnSubmit(NewP)
                ctx.SubmitChanges()
                'Return NewPId
            Catch ex As Exception
                Throw New Exception("Error while create proposal file.")
            End Try
        End Using
    End Sub

    Public Function InsertGeneral(ByVal NewG As General)
        Using ctx As New DlmsDataContext
            If ctx.Connection.State = ConnectionState.Closed Then ctx.Connection.Open()
            Try
                Dim NewGId = NewG.G_ID
                With NewG
                    .G_ID = NewGId
                    .Title = NewG.Title
                    .G_Date = NewG.G_Date
                    .BookingBy = NewG.BookingBy
                    .G_CreateDate = NewG.G_CreateDate
                    .G_RunningNo = NewG.G_RunningNo
                End With
                ctx.Generals.InsertOnSubmit(NewG)
                ctx.SubmitChanges()
                Return NewGId
            Catch ex As Exception
                Throw New Exception("Error while create new general.")
            End Try
        End Using
    End Function


    Public Function getQuotation(ByVal QID As String) As Quotation
        Using ctx As New DlmsDataContext
            Return (From r In ctx.Quotations Where r.quotation_no = QID).SingleOrDefault
        End Using
    End Function

    'Public Sub UpdateGeneral(ByVal UpdateG As General)
    '    Using ctx As New DlmsDataContext
    '        If ctx.Connection.State = ConnectionState.Closed Then ctx.Connection.Open()
    '        Try
    '            Dim currentGId = UpdateG.G_ID
    '            Dim selectGId = (From g In ctx.QuotationProposals Where g.G_ID = currentGId).SingleOrDefault
    '            If selectGId IsNot Nothing Then
    '                selectGId.P_ID = UpdateG.P_ID
    '            End If
    '            ctx.SubmitChanges()
    '        Catch ex As Exception
    '            Throw New Exception("Error while update proposal number in table quotation.")
    '        End Try
    '    End Using
    'End Sub

End Class