import PathRouter from "next/router";
import React from "react";

import Layout from "common/ui/layout";
import Loader from "common/ui/loader";

export type IPage = {
  isLoggedIn: boolean;
  loginRequired?: boolean;
  children: React.ReactNode;
}

const Page: React.FC<IPage> = ({ isLoggedIn, loginRequired = false, children }) => {
  if (loginRequired && !isLoggedIn) {
    if (typeof(window) !== "undefined") {
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

export default Page;