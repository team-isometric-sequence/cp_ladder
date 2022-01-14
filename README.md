# Requirements

- Elixir 1.12.3
- Phoenix 1.6.2
- Postgres (Database)
- Next.js (with Typescript)
  - Chakra UI (for UI component)
  - Emotion (for styled-component)

# Installation

0. 먼저 준비해야 하는 것들

- elixir
- node.js (16.13.0 이상)
- yarn (npm install yarn) - JS 패키지 매니저

위의 준비문들이 세팅되어 있다면 `./cp install` 명령어로 설치하시면 됩니다.

# Running

## Database Setup

1. Postgres 설치 후 백그라운드에서 돌아가도록 세팅 (필요하다면 Docker 기반으로 세팅할 수 있도록 합시다.)
2. createdb cp_ladder_dev (cp_ladder_dev 이라는 이름의 Database가 만들어져 있으면 됩니다.)
3. 프로젝트 홈 디렉토리에서 `./cp migrate`

postgres 데이터베이스에 패스워드를 설정해준 적이 있다면, `DB_PASSWORD` 환경변수를 설정해주시길 바랍니다.

## Server

`./cp run server`

# Development

(TBD)

# Test 실행하기

(TBD)