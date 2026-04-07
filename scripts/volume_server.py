#!/usr/bin/env python3
from http.server import HTTPServer, BaseHTTPRequestHandler
import json
import subprocess

def get_volume():
    out = subprocess.run(["pactl", "get-sink-volume", "@DEFAULT_SINK@"], capture_output=True, text=True)
    vol_line = [l for l in out.stdout.splitlines() if "Volume:" in l][0]
    vol = int(vol_line.split("/")[1].strip().replace("%", ""))
    mute_out = subprocess.run(["pactl", "get-sink-mute", "@DEFAULT_SINK@"], capture_output=True, text=True)
    muted = "yes" in mute_out.stdout
    return {"volume": vol, "muted": muted}

def set_volume(vol):
    subprocess.run(["pactl", "set-sink-volume", "@DEFAULT_SINK@", f"{vol}%"])
def toggle_mute():
    subprocess.run(["pactl", "set-sink-mute", "@DEFAULT_SINK@", "toggle"])

class Handler(BaseHTTPRequestHandler):
    def do_GET(self):
        if self.path == "/volume":
            self.send_response(200); self.send_header("Content-Type", "application/json"); self.end_headers()
            self.wfile.write(json.dumps(get_volume()).encode())
    def do_POST(self):
        length = int(self.headers["Content-Length"])
        data = self.rfile.read(length).decode()
        if self.path == "/volume":
            vol = json.loads(data)["volume"]
            set_volume(vol)
        elif self.path == "/mute":
            toggle_mute()
        self.send_response(200); self.end_headers()

HTTPServer(("localhost", 8081), Handler).serve_forever()
