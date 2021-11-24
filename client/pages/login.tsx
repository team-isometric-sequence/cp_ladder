import { useRouter } from "next/router";
import React, { useState, useContext } from "react";
import { Formik, Form } from "formik";

import {
  Box,
  Heading,
  FormControl,
  FormLabel,
  Input,
  Button,
  CircularProgress,
  InputGroup,
} from "@chakra-ui/react";

import Loader from "common/ui/loader";
import AppContext from "common/contexts/app-context";
import LocalStorageService from "common/services/local-storage-service";

import UserApi from "api/user-api";

const LoginPage = () => {
  const { isLoggedIn } = useContext(AppContext);

  const [key, setKey] = useState(0);
  const [isLoading, setLoading] = useState(false);
  const router = useRouter();

  if (isLoggedIn) {
    router.push("/");
    return <Loader />;
  }

  const { next } = router.query;

  return (
    <div>

      <Box textAlign="center">
        <Heading>Login</Heading>
      </Box>
      <Box my={4} textAlign="left">
        <Formik
          initialValues={{
            username: "",
            password: "",
          }}
          onSubmit={(values, actions) => {
            setKey(key + 1);
            setLoading(true);
            UserApi.login(values.username, values.password)
              .then((result: any) => {
                if (result.ok) {
                  console.log(result);
                  LocalStorageService.setAccessToken(result.data.jwt);
                  const nextPath = next?.toString() || "/";
                  window.location.href = nextPath;
                  router.push(nextPath);
                }
                setLoading(false);
              }).catch(() => {
                setLoading(false);
              }
            );
          }}
        >
          {({ handleChange, handleBlur }) => (
            <Form key={key}>
              <FormControl isRequired>
                <FormLabel>User Name</FormLabel>
                <Input
                  type="text"
                  placeholder="ID를 입력"
                  name="username"
                  size="lg"
                  onChange={handleChange}
                  onBlur={handleBlur}
                />
              </FormControl>
              <FormControl isRequired mt={6}>
                <FormLabel>Password</FormLabel>
                <InputGroup>
                  <Input
                    type={'password'}
                    placeholder="*******"
                    name="password"
                    onChange={handleChange}
                    onBlur={handleBlur}
                    size="lg"
                  />
                </InputGroup>
              </FormControl>
              <Button
                variantColor="teal"
                variant="outline"
                type="submit"
                width="full"
                mt={4}
              >
                {isLoading ? (
                  <CircularProgress
                    isIndeterminate
                    size="24px"
                    color="teal"
                  />
                ) : (
                  'Sign In'
                )}
              </Button>
            </Form>
          )}
        </Formik>
      </Box>
    </div>
  )
}

export default LoginPage;