import Foundation

protocol HTTPResponseDescription {
    var statusCode: Int { get }
    var description: String { get }
}

enum NSURLErrorCode: Error, HTTPResponseDescription {

    case unknown
    case invalidResponse
    case badURL
    case timedOut
    case decodingError
    case outOfRange(Int)
    
    init(code: Int) {
        switch code {
        case 0: self = .unknown
        case 1: self = .invalidResponse
        case 2: self = .badURL
        case 3: self = .timedOut
        default:  self = .outOfRange(code)
        }
    }
    
    var statusCode: Int {
        switch self {
        case .unknown: return 0
        case .invalidResponse: return 1
        case .badURL: return 2
        case .timedOut: return 3
        case .decodingError: return 4
        case .outOfRange(let code): return code
        }
    }
    
    var description: String {
        switch self {
        case .badURL: return "The URL was malformed."
        case .invalidResponse: return "Invalid response"
        case .decodingError: return "Failed to decode the response."
        case .outOfRange(let statusCode): return "The request \(statusCode) was out of range."
        case .unknown: return "An unknown error occurred."
        case .timedOut: return "The request timed out."
            
        }
    }
}

/// 1..x
enum InformationalResponse: Error, HTTPResponseDescription {
    case continueResponse
    case switchingProtocols
    case processingDeprecated
    case earlyHints
    case unknown(Int)

    init(code: Int) {
        switch code {
        case 100: self = .continueResponse
        case 101: self = .switchingProtocols
        case 102: self = .processingDeprecated
        case 103: self = .earlyHints
        default:  self = .unknown(code)
        }
    }
    
    var statusCode: Int {
        switch self {
        case .continueResponse:     return 100
        case .switchingProtocols:   return 101
        case .processingDeprecated: return 102
        case .earlyHints:           return 103
        case .unknown(let code):    return code
        }
    }
    
    var description: String {
        switch self {
        case .continueResponse:     return "Continue"
        case .switchingProtocols:   return "Switching Protocols"
        case .processingDeprecated: return "Processing"
        case .earlyHints:           return "Early Hints"
        case .unknown(let code):    return "Unknown code: \(code)"
        }
    }
    
}

/// 2..x
enum SuccessfulResponses: Error, Equatable, HTTPResponseDescription {
    case ok
    case created
    case accepted
    case nonAuthoritativeInformation
    case noContent
    case resetContent
    case partialContent
    case multiStatus
    case alreadyReported
    case imUsed
    case unknown(Int)
    
    init(code: Int) {
        switch code {
        case 200: self = .ok
        case 201: self = .created
        case 202: self = .accepted
        case 203: self = .nonAuthoritativeInformation
        case 204: self = .noContent
        case 205: self = .resetContent
        case 206: self = .partialContent
        case 207: self = .multiStatus
        case 208: self = .alreadyReported
        case 226: self = .imUsed
        default:  self = .unknown(code)
        }
    }

    var statusCode: Int {
        switch self {
        case .ok:                           return 200
        case .created:                      return 201
        case .accepted:                     return 202
        case .nonAuthoritativeInformation:  return 203
        case .noContent:                    return 204
        case .resetContent:                 return 205
        case .partialContent:               return 206
        case .multiStatus:                  return 207
        case .alreadyReported:              return 208
        case .imUsed:                       return 226
        case .unknown(let code):            return code
        }
    }

    var description: String {
        switch self {
        case .ok:
            return "OK"
        case .created:
            return "Created"
        case .accepted:
            return "Accepted"
        case .nonAuthoritativeInformation:
            return "Non-Authoritative Information"
        case .noContent:
            return "No Content"
        case .resetContent:
            return "Reset Content"
        case .partialContent:
            return "Partial Content"
        case .multiStatus:
            return "Multi-Status"
        case .alreadyReported:
            return "Already Reported"
        case .imUsed:
            return "IM Used"
        case .unknown(let code):
            return "Unknown Success code: \(code)"
        }
    }
}

/// 3..x
enum RedirectionMessages: Error, HTTPResponseDescription {
    case useProxy
    case found
    case seeOther
    case notModified
    case useProxyForAuthentication
    case temporaryRedirect
    case permanentRedirect
    case unknown(Int)
    
    init(code: Int) {
        switch code {
        case 300: self = .useProxy
        case 302: self = .found
        case 303: self = .seeOther
        case 304: self = .notModified
        case 305: self = .useProxyForAuthentication
        case 307: self = .temporaryRedirect
        case 308: self = .permanentRedirect
        default:  self = .unknown(code)
        }
    }

    var statusCode: Int {
        switch self {
        case .useProxy:                   return 300
        case .found:                      return 302
        case .seeOther:                   return 303
        case .notModified:                return 304
        case .useProxyForAuthentication:  return 305
        case .temporaryRedirect:          return 307
        case .permanentRedirect:          return 308
        case .unknown(let code):          return code
        }
    }

    var description: String {
        switch self {
        case .useProxy:
            return "Multiple Choices" // Исторически 300 — это Multiple Choices
        case .found:
            return "Found"
        case .seeOther:
            return "See Other"
        case .notModified:
            return "Not Modified"
        case .useProxyForAuthentication:
            return "Use Proxy"
        case .temporaryRedirect:
            return "Temporary Redirect"
        case .permanentRedirect:
            return "Permanent Redirect"
        case .unknown(let code):
            return "Unknown Redirection code: \(code)"
        }
    }
}
/// 4..x
enum ClientErrorResponses: Error, HTTPResponseDescription {
    case badRequest
    case unauthorized
    case forbidden
    case notFound
    case methodNotAllowed
    case notAcceptable
    case proxyAuthenticationRequired
    case requestTimeout
    case conflict
    case gone
    case lengthRequired
    case preconditionFailed
    case payloadTooLarge
    case URITooLong
    case unsupportedMediaType
    case rangeNotSatisfiable
    case expectationFailed
    case misdirectedRequest
    case unProcessableEntity
    case locked
    case failedDependency
    case upgradeRequired
    case preconditionRequired
    case tooManyRequests
    case requestHeaderFieldsTooLarge
    case unavailableForLegalReasons
    case unknown(Int)

    init(code: Int) {
        switch code {
        case 400: self = .badRequest
        case 401: self = .unauthorized
        case 403: self = .forbidden
        case 404: self = .notFound
        case 405: self = .methodNotAllowed
        case 406: self = .notAcceptable
        case 407: self = .proxyAuthenticationRequired
        case 408: self = .requestTimeout
        case 409: self = .conflict
        case 410: self = .gone
        case 411: self = .lengthRequired
        case 412: self = .preconditionFailed
        case 413: self = .payloadTooLarge
        case 414: self = .URITooLong
        case 415: self = .unsupportedMediaType
        case 416: self = .rangeNotSatisfiable
        case 417: self = .expectationFailed
        case 421: self = .misdirectedRequest
        case 422: self = .unProcessableEntity
        case 423: self = .locked
        case 424: self = .failedDependency
        case 426: self = .upgradeRequired
        case 428: self = .preconditionRequired
        case 429: self = .tooManyRequests
        case 431: self = .requestHeaderFieldsTooLarge
        case 451: self = .unavailableForLegalReasons
        default:  self = .unknown(code)
        }
    }

    var statusCode: Int {
        switch self {
        case .badRequest:                   return 400
        case .unauthorized:                 return 401
        case .forbidden:                    return 403
        case .notFound:                     return 404
        case .methodNotAllowed:             return 405
        case .notAcceptable:                return 406
        case .proxyAuthenticationRequired:  return 407
        case .requestTimeout:               return 408
        case .conflict:                     return 409
        case .gone:                         return 410
        case .lengthRequired:               return 411
        case .preconditionFailed:           return 412
        case .payloadTooLarge:              return 413
        case .URITooLong:                   return 414
        case .unsupportedMediaType:         return 415
        case .rangeNotSatisfiable:          return 416
        case .expectationFailed:            return 417
        case .misdirectedRequest:           return 421
        case .unProcessableEntity:          return 422
        case .locked:                       return 423
        case .failedDependency:             return 424
        case .upgradeRequired:              return 426
        case .preconditionRequired:         return 428
        case .tooManyRequests:              return 429
        case .requestHeaderFieldsTooLarge:  return 431
        case .unavailableForLegalReasons:   return 451
        case .unknown(let code):            return code
        }
    }

    var description: String {
        switch self {
        case .badRequest:                   return "Bad Request"
        case .unauthorized:                 return "Unauthorized"
        case .forbidden:                    return "Forbidden"
        case .notFound:                     return "Not Found"
        case .methodNotAllowed:             return "Method Not Allowed"
        case .notAcceptable:                return "Not Acceptable"
        case .proxyAuthenticationRequired:  return "Proxy Authentication Required"
        case .requestTimeout:               return "Request Timeout"
        case .conflict:                     return "Conflict"
        case .gone:                         return "Gone"
        case .lengthRequired:               return "Length Required"
        case .preconditionFailed:           return "Precondition Failed"
        case .payloadTooLarge:              return "Payload Too Large"
        case .URITooLong:                   return "URI Too Long"
        case .unsupportedMediaType:         return "Unsupported Media Type"
        case .rangeNotSatisfiable:          return "Range Not Satisfiable"
        case .expectationFailed:            return "Expectation Failed"
        case .misdirectedRequest:           return "Misdirected Request"
        case .unProcessableEntity:          return "Unprocessable Entity"
        case .locked:                       return "Locked"
        case .failedDependency:             return "Failed Dependency"
        case .upgradeRequired:              return "Upgrade Required"
        case .preconditionRequired:         return "Precondition Required"
        case .tooManyRequests:              return "Too Many Requests"
        case .requestHeaderFieldsTooLarge:  return "Request Header Fields Too Large"
        case .unavailableForLegalReasons:   return "Unavailable For Legal Reasons"
        case .unknown(let code):            return "Unknown Client Error code: \(code)"
        }
    }
}

/// 5..x
enum ServerErrorResponses: Error, HTTPResponseDescription {
    case internalServerError
    case notImplemented
    case badGateway
    case serviceUnavailable
    case gatewayTimeout
    case httpVersionNotSupported
    case variantAlsoNegotiates
    case insufficientStorage
    case loopDetected
    case notExtended
    case networkAuthenticationRequired
    case unknown(Int)

    init(code: Int) {
        switch code {
        case 500: self = .internalServerError
        case 501: self = .notImplemented
        case 502: self = .badGateway
        case 503: self = .serviceUnavailable
        case 504: self = .gatewayTimeout
        case 505: self = .httpVersionNotSupported
        case 506: self = .variantAlsoNegotiates
        case 507: self = .insufficientStorage
        case 508: self = .loopDetected
        case 510: self = .notExtended
        case 511: self = .networkAuthenticationRequired
        default:  self = .unknown(code)
        }
    }

    var statusCode: Int {
        switch self {
        case .internalServerError:           return 500
        case .notImplemented:                return 501
        case .badGateway:                    return 502
        case .serviceUnavailable:            return 503
        case .gatewayTimeout:                return 504
        case .httpVersionNotSupported:       return 505
        case .variantAlsoNegotiates:         return 506
        case .insufficientStorage:           return 507
        case .loopDetected:                  return 508
        case .notExtended:                   return 510
        case .networkAuthenticationRequired: return 511
        case .unknown(let code):             return code
        }
    }

    var description: String {
        switch self {
        case .internalServerError:
            return "Internal Server Error"
        case .notImplemented:
            return "Not Implemented"
        case .badGateway:
            return "Bad Gateway"
        case .serviceUnavailable:
            return "Service Unavailable"
        case .gatewayTimeout:
            return "Gateway Timeout"
        case .httpVersionNotSupported:
            return "HTTP Version Not Supported"
        case .variantAlsoNegotiates:
            return "Variant Also Negotiates"
        case .insufficientStorage:
            return "Insufficient Storage"
        case .loopDetected:
            return "Loop Detected"
        case .notExtended:
            return "Not Extended"
        case .networkAuthenticationRequired:
            return "Network Authentication Required"
        case .unknown(let code):
            return "Unknown Server Error code: \(code)"
        }
    }
}

enum NetworkHTTPResponseService: Error, Equatable, HTTPResponseDescription {
    
    static func == (lhs: NetworkHTTPResponseService, rhs: NetworkHTTPResponseService) -> Bool {
        return lhs.statusCode == rhs.statusCode
    }
    
    case informationResponse(InformationalResponse)
    case successfulResponse(SuccessfulResponses)
    case redirectionMessages(RedirectionMessages)
    case clientErrorResponses(ClientErrorResponses)
    case serverErrorResponses(ServerErrorResponses)
    case unknownError(_ status: Int)
    case badRequest(codeError: NSURLErrorCode)

    init(urlResponse: HTTPURLResponse) {
            let statusCode = urlResponse.statusCode
            switch statusCode {
            case 100..<199: self = .informationResponse(InformationalResponse(code: statusCode))
            case 200..<299: self = .successfulResponse(SuccessfulResponses(code: statusCode))
            case 300..<399: self = .redirectionMessages(RedirectionMessages(code: statusCode))
            case 400..<499: self = .clientErrorResponses(ClientErrorResponses(code: statusCode))
            case 500..<599: self = .serverErrorResponses(ServerErrorResponses(code: statusCode))
            default:        self = .unknownError(statusCode)
        }
    }
    
    var successfulStatus: SuccessfulResponses? {
        if case .successfulResponse(let status) = self { return status }
        return nil
    }

    var clientError: ClientErrorResponses? {
        if case .clientErrorResponses(let status) = self { return status }
        return nil
    }

      
    var statusCode: Int {
        switch self {
        case .informationResponse(let code):
            return code.statusCode
        case .successfulResponse(let code):
            return code.statusCode
        case .redirectionMessages(let code):
            return code.statusCode
        case .clientErrorResponses(let code):
            return code.statusCode
        case .serverErrorResponses(let code):
            return code.statusCode
        case .unknownError(let code):
            return code
        case . badRequest(let codeError):
            return codeError.statusCode
        }
    }
    
    var description: String {
        switch self {
            case .informationResponse(statusCode: let code):
            return "Informational Response status code: \(code.description)"
            case .successfulResponse(statusCode: let code):
            return "Successful Response status code: \(code.description)"
            case .redirectionMessages(statusCode: let code):
            return "Redirection Messages status code: \(code.description)"
            case .clientErrorResponses(statusCode: let code):
            return "Client Error Responses status code: \(code.description)"
            case .serverErrorResponses(statusCode: let code):
            return "Server Error Responses status code: \(code.description)"
            case .unknownError(statusCode: let code):
            return "Unknown Error status code: \(code.description)"
        case .badRequest(codeError: let code):
            return "Bad Response status code: \(code.description)"
        }
    }

}
