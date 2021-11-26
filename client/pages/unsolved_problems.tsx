import type { NextPage } from "next";
import Head from "next/head";
import { useRouter } from "next/router";

import React, { useState, useEffect } from "react";

import {
  Table,
  Thead,
  Tbody,
  Tr,
  Td,
  Th,
} from "@chakra-ui/react";

import Loader from "common/ui/loader";
import Paginator, { PageInfoProps } from "common/ui/paginator";

import ProblemApi from "api/problem-api";

type IProblem = {
  problemNumber: number,
  title: string,
  tier: number,
  solvedCount: number,
  submissionCount: number
};

const UnsolvedProblemsPage: NextPage = () => {
  const router = useRouter();

  const page = parseInt(router.query.page as string || "1");
  const orderBy = router.query.order_by as string || "tier_asc";

  const [loading, setLoading] = useState(true);
  const [problems, setProblems] = useState<IProblem[]>([]);
  const [pageInfo, setPageInfo] = useState({});
  const [error, setError] = useState<any>(null);

  const setPage = (pageNum: number) => {
    router.push({
      pathname: '/unsolved_problems',
      query: { page: pageNum, order_by: orderBy }
    })
  }

  const fetchProblems = async () => {
    try {
      const data = await ProblemApi.getProblems(page);
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
  if (error) return <div>에러가 발생했습니다....ㅜ</div>;

  return (
    <div>
      <Head>
        <title>홍익대학교에서 풀지 않은 문제</title>
        <meta name="description" content="홍익대학교에서 풀지 않은 문제" />
        <link rel="icon" href="/favicon.ico" />
      </Head>

      <Table variant="simple">
        <Thead>
          <Th>문제 번호</Th>
          <Th>문제 제목</Th>
          <Th>맞힌 사람 수</Th>
        </Thead>
        <Tbody>
        {problems.map((problem) => (
          <Tr key={`problem-row-${problem.problemNumber}`}>
            <Td>{problem.problemNumber}</Td>
            <Td>{problem.title}</Td>
            <Td>{problem.solvedCount}</Td>
          </Tr>
        ))}
        </Tbody>
      </Table>

      <Paginator pageInfo={pageInfo as PageInfoProps} setPage={setPage} />
    </div>
  )
}

export default UnsolvedProblemsPage