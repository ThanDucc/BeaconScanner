# BeaconScanner

A description of this package.

Usage:

1. Create variable Beacon with array UUID which need to scan

- beaconScanner = BeaconScanner(uuid: [])

2. Set up Location Manager

- beaconScanner?.setupLocationManager()

3. Delegate to current class

- beaconScanner?.delegate = self

4. Start scanning

- beaconScanner?.startScanning()

5. Stop scanning

- beaconScanner?.stopScanning()

6. Handle when scan successfully 

- in func rangingBeacon(beacons: [CLBeacon]) {
        //
    }
