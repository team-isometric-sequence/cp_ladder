import Image from "next/image";

import React from "react";

const UnrankedBadge = () => (
  <Image
    src="/assets/badges/0.svg" alt="Unranked"
    width="15rem"
    height="13rem"
  />
);

const Bronze5Badge = () => (
  <Image
    src="/assets/badges/1.svg" alt="Bronze 5"
    width="15rem"
    height="13rem"
  />
);

const Bronze4Badge = () => (
  <Image
    src="/assets/badges/2.svg" alt="Bronze 4"
    width="15rem"
    height="13rem"
  />
);

const Bronze3Badge = () => (
  <Image
    src="/assets/badges/3.svg" alt="Bronze 3"
    width="15rem"
    height="13rem"
  />
);

const Bronze2Badge = () => (
  <Image
    src="/assets/badges/4.svg" alt="Bronze 2"
    width="15rem"
    height="13rem"
  />
);

const Bronze1Badge = () => (
  <Image
    src="/assets/badges/5.svg" alt="Bronze 1"
    width="15rem"
    height="13rem"
  />
);

const Silver5Badge = () => (
  <Image
    src="/assets/badges/6.svg" alt="Silver 5"
    width="15rem"
    height="13rem"
  />
);

const Silver4Badge = () => (
  <Image
    src="/assets/badges/7.svg" alt="Silver 4"
    width="15rem"
    height="13rem"
  />
);

const Silver3Badge = () => (
  <Image
    src="/assets/badges/8.svg" alt="Silver 3"
    width="15rem"
    height="13rem"
  />
);

const Silver2Badge = () => (
  <Image
    src="/assets/badges/9.svg" alt="Silver 2"
    width="15rem"
    height="13rem"
  />
);

const Silver1Badge = () => (
  <Image
    src="/assets/badges/10.svg" alt="Silver 1"
    width="15rem"
    height="13rem"
  />
);

const Gold5Badge = () => (
  <Image
    src="/assets/badges/11.svg" alt="Gold 5"
    width="15rem"
    height="13rem"
  />
);

const Gold4Badge = () => (
  <Image
    src="/assets/badges/12.svg" alt="Gold 4"
    width="15rem"
    height="13rem"
  />
);

const Gold3Badge = () => (
  <Image
    src="/assets/badges/13.svg" alt="Gold 3"
    width="15rem"
    height="13rem"
  />
);

const Gold2Badge = () => (
  <Image
    src="/assets/badges/14.svg" alt="Gold 2"
    width="15rem"
    height="13rem"
  />
);

const Gold1Badge = () => (
  <Image
    src="/assets/badges/15.svg" alt="Gold 1"
    width="15rem"
    height="13rem"
  />
);

const Platinum5Badge = () => (
  <Image
    src="/assets/badges/16.svg" alt="Platinum 5"
    width="15rem"
    height="13rem"
  />
);

const Platinum4Badge = () => (
  <Image
    src="/assets/badges/17.svg" alt="Platinum 4"
    width="15rem"
    height="13rem"
  />
);

const Platinum3Badge = () => (
  <Image
    src="/assets/badges/18.svg" alt="Platinum 3"
    width="15rem"
    height="13rem"
  />
);

const Platinum2Badge = () => (
  <Image
    src="/assets/badges/19.svg" alt="Platinum 2"
    width="15rem"
    height="13rem"
  />
);

const Platinum1Badge = () => (
  <Image
    src="/assets/badges/20.svg" alt="Platinum 1"
    width="15rem"
    height="13rem"
  />
);

const Diamond5Badge = () => (
  <Image
    src="/assets/badges/21.svg" alt="Diamond 5"
    width="15rem"
    height="13rem"
  />
);

const Diamond4Badge = () => (
  <Image
    src="/assets/badges/22.svg" alt="Diamond 4"
    width="15rem"
    height="13rem"
  />
);

const Diamond3Badge = () => (
  <Image
    src="/assets/badges/23.svg" alt="Diamond 3"
    width="15rem"
    height="13rem"
  />
);

const Diamond2Badge = () => (
  <Image
    src="/assets/badges/24.svg" alt="Diamond 2"
    width="15rem"
    height="13rem"
  />
);

const Diamond1Badge = () => (
  <Image
    src="/assets/badges/25.svg" alt="Diamond 1"
    width="15rem"
    height="13rem"
  />
);

const Ruby5Badge = () => (
  <Image
    src="/assets/badges/26.svg" alt="Ruby 5"
    width="15rem"
    height="13rem"
  />
);

const Ruby4Badge = () => (
  <Image
    src="/assets/badges/27.svg" alt="Ruby 4"
    width="15rem"
    height="13rem"
  />
);

const Ruby3Badge = () => (
  <Image
    src="/assets/badges/28.svg" alt="Ruby 3"
    width="15rem"
    height="13rem"
  />
);

const Ruby2Badge = () => (
  <Image
    src="/assets/badges/29.svg" alt="Ruby 2"
    width="15rem"
    height="13rem"
  />
);

const Ruby1Badge = () => (
  <Image
    src="/assets/badges/30.svg" alt="Ruby 1"
    width="15rem"
    height="13rem"
  />
);

const SolvedacBadge: React.FC<{ tier: number }> = ({ tier }) => {
  switch(true) {
    case tier === 0:
      return <UnrankedBadge />;
    case tier === 1:
      return <Bronze5Badge />;
    case tier === 2:
      return <Bronze4Badge />;
    case tier === 3:
      return <Bronze3Badge />;
    case tier === 4:
      return <Bronze2Badge />;
    case tier === 5:
      return <Bronze1Badge />;
    case tier === 6:
      return <Silver5Badge />;
    case tier === 7:
      return <Silver4Badge />;
    case tier === 8:
      return <Silver3Badge />;
    case tier === 9:
      return <Silver2Badge />;
    case tier === 10:
      return <Silver1Badge />;
    case tier === 11:
      return <Gold5Badge />;
    case tier === 12:
      return <Gold4Badge />;
    case tier === 13:
      return <Gold3Badge />;
    case tier === 14:
      return <Gold2Badge />;
    case tier === 15:
      return <Gold1Badge />;
    case tier === 16:
      return <Platinum5Badge />;
    case tier === 17:
      return <Platinum4Badge />;
    case tier === 18:
      return <Platinum3Badge />;
    case tier === 19:
      return <Platinum2Badge />;
    case tier === 20:
      return <Platinum1Badge />;
    case tier === 21:
      return <Diamond5Badge />;
    case tier === 22:
      return <Diamond4Badge />;
    case tier === 23:
      return <Diamond3Badge />;
    case tier === 24:
      return <Diamond2Badge />;
    case tier === 25:
      return <Diamond1Badge />;
    case tier === 26:
      return <Ruby5Badge />;
    case tier === 27:
      return <Ruby4Badge />;
    case tier === 28:
      return <Ruby3Badge />;
    case tier === 29:
      return <Ruby2Badge />;
    case tier === 30:
      return <Ruby1Badge />;
    default:
      return <UnrankedBadge />;
  }
}

export default SolvedacBadge;