import React from "react";
import "./App.css";
import { signUp, signIn } from "./Auth.js";

class App extends React.Component {
  constructor() {
    super();
    this.state = {
      userEmail: "",
      userPassword: "",
      userPasswordConfirmation: "",
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
              id="user-email"
              value={this.state.userEmail}
              onChange={this.updateUserEmail}
            />
          </label>
          <label>
            <span>Password</span>
            <input
              type="password"
              id="user-password"
              value={this.state.userPassword}
              onChange={this.updateUserPassword}
            />
          </label>
          <label>
            <span>Password Confirmation</span>
            <input
              type="password"
              id="user-password-confirmation"
              value={this.state.userPasswordConfirmation}
              onChange={this.updateUserPasswordConfirmation}
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
              id="user-email"
              value={this.state.userEmail}
              onChange={this.updateUserEmail}
            />
          </label>
          <label>
            <span>Password</span>
            <input
              type="password"
              id="user-password"
              value={this.state.userPassword}
              onChange={this.updateUserPassword}
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

  updateUserEmail = (event) => {
    this.setState({ userEmail: event.target.value });
  };
  updateUserPassword = (event) => {
    this.setState({ userPassword: event.target.value });
  };
  updateUserPasswordConfirmation = (event) => {
    this.setState({
      userPasswordCOupdateUserPasswordConfirmation: event.target.value,
    });
  };
  updateSequenceCurrent = (event) => {
    this.setState({ sequenceCurrent: event.target.value });
  };

  doSignUp = async () => {
    // let urls = await fetchGifs(this.state.text);
    // console.log(urls);
    // this.setState({
    //   images: urls,
    // });
  };

  doSignIn = async () => {
    // let urls = await fetchGifs(this.state.text);
    // console.log(urls);
    // this.setState({
    //   images: urls,
    // });
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
