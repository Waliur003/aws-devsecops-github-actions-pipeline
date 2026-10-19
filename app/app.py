def get_message():
    return "GitHub Actions Cloud Engineering Lab"


def health_check():
    return "healthy"


if __name__ == "__main__":
    print(get_message())
    print(health_check())