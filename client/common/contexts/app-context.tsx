import React, { createContext, useEffect, useState } from "react";

import UserApi from "api/user-api";
import { LoginRequiredError } from "common/exceptions";

const AppContext = createContext<{
  isLoggedIn: boolean;
  user?: {
    username?: string;
    email? : string;
  };
}>({ isLoggedIn: false });

const AppContextProvider: React.FC = ({
  children
}) => {
  const [profile, setProfile] = useState({});

  useEffect(() => {
    UserApi.getProfile()
      .then((profile) => {
        setProfile(profile);
      })
      .catch((error) => {
        if (error instanceof LoginRequiredError) {
          console.log("Login Requied");
        }
        console.log(error);
      });
  }, []);

  const context = {
    isLoggedIn: Object.keys(profile).length !== 0,
    user: profile,
  }

  return (<AppContext.Provider value={ context }>
    { children }
  </AppContext.Provider>)
};

export { AppContextProvider };

export default AppContext;