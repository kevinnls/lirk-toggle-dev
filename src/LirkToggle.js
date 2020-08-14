import React, { useEffect } from "react";
import "./LirkToggle.css";

const Toggle = (props) => {
  return (
    <div id="lirk-toggle" onClick={props.clickHandler}>
      {props.children}
    </div>
  );
};
const ToggleTrack = (props) => {
  useEffect(() => {
    document
      .getElementById("lirk-toggleTrack")
      .style.setProperty("--track-theme", `var(--${props.theme})`);
  });
  return (
    <div id="lirk-toggleTrack">
      <span aria-label="lightmode" role="img" style={{ gridColumn: 1 / 1 }}>
        🌞
      </span>
      <span aria-label="lightmode" role="img" style={{ gridColumn: 2 / 1 }}>
        🌛
      </span>
      {props.children}
    </div>
  );
};
const ToggleRunner = (props) => {
  useEffect(() => {
    document
      .getElementById("lirk-toggleRunner")
      .style.setProperty("--runner-position", props.pos);
  });
  return <div id="lirk-toggleRunner" />;
};

class LirkToggle extends React.Component {
  constructor(props) {
    super(props);
    let cookie = getLirkCookie();
    switch (cookie) {
      case "light":
        this.state = this.lightState;
        break;
      case "dark":
        this.state = this.darkState;
        break;
      default:
        setLirkCookie("light");
        this.state = this.lightState;
    }
  }

  lightState = {
    theme: "light",
    runnerPosition: "1",
  };
  darkState = {
    theme: "dark",
    runnerPosition: "2",
  };

  handleClick = this.handleClick.bind(this);

  render() {
    return (
      <Toggle clickHandler={this.handleClick}>
        <ToggleTrack theme={this.state.theme}>
          <ToggleRunner pos={this.state.runnerPosition} />
        </ToggleTrack>
      </Toggle>
    );
  }
  componentDidUpdate() {
    //aka changeTheme();
    setLirkCookie(this.state.theme);
  }
  handleClick() {
    if (this.state.theme === "light") this.setState(this.darkState);
    else this.setState(this.lightState);
  }
}

function getLirkCookie() {
  const cookieName = "lirk-theme=";
  let cookieArray =
    document.cookie && decodeURIComponent(document.cookie).split(";");
  if (cookieArray === "") return "";
  for (let cookie of cookieArray) {
    cookie = cookie.trim();
    if (cookie.indexOf(cookieName) === 0)
      return cookie.substring(cookieName.length);
    else return "";
  }
}

function setLirkCookie(theme) {
  const cookieName = "lirk-theme=";
  document.cookie = cookieName + theme;
}

export default LirkToggle;
