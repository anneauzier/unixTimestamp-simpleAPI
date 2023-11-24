import Vapor

struct DataRequest: Content {
    let date: String
}

struct ConvertedResponse: Content {
    let unix_timestamp: Int
}

struct ErrorRequested: Content {
    let error: String
}

func routes(_ app: Application) throws {
    app.post("converter") { req -> EventLoopFuture<Response> in

        let requestData = try req.content.decode(DataRequest.self)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/mm/yyyy"

        guard let date = dateFormatter.date(from: requestData.date) else {
            let error = ErrorRequested(error: "Formato de data inválido. Use dd/mm/yyyy.")
            return error.encodeResponse(status: .badRequest, for: req)
        }

        let unixTimestamp = Int(date.timeIntervalSince1970)
        let response = ConvertedResponse(unix_timestamp: unixTimestamp)
        
        return response.encodeResponse(status: .ok, for: req)
    }
}



