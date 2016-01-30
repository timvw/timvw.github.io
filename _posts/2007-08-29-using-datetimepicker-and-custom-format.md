---
ID: 199
post_title: Using DateTimePicker and Custom Format
author: timvw
post_date: 2007-08-29 17:32:42
post_excerpt: ""
layout: post
permalink: >
  http://www.timvw.be/2007/08/29/using-datetimepicker-and-custom-format/
published: true
dsq_thread_id:
  - "1920565393"
---
<p>Today we ran into a nasty problem with <a href="http://msdn2.microsoft.com/en-us/library/system.windows.forms.datetimepickerformat.aspx">DateTimePickerFormat</a>.Custom. We allow the user to input a month/date with a DateTimePicker as following (nothing fancy):</p>
[code lang="csharp"]private void Form1_Load(object sender, EventArgs e)
{
 this.dateTimePicker1.Value = new DateTime(2007, 8, 31);
 this.dateTimePicker1.Format = DateTimePickerFormat.Custom;
 this.dateTimePicker1.CustomFormat = "MM/yyyy";
}[/code]
<p>Now, change to 09/2007 and notice that you get an Exception, because the control tries to create an unrepresentable new DateTime(2007, 8+1, 31). Thus, if you're going to use the DateTimePicker for MM/yyyy input make sure to set it's value to a DateTimeTime with a day component that exists for all months/years (thus a value between 1 and 28).</p>
<p><b>Addendum:</b> As usual, super moderator and MVP <a href="https://mvp.support.microsoft.com/default.aspx/profile=6c93adc6-026f-42bf-823c-8e65ca732af2">Hans Passant</a> provided a nice workaround for the problem:)</p>
[code lang="csharp"]public class MonthPicker : DateTimePicker {
  public MonthPicker() {
    this.Format = DateTimePickerFormat.Custom;
    this.CustomFormat = "MM/yyyy";
    DateTime now = DateTime.Now;
    this.Value = new DateTime(now.Year, now.Month, 1);
  }
  protected override void WndProc(ref Message m) {
    if (m.Msg == 0x204e) {
      NMHDR hdr = (NMHDR)m.GetLParam(typeof(NMHDR));
      if (hdr.code == -759) {
        NMDATETIMECHANGE dt = (NMDATETIMECHANGE)m.GetLParam(typeof(NMDATETIMECHANGE));
        this.Value = new DateTime(dt.st.wYear, dt.st.wMonth, 1);
        return;
      }
    }
    base.WndProc(ref m);
  }
  // P/Invoke declarations
  [StructLayout(LayoutKind.Sequential)]
  private struct NMHDR {
    public IntPtr hWnd;
    public IntPtr id;
    public int code;
  }
  [StructLayout(LayoutKind.Sequential, CharSet = CharSet.Auto)]
  private class NMDATETIMECHANGE {
    public NMHDR nmhdr;
    public int dwFlags;
    public SYSTEMTIME st;
  }
  [StructLayout(LayoutKind.Sequential)]
  private class SYSTEMTIME {
    public short wYear;
    public short wMonth;
    public short wDayOfWeek;
    public short wDay;
    public short wHour;
    public short wMinute;
    public short wSecond;
    public short wMilliseconds;
  }
}[/code]