import Foundation





import Foundation

struct StockTimeSeriesResponse: Codable {
    let metadata: MetaData
    let timeSeries: [String: TimeSeries]

    enum CodingKeys: String, CodingKey {
        case metadata = "Meta Data"
        case timeSeries = "Time Series (Daily)"
    }
}

struct MetaData: Codable {
    let information, symbol, lastRefreshed, outputSize: String
    let timezone: String

    enum CodingKeys: String, CodingKey {
        case information = "1. Information"
        case symbol = "2. Symbol"
        case lastRefreshed = "3. Last Refreshed"
        case outputSize = "4. Output Size"
        case timezone = "5. Time Zone"
    }
}

struct TimeSeries: Codable {
    let open, high, low, close, volume: String


    enum CodingKeys: String, CodingKey {
        case open = "1. open"
        case high = "2. high"
        case low = "3. low"
        case close = "4. close"
        case volume = "5. volume"
    }
}



