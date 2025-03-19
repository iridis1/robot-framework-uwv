class Wajong:

    def calculate_benefit(self, age: int, can_work: bool, income = 0):
        """ Calculate monthly benefit. Scenario with income not supported. """
        if income > 0:
            raise NotImplementedError("Calculation with income not supported.")
        if age < 18:
            raise ValueError("Age should be at least 18 years.")

        benefit_amounts = {
            18: (790.40, 845.20),
            19: (942.79, 1008.54),
            20: (1240.81, 1328.48),
            21: (1534.22, 1643.81)
        }

        key = age if age < 21 else 21

        return benefit_amounts[key][0 if can_work else 1]
