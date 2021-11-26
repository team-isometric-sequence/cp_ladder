import PathRouter from "next/router";
import React from "react";

import Layout from "common/ui/layout";
import Loader from "common/ui/loader";

type IAuthenticationWrapper = {
  isLoggedIn: boolean;
  children: React.ReactNode;
}

const AuthenticationWrapper: React.FC<IAuthenticationWrapper> = ({ isLoggedIn, children }) => {
  if (typeof(window) !== "undefined") {
    if (window.location.pathname.includes("/unsolved_problems")) {
      return (
        <Layout>
          {children}
        </Layout>
      )
    }
  }

  if (isLoggedIn) {
    return (
      <Layout>
        {children}
      </Layout>
    );
  }

  if (typeof(window) !== "undefined") {
    if (!window.location.pathname.includes("/login")) {
      PathRouter.push(`/login?next=${window.location.pathname}`);
      return <Loader />;
    }
  }

  return (
    <Layout>
      {children}
    </Layout>
  );
}

export default AuthenticationWrapper;