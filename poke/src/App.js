import React from "react";
import "./App.css";
import { signUp, signIn } from "./Auth.js";

async function responseText(response) {
  let text = await response.text();
  return `HTTP Status: ${response.status}, Body: ${text}`;
}

class App extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      signUpEmail: "",
      signUpPassword: "",
      signUpPasswordConfirmation: "",
      signInEmail: "",
      signInPassword: "",
      sequenceCurrent: "",
      token: "",
      message: "",
    };
  }

  render() {
    return (
      <div className="App">
        <div className={this.classHiddenIfLoggedIn()}>
          <h3>Sign up</h3>
          <label>
            <span>Email</span>
            <input
              type="email"
              id="signup-email"
              value={this.state.signUpEmail}
              onChange={this.updateSignUpEmail}
            />
          </label>
          <label>
            <span>Password</span>
            <input
              type="password"
              id="signup-password"
              value={this.state.signUpPassword}
              onChange={this.updateSignUpPassword}
            />
          </label>
          <label>
            <span>Password Confirmation</span>
            <input
              type="password"
              id="signup-password-confirmation"
              value={this.state.signUpPasswordConfirmation}
              onChange={this.updateSignUpPasswordConfirmation}
            />
          </label>
          <button type="button" onClick={this.doSignUp}>
            Sign up
          </button>
        </div>
        <div className={this.classHiddenIfLoggedIn()}>
          <h3>Sign in</h3>
          <label>
            <span>Email</span>
            <input
              type="email"
              id="signin-email"
              value={this.state.signInEmail}
              onChange={this.updateSignInEmail}
            />
          </label>
          <label>
            <span>Password</span>
            <input
              type="password"
              id="signin-password"
              value={this.state.signInPassword}
              onChange={this.updateSignInPassword}
            />
          </label>
          <button type="button" onClick={this.doSignIn}>
            Sign in
          </button>
        </div>
        <div className={this.classHiddenIfLoggedOut()}>
          <table id="http-api-endpoints">
            <thead>
              <tr>
                <th>HTTP API endpoint</th>
                <th>Command</th>
              </tr>
            </thead>
            <tbody>
              <tr>
                <td>GET /current</td>
                <td>
                  <button type="button" onClick={this.doCurrent}>
                    Current
                  </button>
                </td>
              </tr>
              <tr>
                <td>PUT /current</td>
                <td>
                  <input
                    type="text"
                    id="sequence-current"
                    value={this.state.sequenceCurrent}
                    onChange={this.updateSequenceCurrent}
                  />
                  <button type="button" onClick={this.doReset}>
                    Reset
                  </button>
                </td>
              </tr>
              <tr>
                <td>GET /next</td>
                <td>
                  <button type="button" onClick={this.doNext}>
                    Next
                  </button>
                </td>
              </tr>
            </tbody>
          </table>
        </div>
        <div>
          <h3>Output</h3>
          <div>{this.state.message}</div>
        </div>
      </div>
    );
  }

  isLoggedIn = () => this.state.token !== "";

  classHiddenIfLoggedIn = () => {
    if (this.isLoggedIn()) {
      return "is-hidden";
    }
    return "";
  };

  classHiddenIfLoggedOut = () => {
    if (!this.isLoggedIn()) {
      return "is-hidden";
    }
    return "";
  };

  updateSignUpEmail = (event) => {
    this.setState({ signUpEmail: event.target.value });
  };
  updateSignUpPassword = (event) => {
    this.setState({ signUpPassword: event.target.value });
  };
  updateSignUpPasswordConfirmation = (event) => {
    this.setState({ signUpPasswordConfirmation: event.target.value });
  };
  updateSignInEmail = (event) => {
    this.setState({ signInEmail: event.target.value });
  };
  updateSignInPassword = (event) => {
    this.setState({ signInPassword: event.target.value });
  };
  updateSequenceCurrent = (event) => {
    this.setState({ sequenceCurrent: event.target.value });
  };

  doSignUp = async () => {
    try {
      let token = await signUp(
        this.state.signUpEmail,
        this.state.signUpPassword,
        this.state.signUpPasswordConfirmation
      );
      this.setState({ token: token, message: "" });
      console.info(`Sign up token: ${token}`);
    } catch (response) {
      this.setState({ message: await responseText(response) });
    }
  };

  doSignIn = async () => {
    try {
      let token = await signIn(
        this.state.signInEmail,
        this.state.signInPassword
      );
      this.setState({ token: token, message: "" });
      console.info(`Sign in token: ${token}`);
    } catch (response) {
      this.setState({ message: await responseText(response) });
    }
  };

  doCurrent = async () => {
    // let urls = await fetchGifs(this.state.text);
    // console.log(urls);
    // this.setState({
    //   images: urls,
    // });
  };

  doReset = async () => {
    // let urls = await fetchGifs(this.state.text);
    // console.log(urls);
    // this.setState({
    //   images: urls,
    // });
  };

  doNext = async () => {
    // let urls = await fetchGifs(this.state.text);
    // console.log(urls);
    // this.setState({
    //   images: urls,
    // });
  };
}

export default App;
