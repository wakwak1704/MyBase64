module MyBase64
    class << self
        def encoder(data)
            data = convertTo0b(data)
            data = padWith0(data)
            data = convert6bitString(data)
            padWithEqual(data)
        end

        def decoder(data)
            data = detachWithEqual(data)
            data = convertTo6bit0b(data)
            data = detachWith0(data)
            convertToString(data)
        end

        private
        def convertTo0b(data)
            bit_data = ""
            data.each_char do |c|
                bit_data += format("%08b", c.ord)
            end
            bit_data
        end

        def padWith0(data)
            while data.length % 6 != 0 do
                data += "0"
            end
            data
        end

        def convert6bitString(data)
            conversionTable = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/"
            str_data = ""
            (data.length / 6).times do |i|
                str_data += conversionTable[data[i * 6, 6].to_i(2)]
            end
            str_data
        end

        def padWithEqual(data)
            while data.length % 4 != 0 do
                data += "="
            end
            data
        end

        def detachWithEqual(data)
            while data[data.length - 1] == "=" do
                data.chop!
            end
            data
        end

        def convertTo6bit0b(data)
            conversionTable = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/"
            bit_data = ""
            data.each_char do |c|
                bit_data += format("%06b", conversionTable.index(c))
            end
            bit_data
        end

        def detachWith0(data)
            (data.length % 8).times do
                data.chop!
            end
            data
        end

        def convertToString(data)
            str_data = ""
            (data.length / 8).times do |i|
                str_data += data[i * 8, 8].to_i(2).chr
            end
            str_data
        end
    end
end
