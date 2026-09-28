// Where a window is on the screen, in physical pixels (after Shot.DpiAware),
// so flatfile.ps1 can turn Excel's screen positions of cells into places on
// the picture PrintWindow makes of that window.
using System;
using System.Runtime.InteropServices;

public static class WinRect
{
    [StructLayout (LayoutKind.Sequential)] struct RECT { public int Left, Top, Right, Bottom; }
    [DllImport ("user32.dll")] static extern bool GetWindowRect (IntPtr hWnd, out RECT rect);

    /// "left top right bottom"
    public static int[] Of (IntPtr hWnd)
    {
        RECT r;
        GetWindowRect (hWnd, out r);
        return new int[] { r.Left, r.Top, r.Right, r.Bottom };
    }
}
