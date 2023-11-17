# Unix Timestamp API with Vapor

A simple unix timestamp converter API made in Swift.

## Usage

#### Converting UTC date 🕑

<summary><code>POST</code> <code><b>/converter</b></code></summary>

##### Parameters

> | name      |  type     | data type               | body                                                                  |
> |-----------|-----------|-------------------------|-----------------------------------------------------------------------|
> | Date      |  required | JSON                    | { "date": "dd/mm/yyyy" } |


##### Responses

> | http code     | content-type                      | response                                                            |
> |---------------|-----------------------------------|---------------------------------------------------------------------|
> | `200`         | `text/plain;charset=UTF-8`        | `{ "unix_timestamp": 1234567890 }`                                  |
> | `400`         | `application/json`                | `{ "error": "Formato de data inválido. Use dd/mm/yyyy." }`          |

### How I made it 🙋🏻‍♀️

First, I created three structs for each data I had to deal with, all of them of type Content.

```
struct DataRequest: Content { let date: String }                                                                        
struct ConvertedResponse: Content { let unixTimestamp: Int }                                                                                                                                |
struct ErrorRequested: Content { let error: String }
```

Second, I made the logic to convert date in unix time stamp.

I convert the data from `"dd/mm/yyyy"` to a object `Date` type with `DateFormatter`. 
```
let requestData = try req.content.decode(DataRequest.self)
let dateFormatter = DateFormatter()
dateFormatter.dateFormat = "dd/mm/y
```
If the conversion is successful, the code calculates the Unix timestamp and creates a response in JSON format containig that Unix timestamp.

```
let unixTimestamp = Int(date.timeIntervalSince1970)
let response = ConvertedResponse(unixTimestamp: unixTimestamp)
       
return response.encodeResponse(status: .ok, for: req)
```
If the date conversion fails, and error its generated indicating that the date format is invalid, and an error response is sent back.

```
let error = ErrorRequested(error: "Formato de data inválido. Use dd/mm/yyyy.")
return error.encodeResponse(status: .badRequest, for: req)
```
