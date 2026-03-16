import Foundation
import UIKit

struct ExportService {

    static func generateCSV(from measurements: [LuxMeasurement]) -> URL? {
        let lang = LanguageManager.shared
        let headers = [lang.s("Datum"), "Lux", lang.s("Notiz"), lang.s("Profil"), lang.s("Standort"), lang.s("Breitengrad"), lang.s("Längengrad"), "ISO", lang.s("Belichtung"), lang.s("Gerät")]
        var csv = headers.joined(separator: ";") + "\n"

        for m in measurements {
            let date = m.timestamp?.formattedCSV ?? "-"
            let lux = m.luxValue.formattedLux
            let note = (m.note ?? "").replacingOccurrences(of: ";", with: ",")
            let profile = m.profileName ?? "-"
            let location = m.locationName ?? "-"
            let lat = m.hasLocation ? String(format: "%.6f", m.latitude) : "-"
            let lon = m.hasLocation ? String(format: "%.6f", m.longitude) : "-"
            let iso = m.iso > 0 ? String(format: "%.0f", m.iso) : "-"
            let exposure = m.exposureDuration > 0 ? m.formattedExposure : "-"
            let device = m.deviceModel ?? "-"

            csv += "\(date);\(lux);\(note);\(profile);\(location);\(lat);\(lon);\(iso);\(exposure);\(device)\n"
        }

        let fileName = "LuxMaster_Export_\(Date().formattedCSV.replacingOccurrences(of: ":", with: "-")).csv"
        let tempURL = FileManager.default.temporaryDirectory.appendingPathComponent(fileName)

        do {
            try csv.write(to: tempURL, atomically: true, encoding: .utf8)
            return tempURL
        } catch {
            return nil
        }
    }

    static func generatePDF(from measurements: [LuxMeasurement], title: String? = nil) -> URL? {
        let lang = LanguageManager.shared
        let pdfTitle = title ?? lang.s("LuxMaster Messbericht")
        let pageSize = CGSize(width: 595, height: 842)
        let margin: CGFloat = 40
        let contentWidth = pageSize.width - 2 * margin

        let renderer = UIGraphicsPDFRenderer(bounds: CGRect(origin: .zero, size: pageSize))

        let data = renderer.pdfData { context in
            context.beginPage()
            var yPosition: CGFloat = margin

            let titleAttrs: [NSAttributedString.Key: Any] = [
                .font: UIFont.boldSystemFont(ofSize: 22),
                .foregroundColor: UIColor.label
            ]
            (pdfTitle as NSString).draw(at: CGPoint(x: margin, y: yPosition), withAttributes: titleAttrs)
            yPosition += 35

            let dateAttrs: [NSAttributedString.Key: Any] = [
                .font: UIFont.systemFont(ofSize: 11),
                .foregroundColor: UIColor.secondaryLabel
            ]
            (lang.s("Erstellt: %@", Date().formattedLong) as NSString).draw(at: CGPoint(x: margin, y: yPosition), withAttributes: dateAttrs)
            yPosition += 25

            if !measurements.isEmpty {
                let luxValues = measurements.map(\.luxValue)
                let avg = luxValues.reduce(0, +) / Double(luxValues.count)
                let summaryAttrs: [NSAttributedString.Key: Any] = [
                    .font: UIFont.systemFont(ofSize: 12),
                    .foregroundColor: UIColor.label
                ]
                let summary = lang.s("Messungen: %d  |  Min: %@  |  Max: %@  |  Durchschnitt: %@", measurements.count, (luxValues.min() ?? 0).formattedLuxWithUnit, (luxValues.max() ?? 0).formattedLuxWithUnit, avg.formattedLuxWithUnit)
                (summary as NSString).draw(at: CGPoint(x: margin, y: yPosition), withAttributes: summaryAttrs)
                yPosition += 30
            }

            let separatorPath = UIBezierPath()
            separatorPath.move(to: CGPoint(x: margin, y: yPosition))
            separatorPath.addLine(to: CGPoint(x: margin + contentWidth, y: yPosition))
            UIColor.separator.setStroke()
            separatorPath.stroke()
            yPosition += 15

            let headerAttrs: [NSAttributedString.Key: Any] = [
                .font: UIFont.boldSystemFont(ofSize: 10),
                .foregroundColor: UIColor.label
            ]
            let columns: [(String, CGFloat)] = [
                (lang.s("Datum"), 0), ("Lux", 160), (lang.s("Profil"), 240), (lang.s("Notiz"), 330), (lang.s("Standort"), 430)
            ]
            for (label, x) in columns {
                (label as NSString).draw(at: CGPoint(x: margin + x, y: yPosition), withAttributes: headerAttrs)
            }
            yPosition += 20

            let rowAttrs: [NSAttributedString.Key: Any] = [
                .font: UIFont.systemFont(ofSize: 9),
                .foregroundColor: UIColor.label
            ]
            let maxY = pageSize.height - margin - 30

            for measurement in measurements {
                if yPosition > maxY {
                    context.beginPage()
                    yPosition = margin
                }

                let rowData: [(String, CGFloat)] = [
                    (measurement.timestamp?.formattedShort ?? "-", 0),
                    (measurement.luxValue.formattedLuxWithUnit, 160),
                    (measurement.profileName ?? "-", 240),
                    (String((measurement.note ?? "-").prefix(25)), 330),
                    (String((measurement.locationName ?? "-").prefix(20)), 430)
                ]

                for (text, x) in rowData {
                    (text as NSString).draw(at: CGPoint(x: margin + x, y: yPosition), withAttributes: rowAttrs)
                }
                yPosition += 16
            }

            let footerAttrs: [NSAttributedString.Key: Any] = [
                .font: UIFont.systemFont(ofSize: 8),
                .foregroundColor: UIColor.tertiaryLabel
            ]
            (lang.s("Generiert mit LuxMaster") as NSString).draw(
                at: CGPoint(x: margin, y: pageSize.height - margin),
                withAttributes: footerAttrs
            )
        }

        let fileName = "LuxMaster_Report_\(Date().formattedCSV.replacingOccurrences(of: ":", with: "-")).pdf"
        let tempURL = FileManager.default.temporaryDirectory.appendingPathComponent(fileName)

        do {
            try data.write(to: tempURL)
            return tempURL
        } catch {
            return nil
        }
    }
}
