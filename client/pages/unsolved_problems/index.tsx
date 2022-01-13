import type { NextPage } from "next";
import Head from "next/head";
import { useRouter } from "next/router";

import React from "react";

import styled from "@emotion/styled";

import {
  Button,
  Container,
  VStack,
  LinkBox,
  LinkOverlay
} from "@chakra-ui/react";

import Page, { IPage } from "common/ui/page";

const UnsolvedProblemsIndexPage: NextPage<IPage> = ({ isLoggedIn }) => {
  return (
    <Page isLoggedIn={isLoggedIn}>
      <Container maxW='container.sm' style={{"display": "flex", "height": "calc(100vh - 4rem)"}}>
        <VStack
          style={{ "justifyContent": "center", "flex": "1"}}
          spacing={4}
          align='stretch'
        >
          <LinkBox>
            <LinkOverlay href="/unsolved_problems/hongik">
              <Button isFullWidth size="lg" colorScheme='teal' variant='outline'>
                홍익대학교
              </Button>
            </LinkOverlay>
          </LinkBox>

          <LinkBox>
            <LinkOverlay href="/unsolved_problems/ehwa">
              <Button isFullWidth size="lg" colorScheme='teal' variant='outline'>
                이화여자대학교
              </Button>
            </LinkOverlay>
          </LinkBox>

          <LinkBox>
            <LinkOverlay href="/unsolved_problems/sogang">
              <Button isFullWidth size="lg" colorScheme='teal' variant='outline'>
                서강대학교
              </Button>
            </LinkOverlay>
          </LinkBox>

          <LinkBox>
            <LinkOverlay href="/unsolved_problems/sookmyeong">
              <Button isFullWidth size="lg" colorScheme='teal' variant='outline'>
                숙명여자대학교
              </Button>
            </LinkOverlay>
          </LinkBox>

          <LinkBox>
            <LinkOverlay href="/unsolved_problems/yonsei">
              <Button isFullWidth size="lg" colorScheme='teal' variant='outline'>
                연세대학교
              </Button>
            </LinkOverlay>
          </LinkBox>
        </VStack>
      </Container>
    </Page>
  );
}

export default UnsolvedProblemsIndexPage