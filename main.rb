# load 'base64.rb'
load 'myBase64.rb'

def main(argv)
    inputFileName = ""
    outputFileName = ""
    e = false
    d = false
    argv.count.times do |i|
        case argv[i]
        when "-i" then
            inputFileName = argv[i + 1]
        when "-o" then
            outputFileName = argv[i + 1]
        when "-d" then
            d = true
        when "-e" then
            e = true
        end
    end

    exit 1 if inputFileName.length == 0 || outputFileName.length == 0

    File.open(inputFileName, "r") do |file|
        @inputString = file.read
    end
    @outputFile = File.open(outputFileName, "w")

    if e & d then
        @outputFile.puts MyBase64.decoder(@inputString.chop)
    else
        @outputFile.puts MyBase64.encoder(@inputString)
    end

    @outputFile.close
end

main(ARGV)
