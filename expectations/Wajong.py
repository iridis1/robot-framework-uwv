class Wajong:

    def calculate_benefit(self, age: int, can_work: bool, income = 0):
        if (income > 0):
            raise Exception("Calculation with income not supported.")
        if (age < 18):
            raise Exception("Age should be at least 18 years.")
        match age:
            case 18:
                if can_work:
                    return 790.40
                else:
                    return 845, 20
            case 19:
                if can_work:
                    return 942.79
                else:
                    return 1.008, 54
            case 20:
                if can_work:
                    return 1240.81
                else:
                    return 1328.48
            case _:  # > 21
                if can_work:
                    return 1534.22
                else:
                    return 1643.81
