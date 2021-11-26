import React, { ReactNode, useContext } from 'react';
import { useRouter } from "next/router";

import {
  Box,
  Flex,
  Avatar,
  HStack,
  Link,
  IconButton,
  Button,
  Menu,
  MenuButton,
  MenuList,
  MenuItem,
  MenuDivider,
  useDisclosure,
  useColorModeValue,
  Stack,
} from '@chakra-ui/react';
import { HamburgerIcon, CloseIcon } from '@chakra-ui/icons';

import LocalStorageService from 'common/services/local-storage-service';
import AppContext from 'common/contexts/app-context';

const NavLink: React.FC<any> = ({ children, ...props }) => (
  <Link
    px={2}
    py={1}
    rounded={'md'}
    _hover={{
      textDecoration: 'none',
      bg: useColorModeValue('gray.200', 'gray.700'),
    }}
    {...props}
  >
    {children}
  </Link>
);

const Layout: React.FC = ({ children }) => {
  const { isLoggedIn, user } = useContext(AppContext);
  const { isOpen, onOpen, onClose } = useDisclosure();

  const router = useRouter();

  return (
    <>
      <Box bg={useColorModeValue('gray.100', 'gray.900')} px={4}>
        <Flex h={16} alignItems={'center'} justifyContent={'space-between'}>
          <IconButton
            size={'md'}
            icon={isOpen ? <CloseIcon /> : <HamburgerIcon />}
            aria-label={'Open Menu'}
            display={{ md: 'none' }}
            onClick={isOpen ? onClose : onOpen}
          />
          <HStack spacing={8} alignItems={'center'}>
            <Box>CP Ladder</Box>
            <HStack
              as={'nav'}
              spacing={4}
              display={{ base: 'none', md: 'flex' }}>
              <NavLink href="/unsolved_problems">
                학교에서 풀지 않은 문제 목록
              </NavLink>
              <NavLink href="#">
                즐겨찾기 (공사 중)
              </NavLink>
            </HStack>
          </HStack>
          <Flex alignItems={'center'}>
            <Menu>
              <MenuButton
                as={Button}
                rounded={'full'}
                variant={'link'}
                cursor={'pointer'}
                minW={0}>
                <Avatar
                  size={'sm'}
                  src={
                    'https://images.unsplash.com/photo-1493666438817-866a91353ca9?ixlib=rb-0.3.5&q=80&fm=jpg&crop=faces&fit=crop&h=200&w=200&s=b616b2c5b373a80ffc9636ba24f7a4a9'
                  }
                />
              </MenuButton>
              <MenuList>
                {isLoggedIn ? (
                  <MenuItem>Logged in as&nbsp;<b>{user?.username}</b></MenuItem>
                ) : (
                  <></>
                )}
                <MenuDivider />
                {isLoggedIn ? (
                  <MenuItem
                    onClick={() => {
                      LocalStorageService.setAccessToken("");
                      router.push("/login");
                    }}
                  >
                    로그아웃
                  </MenuItem>
                ) : (
                  <MenuItem
                    onClick={()=> {
                      router.push("/login");
                    }}
                  >
                    로그인
                  </MenuItem>
                )}
              </MenuList>
            </Menu>
          </Flex>
        </Flex>

        {isOpen && (
          <Box pb={4} display={{ md: 'none' }}>
            <Stack as={'nav'} spacing={4}>
              <NavLink href="/unsolved_problems">
                학교에서 풀지 않은 문제 목록
              </NavLink>
              <NavLink href="#">
                즐겨찾기 (공사 중)
              </NavLink>
            </Stack>
          </Box>
        )}
      </Box>

      <Box p={4}>
        {children}
      </Box>
    </>
  );
}

export default Layout;