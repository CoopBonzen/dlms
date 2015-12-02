Public Module ConstEnumModule

    ' สิทธิต่างๆ ที่ user สามารถทำได้
    Public Const PrivViewQPQ As String = "ViewQuotation/Proposal/General"

    Public Const PrivAddNewDocument As String = "AddNewDocument"

    Public Const PrivEditQuotation As String = "EditQuotation"
    Public Const PrivApproveQuotation As String = "ApproveQuotation"
    Public Const PrivDeleteFileQuotation As String = "DeleteFileQuotation"

    Public Const PrivUploadFileQuotation As String = "UploadFileQuotation"
    Public Const PrivUploadFileProposal As String = "UploadFileProposal"
    Public Const PrivUploadFileGeneral As String = "UploadFileGeneral"

    Public Const PrivManageUserAndUserGroup As String = "ManageUserAndUserGroup"

    'Public Const PrivBookingGeneral As String = "BookingGeneral"
    'Public Const PrivBookingQuotation As String = "BookingQuotation"
    'Public Const PrivDeleteQuotation As String = "DeleteQuotation"
    'Public Const PrivViewGeneral As String = "ViewGeneral"
    'Public Const PrivReverseQuotation As String = "ReverseQuotation"
    'Public Const PrivAddCompany As String = "AddCompany"
    'Public Const PrivEditCompany As String = "EditCompany"
    'Public Const PrivDeleteCompany As String = "DeleteCompany"
    'Public Const PrivManageQuotation As String = "ManageQuotationTemplate"
    'Public Const PrivAddDescription As String = "AddQuotationDescription"
    'Public Const PrivEditDescription As String = "EditQuotationDescription"
    'Public Const PrivDeleteDescription As String = "DeleteQuotationDescription"
    'Public Const PrivPrintQuotation As String = "PrintQuotation"

#Region "Privilege"
    Public Class PrivilegeInfo
        Private _name As String
        ''' <summary>
        ''' ชื่อสิทธิ
        ''' </summary>
        ''' <value></value>
        ''' <returns></returns>
        ''' <remarks></remarks>
        Public Property Name() As String
            Get
                Return _name
            End Get
            Set(ByVal value As String)
                _name = value
            End Set
        End Property

        Private _text As String
        ''' <summary>
        ''' ชื่อของสิทธิที่สามารถอ่านเข้าใจได้
        ''' </summary>
        ''' <value></value>
        ''' <returns></returns>
        ''' <remarks></remarks>
        Public Property Text() As String
            Get
                Return _text
            End Get
            Set(ByVal value As String)
                _text = value
            End Set
        End Property
    End Class

    Public UserPrivilege As New List(Of PrivilegeInfo)

    ''' <summary>
    ''' สร้างข้อมูลสำหรับรายการ Privilege ในระบบ
    ''' </summary>
    ''' <remarks></remarks>
    Public Sub CreatePrivilege()
        With UserPrivilege
            .Clear()
            .Add(New PrivilegeInfo With {.Name = PrivViewQPQ, .Text = "View Quotation/Proposal/General"})

            .Add(New PrivilegeInfo With {.Name = PrivAddNewDocument, .Text = "Add New Document"})

            .Add(New PrivilegeInfo With {.Name = PrivEditQuotation, .Text = "Add/Update Quotation"})
            .Add(New PrivilegeInfo With {.Name = PrivApproveQuotation, .Text = "Approve Quotation"})
            .Add(New PrivilegeInfo With {.Name = PrivDeleteFileQuotation, .Text = "Delete File Quotation"})

            .Add(New PrivilegeInfo With {.Name = PrivUploadFileQuotation, .Text = "Upload File Quotation"})
            .Add(New PrivilegeInfo With {.Name = PrivUploadFileProposal, .Text = "Upload File Proposal"})
            .Add(New PrivilegeInfo With {.Name = PrivUploadFileGeneral, .Text = "Upload File General"})

            .Add(New PrivilegeInfo With {.Name = PrivManageUserAndUserGroup, .Text = "ManageUser And UserGroup"})

            '.Add(New PrivilegeInfo With {.Name = PrivViewGeneral, .Text = "View General"})
            '.Add(New PrivilegeInfo With {.Name = PrivBookingGeneral, .Text = "Booking General"})
            '.Add(New PrivilegeInfo With {.Name = PrivBookingQuotation, .Text = "Booking Quotation"})
            '.Add(New PrivilegeInfo With {.Name = PrivDeleteQuotation, .Text = "Delete Quotation"})
            '.Add(New PrivilegeInfo With {.Name = PrivAddCompany, .Text = "Add Company"})
            '.Add(New PrivilegeInfo With {.Name = PrivEditCompany, .Text = "Edit Company"})
            '.Add(New PrivilegeInfo With {.Name = PrivDeleteCompany, .Text = "Delete Company"})
            '.Add(New PrivilegeInfo With {.Name = PrivReverseQuotation, .Text = "Reverse Quotation"})

            '.Add(New PrivilegeInfo With {.Name = PrivManageQuotation, .Text = "Manage Quotation Template"})
            '.Add(New PrivilegeInfo With {.Name = PrivAddDescription, .Text = "Add Quotation Description"})
            '.Add(New PrivilegeInfo With {.Name = PrivEditDescription, .Text = "Edit Quotation Description"})
            '.Add(New PrivilegeInfo With {.Name = PrivDeleteDescription, .Text = "Delete Quotation Description"})
        End With
    End Sub
#End Region

    Public Function IsUserRole(ByVal user As String, ByVal role As String) As Boolean
        Dim ctx As New DlmsDataContext
        'Dim UserId = (From u In ctx.Users Where u.user_id = User).SingleOrDefault
        Dim UserRole = (From u In ctx.Users _
                     Join ug In ctx.UserGroups On u.user_group_id Equals ug.user_group_id
                     Join gr In ctx.UserGroupRoles On ug.user_group_id Equals gr.user_group_id
                     Where u.user_name = user And gr.role_name.ToLower = role.ToLower).SingleOrDefault
        If UserRole IsNot Nothing Then
            Return True
        Else
            Return False
        End If
    End Function

End Module
