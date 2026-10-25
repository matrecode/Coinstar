//
//  Country.swift
//  Coinstar
//
//  Created by Akshay Matre on 04/10/26.
//

struct Country: Identifiable, Hashable, Equatable {
    let code: String // IN
    let name: String // India
    let dialCode: String // +91
    var id: String { code }
    /// Flag rendered from the ISO code at draw time (regional indicator
    /// symbols), NOT an image asset.
    var flag: String { Country.flagEmoji(for: code) }
    
    static func flagEmoji(for isoCode: String) -> String {
        let base: UInt32 = 127397 // regional indicator "A" (0x1F1E6) minus ASCII "A" (0x41)
        var scalars = String.UnicodeScalarView()
        for ascii in isoCode.uppercased().unicodeScalars {
            guard let flagScalar = Unicode.Scalar(base + ascii.value) else { continue }
            scalars.append(flagScalar)
        }
        return String(scalars)
    }
}

extension Country {
    static let `default` = Country(code: "IN", name: "India", dialCode: "+91")

    static let all: [Country] = [
        // Africa
        Country(code: "DZ", name: "Algeria", dialCode: "+213"),
        Country(code: "AO", name: "Angola", dialCode: "+244"),
        Country(code: "BJ", name: "Benin", dialCode: "+229"),
        Country(code: "BW", name: "Botswana", dialCode: "+267"),
        Country(code: "BF", name: "Burkina Faso", dialCode: "+226"),
        Country(code: "BI", name: "Burundi", dialCode: "+257"),
        Country(code: "CV", name: "Cabo Verde", dialCode: "+238"),
        Country(code: "CM", name: "Cameroon", dialCode: "+237"),
        Country(code: "CF", name: "Central African Republic", dialCode: "+236"),
        Country(code: "TD", name: "Chad", dialCode: "+235"),
        Country(code: "KM", name: "Comoros", dialCode: "+269"),
        Country(code: "CG", name: "Congo (Republic)", dialCode: "+242"),
        Country(code: "CD", name: "Congo (DRC)", dialCode: "+243"),
        Country(code: "DJ", name: "Djibouti", dialCode: "+253"),
        Country(code: "EG", name: "Egypt", dialCode: "+20"),
        Country(code: "GQ", name: "Equatorial Guinea", dialCode: "+240"),
        Country(code: "ER", name: "Eritrea", dialCode: "+291"),
        Country(code: "SZ", name: "Eswatini", dialCode: "+268"),
        Country(code: "ET", name: "Ethiopia", dialCode: "+251"),
        Country(code: "GA", name: "Gabon", dialCode: "+241"),
        Country(code: "GM", name: "Gambia", dialCode: "+220"),
        Country(code: "GH", name: "Ghana", dialCode: "+233"),
        Country(code: "GN", name: "Guinea", dialCode: "+224"),
        Country(code: "GW", name: "Guinea-Bissau", dialCode: "+245"),
        Country(code: "CI", name: "Ivory Coast", dialCode: "+225"),
        Country(code: "KE", name: "Kenya", dialCode: "+254"),
        Country(code: "LS", name: "Lesotho", dialCode: "+266"),
        Country(code: "LR", name: "Liberia", dialCode: "+231"),
        Country(code: "LY", name: "Libya", dialCode: "+218"),
        Country(code: "MG", name: "Madagascar", dialCode: "+261"),
        Country(code: "MW", name: "Malawi", dialCode: "+265"),
        Country(code: "ML", name: "Mali", dialCode: "+223"),
        Country(code: "MR", name: "Mauritania", dialCode: "+222"),
        Country(code: "MU", name: "Mauritius", dialCode: "+230"),
        Country(code: "MA", name: "Morocco", dialCode: "+212"),
        Country(code: "MZ", name: "Mozambique", dialCode: "+258"),
        Country(code: "NA", name: "Namibia", dialCode: "+264"),
        Country(code: "NE", name: "Niger", dialCode: "+227"),
        Country(code: "NG", name: "Nigeria", dialCode: "+234"),
        Country(code: "RW", name: "Rwanda", dialCode: "+250"),
        Country(code: "ST", name: "Sao Tome and Principe", dialCode: "+239"),
        Country(code: "SN", name: "Senegal", dialCode: "+221"),
        Country(code: "SC", name: "Seychelles", dialCode: "+248"),
        Country(code: "SL", name: "Sierra Leone", dialCode: "+232"),
        Country(code: "SO", name: "Somalia", dialCode: "+252"),
        Country(code: "ZA", name: "South Africa", dialCode: "+27"),
        Country(code: "SS", name: "South Sudan", dialCode: "+211"),
        Country(code: "SD", name: "Sudan", dialCode: "+249"),
        Country(code: "TZ", name: "Tanzania", dialCode: "+255"),
        Country(code: "TG", name: "Togo", dialCode: "+228"),
        Country(code: "TN", name: "Tunisia", dialCode: "+216"),
        Country(code: "UG", name: "Uganda", dialCode: "+256"),
        Country(code: "ZM", name: "Zambia", dialCode: "+260"),
        Country(code: "ZW", name: "Zimbabwe", dialCode: "+263"),

        // Americas
        Country(code: "AG", name: "Antigua and Barbuda", dialCode: "+1268"),
        Country(code: "AR", name: "Argentina", dialCode: "+54"),
        Country(code: "BS", name: "Bahamas", dialCode: "+1242"),
        Country(code: "BB", name: "Barbados", dialCode: "+1246"),
        Country(code: "BZ", name: "Belize", dialCode: "+501"),
        Country(code: "BO", name: "Bolivia", dialCode: "+591"),
        Country(code: "BR", name: "Brazil", dialCode: "+55"),
        Country(code: "CA", name: "Canada", dialCode: "+1"),
        Country(code: "CL", name: "Chile", dialCode: "+56"),
        Country(code: "CO", name: "Colombia", dialCode: "+57"),
        Country(code: "CR", name: "Costa Rica", dialCode: "+506"),
        Country(code: "CU", name: "Cuba", dialCode: "+53"),
        Country(code: "DM", name: "Dominica", dialCode: "+1767"),
        Country(code: "DO", name: "Dominican Republic", dialCode: "+1809"),
        Country(code: "EC", name: "Ecuador", dialCode: "+593"),
        Country(code: "SV", name: "El Salvador", dialCode: "+503"),
        Country(code: "GD", name: "Grenada", dialCode: "+1473"),
        Country(code: "GT", name: "Guatemala", dialCode: "+502"),
        Country(code: "GY", name: "Guyana", dialCode: "+592"),
        Country(code: "HT", name: "Haiti", dialCode: "+509"),
        Country(code: "HN", name: "Honduras", dialCode: "+504"),
        Country(code: "JM", name: "Jamaica", dialCode: "+1876"),
        Country(code: "MX", name: "Mexico", dialCode: "+52"),
        Country(code: "NI", name: "Nicaragua", dialCode: "+505"),
        Country(code: "PA", name: "Panama", dialCode: "+507"),
        Country(code: "PY", name: "Paraguay", dialCode: "+595"),
        Country(code: "PE", name: "Peru", dialCode: "+51"),
        Country(code: "KN", name: "Saint Kitts and Nevis", dialCode: "+1869"),
        Country(code: "LC", name: "Saint Lucia", dialCode: "+1758"),
        Country(code: "VC", name: "Saint Vincent and the Grenadines", dialCode: "+1784"),
        Country(code: "SR", name: "Suriname", dialCode: "+597"),
        Country(code: "TT", name: "Trinidad and Tobago", dialCode: "+1868"),
        Country(code: "US", name: "United States", dialCode: "+1"),
        Country(code: "UY", name: "Uruguay", dialCode: "+598"),
        Country(code: "VE", name: "Venezuela", dialCode: "+58"),

        // Asia
        Country(code: "AF", name: "Afghanistan", dialCode: "+93"),
        Country(code: "AM", name: "Armenia", dialCode: "+374"),
        Country(code: "AZ", name: "Azerbaijan", dialCode: "+994"),
        Country(code: "BH", name: "Bahrain", dialCode: "+973"),
        Country(code: "BD", name: "Bangladesh", dialCode: "+880"),
        Country(code: "BT", name: "Bhutan", dialCode: "+975"),
        Country(code: "BN", name: "Brunei", dialCode: "+673"),
        Country(code: "KH", name: "Cambodia", dialCode: "+855"),
        Country(code: "CN", name: "China", dialCode: "+86"),
        Country(code: "CY", name: "Cyprus", dialCode: "+357"),
        Country(code: "GE", name: "Georgia", dialCode: "+995"),
        Country(code: "IN", name: "India", dialCode: "+91"),
        Country(code: "ID", name: "Indonesia", dialCode: "+62"),
        Country(code: "IR", name: "Iran", dialCode: "+98"),
        Country(code: "IQ", name: "Iraq", dialCode: "+964"),
        Country(code: "IL", name: "Israel", dialCode: "+972"),
        Country(code: "JP", name: "Japan", dialCode: "+81"),
        Country(code: "JO", name: "Jordan", dialCode: "+962"),
        Country(code: "KZ", name: "Kazakhstan", dialCode: "+7"),
        Country(code: "KW", name: "Kuwait", dialCode: "+965"),
        Country(code: "KG", name: "Kyrgyzstan", dialCode: "+996"),
        Country(code: "LA", name: "Laos", dialCode: "+856"),
        Country(code: "LB", name: "Lebanon", dialCode: "+961"),
        Country(code: "MY", name: "Malaysia", dialCode: "+60"),
        Country(code: "MV", name: "Maldives", dialCode: "+960"),
        Country(code: "MN", name: "Mongolia", dialCode: "+976"),
        Country(code: "MM", name: "Myanmar", dialCode: "+95"),
        Country(code: "NP", name: "Nepal", dialCode: "+977"),
        Country(code: "KP", name: "North Korea", dialCode: "+850"),
        Country(code: "OM", name: "Oman", dialCode: "+968"),
        Country(code: "PK", name: "Pakistan", dialCode: "+92"),
        Country(code: "PS", name: "Palestine", dialCode: "+970"),
        Country(code: "PH", name: "Philippines", dialCode: "+63"),
        Country(code: "QA", name: "Qatar", dialCode: "+974"),
        Country(code: "SA", name: "Saudi Arabia", dialCode: "+966"),
        Country(code: "SG", name: "Singapore", dialCode: "+65"),
        Country(code: "KR", name: "South Korea", dialCode: "+82"),
        Country(code: "LK", name: "Sri Lanka", dialCode: "+94"),
        Country(code: "SY", name: "Syria", dialCode: "+963"),
        Country(code: "TW", name: "Taiwan", dialCode: "+886"),
        Country(code: "TJ", name: "Tajikistan", dialCode: "+992"),
        Country(code: "TH", name: "Thailand", dialCode: "+66"),
        Country(code: "TL", name: "Timor-Leste", dialCode: "+670"),
        Country(code: "TR", name: "Turkey", dialCode: "+90"),
        Country(code: "TM", name: "Turkmenistan", dialCode: "+993"),
        Country(code: "AE", name: "United Arab Emirates", dialCode: "+971"),
        Country(code: "UZ", name: "Uzbekistan", dialCode: "+998"),
        Country(code: "VN", name: "Vietnam", dialCode: "+84"),
        Country(code: "YE", name: "Yemen", dialCode: "+967"),

        // Europe
        Country(code: "AL", name: "Albania", dialCode: "+355"),
        Country(code: "AD", name: "Andorra", dialCode: "+376"),
        Country(code: "AT", name: "Austria", dialCode: "+43"),
        Country(code: "BY", name: "Belarus", dialCode: "+375"),
        Country(code: "BE", name: "Belgium", dialCode: "+32"),
        Country(code: "BA", name: "Bosnia and Herzegovina", dialCode: "+387"),
        Country(code: "BG", name: "Bulgaria", dialCode: "+359"),
        Country(code: "HR", name: "Croatia", dialCode: "+385"),
        Country(code: "CZ", name: "Czech Republic", dialCode: "+420"),
        Country(code: "DK", name: "Denmark", dialCode: "+45"),
        Country(code: "EE", name: "Estonia", dialCode: "+372"),
        Country(code: "FI", name: "Finland", dialCode: "+358"),
        Country(code: "FR", name: "France", dialCode: "+33"),
        Country(code: "DE", name: "Germany", dialCode: "+49"),
        Country(code: "GR", name: "Greece", dialCode: "+30"),
        Country(code: "HU", name: "Hungary", dialCode: "+36"),
        Country(code: "IS", name: "Iceland", dialCode: "+354"),
        Country(code: "IE", name: "Ireland", dialCode: "+353"),
        Country(code: "IT", name: "Italy", dialCode: "+39"),
        Country(code: "XK", name: "Kosovo", dialCode: "+383"),
        Country(code: "LV", name: "Latvia", dialCode: "+371"),
        Country(code: "LI", name: "Liechtenstein", dialCode: "+423"),
        Country(code: "LT", name: "Lithuania", dialCode: "+370"),
        Country(code: "LU", name: "Luxembourg", dialCode: "+352"),
        Country(code: "MT", name: "Malta", dialCode: "+356"),
        Country(code: "MD", name: "Moldova", dialCode: "+373"),
        Country(code: "MC", name: "Monaco", dialCode: "+377"),
        Country(code: "ME", name: "Montenegro", dialCode: "+382"),
        Country(code: "NL", name: "Netherlands", dialCode: "+31"),
        Country(code: "MK", name: "North Macedonia", dialCode: "+389"),
        Country(code: "NO", name: "Norway", dialCode: "+47"),
        Country(code: "PL", name: "Poland", dialCode: "+48"),
        Country(code: "PT", name: "Portugal", dialCode: "+351"),
        Country(code: "RO", name: "Romania", dialCode: "+40"),
        Country(code: "RU", name: "Russia", dialCode: "+7"),
        Country(code: "SM", name: "San Marino", dialCode: "+378"),
        Country(code: "RS", name: "Serbia", dialCode: "+381"),
        Country(code: "SK", name: "Slovakia", dialCode: "+421"),
        Country(code: "SI", name: "Slovenia", dialCode: "+386"),
        Country(code: "ES", name: "Spain", dialCode: "+34"),
        Country(code: "SE", name: "Sweden", dialCode: "+46"),
        Country(code: "CH", name: "Switzerland", dialCode: "+41"),
        Country(code: "UA", name: "Ukraine", dialCode: "+38"),
        Country(code: "GB", name: "United Kingdom", dialCode: "+44"),
        Country(code: "VA", name: "Vatican City", dialCode: "+379"),

        // Oceania
        Country(code: "AU", name: "Australia", dialCode: "+61"),
        Country(code: "FJ", name: "Fiji", dialCode: "+679"),
        Country(code: "KI", name: "Kiribati", dialCode: "+686"),
        Country(code: "MH", name: "Marshall Islands", dialCode: "+692"),
        Country(code: "FM", name: "Micronesia", dialCode: "+691"),
        Country(code: "NR", name: "Nauru", dialCode: "+674"),
        Country(code: "NZ", name: "New Zealand", dialCode: "+64"),
        Country(code: "PW", name: "Palau", dialCode: "+680"),
        Country(code: "PG", name: "Papua New Guinea", dialCode: "+675"),
        Country(code: "WS", name: "Samoa", dialCode: "+685"),
        Country(code: "SB", name: "Solomon Islands", dialCode: "+677"),
        Country(code: "TO", name: "Tonga", dialCode: "+676"),
        Country(code: "TV", name: "Tuvalu", dialCode: "+688"),
        Country(code: "VU", name: "Vanuatu", dialCode: "+678"),
    ].sorted { $0.name < $1.name }
}

extension Country {
   // TODO: commonly used length for validation not finalized
    private static let phoneNumberLengths: [String: ClosedRange<Int>] = [
        "US": 10...10, "CA": 10...10, "GB": 10...10, "IN": 10...10,
        "AU": 9...9, "DE": 10...11, "FR": 9...9, "IT": 9...10,
        "ES": 9...9, "NL": 9...9, "BE": 9...9, "CH": 9...9,
        "NO": 8...8, "DK": 8...8, "FI": 9...10, "PL": 9...9,
        "PT": 9...9, "IE": 9...9, "GR": 10...10, "CZ": 9...9,
        "HU": 9...9, "RO": 9...9, "BG": 9...9, "RU": 10...10,
        "UA": 9...9, "TR": 10...10, "CN": 11...11, "JP": 10...10,
        "KR": 9...10, "SG": 8...8, "MY": 9...10, "ID": 9...12,
        "TH": 9...9, "VN": 9...10, "PH": 10...10, "PK": 10...10,
        "BD": 10...10, "LK": 9...9, "NP": 10...10, "AE": 9...9,
        "SA": 9...9, "QA": 8...8, "KW": 8...8, "BH": 8...8,
        "OM": 8...8, "JO": 9...9, "IL": 9...9, "EG": 10...10,
        "ZA": 9...9, "NG": 10...10, "KE": 9...9, "GH": 9...9,
        "MA": 9...9, "DZ": 9...9, "TN": 8...8, "BR": 10...11,
        "MX": 10...10, "AR": 10...10, "CL": 9...9, "CO": 10...10,
        "PE": 9...9, "VE": 10...10, "EC": 9...9, "NZ": 8...9,
    ]

    private static let defaultPhoneNumberLengthRange: ClosedRange<Int> = 6...14

    /// Valid digit-count range for a mobile number in this country,
    /// excluding the dial code.
    var phoneNumberLengthRange: ClosedRange<Int> {
        Country.phoneNumberLengths[code] ?? Country.defaultPhoneNumberLengthRange
    }
}

