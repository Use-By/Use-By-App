import Foundation

func getExpirationDate(useByDate: Date?, afterOpeningDate: Date?) -> Date {
    if let useByDate = useByDate, let afterOpeningDate = afterOpeningDate {
        return useByDate < afterOpeningDate ? useByDate : afterOpeningDate
    }

    if let useByDate = useByDate {
        return useByDate
    }

    if let afterOpeningDate = afterOpeningDate {
        return afterOpeningDate
    }

    return Date()
}
