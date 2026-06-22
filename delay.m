release(deviceWriter)
release(deviceReader)

deviceReader = audioDeviceReader('Device', 'Microphone (Live Streamer CAM313 Microphone)', 'SampleRate', 48000);
deviceWriter = audioDeviceWriter('Device', 'Default', 'SampleRate', 48000);
delay = dsp.Delay(4800); % 0.1 s at 48 kHz

while true
    x = deviceReader();
    y = x + 0.5*delay(x);
    deviceWriter(y);
end