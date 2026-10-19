def get_message():
    return "My AWS DevSecOps Pipeline"


def health_check():
    return "healthy"


if __name__ == "__main__":
    print(get_message())
    print(health_check())