// swiftlint:disable file_length line_length
import Foundation

enum Translations {
    // Keys are the German source strings. Values map language codes to translations.
    // German ("de") is the source language and doesn't need entries here.
    static let data: [String: [String: String]] = [

        // MARK: - Tab Bar
        "Messen": ["en": "Measure", "fr": "Mesurer", "es": "Medir", "it": "Misura", "pt": "Medir", "zh-Hans": "测量", "ja": "測定"],
        "Verlauf": ["en": "History", "fr": "Historique", "es": "Historial", "it": "Cronologia", "pt": "Histórico", "zh-Hans": "历史记录", "ja": "履歴"],
        "Einstellungen": ["en": "Settings", "fr": "Réglages", "es": "Ajustes", "it": "Impostazioni", "pt": "Definições", "zh-Hans": "设置", "ja": "設定"],

        // MARK: - LuxRange Names
        "Dunkelheit": ["en": "Darkness", "fr": "Obscurité", "es": "Oscuridad", "it": "Oscurità", "pt": "Escuridão", "zh-Hans": "黑暗", "ja": "暗闇"],
        "Sehr dunkel": ["en": "Very dark", "fr": "Très sombre", "es": "Muy oscuro", "it": "Molto scuro", "pt": "Muito escuro", "zh-Hans": "非常暗", "ja": "非常に暗い"],
        "Dämmerung": ["en": "Twilight", "fr": "Crépuscule", "es": "Penumbra", "it": "Penombra", "pt": "Penumbra", "zh-Hans": "昏暗", "ja": "薄明かり"],
        "Innenraum": ["en": "Indoor", "fr": "Intérieur", "es": "Interior", "it": "Interno", "pt": "Interior", "zh-Hans": "室内", "ja": "室内"],
        "Heller Innenraum": ["en": "Bright indoor", "fr": "Intérieur lumineux", "es": "Interior luminoso", "it": "Interno luminoso", "pt": "Interior luminoso", "zh-Hans": "明亮室内", "ja": "明るい室内"],
        "Bewölkt": ["en": "Overcast", "fr": "Nuageux", "es": "Nublado", "it": "Nuvoloso", "pt": "Nublado", "zh-Hans": "多云", "ja": "曇り"],
        "Tageslicht": ["en": "Daylight", "fr": "Lumière du jour", "es": "Luz diurna", "it": "Luce diurna", "pt": "Luz do dia", "zh-Hans": "日光", "ja": "日光"],
        "Direktes Sonnenlicht": ["en": "Direct sunlight", "fr": "Soleil direct", "es": "Luz solar directa", "it": "Luce solare diretta", "pt": "Luz solar direta", "zh-Hans": "直射阳光", "ja": "直射日光"],

        // MARK: - LuxRange Detailed Descriptions
        "Nahezu vollständige Dunkelheit": ["en": "Nearly complete darkness", "fr": "Obscurité presque totale", "es": "Oscuridad casi total", "it": "Oscurità quasi completa", "pt": "Escuridão quase total", "zh-Hans": "几乎完全黑暗", "ja": "ほぼ完全な暗闇"],
        "Mondlicht, schwache Beleuchtung": ["en": "Moonlight, dim lighting", "fr": "Clair de lune, éclairage faible", "es": "Luz de luna, iluminación tenue", "it": "Chiaro di luna, luce fioca", "pt": "Luar, iluminação fraca", "zh-Hans": "月光，微弱照明", "ja": "月光、薄暗い照明"],
        "Kerzenlicht, gedimmte Räume": ["en": "Candlelight, dimmed rooms", "fr": "Bougie, pièces tamisées", "es": "Luz de velas, salas atenuadas", "it": "Lume di candela, stanze soffuse", "pt": "Luz de vela, salas escurecidas", "zh-Hans": "烛光，昏暗房间", "ja": "キャンドル、薄暗い部屋"],
        "Normaler Wohnraum, Büro": ["en": "Normal living room, office", "fr": "Salon, bureau", "es": "Sala de estar, oficina", "it": "Soggiorno, ufficio", "pt": "Sala de estar, escritório", "zh-Hans": "普通客厅、办公室", "ja": "一般的なリビング、オフィス"],
        "Gut beleuchteter Arbeitsplatz": ["en": "Well-lit workspace", "fr": "Espace de travail bien éclairé", "es": "Espacio de trabajo bien iluminado", "it": "Posto di lavoro ben illuminato", "pt": "Local de trabalho bem iluminado", "zh-Hans": "光线充足的工作场所", "ja": "明るい作業場"],
        "Bewölkter Himmel, Schatten": ["en": "Overcast sky, shade", "fr": "Ciel nuageux, ombre", "es": "Cielo nublado, sombra", "it": "Cielo nuvoloso, ombra", "pt": "Céu nublado, sombra", "zh-Hans": "阴天、阴影", "ja": "曇り空、日陰"],
        "Helles Tageslicht": ["en": "Bright daylight", "fr": "Lumière vive du jour", "es": "Luz diurna intensa", "it": "Forte luce diurna", "pt": "Luz do dia intensa", "zh-Hans": "明亮日光", "ja": "明るい日光"],

        // MARK: - MeasurementProfile Names
        "Allgemein": ["en": "General", "fr": "Général", "es": "General", "it": "Generale", "pt": "Geral", "zh-Hans": "通用", "ja": "一般"],
        "Büro": ["en": "Office", "fr": "Bureau", "es": "Oficina", "it": "Ufficio", "pt": "Escritório", "zh-Hans": "办公室", "ja": "オフィス"],
        "Fotografie": ["en": "Photography", "fr": "Photographie", "es": "Fotografía", "it": "Fotografia", "pt": "Fotografia", "zh-Hans": "摄影", "ja": "写真"],
        "Gewächshaus": ["en": "Greenhouse", "fr": "Serre", "es": "Invernadero", "it": "Serra", "pt": "Estufa", "zh-Hans": "温室", "ja": "温室"],
        "Außen": ["en": "Outdoor", "fr": "Extérieur", "es": "Exterior", "it": "Esterno", "pt": "Exterior", "zh-Hans": "户外", "ja": "屋外"],

        // MARK: - MeasurementProfile Descriptions
        "Allgemeine Lichtmessung": ["en": "General light measurement", "fr": "Mesure de lumière générale", "es": "Medición de luz general", "it": "Misurazione della luce generale", "pt": "Medição de luz geral", "zh-Hans": "通用光照测量", "ja": "一般的な照度測定"],
        "Arbeitsplatzbeleuchtung (300-500 Lux empfohlen)": ["en": "Workplace lighting (300–500 Lux recommended)", "fr": "Éclairage de bureau (300–500 Lux recommandé)", "es": "Iluminación laboral (300–500 Lux recomendados)", "it": "Illuminazione lavorativa (300–500 Lux raccomandati)", "pt": "Iluminação do local de trabalho (300–500 Lux recomendados)", "zh-Hans": "工作场所照明（建议 300–500 Lux）", "ja": "職場照明（300〜500ルクス推奨）"],
        "Belichtungsmessung für Fotografie": ["en": "Exposure metering for photography", "fr": "Mesure d'exposition photo", "es": "Medición de exposición fotográfica", "it": "Misurazione dell'esposizione fotografica", "pt": "Medição de exposição fotográfica", "zh-Hans": "摄影曝光测量", "ja": "写真撮影用の露出測定"],
        "Pflanzenlicht-Messung": ["en": "Plant light measurement", "fr": "Mesure de lumière pour plantes", "es": "Medición de luz para plantas", "it": "Misurazione della luce per piante", "pt": "Medição de luz para plantas", "zh-Hans": "植物光照测量", "ja": "植物用照度測定"],
        "Außenmessung / Tageslicht": ["en": "Outdoor / daylight measurement", "fr": "Mesure extérieure / lumière du jour", "es": "Medición exterior / luz diurna", "it": "Misurazione esterna / luce diurna", "pt": "Medição exterior / luz do dia", "zh-Hans": "户外测量 / 日光", "ja": "屋外測定 / 日光"],

        // MARK: - LuxDescriptor
        "Entspricht: Vollmondnacht": ["en": "Equivalent: Full moon night", "fr": "Équivalent : Nuit de pleine lune", "es": "Equivalente: Noche de luna llena", "it": "Equivalente: Notte di luna piena", "pt": "Equivalente: Noite de lua cheia", "zh-Hans": "相当于：满月之夜", "ja": "相当：満月の夜"],
        "Entspricht: Straßenbeleuchtung": ["en": "Equivalent: Street lighting", "fr": "Équivalent : Éclairage public", "es": "Equivalente: Alumbrado público", "it": "Equivalente: Illuminazione stradale", "pt": "Equivalente: Iluminação pública", "zh-Hans": "相当于：街道照明", "ja": "相当：街灯"],
        "Entspricht: Wohnzimmer, gedimmt": ["en": "Equivalent: Living room, dimmed", "fr": "Équivalent : Salon, tamisé", "es": "Equivalente: Sala de estar, atenuada", "it": "Equivalente: Soggiorno, luce soffusa", "pt": "Equivalente: Sala, luz reduzida", "zh-Hans": "相当于：客厅，调暗", "ja": "相当：リビング、薄暗い"],
        "Entspricht: Flur, Treppenhaus": ["en": "Equivalent: Hallway, staircase", "fr": "Équivalent : Couloir, cage d'escalier", "es": "Equivalente: Pasillo, escalera", "it": "Equivalente: Corridoio, scale", "pt": "Equivalente: Corredor, escadas", "zh-Hans": "相当于：走廊、楼梯间", "ja": "相当：廊下、階段"],
        "Entspricht: Wohnraum, normal": ["en": "Equivalent: Living room, normal", "fr": "Équivalent : Pièce à vivre, normal", "es": "Equivalente: Sala de estar, normal", "it": "Equivalente: Soggiorno, normale", "pt": "Equivalente: Sala de estar, normal", "zh-Hans": "相当于：客厅，正常", "ja": "相当：リビング、通常"],
        "Entspricht: Büro-Arbeitsplatz": ["en": "Equivalent: Office workspace", "fr": "Équivalent : Poste de bureau", "es": "Equivalente: Puesto de oficina", "it": "Equivalente: Postazione ufficio", "pt": "Equivalente: Posto de trabalho", "zh-Hans": "相当于：办公工位", "ja": "相当：オフィス作業場"],
        "Entspricht: gut beleuchteter Arbeitsplatz": ["en": "Equivalent: Well-lit workspace", "fr": "Équivalent : Espace bien éclairé", "es": "Equivalente: Espacio bien iluminado", "it": "Equivalente: Spazio ben illuminato", "pt": "Equivalente: Espaço bem iluminado", "zh-Hans": "相当于：光线充足的工作区", "ja": "相当：明るい作業場"],
        "Entspricht: Zeichenarbeitsplatz": ["en": "Equivalent: Drawing workspace", "fr": "Équivalent : Poste de dessin", "es": "Equivalente: Mesa de dibujo", "it": "Equivalente: Postazione da disegno", "pt": "Equivalente: Posto de desenho", "zh-Hans": "相当于：绘图工作台", "ja": "相当：製図作業場"],
        "Entspricht: bewölkter Tag": ["en": "Equivalent: Overcast day", "fr": "Équivalent : Jour nuageux", "es": "Equivalente: Día nublado", "it": "Equivalente: Giorno nuvoloso", "pt": "Equivalente: Dia nublado", "zh-Hans": "相当于：阴天", "ja": "相当：曇りの日"],
        "Entspricht: bedeckter Himmel": ["en": "Equivalent: Overcast sky", "fr": "Équivalent : Ciel couvert", "es": "Equivalente: Cielo cubierto", "it": "Equivalente: Cielo coperto", "pt": "Equivalente: Céu encoberto", "zh-Hans": "相当于：阴天天空", "ja": "相当：曇天"],
        "Entspricht: Tageslicht, Schatten": ["en": "Equivalent: Daylight, shade", "fr": "Équivalent : Lumière du jour, ombre", "es": "Equivalente: Luz diurna, sombra", "it": "Equivalente: Luce diurna, ombra", "pt": "Equivalente: Luz do dia, sombra", "zh-Hans": "相当于：日光、阴影", "ja": "相当：日光、日陰"],
        "Entspricht: helles Tageslicht": ["en": "Equivalent: Bright daylight", "fr": "Équivalent : Lumière vive du jour", "es": "Equivalente: Luz diurna intensa", "it": "Equivalente: Forte luce diurna", "pt": "Equivalente: Luz do dia intensa", "zh-Hans": "相当于：明亮日光", "ja": "相当：明るい日光"],
        "Entspricht: Sonnenlicht": ["en": "Equivalent: Sunlight", "fr": "Équivalent : Lumière du soleil", "es": "Equivalente: Luz solar", "it": "Equivalente: Luce solare", "pt": "Equivalente: Luz solar", "zh-Hans": "相当于：阳光", "ja": "相当：太陽光"],
        "Entspricht: direktes Sonnenlicht": ["en": "Equivalent: Direct sunlight", "fr": "Équivalent : Soleil direct", "es": "Equivalente: Luz solar directa", "it": "Equivalente: Luce solare diretta", "pt": "Equivalente: Luz solar direta", "zh-Hans": "相当于：直射阳光", "ja": "相当：直射日光"],

        // MARK: - LuxDescriptor Recommendations (format strings)
        "Zu dunkel für %@ (min. %d Lux empfohlen)": ["en": "Too dark for %@ (min. %d Lux recommended)", "fr": "Trop sombre pour %@ (min. %d Lux recommandé)", "es": "Demasiado oscuro para %@ (mín. %d Lux recomendados)", "it": "Troppo scuro per %@ (min. %d Lux raccomandati)", "pt": "Muito escuro para %@ (mín. %d Lux recomendados)", "zh-Hans": "%@ 光线不足（建议最低 %d Lux）", "ja": "%@ には暗すぎます（最低 %d ルクス推奨）"],
        "Zu hell für %@ (max. %d Lux empfohlen)": ["en": "Too bright for %@ (max. %d Lux recommended)", "fr": "Trop lumineux pour %@ (max. %d Lux recommandé)", "es": "Demasiado brillante para %@ (máx. %d Lux recomendados)", "it": "Troppo luminoso per %@ (max. %d Lux raccomandati)", "pt": "Muito claro para %@ (máx. %d Lux recomendados)", "zh-Hans": "%@ 光线过强（建议最高 %d Lux）", "ja": "%@ には明るすぎます（最大 %d ルクス推奨）"],

        // MARK: - Settings
        "Kalibrierung": ["en": "Calibration", "fr": "Calibrage", "es": "Calibración", "it": "Calibrazione", "pt": "Calibração", "zh-Hans": "校准", "ja": "キャリブレーション"],
        "Kalibriert": ["en": "Calibrated", "fr": "Calibré", "es": "Calibrado", "it": "Calibrato", "pt": "Calibrado", "zh-Hans": "已校准", "ja": "校正済み"],
        "Nicht kalibriert": ["en": "Not calibrated", "fr": "Non calibré", "es": "Sin calibrar", "it": "Non calibrato", "pt": "Não calibrado", "zh-Hans": "未校准", "ja": "未校正"],
        "Ohne Kalibrierung beträgt die Genauigkeit ca. +/-30%.": ["en": "Without calibration, accuracy is approximately +/-30%.", "fr": "Sans calibrage, la précision est d'environ +/-30 %.", "es": "Sin calibración, la precisión es de aproximadamente +/-30 %.", "it": "Senza calibrazione, la precisione è circa +/-30%.", "pt": "Sem calibração, a precisão é de aproximadamente +/-30%.", "zh-Hans": "未校准时，精度约为 +/-30%。", "ja": "校正なしの場合、精度は約 +/-30% です。"],
        "Neue Kalibrierung starten": ["en": "Start new calibration", "fr": "Nouveau calibrage", "es": "Iniciar nueva calibración", "it": "Avvia nuova calibrazione", "pt": "Iniciar nova calibração", "zh-Hans": "开始新的校准", "ja": "新しいキャリブレーションを開始"],
        "Kalibrierungsprofile verwalten": ["en": "Manage calibration profiles", "fr": "Gérer les profils de calibrage", "es": "Gestionar perfiles de calibración", "it": "Gestisci profili di calibrazione", "pt": "Gerir perfis de calibração", "zh-Hans": "管理校准配置", "ja": "キャリブレーションプロファイルを管理"],
        "Messhinweise": ["en": "Measurement Notes", "fr": "Notes de mesure", "es": "Notas de medición", "it": "Note di misurazione", "pt": "Notas de medição", "zh-Hans": "测量说明", "ja": "測定について"],
        "Kamera-basierte Messung": ["en": "Camera-based measurement", "fr": "Mesure par caméra", "es": "Medición basada en cámara", "it": "Misurazione tramite fotocamera", "pt": "Medição baseada em câmara", "zh-Hans": "基于相机的测量", "ja": "カメラベースの測定"],
        "LuxMaster nutzt den Kamerasensor zur Lux-Berechnung. Die Genauigkeit hängt vom iPhone-Modell und der Kalibrierung ab.": ["en": "LuxMaster uses the camera sensor to calculate Lux. Accuracy depends on the iPhone model and calibration.", "fr": "LuxMaster utilise le capteur de la caméra pour calculer les Lux. La précision dépend du modèle d'iPhone et du calibrage.", "es": "LuxMaster utiliza el sensor de la cámara para calcular Lux. La precisión depende del modelo de iPhone y la calibración.", "it": "LuxMaster utilizza il sensore della fotocamera per calcolare i Lux. La precisione dipende dal modello di iPhone e dalla calibrazione.", "pt": "LuxMaster utiliza o sensor da câmara para calcular Lux. A precisão depende do modelo do iPhone e da calibração.", "zh-Hans": "LuxMaster 使用相机传感器计算勒克斯值。精度取决于 iPhone 型号和校准。", "ja": "LuxMaster はカメラセンサーでルクスを計算します。精度は iPhone モデルと校正に依存します。"],
        "Datenschutz": ["en": "Privacy", "fr": "Confidentialité", "es": "Privacidad", "it": "Privacy", "pt": "Privacidade", "zh-Hans": "隐私", "ja": "プライバシー"],
        "Keine Bilder werden gespeichert": ["en": "No images are saved", "fr": "Aucune image n'est enregistrée", "es": "No se guardan imágenes", "it": "Nessuna immagine viene salvata", "pt": "Nenhuma imagem é guardada", "zh-Hans": "不保存任何图像", "ja": "画像は保存されません"],
        "Kamera-Frames werden ausschließlich im Arbeitsspeicher für die Helligkeitsberechnung analysiert und sofort verworfen.": ["en": "Camera frames are analyzed exclusively in memory for brightness calculation and immediately discarded.", "fr": "Les images sont analysées exclusivement en mémoire pour le calcul de la luminosité et immédiatement supprimées.", "es": "Los fotogramas se analizan exclusivamente en memoria para el cálculo del brillo y se descartan inmediatamente.", "it": "I fotogrammi vengono analizzati esclusivamente in memoria per il calcolo della luminosità e immediatamente eliminati.", "pt": "Os fotogramas são analisados exclusivamente em memória para o cálculo do brilho e imediatamente descartados.", "zh-Hans": "相机帧仅在内存中用于亮度计算，并立即丢弃。", "ja": "カメラフレームは明るさ計算のためメモリ内でのみ分析され、直ちに破棄されます。"],
        "Daten": ["en": "Data", "fr": "Données", "es": "Datos", "it": "Dati", "pt": "Dados", "zh-Hans": "数据", "ja": "データ"],
        "Alle Messungen löschen": ["en": "Delete all measurements", "fr": "Supprimer toutes les mesures", "es": "Eliminar todas las mediciones", "it": "Elimina tutte le misurazioni", "pt": "Apagar todas as medições", "zh-Hans": "删除所有测量", "ja": "すべての測定を削除"],
        "Info": ["en": "Info", "fr": "Infos", "es": "Info", "it": "Info", "pt": "Info", "zh-Hans": "信息", "ja": "情報"],
        "Alle Messungen löschen?": ["en": "Delete all measurements?", "fr": "Supprimer toutes les mesures ?", "es": "¿Eliminar todas las mediciones?", "it": "Eliminare tutte le misurazioni?", "pt": "Apagar todas as medições?", "zh-Hans": "删除所有测量？", "ja": "すべての測定を削除しますか？"],
        "Alle löschen": ["en": "Delete all", "fr": "Tout supprimer", "es": "Eliminar todo", "it": "Elimina tutto", "pt": "Apagar tudo", "zh-Hans": "全部删除", "ja": "すべて削除"],
        "Abbrechen": ["en": "Cancel", "fr": "Annuler", "es": "Cancelar", "it": "Annulla", "pt": "Cancelar", "zh-Hans": "取消", "ja": "キャンセル"],
        "Diese Aktion kann nicht rückgängig gemacht werden.": ["en": "This action cannot be undone.", "fr": "Cette action est irréversible.", "es": "Esta acción no se puede deshacer.", "it": "Questa azione non può essere annullata.", "pt": "Esta ação não pode ser desfeita.", "zh-Hans": "此操作无法撤销。", "ja": "この操作は取り消せません。"],
        "Aktiv": ["en": "Active", "fr": "Actif", "es": "Activo", "it": "Attivo", "pt": "Ativo", "zh-Hans": "活跃", "ja": "有効"],
        "Löschen": ["en": "Delete", "fr": "Supprimer", "es": "Eliminar", "it": "Elimina", "pt": "Apagar", "zh-Hans": "删除", "ja": "削除"],
        "Aktivieren": ["en": "Activate", "fr": "Activer", "es": "Activar", "it": "Attiva", "pt": "Ativar", "zh-Hans": "激活", "ja": "有効化"],
        "Kalibrierungsprofile": ["en": "Calibration Profiles", "fr": "Profils de calibrage", "es": "Perfiles de calibración", "it": "Profili di calibrazione", "pt": "Perfis de calibração", "zh-Hans": "校准配置", "ja": "キャリブレーションプロファイル"],
        "Sprache": ["en": "Language", "fr": "Langue", "es": "Idioma", "it": "Lingua", "pt": "Idioma", "zh-Hans": "语言", "ja": "言語"],
        "Faktor": ["en": "Factor", "fr": "Facteur", "es": "Factor", "it": "Fattore", "pt": "Fator", "zh-Hans": "系数", "ja": "係数"],
        "Datum": ["en": "Date", "fr": "Date", "es": "Fecha", "it": "Data", "pt": "Data", "zh-Hans": "日期", "ja": "日付"],
        "App": ["en": "App", "fr": "App", "es": "App", "it": "App", "pt": "App", "zh-Hans": "应用", "ja": "アプリ"],
        "Version": ["en": "Version", "fr": "Version", "es": "Versión", "it": "Versione", "pt": "Versão", "zh-Hans": "版本", "ja": "バージョン"],
        "Gerät": ["en": "Device", "fr": "Appareil", "es": "Dispositivo", "it": "Dispositivo", "pt": "Dispositivo", "zh-Hans": "设备", "ja": "デバイス"],

        // MARK: - Calibration
        "Um die Messgenauigkeit zu verbessern, kalibriere LuxMaster gegen ein Referenz-Luxmeter oder eine bekannte Lichtquelle.": ["en": "To improve measurement accuracy, calibrate LuxMaster against a reference lux meter or a known light source.", "fr": "Pour améliorer la précision, calibrez LuxMaster avec un luxmètre de référence ou une source lumineuse connue.", "es": "Para mejorar la precisión, calibre LuxMaster con un luxómetro de referencia o una fuente de luz conocida.", "it": "Per migliorare la precisione, calibra LuxMaster con un luxmetro di riferimento o una fonte di luce nota.", "pt": "Para melhorar a precisão, calibre o LuxMaster com um luxímetro de referência ou uma fonte de luz conhecida.", "zh-Hans": "为提高测量精度，请使用参考照度计或已知光源校准 LuxMaster。", "ja": "測定精度を向上させるには、基準照度計または既知の光源で校正してください。"],
        "Schritt 1: Lichtquelle messen": ["en": "Step 1: Measure light source", "fr": "Étape 1 : Mesurer la source", "es": "Paso 1: Medir fuente de luz", "it": "Passo 1: Misura la fonte", "pt": "Passo 1: Medir fonte de luz", "zh-Hans": "步骤 1：测量光源", "ja": "ステップ 1：光源を測定"],
        "Schritt 2: Referenzwert eingeben": ["en": "Step 2: Enter reference value", "fr": "Étape 2 : Saisir la référence", "es": "Paso 2: Introducir valor de referencia", "it": "Passo 2: Inserisci il riferimento", "pt": "Passo 2: Introduzir valor de referência", "zh-Hans": "步骤 2：输入参考值", "ja": "ステップ 2：基準値を入力"],
        "Schritt 3: Kalibrierung speichern": ["en": "Step 3: Save calibration", "fr": "Étape 3 : Enregistrer le calibrage", "es": "Paso 3: Guardar calibración", "it": "Passo 3: Salva la calibrazione", "pt": "Passo 3: Guardar calibração", "zh-Hans": "步骤 3：保存校准", "ja": "ステップ 3：校正を保存"],
        "Kalibrierung starten": ["en": "Start calibration", "fr": "Démarrer le calibrage", "es": "Iniciar calibración", "it": "Avvia calibrazione", "pt": "Iniciar calibração", "zh-Hans": "开始校准", "ja": "キャリブレーション開始"],
        "Richte die Kamera auf die Lichtquelle": ["en": "Point the camera at the light source", "fr": "Dirigez la caméra vers la source lumineuse", "es": "Apunte la cámara a la fuente de luz", "it": "Punta la fotocamera verso la fonte di luce", "pt": "Aponte a câmara para a fonte de luz", "zh-Hans": "将相机对准光源", "ja": "カメラを光源に向けてください"],
        "Warte bis der Wert stabil ist, dann drücke 'Wert erfassen'.": ["en": "Wait until the value is stable, then press 'Capture value'.", "fr": "Attendez que la valeur soit stable, puis appuyez sur « Capturer ».", "es": "Espere a que el valor sea estable y pulse 'Capturar valor'.", "it": "Attendi che il valore sia stabile, poi premi 'Cattura valore'.", "pt": "Aguarde até o valor estabilizar e prima 'Capturar valor'.", "zh-Hans": "等待数值稳定后，按「捕获数值」。", "ja": "値が安定するまで待ち、「値を取得」を押してください。"],
        "Wert erfassen (%@ Lux)": ["en": "Capture value (%@ Lux)", "fr": "Capturer (%@ Lux)", "es": "Capturar valor (%@ Lux)", "it": "Cattura valore (%@ Lux)", "pt": "Capturar valor (%@ Lux)", "zh-Hans": "捕获数值（%@ Lux）", "ja": "値を取得（%@ ルクス）"],
        "Referenzwert eingeben": ["en": "Enter reference value", "fr": "Saisir la valeur de référence", "es": "Introducir valor de referencia", "it": "Inserisci valore di riferimento", "pt": "Introduzir valor de referência", "zh-Hans": "输入参考值", "ja": "基準値を入力"],
        "Gib den bekannten Lux-Wert ein (von einem Referenz-Luxmeter oder einer bekannten Lichtquelle).": ["en": "Enter the known Lux value (from a reference lux meter or a known light source).", "fr": "Saisissez la valeur Lux connue (d'un luxmètre de référence ou d'une source connue).", "es": "Introduzca el valor Lux conocido (de un luxómetro de referencia o fuente conocida).", "it": "Inserisci il valore Lux noto (da un luxmetro di riferimento o una fonte nota).", "pt": "Introduza o valor Lux conhecido (de um luxímetro de referência ou fonte conhecida).", "zh-Hans": "输入已知勒克斯值（来自参考照度计或已知光源）。", "ja": "既知のルクス値を入力してください（基準照度計または既知の光源から）。"],
        "Gemessener Wert": ["en": "Measured value", "fr": "Valeur mesurée", "es": "Valor medido", "it": "Valore misurato", "pt": "Valor medido", "zh-Hans": "测量值", "ja": "測定値"],
        "Referenzwert in Lux": ["en": "Reference value in Lux", "fr": "Valeur de référence en Lux", "es": "Valor de referencia en Lux", "it": "Valore di riferimento in Lux", "pt": "Valor de referência em Lux", "zh-Hans": "参考值（Lux）", "ja": "基準値（ルクス）"],
        "Kalibrierung speichern": ["en": "Save calibration", "fr": "Enregistrer le calibrage", "es": "Guardar calibración", "it": "Salva calibrazione", "pt": "Guardar calibração", "zh-Hans": "保存校准", "ja": "校正を保存"],
        "Kalibrierung erfolgreich": ["en": "Calibration successful", "fr": "Calibrage réussi", "es": "Calibración exitosa", "it": "Calibrazione riuscita", "pt": "Calibração bem-sucedida", "zh-Hans": "校准成功", "ja": "キャリブレーション成功"],
        "Korrekturfaktor": ["en": "Correction factor", "fr": "Facteur de correction", "es": "Factor de corrección", "it": "Fattore di correzione", "pt": "Fator de correção", "zh-Hans": "校正系数", "ja": "補正係数"],
        "Referenzwert": ["en": "Reference value", "fr": "Valeur de référence", "es": "Valor de referencia", "it": "Valore di riferimento", "pt": "Valor de referência", "zh-Hans": "参考值", "ja": "基準値"],
        "Fertig": ["en": "Done", "fr": "Terminé", "es": "Listo", "it": "Fine", "pt": "Concluído", "zh-Hans": "完成", "ja": "完了"],

        // MARK: - Chart
        "Messverlauf": ["en": "Measurement History", "fr": "Historique des mesures", "es": "Historial de mediciones", "it": "Cronologia misurazioni", "pt": "Histórico de medições", "zh-Hans": "测量历史", "ja": "測定履歴"],
        "Keine Daten": ["en": "No data", "fr": "Aucune donnée", "es": "Sin datos", "it": "Nessun dato", "pt": "Sem dados", "zh-Hans": "暂无数据", "ja": "データなし"],
        "Speichere Messungen, um den Verlauf zu sehen.": ["en": "Save measurements to see the history.", "fr": "Enregistrez des mesures pour voir l'historique.", "es": "Guarde mediciones para ver el historial.", "it": "Salva le misurazioni per vedere la cronologia.", "pt": "Guarde medições para ver o histórico.", "zh-Hans": "保存测量数据以查看历史记录。", "ja": "履歴を表示するには測定を保存してください。"],
        "Zeit": ["en": "Time", "fr": "Temps", "es": "Tiempo", "it": "Tempo", "pt": "Tempo", "zh-Hans": "时间", "ja": "時間"],
        "Min": ["en": "Min", "fr": "Min", "es": "Mín", "it": "Min", "pt": "Mín", "zh-Hans": "最小", "ja": "最小"],
        "Max": ["en": "Max", "fr": "Max", "es": "Máx", "it": "Max", "pt": "Máx", "zh-Hans": "最大", "ja": "最大"],
        "Schnitt": ["en": "Avg", "fr": "Moy", "es": "Prom", "it": "Med", "pt": "Méd", "zh-Hans": "平均", "ja": "平均"],
        "Anzahl": ["en": "Count", "fr": "Nombre", "es": "Cantidad", "it": "Numero", "pt": "Número", "zh-Hans": "数量", "ja": "件数"],

        // MARK: - Save Sheet
        "Messwert": ["en": "Reading", "fr": "Mesure", "es": "Lectura", "it": "Lettura", "pt": "Leitura", "zh-Hans": "测量值", "ja": "測定値"],
        "Bereich": ["en": "Range", "fr": "Plage", "es": "Rango", "it": "Intervallo", "pt": "Faixa", "zh-Hans": "范围", "ja": "範囲"],
        "Notiz": ["en": "Note", "fr": "Note", "es": "Nota", "it": "Nota", "pt": "Nota", "zh-Hans": "备注", "ja": "メモ"],
        "Optionale Notiz...": ["en": "Optional note...", "fr": "Note optionnelle...", "es": "Nota opcional...", "it": "Nota opzionale...", "pt": "Nota opcional...", "zh-Hans": "可选备注...", "ja": "メモ（任意）..."],
        "Profil": ["en": "Profile", "fr": "Profil", "es": "Perfil", "it": "Profilo", "pt": "Perfil", "zh-Hans": "配置", "ja": "プロファイル"],
        "Messprofil": ["en": "Measurement profile", "fr": "Profil de mesure", "es": "Perfil de medición", "it": "Profilo di misurazione", "pt": "Perfil de medição", "zh-Hans": "测量配置", "ja": "測定プロファイル"],
        "Standort": ["en": "Location", "fr": "Lieu", "es": "Ubicación", "it": "Posizione", "pt": "Localização", "zh-Hans": "位置", "ja": "場所"],
        "Standort speichern": ["en": "Save location", "fr": "Enregistrer le lieu", "es": "Guardar ubicación", "it": "Salva posizione", "pt": "Guardar localização", "zh-Hans": "保存位置", "ja": "場所を保存"],
        "Standortzugriff erlauben": ["en": "Allow location access", "fr": "Autoriser l'accès au lieu", "es": "Permitir acceso a ubicación", "it": "Consenti accesso alla posizione", "pt": "Permitir acesso à localização", "zh-Hans": "允许访问位置", "ja": "位置情報へのアクセスを許可"],
        "Standort wird ermittelt...": ["en": "Determining location...", "fr": "Localisation en cours...", "es": "Determinando ubicación...", "it": "Rilevamento posizione...", "pt": "A determinar localização...", "zh-Hans": "正在获取位置...", "ja": "位置を取得中..."],
        "Messung speichern": ["en": "Save measurement", "fr": "Enregistrer la mesure", "es": "Guardar medición", "it": "Salva misurazione", "pt": "Guardar medição", "zh-Hans": "保存测量", "ja": "測定を保存"],
        "Speichern": ["en": "Save", "fr": "Enregistrer", "es": "Guardar", "it": "Salva", "pt": "Guardar", "zh-Hans": "保存", "ja": "保存"],
        "Fehler beim Speichern": ["en": "Error saving", "fr": "Erreur d'enregistrement", "es": "Error al guardar", "it": "Errore di salvataggio", "pt": "Erro ao guardar", "zh-Hans": "保存失败", "ja": "保存エラー"],

        // MARK: - InfoBanner
        "Stabil": ["en": "Stable", "fr": "Stable", "es": "Estable", "it": "Stabile", "pt": "Estável", "zh-Hans": "稳定", "ja": "安定"],
        "Schwankend": ["en": "Fluctuating", "fr": "Fluctuant", "es": "Fluctuante", "it": "Fluttuante", "pt": "Flutuante", "zh-Hans": "波动", "ja": "変動中"],
        "Instabil": ["en": "Unstable", "fr": "Instable", "es": "Inestable", "it": "Instabile", "pt": "Instável", "zh-Hans": "不稳定", "ja": "不安定"],

        // MARK: - Detail View
        "Lichtverhältnisse": ["en": "Light Conditions", "fr": "Conditions d'éclairage", "es": "Condiciones de luz", "it": "Condizioni di luce", "pt": "Condições de luz", "zh-Hans": "光照条件", "ja": "照明条件"],
        "Technische Daten": ["en": "Technical Data", "fr": "Données techniques", "es": "Datos técnicos", "it": "Dati tecnici", "pt": "Dados técnicos", "zh-Hans": "技术数据", "ja": "技術データ"],
        "Belichtung": ["en": "Exposure", "fr": "Exposition", "es": "Exposición", "it": "Esposizione", "pt": "Exposição", "zh-Hans": "曝光", "ja": "露出"],
        "Details": ["en": "Details", "fr": "Détails", "es": "Detalles", "it": "Dettagli", "pt": "Detalhes", "zh-Hans": "详情", "ja": "詳細"],
        "Zeitpunkt": ["en": "Timestamp", "fr": "Horodatage", "es": "Marca temporal", "it": "Data e ora", "pt": "Data e hora", "zh-Hans": "时间", "ja": "日時"],
        "Koordinaten": ["en": "Coordinates", "fr": "Coordonnées", "es": "Coordenadas", "it": "Coordinate", "pt": "Coordenadas", "zh-Hans": "坐标", "ja": "座標"],
        "Notiz hinzufügen...": ["en": "Add note...", "fr": "Ajouter une note...", "es": "Añadir nota...", "it": "Aggiungi nota...", "pt": "Adicionar nota...", "zh-Hans": "添加备注...", "ja": "メモを追加..."],
        "Messung": ["en": "Measurement", "fr": "Mesure", "es": "Medición", "it": "Misurazione", "pt": "Medição", "zh-Hans": "测量", "ja": "測定"],

        // MARK: - History
        "Keine Messungen": ["en": "No Measurements", "fr": "Aucune mesure", "es": "Sin mediciones", "it": "Nessuna misurazione", "pt": "Sem medições", "zh-Hans": "暂无测量", "ja": "測定なし"],
        "Gespeicherte Messungen erscheinen hier.": ["en": "Saved measurements will appear here.", "fr": "Les mesures enregistrées apparaîtront ici.", "es": "Las mediciones guardadas aparecerán aquí.", "it": "Le misurazioni salvate appariranno qui.", "pt": "As medições guardadas aparecerão aqui.", "zh-Hans": "保存的测量将显示在这里。", "ja": "保存した測定がここに表示されます。"],
        "Suche in Messungen...": ["en": "Search measurements...", "fr": "Rechercher...", "es": "Buscar mediciones...", "it": "Cerca misurazioni...", "pt": "Pesquisar medições...", "zh-Hans": "搜索测量...", "ja": "測定を検索..."],

        // MARK: - Export
        "Format": ["en": "Format", "fr": "Format", "es": "Formato", "it": "Formato", "pt": "Formato", "zh-Hans": "格式", "ja": "形式"],
        "Exportformat": ["en": "Export format", "fr": "Format d'export", "es": "Formato de exportación", "it": "Formato di esportazione", "pt": "Formato de exportação", "zh-Hans": "导出格式", "ja": "エクスポート形式"],
        "Vorschau": ["en": "Preview", "fr": "Aperçu", "es": "Vista previa", "it": "Anteprima", "pt": "Pré-visualização", "zh-Hans": "预览", "ja": "プレビュー"],
        "Messungen": ["en": "Measurements", "fr": "Mesures", "es": "Mediciones", "it": "Misurazioni", "pt": "Medições", "zh-Hans": "测量", "ja": "測定"],
        "Von": ["en": "From", "fr": "De", "es": "Desde", "it": "Da", "pt": "De", "zh-Hans": "从", "ja": "開始"],
        "Bis": ["en": "To", "fr": "À", "es": "Hasta", "it": "A", "pt": "Até", "zh-Hans": "到", "ja": "終了"],
        "Durchschnitt": ["en": "Average", "fr": "Moyenne", "es": "Promedio", "it": "Media", "pt": "Média", "zh-Hans": "平均", "ja": "平均"],
        "Exportieren": ["en": "Export", "fr": "Exporter", "es": "Exportar", "it": "Esporta", "pt": "Exportar", "zh-Hans": "导出", "ja": "エクスポート"],
        "Export": ["en": "Export", "fr": "Export", "es": "Exportar", "it": "Esporta", "pt": "Exportar", "zh-Hans": "导出", "ja": "エクスポート"],
        "Export fehlgeschlagen": ["en": "Export failed", "fr": "Échec de l'export", "es": "Error de exportación", "it": "Esportazione fallita", "pt": "Exportação falhou", "zh-Hans": "导出失败", "ja": "エクスポート失敗"],

        // MARK: - Measurement View
        "Kamerazugriff erforderlich": ["en": "Camera Access Required", "fr": "Accès caméra requis", "es": "Se requiere acceso a la cámara", "it": "Accesso alla fotocamera richiesto", "pt": "Acesso à câmara necessário", "zh-Hans": "需要相机权限", "ja": "カメラへのアクセスが必要"],
        "LuxMaster benötigt Zugriff auf die Kamera, um die Lichtstärke zu messen. Es werden keine Bilder gespeichert.": ["en": "LuxMaster needs camera access to measure light intensity. No images are saved.", "fr": "LuxMaster nécessite l'accès à la caméra pour mesurer l'intensité lumineuse. Aucune image n'est enregistrée.", "es": "LuxMaster necesita acceso a la cámara para medir la intensidad de la luz. No se guardan imágenes.", "it": "LuxMaster necessita dell'accesso alla fotocamera per misurare l'intensità luminosa. Nessuna immagine viene salvata.", "pt": "LuxMaster necessita de acesso à câmara para medir a intensidade luminosa. Nenhuma imagem é guardada.", "zh-Hans": "LuxMaster 需要相机权限来测量光照强度。不会保存任何图像。", "ja": "LuxMaster は光の強さを測定するためにカメラへのアクセスが必要です。画像は保存されません。"],
        "Einstellungen öffnen": ["en": "Open Settings", "fr": "Ouvrir les réglages", "es": "Abrir ajustes", "it": "Apri impostazioni", "pt": "Abrir definições", "zh-Hans": "打开设置", "ja": "設定を開く"],

        // MARK: - Camera Errors
        "Kamerazugriff wurde verweigert. Bitte in den Einstellungen erlauben.": ["en": "Camera access was denied. Please allow in Settings.", "fr": "L'accès à la caméra a été refusé. Veuillez l'autoriser dans les réglages.", "es": "Se denegó el acceso a la cámara. Permítalo en los ajustes.", "it": "L'accesso alla fotocamera è stato negato. Consentirlo nelle impostazioni.", "pt": "O acesso à câmara foi negado. Permita-o nas definições.", "zh-Hans": "相机权限被拒绝，请在设置中允许。", "ja": "カメラへのアクセスが拒否されました。設定で許可してください。"],
        "Keine geeignete Kamera gefunden.": ["en": "No suitable camera found.", "fr": "Aucune caméra appropriée trouvée.", "es": "No se encontró una cámara adecuada.", "it": "Nessuna fotocamera adatta trovata.", "pt": "Nenhuma câmara adequada encontrada.", "zh-Hans": "未找到合适的相机。", "ja": "適切なカメラが見つかりません。"],
        "Kamera konnte nicht konfiguriert werden.": ["en": "Camera could not be configured.", "fr": "La caméra n'a pas pu être configurée.", "es": "No se pudo configurar la cámara.", "it": "Impossibile configurare la fotocamera.", "pt": "Não foi possível configurar a câmara.", "zh-Hans": "无法配置相机。", "ja": "カメラを設定できませんでした。"],
        "Kamerafehler: %@": ["en": "Camera error: %@", "fr": "Erreur caméra : %@", "es": "Error de cámara: %@", "it": "Errore fotocamera: %@", "pt": "Erro de câmara: %@", "zh-Hans": "相机错误：%@", "ja": "カメラエラー：%@"],

        // MARK: - Export Service
        "Erstellt: %@": ["en": "Created: %@", "fr": "Créé : %@", "es": "Creado: %@", "it": "Creato: %@", "pt": "Criado: %@", "zh-Hans": "创建日期：%@", "ja": "作成日：%@"],
        "Generiert mit LuxMaster": ["en": "Generated with LuxMaster", "fr": "Généré avec LuxMaster", "es": "Generado con LuxMaster", "it": "Generato con LuxMaster", "pt": "Gerado com LuxMaster", "zh-Hans": "由 LuxMaster 生成", "ja": "LuxMaster で生成"],
        "LuxMaster Messbericht": ["en": "LuxMaster Report", "fr": "Rapport LuxMaster", "es": "Informe LuxMaster", "it": "Rapporto LuxMaster", "pt": "Relatório LuxMaster", "zh-Hans": "LuxMaster 测量报告", "ja": "LuxMaster レポート"],
        "Messungen: %d  |  Min: %@  |  Max: %@  |  Durchschnitt: %@": ["en": "Measurements: %d  |  Min: %@  |  Max: %@  |  Average: %@", "fr": "Mesures : %d  |  Min : %@  |  Max : %@  |  Moyenne : %@", "es": "Mediciones: %d  |  Mín: %@  |  Máx: %@  |  Promedio: %@", "it": "Misurazioni: %d  |  Min: %@  |  Max: %@  |  Media: %@", "pt": "Medições: %d  |  Mín: %@  |  Máx: %@  |  Média: %@", "zh-Hans": "测量：%d  |  最小：%@  |  最大：%@  |  平均：%@", "ja": "測定：%d  |  最小：%@  |  最大：%@  |  平均：%@"],
        "Breitengrad": ["en": "Latitude", "fr": "Latitude", "es": "Latitud", "it": "Latitudine", "pt": "Latitude", "zh-Hans": "纬度", "ja": "緯度"],
        "Längengrad": ["en": "Longitude", "fr": "Longitude", "es": "Longitud", "it": "Longitudine", "pt": "Longitude", "zh-Hans": "经度", "ja": "経度"],
        "OK": ["en": "OK", "fr": "OK", "es": "OK", "it": "OK", "pt": "OK", "zh-Hans": "好", "ja": "OK"],

        // MARK: - Multi-Point Calibration
        "Kalibrierpunkt gespeichert": ["en": "Calibration point saved", "fr": "Point de calibrage enregistré", "es": "Punto de calibración guardado", "it": "Punto di calibrazione salvato", "pt": "Ponto de calibração guardado", "zh-Hans": "校准点已保存", "ja": "校正ポイントを保存しました"],
        "Punkt %d": ["en": "Point %d", "fr": "Point %d", "es": "Punto %d", "it": "Punto %d", "pt": "Ponto %d", "zh-Hans": "点 %d", "ja": "ポイント %d"],
        "Gemessen: %@ Lux": ["en": "Measured: %@ Lux", "fr": "Mesuré : %@ Lux", "es": "Medido: %@ Lux", "it": "Misurato: %@ Lux", "pt": "Medido: %@ Lux", "zh-Hans": "测量值：%@ Lux", "ja": "測定値：%@ ルクス"],
        "Referenz: %@ Lux": ["en": "Reference: %@ Lux", "fr": "Référence : %@ Lux", "es": "Referencia: %@ Lux", "it": "Riferimento: %@ Lux", "pt": "Referência: %@ Lux", "zh-Hans": "参考值：%@ Lux", "ja": "基準値：%@ ルクス"],
        "Für beste Ergebnisse, kalibriere bei 2-5 verschiedenen Helligkeitsstufen.": ["en": "For best results, calibrate at 2-5 different brightness levels.", "fr": "Pour de meilleurs résultats, calibrez à 2-5 niveaux de luminosité différents.", "es": "Para mejores resultados, calibre a 2-5 niveles de brillo diferentes.", "it": "Per risultati migliori, calibra a 2-5 livelli di luminosità diversi.", "pt": "Para melhores resultados, calibre a 2-5 níveis de brilho diferentes.", "zh-Hans": "为获得最佳效果，请在 2-5 个不同亮度级别下校准。", "ja": "最良の結果を得るには、2〜5 の異なる明るさレベルで校正してください。"],
        "Weiteren Punkt hinzufügen (%d/5)": ["en": "Add another point (%d/5)", "fr": "Ajouter un point (%d/5)", "es": "Añadir otro punto (%d/5)", "it": "Aggiungi un altro punto (%d/5)", "pt": "Adicionar outro ponto (%d/5)", "zh-Hans": "添加更多点 (%d/5)", "ja": "ポイントを追加 (%d/5)"],
        "Kalibrierung abschliessen": ["en": "Finish calibration", "fr": "Terminer le calibrage", "es": "Finalizar calibración", "it": "Termina calibrazione", "pt": "Concluir calibração", "zh-Hans": "完成校准", "ja": "キャリブレーションを完了"],
        "Kalibrierpunkte": ["en": "Calibration points", "fr": "Points de calibrage", "es": "Puntos de calibración", "it": "Punti di calibrazione", "pt": "Pontos de calibração", "zh-Hans": "校准点", "ja": "校正ポイント"],
        "Punkte": ["en": "Points", "fr": "Points", "es": "Puntos", "it": "Punti", "pt": "Pontos", "zh-Hans": "点", "ja": "ポイント"],
        "Punkt speichern": ["en": "Save point", "fr": "Enregistrer le point", "es": "Guardar punto", "it": "Salva punto", "pt": "Guardar ponto", "zh-Hans": "保存点", "ja": "ポイントを保存"],
        "Schritt 3: Weitere Punkte hinzufügen (optional)": ["en": "Step 3: Add more points (optional)", "fr": "Étape 3 : Ajouter des points (optionnel)", "es": "Paso 3: Añadir más puntos (opcional)", "it": "Passo 3: Aggiungi altri punti (opzionale)", "pt": "Passo 3: Adicionar mais pontos (opcional)", "zh-Hans": "步骤 3：添加更多点（可选）", "ja": "ステップ 3：ポイントを追加（任意）"],
        "Schritt 4: Kalibrierung speichern": ["en": "Step 4: Save calibration", "fr": "Étape 4 : Enregistrer le calibrage", "es": "Paso 4: Guardar calibración", "it": "Passo 4: Salva la calibrazione", "pt": "Passo 4: Guardar calibração", "zh-Hans": "步骤 4：保存校准", "ja": "ステップ 4：校正を保存"],

        // MARK: - Exposure Lock
        "AE gesperrt": ["en": "AE locked", "fr": "AE verrouillé", "es": "AE bloqueado", "it": "AE bloccato", "pt": "AE bloqueado", "zh-Hans": "AE 已锁定", "ja": "AE ロック"],

        // MARK: - Screenshot Mode
        "Screenshot-Modus": ["en": "Screenshot mode", "fr": "Mode capture d'écran", "es": "Modo captura de pantalla", "it": "Modalità screenshot", "pt": "Modo captura de ecrã", "zh-Hans": "截图模式", "ja": "スクリーンショットモード"],
    ]
}
