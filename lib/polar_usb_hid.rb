module PolarUsb
  class HidController < BaseController
    PACKET_SIZE = 64

    def initialize(options)
      @usb_vendor = 0x0da4
      @usb_product = 0x0008

      @usb_context = LIBUSB::Context.new
      @device = @usb_context.devices(idVendor: @usb_vendor, idProduct: @usb_product).first
      raise PolarUsbDeviceNotFound.new "Could not find Polar USB device" unless @device

      usb_reset_device_access
      @handle = @device.open.claim_interface(0)

      self.product = @device.product
      self.serial_number = @device.serial_number
      STDERR.write "Connected to #{self.product} serial #{self.serial_number}\n"

    rescue LIBUSB::ERROR_ACCESS
      raise PolarUsbDeviceError.new "No permission to access Polar USB device"
    rescue LIBUSB::ERROR_BUSY
      raise PolarUsbDeviceError.new "Polar USB device is busy"
    end

    def request(data = nil)
      packet_num = 0

      packet = []
      packet[0] = 1
      packet[1] = (data.length+2) << 2
      packet[2] = packet_num
      packet += data.bytes

      usb_write packet

      read
    end

    def read
      packet_num = 0
      initial_packet = true
      response = []

      loop do
        packet = usb_read

        # Byte 0   = packet type = 0x11
        # Byte 1   = packet size << 2 (| 0x1 for more | 0x2 for a notification)
        # Byte 2   = packet number
        # Byte 3.. = payload

        raise PolarUsbProtocolError.new "Unknown packet type #{packet[0]}?", packet if packet[0] != 0x11
        size = packet[1] >> 2
        has_more = (packet[1] & 0x01) != 0
        is_notification = (packet[1] & 0x02) != 0

        start = 3
        size -= 2

        if is_notification
          process_notification packet[start..-1]
          next
        end

        if initial_packet
          # Two more status bytes before the actual payload
          process_error packet[start..-1] if packet[start] != 0
          size -= 2
          start += 2
          initial_packet = false
        end

        raise PolarUsbProtocolError.new "Expecting packet number #{packet_num}, got #{packet[2]}", packet if packet_num != packet[2]

        size -= 1 unless has_more # Remove trailing 0x0 of final packet
        response += packet[start..start + size]

        return response.pack("C*") unless has_more

        # Send ack and go to next iteration for next packet
        packet = []
        packet[0] = 1
        packet[1] = 1 << 2 | 0x01
        packet[2] = packet_num

        usb_write packet

        if packet_num == 0xff
          packet_num = 0
        else
          packet_num += 1
        end
      end
    end

    private

    def usb_reset_device_access
      device = @usb_context.devices(idVendor: @usb_vendor, idProduct: @usb_product).first
      if device
        handle = device.open
        handle.detach_kernel_driver(0)
        handle.close
      end
    rescue
    end

    def usb_read
      data = @handle.interrupt_transfer(
        :endpoint => 1|LIBUSB::ENDPOINT_IN,
        :dataIn => PACKET_SIZE,
        :timeout => 100
      ).bytes
      #puts "DEBUG: read #{data.map { |i| i.to_s(16) }.join(' ')}"
      data
    end

    def usb_write(packet)
      if packet.length < PACKET_SIZE
        # Pad packet up to PACKET_SIZE
        packet += [ 0 ] * (PACKET_SIZE - packet.length)
      end
      #puts "DEBUG: write #{packet.map { |i| i.to_s(16) }.join(' ')}"
      @handle.interrupt_transfer(
        :endpoint => 1|LIBUSB::ENDPOINT_OUT,
        :dataOut => packet.pack("C*"),
        :timeout => 100
      )
    end
  end
end
