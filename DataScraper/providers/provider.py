from abc import ABC, abstractmethod


class Provider(ABC):

    COUNTRIES = [
        ("Albania", "AL"),
        ("Austria", "AT"),
        ("Belarus", "BY"),
        ("Belgium", "BE"),
        ("Bosnia and Herzegovina", "BA"),
        ("Bulgaria", "BG"),
        ("Burkina Faso", "BF"),
        ("Costa Rica", "CR"),
        ("Croatia", "HR"),
        ("Cyprus", "CY"),
        ("Czech Republic", "CZ"),
        ("Denmark", "DK"),
        ("Egypt", "EG"),
        ("Estonia", "EE"),
        ("Finland", "FI"),
        ("France", "FR"),
        ("Germany", "DE"),
        ("Greece", "GR"),
        ("Greenland", "GL"),
        ("Hungary", "HU"),
        ("Iceland", "IS"),
        ("Ireland", "IE"),
        ("Israel", "IL"),
        ("Italy", "IT"),
        ("Latvia", "LV"),
        ("Lithuania", "LT"),
        ("Luxembourg", "LU"),
        ("Macedonia", "MK"),
        ("Moldova", "MD"),
        ("Mongolia", "MN"),
        ("Montenegro", "ME"),
        ("Netherlands", "NL"),
        ("Norway", "NO"),
        ("Poland", "PL"),
        ("Portugal", "PT"),
        ("Puerto Rico", "PR"),
        ("Romania", "RO"),
        ("Russia", "RU"),
        ("Serbia", "RS"),
        ("Slovakia", "SK"),
        ("Slovenia", "SI"),
        ("Spain", "ES"),
        ("Swaziland", "SZ"),
        ("Sweden", "SE"),
        ("Switzerland", "CH"),
        ("Turkey", "TR"),
        ("United Kingdom", "GB"),
        ("Ukraine", "UA")
    ]

    @classmethod
    def get_country_by_code(cls, country_code):
        for c in Provider.COUNTRIES:
            country, code = c
            if code == country_code:
                return country
        return None

    @classmethod
    @abstractmethod
    def fetch_country_timeline(cls, country_code):
        pass
