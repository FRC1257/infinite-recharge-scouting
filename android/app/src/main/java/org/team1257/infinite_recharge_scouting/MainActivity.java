package org.team1257.deep_space_scouting;

import android.bluetooth.BluetoothAdapter;
import android.bluetooth.BluetoothDevice;
import android.bluetooth.BluetoothServerSocket;
import android.bluetooth.BluetoothSocket;
import android.content.Context;
import android.os.Bundle;

import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.ArrayList;
import java.util.List;
import java.util.Set;
import java.util.UUID;

import io.flutter.app.FlutterActivity;
import io.flutter.plugins.GeneratedPluginRegistrant;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;

public class MainActivity extends FlutterActivity {
    private static final UUID uuid = UUID.fromString("8ce255c0-200a-11e0-ac64-0800200c9a66");
    private final BluetoothAdapter ba = BluetoothAdapter.getDefaultAdapter();
    Context c = MainActivity.this;
    private AcceptThread at;
    private ConnectThread ct;
    private BluetoothDevice device;
    private UUID devuuid;
    private ConnectedThread cdt;
    private String incomingMessage = "";
    private MethodChannel channel;
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        GeneratedPluginRegistrant.registerWith(this);
        channel = new MethodChannel(getFlutterView(), "org.team1257.deepspacescouting/send");
        new MethodChannel(getFlutterView(), "org.team1257.deepspacescouting/send").setMethodCallHandler(
                new MethodCallHandler() {
                    @Override
                    public void onMethodCall(MethodCall call, Result result) {
                        if (call.method.equals("getDeviceNames")) {
                            List<String> devs = getPairedNames();
                            result.success(devs);
                        }
                        if (call.method.equals("acceptConnections")) {
                            pairDevice(call.argument("name"));
                            result.success("");
                        }
                        if (call.method.equals("sendData")) {
                            pairDevices(call.argument("name"));
                            sendMessage(call.argument("data"));
                        }
                    }
                }
        );
    }
    private class AcceptThread extends Thread {
        private final BluetoothServerSocket ss;
        public AcceptThread() {
            BluetoothServerSocket tmp = null;
            try {
                tmp = ba.listenUsingInsecureRfcommWithServiceRecord("deep_space_scouting", uuid);
            } catch (IOException e) {
                e.printStackTrace();
            }
            ss = tmp;
        }
        public void run() {
            BluetoothSocket socket = null;
            while (true) {
                try {
                    socket = ss.accept();
                } catch (IOException e) {
                    e.printStackTrace();
                    break;
                }
                if (socket != null) {
                    connected(socket, device);
                    try {
                        ss.close();
                    } catch (IOException e) {
                        e.printStackTrace();
                    }
                    break;
                }
            }
        }
        public void cancel() {
            try {
                ss.close();
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
    }
    private class ConnectThread extends Thread {
        private BluetoothSocket socket;
        public ConnectThread(BluetoothDevice adevice, UUID auuid) {
            device = adevice;
            devuuid = auuid;
            BluetoothSocket tmp = null;
            try {
                tmp = device.createInsecureRfcommSocketToServiceRecord(devuuid);
            } catch (IOException e) {
                e.printStackTrace();
            }
            socket = tmp;
        }
        public void run() {
            ba.cancelDiscovery();
            try {
                socket.connect();
            } catch (IOException e) {
                try {
                    socket = (BluetoothSocket) device.getClass().getMethod("createRfcommSocket", new Class[] {int.class}).invoke(device,1);
                    socket.connect();
                } catch (Exception f) {
                    f.printStackTrace();
                }
            }
            connected(socket, device);
        }
        public void cancel() {
            try {
                socket.close();
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
    }
    private class ConnectedThread extends Thread {
        private final BluetoothSocket socket;
        private final InputStream in;
        private final OutputStream out;
        public ConnectedThread(BluetoothSocket asocket) {
            socket = asocket;
            InputStream tmpin = null;
            OutputStream tmpout = null;
            try {
                tmpin = socket.getInputStream();
                tmpout = socket.getOutputStream();
            } catch (IOException e) {
                e.printStackTrace();
            }
            in = tmpin;
            out = tmpout;
        }
        public void run() {
            byte[] buffer = new byte[1024];
            int bytes;
            while (true) {
                try {
                    bytes = in.read(buffer);
                    incomingMessage = new String(buffer, 0, bytes);
                    runOnUiThread(new Runnable() {
                        @Override
                        public void run() {
                            channel.invokeMethod("accept", incomingMessage);
                        }
                    });
                } catch (IOException e) {
                    e.printStackTrace();
                    break;
                }
            }
        }
        public void write(byte[] bytes) {
            try {
                out.write(bytes);
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
        public void cancel() {
            try {
                socket.close();
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
    }
    private void connected(BluetoothSocket asocket, BluetoothDevice adevice) {
        cdt = new ConnectedThread(asocket);
        cdt.start();
    }
    public void pairDevice(String name) {
        Set<BluetoothDevice> pairedDevices = ba.getBondedDevices();
        if (pairedDevices.size() > 0) {
            Object[] devices = pairedDevices.toArray();
            BluetoothDevice device = (BluetoothDevice) devices[0];
            for (Object d : devices) {
                if (((BluetoothDevice) d).getName().equals(name)) {
                    device = (BluetoothDevice) d;
                    break;
                }
            }
            AcceptThread accept = new AcceptThread();
            accept.start();
            ConnectThread connect = new ConnectThread(device, uuid);
            connect.start();
        }
    }
    public void pairDevices(String name) {
        Set<BluetoothDevice> pairedDevices = ba.getBondedDevices();
        if (pairedDevices.size() > 0) {
            Object[] devices = pairedDevices.toArray();
            BluetoothDevice device = (BluetoothDevice) devices[0];
            for (Object d : devices) {
                if (((BluetoothDevice) d).getName().equals(name)) {
                    device = (BluetoothDevice) d;
                    break;
                }
            }
            AcceptThread accept = new AcceptThread();
            accept.start();
            ConnectThread connect = new ConnectThread(device, uuid);
            connect.start();
        }
    }
    public List<String> getPairedNames() {
        Set<BluetoothDevice> pairedDevices = ba.getBondedDevices();
        Object[] devices = pairedDevices.toArray();
        int len = devices.length;
        List<String> paired = new ArrayList<>();
        for (int i = 0; i < len; i++) {
            paired.add(((BluetoothDevice) devices[i]).getName());
        }
        return paired;
    }
    public void sendMessage(String s) {
        byte[] bytes = s.getBytes();
        cdt.write(bytes);
    }
}
