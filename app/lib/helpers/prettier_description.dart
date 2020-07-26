// TODO : This should be in firestore
Map<String, String> _prettier = {
  "STRAKSOVERFØRING": "Vipps",
  "PEPPES PIZZA": "Peppes Pizza",
  "KIWI": "Kiwi",
  "SHELL": "Shell",
  "CIRCLE K": "Circle K",
  "DiscoveryNetworksNorwayAS": "Dplay",
  "Q-PARK GRIEGPAR": "Grieg Park",
  "GODADDY": "Go Daddy",
  "Stadia": "Stadia",
  "BERGEN KOMMUNE": "Bergen Kommune",
  "STAPLES": "Staples",
  "VIPPS": "Vipps",
  "SKYSS": "Skyss",
  "KREDITRENTER": "Kreditrenter",
  "Spotify": "Spotify",
  "CLAS OHL": "Clas Ohlson",
  "Overføring mellom egne kontoer": "Overføring",
  "AFT INVEST AS VASKERELVSMA BERGEN": "Inside",
  "Fra: ": "Vipps",
  "ESSO": "Esso",
  "MIDTTUN HAGESEN": "Midtun Hagesenter",
  "ARK": "Ark",
  "EXTRA": "Coop Extra",
  "ARDUINO": "Arduino",
  "MENY": "Meny",
  "NORLI": "Norli",
  "AMUNDSEN": "Amundsen Spesial",
  "KJELL&": "Kjell & Company",
  "REMA": "Rema 1000",
  "YOUTUBE": "YouTube",
  "AKADEM.KVARTER": "Det Akademiske Kvarter",
  "ELKJØP": "Elkjøp",
  "COCA-COLA ENTERPRISES": "Brusautomat",
  "LØNN": "Lønn",
};

String prettierDescription(String description) {
  for (String key in _prettier.keys) {
    if (description.toLowerCase().contains(key.toLowerCase())) {
      return _prettier[key];
    }
  }
  return description;
}
