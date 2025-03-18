class Wajong:

    """"
    Calculated monthly benefit. Scenario for income not supported.
    """
    def calculate_benefit(self, age: int, can_work: bool, income = 0):
        if income > 0:
            raise NotImplementedError("Calculation with income not supported.")
        if age < 18:
            raise ValueError("Age should be at least 18 years.")
        match age:
            case 18:
                if can_work:
                    return 790.40
                return 845.20
            case 19:
                if can_work:
                    return 942.79
                return 1008.54
            case 20:
                if can_work:
                    return 1240.81
                return 1328.48
            case _:  # > 21
                if can_work:
                    return 1534.22
                return 1643.81
