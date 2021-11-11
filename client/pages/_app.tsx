import '../styles/globals.css'
import type { AppProps } from 'next/app'

import { nest } from "recompose";
import { ChakraProvider } from "@chakra-ui/react";

import AppContext, { AppContextProvider } from "common/contexts/app-context";
import AuthenticationWrapper from 'common/ui/authentication-wrapper';

const Providers = nest( AppContextProvider );

const App: React.FC<AppProps> = ({ Component, pageProps }) => {
  return (
    <Providers>
      <ChakraProvider>
        <AppContext.Consumer>
          {({ isLoggedIn }) => {
            return (
              <AuthenticationWrapper isLoggedIn={isLoggedIn || false}>
                <Component {...pageProps} />
              </AuthenticationWrapper>
            );
          }}
        </AppContext.Consumer>
      </ChakraProvider>
    </Providers>
  )
}

export default App
