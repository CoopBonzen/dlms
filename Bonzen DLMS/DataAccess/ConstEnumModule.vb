Public Module ConstEnumModule

    ' สิทธิต่างๆ ที่ user สามารถทำได้
    Public Const PrivViewQuotation As String = "ViewQuotation"
    Public Const PrivCreateQuotation As String = "CreateQuotation"
    Public Const PrivEditQuotation As String = "EditQuotation"
    Public Const PrivReverseQuotation As String = "ReverseQuotation"
    Public Const PrivDeleteQuotation As String = "DeleteQuotation"
    Public Const PrivPrintQuotation As String = "PrintQuotation"
    Public Const PrivBookingQuotation As String = "BookingQuotation"
    Public Const PrivUploadFileProposal As String = "UploadFileProposal"
    Public Const PrivViewGeneral As String = "ViewGeneral"
    Public Const PrivBookingGeneral As String = "BookingGeneral"
    Public Const PrivUploadFileGeneral As String = "UploadFileGeneral"
    Public Const PrivAddCompany As String = "AddCompany"
    Public Const PrivEditCompany As String = "EditCompany"
    Public Const PrivDeleteCompany As String = "DeleteCompany"
    Public Const PrivManageUserAndUserGroup As String = "ManageUserAndUserGroup"
    Public Const PrivManageQuotation As String = "ManageQuotationTemplate"
    Public Const PrivAddDescription As String = "AddQuotationDescription"
    Public Const PrivEditDescription As String = "EditQuotationDescription"
    Public Const PrivDeleteDescription As String = "DeleteQuotationDescription"


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
            .Add(New PrivilegeInfo With {.Name = PrivViewQuotation, .Text = "View Quotation/Proposal"})
            .Add(New PrivilegeInfo With {.Name = PrivCreateQuotation, .Text = "Create Quotation"})
            .Add(New PrivilegeInfo With {.Name = PrivEditQuotation, .Text = "Edit Quotation"})
            .Add(New PrivilegeInfo With {.Name = PrivReverseQuotation, .Text = "Reverse Quotation"})
            .Add(New PrivilegeInfo With {.Name = PrivDeleteQuotation, .Text = "Delete Quotation"})
            .Add(New PrivilegeInfo With {.Name = PrivPrintQuotation, .Text = "Print Quotation"})
            .Add(New PrivilegeInfo With {.Name = PrivBookingQuotation, .Text = "Booking Quotation"})

            .Add(New PrivilegeInfo With {.Name = PrivUploadFileProposal, .Text = "Upload File Proposal"})
            .Add(New PrivilegeInfo With {.Name = PrivViewGeneral, .Text = "View General"})
            .Add(New PrivilegeInfo With {.Name = PrivBookingGeneral, .Text = "Booking General"})
            .Add(New PrivilegeInfo With {.Name = PrivUploadFileGeneral, .Text = "Upload File General"})

            .Add(New PrivilegeInfo With {.Name = PrivAddCompany, .Text = "Add Company"})
            .Add(New PrivilegeInfo With {.Name = PrivEditCompany, .Text = "Edit Company"})
            .Add(New PrivilegeInfo With {.Name = PrivDeleteCompany, .Text = "Delete Company"})

            .Add(New PrivilegeInfo With {.Name = PrivManageUserAndUserGroup, .Text = "ManageUser And UserGroup"})
            .Add(New PrivilegeInfo With {.Name = PrivManageQuotation, .Text = "Manage Quotation Template"})
            .Add(New PrivilegeInfo With {.Name = PrivAddDescription, .Text = "Add Quotation Description"})
            .Add(New PrivilegeInfo With {.Name = PrivEditDescription, .Text = "Edit Quotation Description"})
            .Add(New PrivilegeInfo With {.Name = PrivDeleteDescription, .Text = "Delete Quotation Description"})
        End With
    End Sub
#End Region

End Module
