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
};

String prettierDescription(String description) {
  for (String key in _prettier.keys) {
    if (description.contains(key)) {
      return _prettier[key];
    }
  }
  return description;
}
