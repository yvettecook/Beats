//
//  MockPeripheral.swift
//  Beats
//
//  Created by Yvette Cook on 11/01/2016.
//  Copyright © 2016 Yvette. All rights reserved.
//

import CoreBluetooth

class MockPeripheral : NSObject {
    
    var delegate: MockPeripheralDelegate?
    
    var services: [CBService]?
    var heartRateService: CBService?
    
    var notifyOnHRUpdate = false
    
    var availableHRs: [Int]?
    
    override init() {
        self.services = [CBService]()
        super.init()
        self.heartRateService = createHRService()
    }
    
    func discoverServices(serviceUUIDS: [CBUUID]?) {
        didDiscoverServicesCalled = true
        guard let service = heartRateService else { return }
        services?.append(service)
        delegate?.peripheral(self, didDiscoverServices: nil)
    }
    
    func discoverCharacteristics(characteristicUUIDs: [CBUUID]?, forService service: CBService) {
        delegate?.peripheral(self, didDiscoverCharacteristics: nil)
    }
    
    
    // MARK: Method flags
    
    var didDiscoverServicesCalled = false
    var updateHRCalled = false
    
    
    // MARK: Services
    
    func createHRService() -> CBService {
        let heartRateService = CBMutableService.init(type: CBUUID(string: "180D"), primary: true)
        
        let measurementUUID = CBUUID(string: "2A37")
        let properties = CBCharacteristicProperties.Notify
        let permissions = CBAttributePermissions.Writeable
        
        let heartRateMeasurementCharacteristic = MockCharacteristic.init(type: measurementUUID, properties: properties, permissions: permissions)
        
        heartRateService.characteristics = [heartRateMeasurementCharacteristic]
        
        return heartRateService
    }
    
    // MARK: Characteristics
    
    func setNotifyValue(enabled: Bool, forCharacteristic characteristic: CBCharacteristic) {
        if characteristic == getHeartRateMeasurementCharacteristic() {
            notifyOnHRUpdate = true
        }
    }
    
    func writeValue(data: NSData, forCharacteristic characteristic: CBCharacteristic, type: CBCharacteristicWriteType) {
        
        // NEED TO WRITE TO THE CHARACTERISTIC'S VALUE HERE
        
        guard let mockChar = characteristic as? MockCharacteristic else {
            print("Not MockCharacteristic")
            return
        }
        
        mockChar.mockValue = data
        delegate?.peripheral(self, didUpdateValueForCharacteristic: mockChar, error: nil)
    }
    
}

extension MockPeripheral {

    // MARK: Heart Rare
    
    func setHeartRateMode(mode: MockHeartRateMode) {
        switch mode {
        case .SteadyResting:
            let average = 61
            availableHRs = [average - 2, average - 1, average, average + 1, average + 2]
            startPulse()
        }
    }
    
    func startPulse() {
        let pulseTimer = NSTimer(timeInterval: 0.5,
                                 target: self,
                                 selector: "updateHR",
                                 userInfo: nil,
                                 repeats: true)
        
        NSRunLoop.mainRunLoop().addTimer(pulseTimer, forMode: NSRunLoopCommonModes)
    }
    
    func updateHR() {
        guard
            let currentHeartRate = availableHRs?.randomItem(),
            let characteristic = getHeartRateMeasurementCharacteristic()
            else { return }
        
        updateHRCalled = true
        let data = heartRateToNSData(currentHeartRate)
        writeValue(data, forCharacteristic: characteristic, type: .WithoutResponse)
    }
    
    func heartRateToNSData(var hr: Int) -> NSData {
        let data = NSData(bytes: &hr, length: sizeof(Int))
        return data
    }

}

extension MockPeripheral {
    
    func getHeartRateService() -> CBService? {
        guard let services = self.services else { return nil }
        
        for service in services {
            if service.UUID.UUIDString == "180D" { return service }
        }
        
        return nil
    }
    
    func getHeartRateMeasurementCharacteristic() -> CBCharacteristic? {
        guard
            let hrService = getHeartRateService(),
            let characteristics = hrService.characteristics
            else { return nil }
        
        for characteristic in characteristics {
            if characteristic.UUID.UUIDString == "2A37" {
                return characteristic
            }
        }
        
        return nil
    }
    
}