class Format:

    def format_currency(self, value: float):
        return f"{float(value):_.2f}".replace(".", ",").replace("_", ".")
