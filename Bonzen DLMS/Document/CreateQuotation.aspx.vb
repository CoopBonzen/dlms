Imports System.Data
Imports System.Data.DataTable
Imports System.Data.SqlClient
Imports DevExpress.Web.ASPxClasses
Imports DevExpress.Web.ASPxEditors
Imports DevExpress.Web.ASPxGridView
Imports DevExpress.Web.ASPxUploadControl
Imports System.IO
Imports System.Web.Configuration



Public Class CreateQuotation
    Inherits System.Web.UI.Page

    'เพิ่มUpload'
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

    'ของเก่า'
    Private ReadOnly Property SelectedDetailIDList() As List(Of Integer)
        Get
            Dim idList As New List(Of Integer)
            'If Not String.IsNullOrWhiteSpace(txt_selectedsub.Text) Then
            '    Dim strIDList As List(Of String) = txt_selectedsub.Text.Split(",").ToList
            '    idList = (From strId In strIDList Select CInt(strId)).ToList
            'End If
            Return idList
        End Get
    End Property
    ''
    Private ReadOnly Property strAddedDetailSubList() As List(Of String)
        Get
            Dim subDataList As New List(Of String)
            'If Not String.IsNullOrWhiteSpace(txt_subData.Text) Then
            '    subDataList = txt_subData.Text.Split(";").ToList
            'End If
            Return subDataList
        End Get
    End Property

    Private ReadOnly Property AddedDetailIDList() As List(Of Integer)
        Get
            Dim subIDList As New List(Of Integer)

            'If Not String.IsNullOrWhiteSpace(txt_subData.Text) Then
            '    Dim subDataList As List(Of String) = strAddedDetailSubList
            '    For i As Integer = 0 To subDataList.Count - 1
            '        Dim subData As String() = subDataList(i).Split("|")
            '        Dim subId As Integer = CInt(subData(0))
            '        subIDList.Add(subId)
            '    Next
            'End If
            Return subIDList
        End Get
    End Property

    Public Property QuotationID() As Integer
        Get
            Return ViewState("Quotation_ID")
        End Get
        Set(ByVal value As Integer)
            ViewState("Quotation_ID") = value
        End Set
    End Property


    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If String.IsNullOrEmpty(Session("Username")) Then Response.Redirect("~/Login.aspx")
        Dim RequestQId = Request.QueryString("qId")
        'txt_subData.Text = ""

        'ของเก่า'
        'gv_addmodule.JSProperties("cpStrAllSubData") = String.Empty
        If (Not IsCallback) Then
            FillSubQuotationCombo("1")
            FillAttnCombo(Session("Company_ID"))
        End If
        If Not IsPostBack Then
            'SetDefaultRemark()
            'SetDefaultCondition()
            AddDataInForm(RequestQId)
        End If

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
        Response.Redirect("../Document/CreateQuotation.aspx?gId=" & QuotationCode)
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

    'Public Sub SetDefaultRemark()
    '    memo_remark.Text = "1.  กำหนดยื่นราคา 30 วัน " & vbCrLf & _
    '                    "2.  การเสนอราคาข้างต้นสาหรับการใช้งานที่อาคารภายใต้การบริหารของ_____________จำนวน ____ อาคาร " & vbCrLf & _
    '                    "3.  เงื่อนไขการชำระเงิน" & vbCrLf & _
    '                    "      3.1 ส่วนของค่า Software License : ชำระทั้งหมดภายหลังติดตั้ง โดยส่งมอบสินค้าภายใน 7 วันหลังจากได้รับใบสั่งซื้อ(ไม่รวมส่วนที่เพิ่มเติมหรือส่วน Implement) " & vbCrLf & _
    '                    "      3.2 ส่วนของค่าบริการ Implement : ชำระหลังจาก Implement เสร็จสิ้นและเปิดให้ใช้งาน " & vbCrLf & _
    '                    "      3.3 ส่วนของค่าปรับปรุงระบบเพิ่มเติม : ชำระหลังจากปรับปรุงระบบเสร็จสิ้นและเปิดให้ใช้งาน " & vbCrLf & _
    '                    "      3.4 ส่วนของค่าบริการ MA : ชำระเมื่อเริ่มต้นใช้บริการในปีถัดไป " & vbCrLf & _
    '                    "4.  ระยะเวลาในการ Implement ประมาณ 2 เดือน " & vbCrLf & _
    '                    "5.  การเสนอราคารวมการฝึกอบรมการใช้งาน 1 ครั้ง/อาคาร ไม่จำกัดจำนวนผู้ฟัง " & vbCrLf & _
    '                    "6.  การเสนอราคา รวมการบริการ MA ฟรี สำหรับปีแรกที่ใช้บริการ " & vbCrLf & _
    '                    "7.  ในกรณีผลิตภัณฑ์ได้รับการพัฒนาเวอร์ชันใหม่ ตลอดช่วงเวลาการใช้บริการนับจากวันที่ส่งสินค้า ผู้ซื้อมีสิทธิ์ในการรับการ Upgrade ระบบฟรีโดยไม่มีค่าใช้จ่ายลิขสิทธิ์"
    'End Sub

    'Public Sub SetDefaultCondition()
    '    memo_condition.Text = "1.   ผู้ซื้อเป็นผู้จัดเตรียมอปุกรณ์ hardware และ software พื้นฐานเอง โดยบริษัท บนเส้น จำกัด ให้คำแนะนำในการเลือกคุณลักษณะขั้นต่ำทางด้าน hardware และ software" & vbCrLf & _
    '                        "      พื้นฐานที่เกี่ยวข้อง, กรณีเลือกบริการแบบโฮสติ้งผู้ซื้อจัดเตรียม internet connection เพื่อเชื่อมต่อมายังโฮสต์ที่บริษัท บนเส้น จัดเตรียมให้" & vbCrLf & _
    '                        "2.   บริษัท บนเส้น จำกัด จะจัดให้มีการฝึกอบรมการใช้งานสำหรับบุคลากรของผู้ซื้อโดยไม่คิดค่าใช้จ่ายจำนวน 1 ครั้ง /1 ปี หากผู้ซื้อต้องการให้มีการฝึกอบรมเพิ่มเติม" & vbCrLf & _
    '                        "      บริษัท บนเส้น จำกัด อาจเรียกค่าใช้จ่ายเพิ่มได้ตามความจำเป็น" & vbCrLf & _
    '                        "3.   ลิขสิทธิ์ : ลิขสิทธิ์ในผลิตภัณฑ์ซอฟต์แวร์และเอกสารคู่มือทั้งหมด (รวมแผนภาพ ภาพถ่าย ภาพเคลื่อนไหว ที่เป็นส่วนหนึ่งอยู่ในผลิตภัณฑ์ซอฟต์แวร์) เป็นสิทธิ์ของ" & vbCrLf & _
    '                        "      บริษัท บนเส้น จำกัด ซึ่งได้รับความคุ้มครองตามกฎหมาย ห้ามดัดแปลง แก้ไข หรือลบเครื่องหมายผลิตภัณฑ์ ชื่อผู้ผลิต คำประกาศสิทธิ์ หรือข้อกำหนดการใช้งาน" & vbCrLf & _
    '                        "      ออกจากผลิตภัณฑ์ซอฟต์แวร์นี้" & vbCrLf & _
    '                        "4.   การอนุญาตใช้งานซอฟต์แวร์ : บริษัท บนเส้น จำกัด อนุญาตให้ผู้ซื้อมีสิทธิ์การใช้งานดังต่อไปนี้" & vbCrLf & _
    '                        "      4.1   การใช้งาน – ผู้ซื้อสามารถใช้งานซอฟต์แวร์บนเครื่องคอมพิวเตอร์เดี่ยวที่ติดตั้ง ซอฟต์แวร์นี้ยกเว้นกรณีที่ผลิตภัณฑ์เป็นแบบใช้งานผ่านอินเตอร์เน็ต จึงสามารถใช้งาน" & vbCrLf & _
    '                        "              บนเครื่องอื่นได้ ผู้ซื้อไม่สามารถติดตั้งซอฟต์แวร์เพิ่มเติมบนเครื่องคอมพิวเตอร์อื่นเพื่อใช้งานมากกว่า 1 เครื่องได้" & vbCrLf & _
    '                        "      4.2   สิทธิ์ – ผู้ซื้อ ได้รับสิทธิ์ในการใช้งานซอฟต์แวร์ตามข้อตกลงกับบริษัท บนเส้น จากัด โดยไม่สามารถจำหน่ายจ่ายโอนสิทธิ์นี้แก่ผู้อื่น รวมถึงไม่สามารถนำไปปล่อยเช่า" & vbCrLf & _
    '                        "              หรือนำไปแสวงหาประโยชน์อื่นใดโดยไม่ได้รับอนุญาตจากบริษัท บนเส้น" & vbCrLf &
    '                        "      4.3   การอัพเกรด – ผู้ซื้อมีสิทธิ์ได้รับการอัพเกรดซอฟต์แวร์ตัวใหม่ล่าสุดของผลิตภัณฑ์ซอฟต์แวร์ ตลอดระยะเวลาการใช้บริการ ทั้งนี้การ Upgrade ไม่รวมการ" & vbCrLf & _
    '                        "              ติดตั้งหรืออบรมเพิ่มเติม" & vbCrLf &
    '                        "5.   Product Support : บริษัท บนเส้น จำกัด มีบริการสนับสนุนการใช้งานผลิตภัณฑ์ซอฟต์แวร์ ดังนี้" & vbCrLf & _
    '                        "      5.1   การให้บริการทางโทรศัพท์ – ติดต่อ Technical Support Center ได้ ที่หมายเลขโทรศัพท์ 0-2642-6201 ในวันจันทร์-ศุกร์ ตั้งแต่เวลา 9:00 – 17:00 น. " & vbCrLf & _
    '                        "              โดยไม่เสียค่าใช้จ่าย (Hotline: 090-665-1743) หรือทางอีเมล์ support@bonzen.co.th" & vbCrLf & _
    '                        "      5.2   กรณีที่ต้องการให้บริษัทฯ เข้าไปให้บริการที่หน่วยงานเพิ่มเติมซึ่ง มิได้อยู่ในขอบเขตการรับประกัน (เช่นการแก้ปัญหาฮาร์ดแวร์ ไวรัส ปัญหาระบบเครือข่ายฯลฯ) " & vbCrLf & _
    '                        "              บริษัทฯ จะคิดค่าบริการ On-site Service Call ครั้ง ละ 7,000 บาท/วัน การจัดฝึกอบรมเพิ่มเติมคิดค่าใช้จ่ายครั้ง ละ 20,000 บาท/วัน" & vbCrLf & _
    '                        "      5.3   ผู้ใช้บริการสามารถตรวจสอบข่าวสารและสถานะของผลิตภัณฑ์ผ่านเว็บไซต์ http://www.genedia.in.th หรือรับฟังข่าวสารได้จากอีเมล์" & vbCrLf & _
    '                        "6.   รายละเอียดบริการ Implementation" & vbCrLf & _
    '                        "      6.1   บริษัท บนเส้น จำกัด จะเตรียมแบบฟอร์มตารางข้อมูลพื้นฐานที่จะนำเข้าระบบให้ผู้ซื้อกรอกข้อมูล" & vbCrLf & _
    '                        "      6.2   ผู้ซื้อเป็นผู้จัดเตรียมเนื้อหาของข้อมูลพื้นฐานที่ใช้ในการนำเข้าระบบให้แก่บริษัท บนเส้น จำกัด โดยส่งมอบพร้อมกันในคราวเดียวหรือมีกำหนดเวลาที่แน่นอน" & vbCrLf & _
    '                        "      6.3   การ Implementation ดำเนินการให้ 1 ครั้ง ในการติดตั้งระบบครั้งแรก หากต้องการให้ Implementation เพิ่มเติมหรือติดตั้ง ใหม่ บริษัทสามารถคิดค่าใช้จ่ายเพิ่มต่างหาก" & vbCrLf & _
    '                        "7.   รายละเอียดบริการ Maintenance Assurance (MA)" & vbCrLf & _
    '                        "      7.1   รับประกันการทำงานของโปรแกรมตลอดช่วงเวลาของสัญญาบริการ" & vbCrLf & _
    '                        "      7.2   ในกรณีผลิตภัณฑ์ได้รับการพัฒนาเวอร์ชันใหม่ จะได้รับสิทธิ์ในการ Upgrade ระบบฟรี" & vbCrLf & _
    '                        "      7.3   Refreshment Training สำหรับผู้ใช้งานทั่วไป ปี ละ 1 ครั้ง" & vbCrLf & _
    '                        "      7.4   ให้คำปรึกษาด้านเทคนิคฟรีโดยไม่จำกัด ทางโทรศัพท์ อีเมล์ msn หรือ remote pc โดยทางผู้ซื้อจัดเตรียม internet access ให้สามารถเข้าถึงเครื่อง หากต้องการ " & vbCrLf & _
    '                        "              ให้เข้าไปให้บริการที่หน่วยงาน คิดค่าเดินทางครั้งละ 2,000 บาท (กรุงเทพฯ และปริมณฑล)" & vbCrLf & _
    '                        "      7.5   Genedia Agent MA สามารถปรับแต่ง mail template ได้ปีละ 2 รายการ" & vbCrLf & _
    '                        "8.   เงื่อนไขการรับประกันโปรแกรม" & vbCrLf & _
    '                        "      8.1   การรับประกันโปรแกรม เป็นการรับประกันการทำงานของโปรแกรมว่าสามารถทำงานได้อย่างถูกต้องภายใต้สภาวะแวดล้อมขณะติดตั้ง โดยไม่รวมถึงการปรับแก้รูปแบบ" & vbCrLf & _
    '                        "              การแสดงผล, การปรับเนื้อความของข้อมูล, การเพิ่มเติมหรือลบหน้าต่างการแสดงผล ความสามารถที่ทำได้ ณ วันติดตั้งซอฟต์แวร์ถือว่าอยู่ในขอบเขตของการรับประกัน" & vbCrLf & _
    '                        "              โปรแกรมทั้งหมด" & vbCrLf & _
    '                        "      8.2   ในระยะเวลา 3 เดือนแรกหลังการติดตั้ง หากพบจุดผิดพลาดจะดำเนินการให้ทันที หลังจากนั้นจะแก้ไขให้ในลักษณะ Patch ที่จะจัดส่งให้ตามกำหนดเวลาที่" & vbCrLf & _
    '                        "              บริษัท บนเส้น กำหนด" & vbCrLf & _
    '                        "      8.3   การเปลี่ยนแปลงสภาวะแวดล้อมของระบบใหม่ (เปลี่ยนเครื่องใหม่, เปลี่ยนอุปกรณ์หรือระบบเกี่ยวเนื่องใหม่) ไม่อยู่ในขอบเขตการรับประกันซึ่ง บริษัท บนเส้น จำกัด" & vbCrLf & _
    '                        "              สามารถคิดค่าใช้จ่ายตามข้อ 5.2" & vbCrLf & _
    '                        "9.   การให้บริการอื่นใดที่ไม่ได้อยู่ในเงื่อนไขการเสนอราคานี้ที่บริษัท บนเส้น จำกัด จัดให้เพิ่มเติม ไม่ถือเป็นความผูกพันและความรับผิดชอบของบริษัท บนเส้น จำกัด"

    'End Sub

     Public Sub AddDataInForm(Q_No)
        'GetQuotationDate(Q_No)
        txt_quotation.Text = Q_No
        dte_quotationDate.Text = GetQuotationDate(Q_No)

        ShowData(Q_No)
    End Sub

    Public Function chkQuotationByNO(ByVal qno As String) As Quotation
        Dim quotation As New Quotation
        Using ctx = New DlmsDataContext
            quotation = (From q In ctx.Quotations Where q.quotation_no = qno).SingleOrDefault
        End Using
        Return quotation
    End Function

    Public Sub ShowData(ByVal qno As String)
        Dim quota As New Quotation
        quota = chkQuotationByNO(qno)
        If quota IsNot Nothing Then
            btn_AddQuotation.Visible = False
            btn_SaveQuotation.Visible = True
            btn_PrintQuotation.Visible = True
            With quota
                QuotationID = .Quota_ID
                cmb_company.Text = .company_name
                cmb_attn.Text = .attn
                txt_tel.Text = .tel
                txt_fax.Text = .fax
                txt_email.Text = .email
                'memo_remark.Text = .remark
                'memo_condition.Text = .condition

                Using ctx = New DlmsDataContext
                    Dim quota_item As New List(Of QuotationItem)
                    Dim subDataList As New List(Of String)
                    quota_item = (From qi In ctx.QuotationItems Where qi.Quota_ID = .Quota_ID).ToList
                    For Each i In quota_item
                        Dim q_DescriptionSub As New QuotationDescriptionSub
                        With q_DescriptionSub
                            .ID_Q_Detail_Main = i.QuotationDescriptionSub.ID_Q_Detail_Main
                            .ID_Q_Detail_Sub = i.ID_Q_Detail_Sub
                            .Q_Detail_Sub = i.QuotationDescriptionSub.Q_Detail_Sub
                            .Price = i.price
                        End With
                        subDataList.Add(StrDetailData(q_DescriptionSub, i.unit))
                    Next
                    'txt_subData.Text = String.Join(";", subDataList)
                    gv_addmodule_DataBind()
                End Using
            End With
        Else
            btn_SaveQuotation.Visible = False
            btn_PrintQuotation.Visible = False
            btn_AddQuotation.Visible = True
        End If
    End Sub

    Protected Sub FillSubQuotationCombo(ByVal quotation As String)
        If String.IsNullOrEmpty(quotation) Then
            Return
        End If
        Session("ID_Q_Detail_Main") = quotation
    End Sub

    Protected Sub FillAttnCombo(ByVal company As String)
        If String.IsNullOrEmpty(company) Then
            Return
        End If
        Session("Company_ID") = company
    End Sub

    Protected Sub lb_QuotationDescriptionSub_Callback(ByVal source As Object, ByVal e As CallbackEventArgsBase)
        FillSubQuotationCombo(e.Parameter)
        'lb_QuotationDescriptionSub.DataBind()
    End Sub

    'Protected Sub cmb_attn_Callback(ByVal source As Object, ByVal e As CallbackEventArgsBase)
    '    FillAttnCombo(e.Parameter)
    '    cmb_attn.DataBind()
    'End Sub

    'Private Sub cbp_subData_Callback(ByVal sender As Object, ByVal e As DevExpress.Web.ASPxClasses.CallbackEventArgsBase) Handles cbp_subData.Callback
    '    If e.Parameter.ToString = "Add Detail" Then
    '        Dim allsubList As List(Of QuotationDescriptionSub) = GetQuotationSubList()
    '        Dim newDetailIDList As List(Of Integer) = AddedDetailIDList
    '        newDetailIDList.AddRange(SelectedDetailIDList)
    '        newDetailIDList = (From id In newDetailIDList Order By id Distinct).ToList
    '        Dim strEmpDataList As New List(Of String)
    '        For i As Integer = 0 To newDetailIDList.Count - 1
    '            Dim index As Integer = i
    '            Dim data As String = GetStrsubDataFromTable(newDetailIDList(index))
    '            If String.IsNullOrWhiteSpace(data) Then
    '                'Dim emp As Employee = (From em In  Where em.empId = newEmployeeIDList(index)).SingleOrDefault
    '                Dim quosub As QuotationDescriptionSub = GetQuotationSubListById(newDetailIDList(index))
    '                data = StrDetailData(quosub)
    '            End If
    '            If Not String.IsNullOrWhiteSpace(data) Then
    '                strEmpDataList.Add(data)
    '            End If
    '        Next
    '        'txt_subData.Text = String.Join(";", strEmpDataList)
    '    ElseIf e.Parameter.ToString.StartsWith("Set Price") Then
    '        Dim cmdInfo As String() = e.Parameter.ToString.Split(":")
    '        Dim params As String() = cmdInfo(1).Split(",")
    '        SetStrDataValue(params(0), 3, If(IsNumeric(params(1)), params(1), 0))
    '    ElseIf e.Parameter.ToString.StartsWith("Set Unit") Then
    '        Dim cmdInfo As String() = e.Parameter.ToString.Split(":")
    '        Dim params As String() = cmdInfo(1).Split(",")
    '        SetStrDataValue(params(0), 4, If(IsNumeric(params(1)), params(1), 0))
    '    End If
    'End Sub

    Private Function StrDetailData(ByVal quosub As QuotationDescriptionSub, Optional ByVal unit As Decimal = 1) As String
        If quosub IsNot Nothing Then
            Return quosub.ID_Q_Detail_Sub & "|" & GetMainDetailById(quosub.ID_Q_Detail_Main) & "|" & quosub.Q_Detail_Sub & "|" & quosub.Price & "|" & unit
        Else
            Return String.Empty
        End If
    End Function

    Private Function GetQuotationDate(ByVal qId As String) As String
        Using ctx As New DlmsDataContext
            Dim Quotation As String = (From q In ctx.QuotationProposals _
                                        Where q.Q_ID = qId Select q.Q_Date).SingleOrDefault
            Return Quotation
        End Using
    End Function

    Private Function GetStrsubDataFromTable(ByVal subId As Integer) As String
        'If Not String.IsNullOrWhiteSpace(txt_subData.Text) Then
        '    Dim subDataList As List(Of String) = strAddedDetailSubList
        '    For i As Integer = 0 To subDataList.Count - 1
        '        Dim subData As String() = subDataList(i).Split("|")
        '        If CInt(subData(0)) = subId Then Return subDataList(i)
        '    Next
        'End If
        Return String.Empty
    End Function

    Public Function GetQuotationSubList() As List(Of QuotationDescriptionSub)
        Using ctx As New DlmsDataContext
            Dim subList As List(Of QuotationDescriptionSub) = (From s In ctx.QuotationDescriptionSubs).ToList
            Return subList
        End Using
    End Function

    Public Function GetQuotationSubListById(ByVal subId As Integer) As QuotationDescriptionSub
        Using ctx As New DlmsDataContext
            Dim quotSub As QuotationDescriptionSub = (From s In ctx.QuotationDescriptionSubs _
                                                      Where s.ID_Q_Detail_Sub = subId).SingleOrDefault
            Return quotSub
        End Using
    End Function

    Public Function GetMainDetailById(ByVal MainId As Integer) As String
        Using ctx As New DlmsDataContext
            Dim MainDetail As String = (From s In ctx.QuotationDescriptions _
                                        Where s.ID_Q_Detail_Main = MainId _
                                        Select s.Q_Detail_Main _
                                        ).SingleOrDefault
            Return MainDetail
        End Using
    End Function

    Public Function GetDetailSubList() As DataTable
        Dim strDetailDataList As List(Of String) = strAddedDetailSubList
        Dim dt As New DataTable
        With dt.Columns
            .Add("ID_Q_Detail_Sub")
            .Add("Q_Detail_Main")
            .Add("Q_Detail_Sub")
            .Add("Price")
            .Add("Unit")
        End With
        For i As Integer = 0 To strDetailDataList.Count - 1
            Dim strData As String() = strDetailDataList(i).Split("|")
            dt.Rows.Add(strData(0), strData(1), strData(2), strData(3), strData(4))
        Next
        Return dt
    End Function

    Public Function GetCompanyData(ByVal companyId As Integer) As vw_Company
        'แก้ให้ดึงข้อมูลจาก DB ของ Salesapp
        Using ctx As New DlmsDataContext
            Dim companyList = (From c In ctx.vw_Companies Where c.prospect_id = companyId).SingleOrDefault
            Return companyList
        End Using
    End Function

    'Public Property DefaultConnString() As String
    '    Get
    '        'Return "Data Source=KNIGHT\MSSQLSERVER_R2;Initial Catalog=gps_mode61_db;User ID=sa;Password=blaster"
    '        Return Web.Configuration.WebConfigurationManager.ConnectionStrings("DLMSConnectionString").ConnectionString
    '    End Get
    '    Set(ByVal value As String)
    '        My.Settings("DLMSConnectionString") = value
    '    End Set
    'End Property

    'Public Function GetCompanyData(ByVal companyId As Integer) As DataTable
    '    Dim sql As String = ""
    '    sql = "Select * " & _
    '        "From SalesApp_db.dbo.prospect p " & _
    '        "Inner Join SalesApp_db.dbo.contact c on p.prospect_id = c.prospect_id" & _
    '        "Order By p.prospect_id DESC"
    '    Dim Con As New SqlClient.SqlConnection(DefaultConnString) : Con.Open()
    '    Dim cmd As New SqlClient.SqlCommand(sql, Con)
    '    Dim da As New SqlClient.SqlDataAdapter(cmd)
    '    Dim dt As New DataTable
    '    da.Fill(dt)
    '    Con.Close() : Return dt
    'End Function

    'Private Sub gv_addmodule_CustomButtonCallback(ByVal sender As Object, ByVal e As DevExpress.Web.ASPxGridView.ASPxGridViewCustomButtonCallbackEventArgs) Handles gv_addmodule.CustomButtonCallback
    '    If e.ButtonID = "btn_Delete" Then
    '        'Dim subId As Integer = gv_addmodule.GetRowValues(e.VisibleIndex, "ID_Q_Detail_Sub")
    '        'Dim strAllSubData As String = txt_subData.Text
    '        'Dim strEmpData As String = GetStrsubDataFromTable(subId)
    '        'If txt_subData.Text.Contains(";" & strEmpData) Then
    '        '    strAllSubData = strAllSubData.Replace(";" & strEmpData, "")
    '        'ElseIf txt_subData.Text.Contains(strEmpData & ";") Then
    '        '    strAllSubData = strAllSubData.Replace(strEmpData & ";", "")
    '        'Else
    '        '    strAllSubData = String.Empty
    '        'End If
    '        'gv_addmodule.JSProperties("cpStrAllSubData") = "Delete employee:" & strAllSubData
    '    End If
    'End Sub

    'Private Sub gv_addmodule_CustomCallback(ByVal sender As Object, ByVal e As DevExpress.Web.ASPxGridView.ASPxGridViewCustomCallbackEventArgs) Handles gv_addmodule.CustomCallback
    '    If e.Parameters.ToString = "Bind data" Then gv_addmodule_DataBind()
    'End Sub

    Private Sub gv_addmodule_DataBind()
        Dim dt = GetDetailSubList()
        'gv_addmodule.DataSource = dt
        'gv_addmodule.DataBind()
    End Sub

    'Private Sub gv_addmodule_HtmlRowCreated(ByVal sender As Object, ByVal e As DevExpress.Web.ASPxGridView.ASPxGridViewTableRowEventArgs) Handles gv_addmodule.HtmlRowCreated
    '    If e.RowType = GridViewRowType.Data Then
    '        Dim subId As Integer = e.KeyValue
    '        'Dim colnPrice As GridViewDataColumn = gv_addmodule.Columns("Price")
    '        'Dim spePrice As ASPxSpinEdit = gv_addmodule.FindRowCellTemplateControl(e.VisibleIndex, colnPrice, "spe_Price")
    '        'spePrice.ClientSideEvents.LostFocus = "function(s, e) { cbp_subData.PerformCallback('Set Price:" & subId & ",' + s.GetValue()); }"

    '        'Dim colnUnit As GridViewDataColumn = gv_addmodule.Columns("Unit")
    '        'Dim speUnit As ASPxSpinEdit = gv_addmodule.FindRowCellTemplateControl(e.VisibleIndex, colnUnit, "spe_Unit")
    '        'speUnit.ClientSideEvents.LostFocus = "function(s, e) { cbp_subData.PerformCallback('Set Unit:" & subId & ",' + s.GetValue()); }"
    '    End If
    'End Sub

    Private Sub SetStrDataValue(ByVal subId As Integer, ByVal colnIndex As Integer, ByVal value As Double)
        Dim oldStrsubData As String = GetStrsubDataFromTable(subId)
        Dim strData As String() = oldStrsubData.Split("|")
        strData(colnIndex) = value
        Dim newStrsubData As String = String.Join("|", strData)
        'txt_subData.Text = txt_subData.Text.Replace(oldStrsubData, newStrsubData)
    End Sub

    Private Sub btn_AddQuotation_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btn_AddQuotation.Click
        Using ctx As New DlmsDataContext
            Try
                Dim maxId = (From r In ctx.Quotations Select CType(r.Quota_ID, Integer?)).Max
                Dim nextId = If(maxId.HasValue, maxId + 1, 1)
                Dim quotationNo As String = txt_quotation.Text.Trim
                Dim companyName As String = cmb_company.Text.Trim
                Dim attnName As String = cmb_attn.Text.Trim
                Dim TbQuotation As New Quotation
                With TbQuotation
                    .Quota_ID = nextId
                    .company_name = companyName
                    .attn = attnName
                    .tel = txt_tel.Text.Trim
                    .fax = txt_fax.Text.Trim
                    .email = txt_email.Text.Trim
                    .quotation_no = quotationNo
                    .quotation_date = dte_quotationDate.Text.Trim
                    .quotation_from = txt_from.Text.Trim
                    .bonzen_tel = txt_bonzentel.Text.Trim
                    .bonzen_email = txt_bonzenemail.Text.Trim
                    'ยังไม่ได้ update Total
                    '.total_amount = sumAmount
                    '.remark = memo_remark.Text
                    '.condition = memo_condition.Text
                End With
                ctx.Quotations.InsertOnSubmit(TbQuotation)
                ctx.SubmitChanges()

                'สั่ง insert Quotation Item
                InsertQuotationItem(nextId)
                UpdateCompanyAndAttnInQuotationProposal(quotationNo, companyName, attnName)
                btn_AddQuotation.Visible = False
                btn_SaveQuotation.Visible = True
                btn_PrintQuotation.Visible = True

                QuotationID = nextId
            Catch ex As Exception
                Throw ex
            End Try

        End Using
    End Sub

    Public Sub InsertQuotationItem(ByVal Quota_ID As Integer)
        Using ctx As New DlmsDataContext
            Dim data As DataTable = GetDetailSubList()
            Dim sumAmount As Decimal
            'สั่ง insert ที่ละ รายการ
            For i = 0 To data.Rows.Count - 1
                Dim maxId = (From r In ctx.QuotationItems Select CType(r.QItem_ID, Integer?)).Max
                Dim nextId = If(maxId.HasValue, maxId + 1, 1)
                Dim TbQuotationItem As New QuotationItem
                With TbQuotationItem
                    .QItem_ID = nextId
                    .ID_Q_Detail_Sub = CInt(data(i)(0))
                    .price = CInt(data(i)(3))
                    'Dim speUnit As ASPxSpinEdit
                    'Dim colnUnit As GridViewDataColumn = gv_addmodule.Columns("Unit")
                    'speUnit = gv_addmodule.FindRowCellTemplateControl(i, colnUnit, "spe_Unit")
                    '.price = speUnit.Text
                    .unit = CDec(data(i)(4))
                    .amount = CInt(data(i)(3)) * CDec(data(i)(4))
                    sumAmount += (CInt(data(i)(3)) * CDec(data(i)(4)))
                    .Quota_ID = Quota_ID
                End With
                ctx.QuotationItems.InsertOnSubmit(TbQuotationItem)
                ctx.SubmitChanges()
            Next
            UpdateTotalInQuotation(Quota_ID, sumAmount)
        End Using
    End Sub

    Private Sub UpdateTotalInQuotation(ByVal quotaId As Integer, ByVal sumAmount As Decimal)
        Using ctx As New DlmsDataContext
            Dim Quotation = (From q In ctx.Quotations Where q.Quota_ID = quotaId).SingleOrDefault
            Quotation.total_amount = sumAmount
            Quotation.Vat = 7
            Quotation.Vat_amount = sumAmount * 1.07
            ctx.SubmitChanges()
        End Using
    End Sub

    Private Sub UpdateCompanyAndAttnInQuotationProposal(ByVal quotaNo As String, ByVal companyName As String, ByVal attnName As String)
        Using ctx As New DlmsDataContext
            Dim QuotaProp = (From qp In ctx.QuotationProposals Where qp.Q_ID = quotaNo).SingleOrDefault
            With QuotaProp
                .ContactCom = companyName
                .ContactName = attnName
            End With
            ctx.SubmitChanges()
        End Using
    End Sub

    Private Sub cmb_company_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles cmb_company.SelectedIndexChanged

    End Sub

    Private Sub cbp_company_Callback(ByVal sender As Object, ByVal e As DevExpress.Web.ASPxClasses.CallbackEventArgsBase) Handles cbp_company.Callback
        FillAttnCombo(e.Parameter)
        cmb_attn.DataBind()

        If IsNumeric(cmb_company.Value) Then
            Dim companyId As Integer = CInt(cmb_company.Value)
            Dim companyData As vw_Company = GetCompanyData(companyId)
            txt_tel.Text = companyData.tel_number
            txt_fax.Text = companyData.fax
            txt_email.Text = companyData.mail
        End If
    End Sub

    Private Sub btn_PrintQuotation_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btn_PrintQuotation.Click
        Response.Redirect("../Report/Report.aspx?quotaId=" & QuotationID)
    End Sub

    Private Sub btn_SaveQuotation_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btn_SaveQuotation.Click
        Using ctx As New DlmsDataContext
            'Dim maxId = (From r In ctx.Quotations Select CType(r.Quota_ID, Integer?)).Max
            'Dim nextId = If(maxId.HasValue, maxId + 1, 1)
            Dim quotationNo As String = txt_quotation.Text.Trim
            Dim companyName As String = cmb_company.Text.Trim
            Dim attnName As String = cmb_attn.Text.Trim
            'Dim TbQuotation As new Quotation
            Dim TbQuotation = (From q In ctx.Quotations Where q.Quota_ID = QuotationID).SingleOrDefault
            With TbQuotation
                '.Quota_ID = nextId
                .company_name = companyName
                .attn = attnName
                .tel = txt_tel.Text.Trim
                .fax = txt_fax.Text.Trim
                .email = txt_email.Text.Trim
                .quotation_no = quotationNo
                .quotation_date = dte_quotationDate.Text.Trim
                .quotation_from = txt_from.Text.Trim
                .bonzen_tel = txt_bonzentel.Text.Trim
                .bonzen_email = txt_bonzenemail.Text.Trim
                'ยังไม่ได้ update Total
                '.total_amount = 
                '.remark = memo_remark.Text
                '.condition = memo_condition.Text
            End With
            ctx.SubmitChanges()
            UpdateQuotationItem()
            UpdateCompanyAndAttnInQuotationProposal(quotationNo, companyName, attnName)
        End Using
    End Sub

    Public Sub UpdateQuotationItem()
        Using ctx As New DlmsDataContext
            Dim data As DataTable = GetDetailSubList()
            For i As Integer = 0 To data.Rows.Count - 1
                Dim TbQuotationItem As New QuotationItem
                TbQuotationItem = (From qi In ctx.QuotationItems Where qi.ID_Q_Detail_Sub = CInt(data.Rows(i)("ID_Q_Detail_Sub")) And qi.Quota_ID = QuotationID).SingleOrDefault

                If TbQuotationItem IsNot Nothing Then
                    'Update
                    With TbQuotationItem
                        '.QItem_ID = nextId
                        '.ID_Q_Detail_Sub = CInt(data(i)(0))
                        .price = CInt(data(i)(3))
                        .unit = CDec(data(i)(4))
                        'Dim speUnit As ASPxSpinEdit
                        'Dim colnUnit As GridViewDataColumn = gv_addmodule.Columns("Unit")
                        'speUnit = gv_addmodule.FindRowCellTemplateControl(i, colnUnit, "spe_Unit")

                        .amount = CInt(data(i)(3)) * CDec(data(i)(4))
                        '.Quota_ID = QuotationID
                    End With
                Else
                    'Insert
                    'data(i)("ID_Q_Detail_Sub")
                    Dim maxId = (From r In ctx.QuotationItems Select CType(r.QItem_ID, Integer?)).Max
                    Dim nextId = If(maxId.HasValue, maxId + 1, 1)
                    Dim New_Record As New QuotationItem
                    With New_Record
                        .QItem_ID = nextId
                        .ID_Q_Detail_Sub = CInt(data(i)(0))
                        .price = CInt(data(i)(3))
                        .unit = CDec(data(i)(4))
                        .amount = CInt(data(i)(3)) * CDec(data(i)(4))
                        .Quota_ID = QuotationID
                    End With
                    ctx.QuotationItems.InsertOnSubmit(New_Record)
                End If
                ctx.SubmitChanges()
            Next
            Dim originalSubList As List(Of QuotationItem) = (From r In ctx.QuotationItems Where r.Quota_ID = QuotationID).ToList
            For Each item In originalSubList
                If Not AddedDetailIDList.Contains(item.ID_Q_Detail_Sub) Then
                    ctx.QuotationItems.DeleteOnSubmit(item)
                End If
            Next
            ctx.SubmitChanges()
        End Using
    End Sub

    Private Sub lds_Attn_Selecting(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.LinqDataSourceSelectEventArgs) Handles lds_Attn.Selecting
        e.WhereParameters("Company_ID") = If(IsNumeric(Session("Company_ID")), CInt(Session("Company_ID")), 0)
    End Sub
End Class