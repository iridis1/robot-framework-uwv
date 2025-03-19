class Format:

    def format_currency(self, value: float):
        """ Formats for example 1200.5 as 1.200,50 """
        return f"{float(value):_.2f}".replace(".", ",").replace("_", ".")
