import { FC } from "react";

import styled from "@emotion/styled";

import {
  Stack as PaginationStack,
  Button
} from "@chakra-ui/react";

const PaginationItem = styled(Button)({ colorScheme: "teal" });

const PaginationEllipsis = () => (
  <PaginationItem isDisabled variant="ghost">
    ...
  </PaginationItem>
)

export type PageInfoProps = {
  count: number;
  currentPage: number;
  hasNext: boolean;
  hasPrevious: boolean;
  startIndex: number;
  endIndex: number;
}

type PaginatorProps = {
  pageInfo: PageInfoProps;
  setPage: (page: number) => void;
  className?: string;
};

const NearestPaginationRange: React.FC<PaginatorProps> = ({ pageInfo, setPage }) => {
  const { endIndex, currentPage } = pageInfo;

  const paginationItems = [
    currentPage - 2,
    currentPage - 1,
    currentPage,
    currentPage + 1,
    currentPage + 2,
  ].map((pageNumber) => {
    if (pageNumber <= 1 || pageNumber >= endIndex) {
      return null;
    }
    return (
      <PaginationItem
        key={pageNumber}
        isActive={currentPage === pageNumber}
        onClick={() => setPage(pageNumber)}
      >
        {pageNumber}
      </PaginationItem>
    );
  });

  return (
    <>
      {1 < currentPage - 2 && <PaginationEllipsis />}
      {paginationItems}
      {currentPage + 2 < endIndex && <PaginationEllipsis />}
    </>
  );
};

const PaginatorWrapper = styled.div`
  display: flex;
  justify-content: center;
`;

const Paginator: FC<PaginatorProps> = ({
  pageInfo,
  setPage,
  className = "",
}) => {
  const { count, hasNext, currentPage, hasPrevious, endIndex } = pageInfo;

  return (
    <PaginatorWrapper>
      <PaginationStack className={className} direction="row">
        <PaginationItem
          isDisabled={!hasPrevious}
          onClick={() => setPage(currentPage - 1)}
        >
          이전
        </PaginationItem>
        <PaginationItem isActive={currentPage == 1} onClick={() => setPage(1)}>
          1
        </PaginationItem>
        <NearestPaginationRange
          pageInfo={pageInfo}
          setPage={setPage}
        />
        {1 !== endIndex && (
          <PaginationItem
            isActive={currentPage == endIndex}
            onClick={() => setPage(endIndex)}
          >
            {endIndex}
          </PaginationItem>
        )}
        <PaginationItem
          isDisabled={!hasNext}
          onClick={() => setPage(currentPage + 1)}
        >
          다음
        </PaginationItem>
      </PaginationStack>
    </PaginatorWrapper>
  );
};

export default Paginator;
