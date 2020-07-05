import fetch from "node-fetch";
import { VirusTimelineType, VirusTimelineSchema } from "../models/timeline";
import { VIRUS_DATA_API } from "../config/constants";



  

export const refreshTimelinesJob = async () => {
    console.log("Refreshing timelines...")
    const APIS = ["graphql", "thevirustracker"];

    for (let key in countries) {
        for (let api of APIS) {
            const url = `http://${VIRUS_DATA_API}/api/timelines/${countries[key]}?api=${api}`;
            try {
                const response = await fetch(url);
                const body = await response.json();
                if (response.status != 200) {
                    continue;
                }
                const timeline = await VirusTimelineSchema.findOne({code: countries[key]});
                if (timeline) {

                    timeline.timeline = body['timeline'];
                    await timeline.save();

                } else {
                    const newTimeline = new VirusTimelineSchema({
                        country: key,
                        code: countries[key],
                        timeline: body['timeline']
                    });
                    await newTimeline.save();
                }
                break;

            } catch (err) {
                /* console.log("error while updating timeline", err); */
		console.log("error while connecting with data api");
            }


        }
    }
    console.log("Finished refreshing...");
}

const countries: {[key: string]: any} = {
    "Afghanistan":	"AF",
    "Albania":	"AL",
    "Algeria":	"DZ",
    "Angola":	"AO",
    "Argentina":	"AR",
    "Armenia":	"AM",
    "Australia":	"AU",
    "Austria":	"AT",
    "Azerbaijan":	"AZ",
    "Bahamas":	"BS",
    "Bangladesh":	"BD",
    "Belarus":	"BY",
    "Belgium":	"BE",
    "Belize":	"BZ",
    "Benin":	"BJ",
    "Bhutan":	"BT",
    "Bolivia":	"BO",
    "Bosnia and Herzegovina":	"BA",
    "Botswana":	"BW",
    "Brazil":	"BR",
    "Brunei Darussalam":	"BN",
    "Bulgaria":	"BG",
    "Burkina Faso":	"BF",
    "Burundi":	"BI",
    "Cambodia":	"KH",
    "Cameroon":	"CM",
    "Canada":	"CA",
    "Ivory Coast":	"CI",
    "Central African Republic":	"CF",
    "Chad":	"TD",
    "Chile":	"CL",
    "China":	"CN",
    "Colombia":	"CO",
    "Congo":	"CG",
    "Democratic Republic of Congo":	"CD",
    "Costa Rica":	"CR",
    "Croatia":	"HR",
    "Cuba":	"CU",
    "Cyprus":	"CY",
    "Czech Republic":	"CZ",
    "Denmark":	"DK",
    "Diamond Princess":	"DP",
    "Djibouti":	"DJ",
    "Dominican Republic":	"DO",
    "DR Congo":	"CD",
    "Ecuador":	"EC",
    "Egypt":	"EG",
    "El Salvador":	"SV",
    "Equatorial Guinea":	"GQ",
    "Eritrea":	"ER",
    "Estonia":	"EE",
    "Ethiopia":	"ET",
    "Falkland Islands":	"FK",
    "Fiji":	"FJ",
    "Finland":	"FI",
    "France":	"FR",
    "French Guiana":	"GF",
    "French Southern Territories":	"TF",
    "Gabon":	"GA",
    "Gambia":	"GM",
    "Georgia":	"GE",
    "Germany":	"DE",
    "Ghana":	"GH",
    "Greece":	"GR",
    "Greenland":	"GL",
    "Guatemala":	"GT",
    "Guinea":	"GN",
    "Guinea-Bissau":	"GW",
    "Guyana":	"GY",
    "Haiti":	"HT",
    "Honduras":	"HN",
    "Hong Kong":	"HK",
    "Hungary":	"HU",
    "Iceland":	"IS",
    "India":	"IN",
    "Indonesia":	"ID",
    "Iran":	"IR",
    "Iraq":	"IQ",
    "Ireland":	"IE",
    "Israel":	"IL",
    "Italy":	"IT",
    "Jamaica":	"JM",
    "Japan":	"JP",
    "Jordan":	"JO",
    "Kazakhstan":	"KZ",
    "Kenya":	"KE",
    "Korea":	"KP",
    "Kosovo":	"XK",
    "Kuwait":	"KW",
    "Kyrgyzstan":	"KG",
    "Lao":	"LA",
    "Latvia":	"LV",
    "Lebanon":	"LB",
    "Lesotho":	"LS",
    "Liberia":	"LR",
    "Libya":	"LY",
    "Lithuania":	"LT",
    "Luxembourg":	"LU",
    "Macedonia":	"MK",
    "Madagascar":	"MG",
    "Malawi":	"MW",
    "Malaysia":	"MY",
    "Mali":	"ML",
    "Mauritania":	"MR",
    "Mexico":	"MX",
    "Moldova":	"MD",
    "Mongolia":	"MN",
    "Montenegro":	"ME",
    "Morocco":	"MA",
    "Mozambique":	"MZ",
    "Myanmar":	"MM",
    "Namibia":	"NA",
    "Nepal":	"NP",
    "Netherlands":	"NL",
    "New Caledonia":	"NC",
    "New Zealand":	"NZ",
    "Nicaragua":	"NI",
    "Niger":	"NE",
    "Nigeria":	"NG",
    "North Korea":	"KP",
    "Norway":	"NO",
    "Oman":	"OM",
    "Pakistan":	"PK",
    "Palestine":	"PS",
    "Panama":	"PA",
    "Papua New Guinea":	"PG",
    "Paraguay":	"PY",
    "Peru":	"PE",
    "Philippines":	"PH",
    "Poland":	"PL",
    "Portugal":	"PT",
    "Puerto Rico":	"PR",
    "Qatar":	"QA",
    "Republic of Kosovo":	"XK",
    "Romania":	"RO",
    "Russia":	"RU",
    "Rwanda":	"RW",
    "Saudi Arabia":	"SA",
    "Senegal":	"SN",
    "Serbia":	"RS",
    "Sierra Leone":	"SL",
    "Singapore":	"SG",
    "Slovakia":	"SK",
    "Slovenia":	"SI",
    "Solomon Islands":	"SB",
    "Somalia":	"SO",
    "South Africa":	"ZA",
    "South Korea":	"KR",
    "South Sudan":	"SS",
    "Spain":	"ES",
    "Sri Lanka":	"LK",
    "Sudan":	"SD",
    "Suriname":	"SR",
    "Svalbard and Jan Mayen":	"SJ",
    "Swaziland":	"SZ",
    "Sweden":	"SE",
    "Switzerland":	"CH",
    "Syrian Arab Republic":	"SY",
    "Taiwan":	"TW",
    "Tajikistan":	"TJ",
    "Tanzania":	"TZ",
    "Thailand":	"TH",
    "Timor-Leste":	"TL",
    "Togo":	"TG",
    "Trinidad and Tobago":	"TT",
    "Tunisia":	"TN",
    "Turkey":	"TR",
    "Turkmenistan":	"TM",
    "UAE":	"AE",
    "Uganda":	"UG",
    "United Kingdom":	"GB",
    "Ukraine":	"UA",
    "USA":	"US",
    "Uruguay":	"UY",
    "Uzbekistan":	"UZ",
    "Vanuatu":	"VU",
    "Venezuela":	"VE",
    "Vietnam":	"VN",
    "Western Sahara":	"EH",
    "Yemen":	"YE",
    "Zambia":	"ZM",
    "Zimbabwe":	"ZW",
}
