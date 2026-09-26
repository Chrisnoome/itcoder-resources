// Window capture for the Access screenshots (shots.ps1). PrintWindow asks the
// window to draw itself into a bitmap, so the picture can only ever hold that
// window's own content - never another program's - even when it is covered.
// Nothing here clicks or types. Access does not paint a datasheet that is off
// every screen, so the window sits on the screen at the back of the stack,
// behind everything, and is never activated.
using System;
using System.Drawing;
using System.Drawing.Imaging;
using System.Runtime.InteropServices;

public static class Shot
{
    [DllImport ("user32.dll")] static extern bool PrintWindow (IntPtr hWnd, IntPtr hdc, uint flags);
    [DllImport ("user32.dll")] static extern bool GetWindowRect (IntPtr hWnd, out RECT rect);
    [DllImport ("user32.dll")] static extern bool SetWindowPos (IntPtr hWnd, IntPtr after, int x, int y, int w, int h, uint flags);
    [DllImport ("user32.dll")] static extern bool ShowWindow (IntPtr hWnd, int command);
    [DllImport ("user32.dll")] static extern bool SetProcessDpiAwarenessContext (IntPtr value);
    [DllImport ("user32.dll")] static extern uint GetWindowThreadProcessId (IntPtr hWnd, out uint pid);
    [DllImport ("user32.dll")] static extern IntPtr GetForegroundWindow ();

    /// The process of the window in front - the one keys typed now would go to.
    public static uint FrontPid () { uint pid; GetWindowThreadProcessId (GetForegroundWindow (), out pid); return pid; }

    /// The process that owns a window (so a stuck run can stop only its own Access).
    public static uint Pid (IntPtr hWnd) { uint pid; GetWindowThreadProcessId (hWnd, out pid); return pid; }

    [StructLayout (LayoutKind.Sequential)] public struct RECT { public int Left, Top, Right, Bottom; }
    [StructLayout (LayoutKind.Sequential)] struct LASTINPUTINFO { public uint cbSize; public uint dwTime; }
    [DllImport ("user32.dll")] static extern bool GetLastInputInfo (ref LASTINPUTINFO info);

    /// When anyone last touched the keyboard or mouse (a tick count) - if it moves
    /// during a run, the run stops: a key press could land in Access (26 Sep 2026).
    public static uint LastInput () { LASTINPUTINFO info = new LASTINPUTINFO (); info.cbSize = 8; GetLastInputInfo (ref info); return info.dwTime; }

    delegate bool EnumProc (IntPtr hWnd, IntPtr lParam);
    [DllImport ("user32.dll")] static extern bool EnumChildWindows (IntPtr parent, EnumProc proc, IntPtr lParam);
    [DllImport ("user32.dll", CharSet = CharSet.Unicode)] static extern int GetClassName (IntPtr hWnd, System.Text.StringBuilder name, int size);
    [DllImport ("user32.dll")] static extern bool IsWindowVisible (IntPtr hWnd);
    [DllImport ("user32.dll")] static extern bool PostMessage (IntPtr hWnd, uint message, IntPtr wParam, IntPtr lParam);

    /// The first visible child window (at any depth) of this class, or zero.
    public static IntPtr Child (IntPtr parent, string className)
    {
        IntPtr found = IntPtr.Zero;
        EnumChildWindows (parent, delegate (IntPtr h, IntPtr l) {
            System.Text.StringBuilder name = new System.Text.StringBuilder (256);
            GetClassName (h, name, 256);
            if (name.ToString () == className && IsWindowVisible (h)) { found = h; return false; }
            return true; }, IntPtr.Zero);
        return found;
    }

    /// A key posted to ONE window by its handle (Down arrow in Design View's
    /// grid, say) - a message to that window, never typing at the desktop.
    public static void PostKey (IntPtr hWnd, int virtualKey)
    {
        PostMessage (hWnd, 0x0100, new IntPtr (virtualKey), IntPtr.Zero);   // WM_KEYDOWN
        PostMessage (hWnd, 0x0101, new IntPtr (virtualKey), IntPtr.Zero);   // WM_KEYUP
    }

    /// Physical pixels from here on, so a picture is at the screen's own scaling.
    public static void DpiAware () { SetProcessDpiAwarenessContext (new IntPtr (-4)); }

    /// Restores the window, puts it at (x, y), w by h, at the back of the stack, without activating it.
    public static void Place (IntPtr hWnd, int x, int y, int w, int h)
    {
        ShowWindow (hWnd, 4);                                                // SW_SHOWNOACTIVATE (restored, not maximised)
        SetWindowPos (hWnd, new IntPtr (1), x, y, w, h, 0x0010);            // HWND_BOTTOM, SWP_NOACTIVATE
    }

    /// Back to the bottom of the stack (Access may bring itself forward).
    public static void Back (IntPtr hWnd)
    {
        SetWindowPos (hWnd, new IntPtr (1), 0, 0, 0, 0, 0x0010 | 0x0001 | 0x0002);   // NOACTIVATE | NOSIZE | NOMOVE
    }

    /// The whole window, drawn by itself, saved as a PNG. Returns "w x h".
    public static string Save (IntPtr hWnd, string file)
    {
        RECT r;
        GetWindowRect (hWnd, out r);
        int w = r.Right - r.Left, h = r.Bottom - r.Top;

        using (Bitmap bitmap = new Bitmap (w, h, PixelFormat.Format32bppArgb))
        {
            using (Graphics g = Graphics.FromImage (bitmap))
            {
                IntPtr hdc = g.GetHdc ();
                PrintWindow (hWnd, hdc, 2);                                  // PW_RENDERFULLCONTENT
                g.ReleaseHdc (hdc);
            }
            bitmap.Save (file, ImageFormat.Png);
        }
        return w + " x " + h;
    }
}
