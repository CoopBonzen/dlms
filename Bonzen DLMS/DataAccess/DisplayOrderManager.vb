Imports System.Linq.Expressions

''' <summary>
''' คลาสสำหรับช่วยจัดการเกี่ยวกับการเรียงลำดับข้อมูล (การ set ค่าในคอลัมน์ display order)
''' </summary>
''' <remarks></remarks>
Public Class DisplayOrderManager(Of T)

    ''' <summary>
    ''' ชื่อคอลัมน์ที่เก็บเลขลำดับในการแสดงผลไว้ default คือ "display_order"
    ''' </summary>
    ''' <remarks></remarks>
    Public DisplayOrderColumnName As String = "display_order"

    Private qRowSet As IQueryable(Of T)
    ''' <summary>
    ''' 
    ''' </summary>
    ''' <param name="qRowSet">Query ซึ่งระบุกลุ่มของ row ที่จะถูกจัดการลำดับ</param>
    ''' <remarks></remarks>
    Public Sub New(ByVal qRowSet As IQueryable(Of T))
        Me.qRowSet = qRowSet
    End Sub

#Region "Method"
    ' ให้ค่าของ display order column
    Protected Function GetDisplayOrder(ByVal row As T) As Integer
        Dim pi = row.GetType.GetProperty(DisplayOrderColumnName)
        Return pi.GetValue(row, Nothing)
    End Function

    ' set ค่า display order column
    Protected Sub SetDisplayOrder(ByVal row As T, ByVal value As Integer)
        Dim pi = row.GetType.GetProperty(DisplayOrderColumnName)
        pi.SetValue(row, value, Nothing)
    End Sub

    ' สั่งสลับ display order ของ row ปัจจุบันกับอีก row หนึ่ง
    Protected Sub Move(ByRef currentRow As T, ByVal Upward As Boolean)
        If currentRow Is Nothing Then Exit Sub

        Dim currentOrder As Integer = GetDisplayOrder(currentRow)
        Dim anotherOrder As Integer = currentOrder + IIf(Upward, -1, +1)

        Dim anotherRow = qRowSet.AddCondition(DisplayOrderColumnName, Compare.Equal, anotherOrder).SingleOrDefault
        If anotherRow IsNot Nothing Then
            SetDisplayOrder(currentRow, anotherOrder)
            SetDisplayOrder(anotherRow, currentOrder)
        End If
    End Sub

    ' สั่งสลับ display order ของ row ปัจจุบันกับอีก row หนึ่ง
    ' โดยใช้ name value dictionary ในการระบุ row
    Protected Sub MoveByKey(ByVal key As IDictionary, ByVal Upward As Boolean)
        Dim q = qRowSet
        For i As Integer = 0 To key.Count - 1
            q = q.AddCondition(key.Keys(i), Compare.Equal, key.Values(i))
        Next
        Move(q.SingleOrDefault, Upward)
    End Sub
#End Region

    ''' <summary>
    ''' สั่งย้ายลำดับการแสดงผลของ row ที่กำหนดขึ้น
    ''' </summary>
    ''' <param name="row"></param>
    ''' <remarks></remarks>
    Public Sub MoveUp(ByVal row As T)
        Move(row, True)
    End Sub

    ''' <summary>
    ''' สั่งย้ายลำดับการแสดงผลของ row ที่กำหนดขึ้น (ใช้ key ในการระบุ row)
    ''' </summary>
    ''' <param name="key"></param>
    ''' <remarks></remarks>
    Public Sub MoveUpByKey(ByVal key As IDictionary)
        MoveByKey(key, True)
    End Sub

    ''' <summary>
    ''' สั่งย้ายลำดับการแสดงผลของ row ที่กำหนดลง
    ''' </summary>
    ''' <param name="row"></param>
    ''' <remarks></remarks>
    Public Sub MoveDown(ByVal row As T)
        Move(row, False)
    End Sub

    ''' <summary>
    ''' สั่งย้ายลำดับการแสดงผลของ row ที่กำหนดลง (ใช้ key ในการระบุ row)
    ''' </summary>
    ''' <param name="key"></param>
    ''' <remarks></remarks>
    Public Sub MoveDownByKey(ByVal key As IDictionary)
        MoveByKey(key, False)
    End Sub

    ''' <summary>
    ''' สั่งให้มีการ run เลขในคอลัมน์ display order ใหม่
    ''' </summary>
    ''' <remarks></remarks>
    Public Sub ReOrder()
        Dim newOrder As Integer = 1
        Dim sortedRows = qRowSet.OrderBy( _
            AddressOf GetDisplayOrder).ToArray
        For Each row In sortedRows
            If GetDisplayOrder(row) <> newOrder Then
                SetDisplayOrder(row, newOrder)
            End If
            newOrder += 1
        Next
    End Sub

End Class
