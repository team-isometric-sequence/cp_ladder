import { Spinner } from "@chakra-ui/react";

const Loader = () => (
  <Spinner
    thickness="4px"
    speed="0.65s"
    emptyColor="gray.200"
    color="blue.500"
    size="xl"
  />
)

export default Loader;