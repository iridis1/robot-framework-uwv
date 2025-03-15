class Format:

    def format_currency(self, value):
        return "€ " + f"{float(value):_.2f}".replace(".", ",").replace("_", ".")
    