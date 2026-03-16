import SwiftUI

struct CalibrationView: View {
    @EnvironmentObject var cameraManager: CameraManager
    @EnvironmentObject var calibrationManager: CalibrationManager
    @EnvironmentObject var lang: LanguageManager
    @Environment(\.dismiss) private var dismiss

    @State private var step: CalibrationStep = .intro
    @State private var referenceValue: String = ""
    @State private var measuredValue: Double = 0
    @State private var collectedPoints: [CalibrationPoint] = []

    enum CalibrationStep {
        case intro, measuring, enterReference, pointSaved, result
    }

    var body: some View {
        NavigationStack {
            VStack(spacing: 24) {
                switch step {
                case .intro: introView
                case .measuring: measuringView
                case .enterReference: enterReferenceView
                case .pointSaved: pointSavedView
                case .result: resultView
                }
            }
            .padding()
            .navigationTitle(lang.s("Kalibrierung"))
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button(lang.s("Abbrechen")) { dismiss() }
                }
            }
        }
    }

    private var introView: some View {
        VStack(spacing: 20) {
            Image(systemName: "scope")
                .font(.system(size: 60))
                .foregroundStyle(.blue)

            Text(lang.s("Kalibrierung")).font(.title2.bold())

            Text(lang.s("Um die Messgenauigkeit zu verbessern, kalibriere LuxMaster gegen ein Referenz-Luxmeter oder eine bekannte Lichtquelle."))
                .multilineTextAlignment(.center)
                .foregroundStyle(.secondary)

            VStack(alignment: .leading, spacing: 8) {
                Label(lang.s("Schritt 1: Lichtquelle messen"), systemImage: "1.circle.fill")
                Label(lang.s("Schritt 2: Referenzwert eingeben"), systemImage: "2.circle.fill")
                Label(lang.s("Schritt 3: Weitere Punkte hinzufügen (optional)"), systemImage: "3.circle.fill")
                Label(lang.s("Schritt 4: Kalibrierung speichern"), systemImage: "4.circle.fill")
            }
            .padding()
            .background(.quaternary, in: RoundedRectangle(cornerRadius: 12))

            Spacer()

            Button { step = .measuring } label: {
                Text(lang.s("Kalibrierung starten"))
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 12)
            }
            .buttonStyle(.borderedProminent)
        }
    }

    private var measuringView: some View {
        VStack(spacing: 20) {
            Text(lang.s("Richte die Kamera auf die Lichtquelle")).font(.headline)

            LuxDisplayView(
                luxValue: cameraManager.smoothedLux,
                luxRange: LuxRange.from(lux: cameraManager.smoothedLux)
            )

            InfoBannerView(isCalibrated: false, stability: cameraManager.stability)

            Text(lang.s("Warte bis der Wert stabil ist, dann drücke 'Wert erfassen'."))
                .font(.caption).foregroundStyle(.secondary).multilineTextAlignment(.center)

            Spacer()

            Button {
                measuredValue = cameraManager.smoothedLux
                step = .enterReference
            } label: {
                Text(lang.s("Wert erfassen (%@ Lux)", cameraManager.smoothedLux.formattedLux))
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 12)
            }
            .buttonStyle(.borderedProminent)
            .disabled(cameraManager.stability < 0.5)
        }
    }

    private var enterReferenceView: some View {
        VStack(spacing: 20) {
            Image(systemName: "pencil.and.list.clipboard")
                .font(.system(size: 40))
                .foregroundStyle(.orange)

            Text(lang.s("Referenzwert eingeben")).font(.title3.bold())

            Text(lang.s("Gib den bekannten Lux-Wert ein (von einem Referenz-Luxmeter oder einer bekannten Lichtquelle)."))
                .font(.subheadline).foregroundStyle(.secondary).multilineTextAlignment(.center)

            LabeledContent(lang.s("Gemessener Wert")) {
                Text(measuredValue.formattedLuxWithUnit).bold()
            }

            TextField(lang.s("Referenzwert in Lux"), text: $referenceValue)
                .keyboardType(.decimalPad)
                .textFieldStyle(.roundedBorder)
                .font(.title3)

            Spacer()

            Button { addPoint() } label: {
                Text(lang.s("Punkt speichern"))
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 12)
            }
            .buttonStyle(.borderedProminent)
            .disabled(Double(referenceValue) == nil || (Double(referenceValue) ?? 0) <= 0)
        }
    }

    private var pointSavedView: some View {
        VStack(spacing: 20) {
            Image(systemName: "checkmark.circle.fill")
                .font(.system(size: 40))
                .foregroundStyle(.green)

            Text(lang.s("Kalibrierpunkt gespeichert")).font(.title3.bold())

            VStack(spacing: 8) {
                ForEach(Array(collectedPoints.enumerated()), id: \.offset) { index, point in
                    HStack {
                        Text(lang.s("Punkt %d", index + 1)).font(.subheadline.bold())
                        Spacer()
                        VStack(alignment: .trailing) {
                            Text(lang.s("Gemessen: %@ Lux", point.measuredValue.formattedLux))
                                .font(.caption)
                            Text(lang.s("Referenz: %@ Lux", point.referenceValue.formattedLux))
                                .font(.caption).foregroundStyle(.secondary)
                        }
                    }
                }
            }
            .padding()
            .background(.quaternary, in: RoundedRectangle(cornerRadius: 12))

            Text(lang.s("Für beste Ergebnisse, kalibriere bei 2-5 verschiedenen Helligkeitsstufen."))
                .font(.caption).foregroundStyle(.secondary).multilineTextAlignment(.center)

            Spacer()

            if collectedPoints.count < 5 {
                Button {
                    referenceValue = ""
                    measuredValue = 0
                    step = .measuring
                } label: {
                    Text(lang.s("Weiteren Punkt hinzufügen (%d/5)", collectedPoints.count))
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 12)
                }
                .buttonStyle(.bordered)
            }

            Button { finishCalibration() } label: {
                Text(lang.s("Kalibrierung abschliessen"))
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 12)
            }
            .buttonStyle(.borderedProminent)
        }
    }

    private var resultView: some View {
        VStack(spacing: 20) {
            Image(systemName: "checkmark.seal.fill")
                .font(.system(size: 60))
                .foregroundStyle(.green)

            Text(lang.s("Kalibrierung erfolgreich")).font(.title2.bold())

            if let profile = calibrationManager.activeProfile {
                VStack(spacing: 8) {
                    LabeledContent(lang.s("Kalibrierpunkte"), value: "\(profile.calibrationPoints.count)")
                    if profile.calibrationPoints.count == 1 {
                        LabeledContent(lang.s("Korrekturfaktor"), value: String(format: "%.3f", profile.calibrationFactor))
                    }
                    ForEach(Array(profile.calibrationPoints.enumerated()), id: \.offset) { index, point in
                        LabeledContent(lang.s("Punkt %d", index + 1)) {
                            Text("\(point.measuredValue.formattedLux) \u{2192} \(point.referenceValue.formattedLux) lx")
                        }
                    }
                    LabeledContent(lang.s("Gerät"), value: profile.deviceModel)
                }
                .padding()
                .background(.quaternary, in: RoundedRectangle(cornerRadius: 12))
            }

            Spacer()

            Button { dismiss() } label: {
                Text(lang.s("Fertig")).frame(maxWidth: .infinity).padding(.vertical, 12)
            }
            .buttonStyle(.borderedProminent)
        }
    }

    private func addPoint() {
        guard let refValue = Double(referenceValue), refValue > 0 else { return }
        collectedPoints.append(CalibrationPoint(referenceValue: refValue, measuredValue: measuredValue))
        step = .pointSaved
    }

    private func finishCalibration() {
        if collectedPoints.count == 1 {
            _ = calibrationManager.createProfile(
                referenceValue: collectedPoints[0].referenceValue,
                measuredValue: collectedPoints[0].measuredValue
            )
        } else {
            _ = calibrationManager.createMultiPointProfile(points: collectedPoints)
        }
        step = .result
    }
}
