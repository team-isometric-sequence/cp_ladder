import type { NextPage } from "next";
import Head from "next/head";
import { useRouter } from "next/router";

import React, { useState, useEffect } from "react";

import {
  Alert,
  AlertIcon,
  Table,
  Thead,
  Tbody,
  Tr,
  Td,
  Th,
  Tag,
  TagLabel,
  TagLeftIcon,
  IconButton,
  Box,
  Heading,
  Flex,
  Spacer,
  Button,
  Text,
  Link,
} from "@chakra-ui/react";
import { LinkIcon, ArrowUpIcon, ArrowDownIcon } from "@chakra-ui/icons";

import { Filter, Tag as LabelIcon } from "react-feather";

import Loader from "common/ui/loader";
import Page, { IPage } from "common/ui/page";

import Paginator, { PageInfoProps } from "common/ui/paginator";

import SolvedacBadge from "common/components/solvedac-badge";

import ProblemApi from "api/problem-api";

type IProblem = {
  problemNumber: number,
  title: string,
  tier: number,
  solvedCount: number,
  submissionCount: number,
  tags: Array<{ name: string }>
};

const getSchoolFullName = (schoolName: string) => {
  switch(true) {
    case schoolName === "ehwa":
      return "이화여자대학교";
    case schoolName === "sogang":
      return "서강대학교";
    case schoolName === "sookmyeong":
      return "숙명여자대학교";
    case schoolName === "yonsei":
      return "연세대학교";
    default:
      return "홍익대학교";
  }
}

const UnsolvedProblemsDetailPage: NextPage<IPage> = ({ isLoggedIn }) => {
  const router = useRouter();

  const schoolName = router.query.school_name as string || "";
  const page = parseInt(router.query.page as string || "1");
  const orderBy = router.query.order_by as string || "tier_asc";
  const tagName = router.query.tag as string || "";

  const [loading, setLoading] = useState(true);
  const [problems, setProblems] = useState<IProblem[]>([]);
  const [pageInfo, setPageInfo] = useState({});
  const [error, setError] = useState<any>(null);

  const setPage = (pageNum: number) => {
    const basePaginationQuery = { page: pageNum, order_by: orderBy };
    const paginationQuery = (tagName !== "") ?
      { ...basePaginationQuery, tag: tagName }
      : basePaginationQuery;

    router.push({
      pathname: `/unsolved_problems/${schoolName}`,
      query: paginationQuery
    })
  }

  const fetchProblems = async () => {
    try {
      const payloads = {
        page,
        orderBy,
        schoolName,
        tagName
      }

      const data = await ProblemApi.getProblems(payloads);
      setProblems(data.objects);
      setPageInfo(data.pageInfo)
    } catch (e) {
      setError(e);
    }

    setLoading(false);
  };

  useEffect(() => {
    fetchProblems();
  }, [loading, router]);

  if (loading) return <Loader />;
  if (schoolName === "") return <Loader />;
  if (error) return <div>에러가 발생했습니다....ㅜ</div>;

  if (!(["hongik", "ehwa", "sogang", "sookmyeong", "yonsei"].includes(schoolName))) {
    router.push("/unsolved_problems");
    return <Loader />;
  }
  const schoolFullName = getSchoolFullName(schoolName);

  return (
    <Page isLoggedIn={isLoggedIn}>
      <Head>
        <title>{schoolFullName}에서 풀지 않은 문제</title>
        <meta name="description" content={`${schoolFullName}에서 풀지 않은 문제`} />
        <link rel="icon" href="/favicon.ico" />
      </Head>

      <Box p={4} pt={8}>
        <Box>
          <Alert status='info' variant='left-accent'>
            <AlertIcon />
            데이터는 2시간 단위로 갱신되어요. 문제를 풀자마자 바로 갱신되지 않을 수도 있으니 참고해주세요!
          </Alert>
        </Box>

        <Box p={4} my={4} borderWidth="1px" borderRadius="lg">
          <Flex>
            <Flex alignItems="center">
              <Heading size="md">정렬 필터&nbsp;</Heading>
              <Filter />
            </Flex>
            <Spacer />
            <Box>
              <Button
                variant={orderBy.includes("tier") ? "solid" : "ghost"}
                colorScheme="teal"
                rightIcon={
                  orderBy === "tier_asc" ? <ArrowUpIcon /> :
                    orderBy === "tier_desc" ? <ArrowDownIcon /> :
                    <></>
                }
                onClick={() =>
                  router.push({
                    pathname: `/unsolved_problems/${schoolName}`,
                    query: { order_by: orderBy === "tier_asc" ? "tier_desc" : "tier_asc" }
                  })
                }
              >
                AC Tier
              </Button>
              <Button
                mx="2"
                variant={orderBy.includes("solved_count") ? "solid" : "ghost"}
                colorScheme="teal"
                rightIcon={
                  orderBy === "solved_count_asc" ? <ArrowUpIcon /> :
                    orderBy === "solved_count_desc" ? <ArrowDownIcon /> :
                    <></>
                }
                onClick={() =>
                  router.push({
                    pathname: `/unsolved_problems/${schoolName}`,
                    query: { order_by: orderBy === "solved_count_desc" ? "solved_count_asc" : "solved_count_desc" }
                  })
                }
              >
                맞힌 사람 수
              </Button>
              <Button
                variant={orderBy.includes("submission_count") ? "solid" : "ghost"}
                colorScheme="teal"
                rightIcon={
                  orderBy === "submission_count_asc" ? <ArrowUpIcon /> :
                    orderBy === "submission_count_desc" ? <ArrowDownIcon /> :
                    <></>
                }
                onClick={() =>
                  router.push({
                    pathname: `/unsolved_problems/${schoolName}`,
                    query: { order_by: orderBy === "submission_count_desc" ? "submission_count_asc" : "submission_count_desc" }
                  })
                }
              >
                제출 수
              </Button>
            </Box>
          </Flex>
        </Box>
      </Box>

      <Box p={4}>
        <Table variant="simple">
          <Thead>
            <Th>
              문제 번호
            </Th>
            <Th>문제 제목</Th>
            <Th>맞힌 사람 수</Th>
          </Thead>
          <Tbody>
          {problems.map((problem) => (
            <Tr key={`problem-row-${problem.problemNumber}`}>
              <Td>
                <SolvedacBadge tier={problem.tier}/>
                &nbsp;
                {problem.problemNumber}
                &nbsp;
                <a
                  target="_blank"
                  href={`https://acmicpc.net/problem/${problem.problemNumber}`}
                  rel="noreferrer"
                >
                  <IconButton
                    size={'s'}
                    icon={<LinkIcon />}
                    aria-label={'Open BOJ Problem Page'}
                  />
                </a>
              </Td>
              <Td>
                {problem.title}
                {problem.tags.length > 0 &&
                  <Box>
                    {problem.tags.map((tag) => (
                      <Link key={`${problem.problemNumber}-${tag.name}`} href={`/unsolved_problems/${schoolName}?tag=${tag.name}`}>
                        <Tag
                          marginTop={1}
                          marginX={1}
                          marginLeft={0}
                          size={"md"}
                          variant='subtle'
                          bg={tag.name == tagName ? "cyan.300" : 'cyan.100'}
                          _hover={{ bg: "cyan.300" }}
                        >
                          <TagLeftIcon boxSize='1rem' as={LabelIcon} />
                          <TagLabel>{tag.name}</TagLabel>
                        </Tag>
                      </Link>
                    ))}
                  </Box>
                }
              </Td>
              <Td><Text as="b" fontSize="lg">{problem.solvedCount}</Text><Text as="span" fontSize="xs"> of {problem.submissionCount}</Text></Td>
            </Tr>
          ))}
          </Tbody>
        </Table>
      </Box>

      <Paginator pageInfo={pageInfo as PageInfoProps} setPage={setPage} />
    </Page>
  )
}

export default UnsolvedProblemsDetailPage