Imports System.Linq.Expressions
Imports System.Data.Linq.Mapping
Imports System.Runtime.CompilerServices
Imports System.Reflection

Public Module LinqModule

#Region "Data Object utilities"
    ''' <summary>
    ''' ใช้ reflection เอาค่าของ property ตามชื่อที่กำหนด
    ''' </summary>
    ''' <param name="obj"></param>
    ''' <param name="Name"></param>
    ''' <returns></returns>
    ''' <remarks></remarks>
    <Extension()> _
    Public Function GetProperty(Of T)(ByVal obj As T, ByVal Name As String) As Object
        Dim pi = obj.GetType.GetProperty(Name)
        Return pi.GetValue(obj, Nothing)
    End Function

    ''' <summary>
    ''' ใช้ reflection ใส่ค่าของ property ตามชื่อที่กำหนด
    ''' </summary>
    ''' <param name="obj"></param>
    ''' <param name="Name"></param>
    ''' <param name="value"></param>
    ''' <remarks></remarks>
    <Extension()> _
    Public Sub SetProperty(Of T)(ByVal obj As T, ByVal Name As String, ByVal value As Object)
        Dim pi = obj.GetType.GetProperty(Name)
        pi.SetValue(obj, value, Nothing)
    End Sub

    ''' <summary>
    ''' ให้ reference ของ object ที่มีค่าเท่ากับตัวที่จะ Find จาก Source ที่กำหนด
    ''' </summary>
    ''' <typeparam name="T"></typeparam>
    ''' <param name="Source">set ที่จะหาข้อมูล</param>
    ''' <param name="ValueObject">object ที่มีค่าเท่ากับตัวที่จะหา</param>
    ''' <returns></returns>
    ''' <remarks></remarks>
    <Extension()> _
    Public Function FindReference(Of T)(ByVal Source As IQueryable(Of T), ByVal ValueObject As T) As T
        ' ดูว่าเงื่อนไขคืออะไร หามาจาก key ของข้อมูล
        Dim criteria As New Dictionary(Of String, Object)
        ' วนลูปผ่าน property เพื่อหา ColumnAttribute ตัวที่เป็น key
        For Each prop As PropertyInfo In ValueObject.GetType.GetProperties
            For Each att As ColumnAttribute In prop.GetCustomAttributes(GetType(ColumnAttribute), True)
                If att.IsPrimaryKey Then
                    criteria.Add( _
                        IIf(String.IsNullOrEmpty(att.Name), prop.Name, att.Name), _
                        ValueObject.GetProperty(prop.Name))
                End If
            Next
        Next
        Dim q = Source
        ' เอาเงื่อนไขไป search ที่ source
        For Each c In criteria
            q = q.AddCondition(c.Key, Compare.Equal, c.Value)
        Next
        Return q.SingleOrDefault
    End Function

    ''' <summary>
    ''' Set property ทุกตัวที่เป็น Column ของ dest ให้เท่ากับ source
    ''' </summary>
    ''' <typeparam name="T"></typeparam>
    ''' <param name="Dest"></param>
    ''' <param name="Source"></param>
    ''' <param name="CopyKeyColumn" >จะให้ copy column ที่เป็น key ด้วยหรือไม่</param>
    ''' <remarks></remarks>
    <Extension()> _
    Public Sub CopyColumnFrom(Of T)(ByVal Dest As T, ByVal Source As T, Optional ByVal CopyKeyColumn As Boolean = False)
        ' วนลูปผ่าน property เพื่อหา ColumnAttribute
        For Each prop As PropertyInfo In GetType(T).GetProperties
            For Each att As ColumnAttribute In prop.GetCustomAttributes(GetType(ColumnAttribute), True)
                If Not att.IsPrimaryKey OrElse CopyKeyColumn Then
                    SetProperty(Dest, prop.Name, GetProperty(Source, prop.Name))
                End If
            Next
        Next
    End Sub

    ''' <summary>
    ''' เอาเฉพาะค่าของฟิลด์ที่กำหนดออกมาจาก object
    ''' </summary>
    ''' <param name="FieldNames">ชื่อฟิลด์ที่ต้องการข้อมูล ถ้าเอาหลายฟิลด์ให้ป้อนชื่อฟิลด์คั่นด้วย comma</param>
    <Extension()> _
    Public Function ExtractFields(Of T)(ByVal obj As T, ByVal FieldNames As String) As Specialized.IOrderedDictionary
        Dim fieldNameArr = FieldNames.Split(",")
        Dim result As New Specialized.OrderedDictionary
        For Each fieldName In fieldNameArr
            result.Add(fieldName, GetProperty(obj, fieldName))
        Next
        Return result
    End Function

    ''' <summary>
    ''' เอาเฉพาะค่าของฟิลด์ที่กำหนดออกมาจาก dictionary
    ''' </summary>
    ''' <param name="FieldNames">ชื่อฟิลด์ที่ต้องการข้อมูล ถ้าเอาหลายฟิลด์ให้ป้อนชื่อฟิลด์คั่นด้วย comma</param>
    <Extension()> _
    Public Function ExtractFields(ByVal dict As Specialized.IOrderedDictionary, ByVal FieldNames As String)
        Dim fieldNameArr = FieldNames.Split(",")
        Dim result As New Specialized.OrderedDictionary
        For Each fieldName In fieldNameArr
            result.Add(fieldName, dict(fieldName))
        Next
        Return result
    End Function

#End Region

#Region "Predicate utilities"

    ''' <summary>
    ''' สร้าง Predicate ระหว่าง property กับ const
    ''' </summary>
    ''' <typeparam name="T"></typeparam>
    ''' <param name="propName"></param>
    ''' <param name="value"></param>
    ''' <returns></returns>
    ''' <remarks></remarks>
    Public Function PredicatePropConst(Of T)(ByVal propName As String, ByVal compareType As Compare, ByVal value As Object) _
    As Expression(Of Func(Of T, Boolean))
        Dim param = Expression.Parameter(GetType(T), "param")
        Dim left = Expression.Convert( _
            Expression.Property(param, GetType(T).GetProperty(propName)), value.GetType)
        Dim right = Expression.Constant(value)
        Dim filter
        Select Case compareType
            Case Compare.Or : filter = Expression.Or(left, right)
            Case Compare.And : filter = Expression.And(left, right)
            Case Compare.Xor : filter = Expression.ExclusiveOr(left, right)
            Case Compare.Equal : filter = Expression.Equal(left, right)
            Case Compare.OrElse : filter = Expression.OrElse(left, right)
            Case Compare.AndAlso : filter = Expression.AndAlso(left, right)
            Case Compare.NotEqual : filter = Expression.NotEqual(left, right)
            Case Compare.LessThan : filter = Expression.LessThan(left, right)
            Case Compare.GreaterThan : filter = Expression.GreaterThan(left, right)
            Case Compare.LessThanOrEqual : filter = Expression.LessThanOrEqual(left, right)
            Case Compare.GreaterThanOrEqual : filter = Expression.GreaterThanOrEqual(left, right)
            Case Compare.Like
                'For the Like operator we encode a call to the LikeString method in the VB runtime
                Dim m = GetType(CompilerServices.Operators).GetMethod("LikeString")
                filter = Expression.Call(m, left, right, Expression.Constant(CompareMethod.Binary))
            Case Else
                Throw New ArgumentException("Not a valid compare type", "compareType", Nothing)
        End Select
        Return Expression.Lambda(Of Func(Of T, Boolean))(filter, param)
    End Function

    ''' <summary>
    ''' ชนิดการเปรียบเทียบ เอาไว้ใช้ใน extension method AddCondition
    ''' </summary>
    ''' <remarks></remarks>
    Public Enum Compare
        [Or] = ExpressionType.Or
        [And] = ExpressionType.And
        [Xor] = ExpressionType.ExclusiveOr
        [Not] = ExpressionType.Not
        Equal = ExpressionType.Equal
        [Like] = ExpressionType.TypeIs + 1
        NotEqual = ExpressionType.NotEqual
        [OrElse] = ExpressionType.OrElse
        [AndAlso] = ExpressionType.AndAlso
        LessThan = ExpressionType.LessThan
        GreaterThan = ExpressionType.GreaterThan
        LessThanOrEqual = ExpressionType.LessThanOrEqual
        GreaterThanOrEqual = ExpressionType.GreaterThanOrEqual
    End Enum

    ''' <summary>
    ''' ใช้เพิ่มเงื่อนไขต่อท้ายให้ Linq Query
    ''' </summary>
    ''' <typeparam name="T">class ของ query</typeparam>
    ''' <param name="q"></param>
    ''' <param name="columnName">ชื่อคอลัมน์</param>
    ''' <param name="compareType">โอเปอเรเตอร์</param>
    ''' <param name="value">ค่าที่จะเทียบ</param>
    ''' <returns></returns>
    ''' <remarks></remarks>
    <Extension()> _
    Public Function AddCondition(Of T)(ByVal q As IQueryable(Of T), _
    ByVal columnName As String, ByVal compareType As Compare, ByVal value As Object) As IQueryable(Of T)
        Return q.Where(PredicatePropConst(Of T)(columnName, compareType, value))
    End Function
#End Region

End Module
