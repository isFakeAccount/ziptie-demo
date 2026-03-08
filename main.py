import spam


def main() -> None:
    print("Hello from ziptie-demo!")
    print(dir(spam))
    out = spam.spam_system("echo Hello from spam!")
    print(out)


if __name__ == "__main__":
    main()
