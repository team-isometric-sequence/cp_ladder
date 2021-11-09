class Exception {
  message: string;

  constructor(message: string = "") {
    this.message = message;
  }
}

class LoginRequiredError extends Exception {
  constructor(message: string = "") {
    super(message);
  }
}

export { LoginRequiredError };