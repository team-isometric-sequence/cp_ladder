import '../styles/globals.css'
import type { AppProps } from 'next/app'

import { nest } from "recompose";
import { ChakraProvider } from "@chakra-ui/react";

import AppContext, { AppContextProvider } from "common/contexts/app-context";

const Providers = nest( AppContextProvider );

const App: React.FC<AppProps> = ({ Component, pageProps }) => {
  return (
    <Providers>
      <ChakraProvider>
        <AppContext.Consumer>
          {({ isLoggedIn }) => {
            return (
              <Component isLoggedIn={isLoggedIn || false} {...pageProps} />
            );
          }}
        </AppContext.Consumer>
      </ChakraProvider>
    </Providers>
  )
}

export default App
