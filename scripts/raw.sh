mkdir -p ~/.config/cava
cat > ~/.config/cava/bar_config <<EOF
[general]
bars = 20
framerate = 60
output = raw
[input]
method = pulse
source = auto
[output]
method = raw
raw_target = /tmp/cava.fifo
bit_format = 16bit
EOF
cava -p ~/.config/cava/bar_config &
