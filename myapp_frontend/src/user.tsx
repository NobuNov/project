export type LoginStatus = {
  id: string;
  admin: string;
};

export const user: LoginStatus[] = [
  {
      id: "Taro_Tanaka",
      admin: "ADMIN"
  },
  {
      id: "Hanako_Goto",
      admin: "ADMIN"
  },
  {
      id: "Kenji_Suzuki",
      admin: "USER"
  },
  {
      id: "Yuki_Sato",
      admin: "USER"
  },
  {
      id: "Akira_Yamada",
      admin: "USER"
}]