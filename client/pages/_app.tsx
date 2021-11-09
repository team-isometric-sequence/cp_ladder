import '../styles/globals.css'
import type { AppProps } from 'next/app'
import PathRouter from "next/router";

import { nest } from "recompose";

import AppContext, { AppContextProvider } from "common/contexts/app-context";

const Providers = nest( AppContextProvider );

const App: React.FC<AppProps> = ({ Component, pageProps }) => {
  return (
    <Providers>
      <AppContext.Consumer>
        {({ isLoggedIn }) => {
          return <Component {...pageProps} />
        }}
      </AppContext.Consumer>
    </Providers>
  )
}

export default App
