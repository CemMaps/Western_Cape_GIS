$port = 8765
$root = "c:\Users\cemgu\OneDrive - University College London\Documents\temp_project\Western_Cape_GIS_GitHub"
$url  = "http://localhost:$port/"

$listener = New-Object System.Net.HttpListener
$listener.Prefixes.Add($url)
$listener.Start()
Write-Host "Server running at $url" -ForegroundColor Cyan
Write-Host "Open that URL in your browser. Press Ctrl+C to stop." -ForegroundColor Gray

$mimeTypes = @{
  ".html" = "text/html"
  ".css"  = "text/css"
  ".js"   = "application/javascript"
  ".json" = "application/json"
  ".fgb"  = "application/octet-stream"
  ".png"  = "image/png"
  ".ico"  = "image/x-icon"
}

try {
  while ($listener.IsListening) {
    $ctx  = $listener.GetContext()
    $req  = $ctx.Request
    $resp = $ctx.Response
    $localPath = $req.Url.LocalPath
    if ($localPath -eq "/") { $localPath = "/index.html" }
    $safePath = $localPath.Replace("/", "\").TrimStart("\")
    $file = Join-Path $root $safePath
    if (Test-Path $file -PathType Leaf) {
      $ext  = [System.IO.Path]::GetExtension($file).ToLower()
      $mime = "application/octet-stream"
      if ($mimeTypes.ContainsKey($ext)) { $mime = $mimeTypes[$ext] }
      $resp.ContentType = $mime
      $resp.AddHeader("Access-Control-Allow-Origin","*")
      $bytes = [System.IO.File]::ReadAllBytes($file)
      $resp.ContentLength64 = $bytes.Length
      $resp.OutputStream.Write($bytes, 0, $bytes.Length)
    } else {
      $resp.StatusCode = 404
      $msg = [System.Text.Encoding]::UTF8.GetBytes("404 Not Found: $safePath")
      $resp.ContentType = "text/plain"
      $resp.ContentLength64 = $msg.Length
      $resp.OutputStream.Write($msg, 0, $msg.Length)
    }
    $resp.OutputStream.Close()
  }
} finally {
  $listener.Stop()
}
