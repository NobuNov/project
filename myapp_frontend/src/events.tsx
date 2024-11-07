// events.tsx
export type EventType = {
    eventId: string;
    userId: string;
    name: string;
    start: Date;
    end: Date;
  };
  
  export const events: EventType[] = [
    // 2024年のイベント
    {
        eventId: "1",
        userId: "Taro_Tanaka",
        name: "会議",
        start: new Date("2024-01-10T09:00:00"),
        end: new Date("2024-01-10T10:00:00")
    },
    {
        eventId: "2",
        userId: "Hanako_Goto",
        name: "面談",
        start: new Date("2024-02-05T14:00:00"),
        end: new Date("2024-02-05T15:30:00")
    },
    {
        eventId: "3",
        userId: "Kenji_Suzuki",
        name: "プロジェクト進捗報告",
        start: new Date("2024-03-12T10:00:00"),
        end: new Date("2024-03-12T11:30:00")
    },
    {
        eventId: "4",
        userId: "Yuki_Sato",
        name: "社内研修",
        start: new Date("2024-04-22T09:00:00"),
        end: new Date("2024-04-22T17:00:00")
    },
    {
        eventId: "5",
        userId: "Akira_Yamada",
        name: "クライアントとの打ち合わせ",
        start: new Date("2024-05-15T13:00:00"),
        end: new Date("2024-05-15T14:30:00")
    },
    {
        eventId: "6",
        userId: "Taro_Tanaka",
        name: "全体会議",
        start: new Date("2024-06-18T11:00:00"),
        end: new Date("2024-06-18T12:00:00")
    },
    {
        eventId: "7",
        userId: "Hanako_Goto",
        name: "チームビルディング",
        start: new Date("2024-07-10T10:00:00"),
        end: new Date("2024-07-10T16:00:00")
    },
    {
        eventId: "8",
        userId: "Kenji_Suzuki",
        name: "夏季休暇",
        start: new Date("2024-08-01T00:00:00"),
        end: new Date("2024-08-15T23:59:59")
    },
    {
        eventId: "9",
        userId: "Yuki_Sato",
        name: "プロジェクトプレゼンテーション",
        start: new Date("2024-09-20T14:00:00"),
        end: new Date("2024-09-20T16:00:00")
    },
    {
        eventId: "10",
        userId: "Akira_Yamada",
        name: "四半期レビュー",
        start: new Date("2024-10-05T09:00:00"),
        end: new Date("2024-10-05T11:00:00")
    },
    {
        eventId: "11",
        userId: "Taro_Tanaka",
        name: "ハロウィンパーティー",
        start: new Date("2024-10-31T18:00:00"),
        end: new Date("2024-10-31T21:00:00")
    },
    {
        eventId: "12",
        userId: "Hanako_Goto",
        name: "年末イベント",
        start: new Date("2024-12-15T10:00:00"),
        end: new Date("2024-12-15T17:00:00")
    },
    {
        eventId: "13",
        userId: "Kenji_Suzuki",
        name: "新年会",
        start: new Date("2024-01-05T18:00:00"),
        end: new Date("2024-01-05T21:00:00")
    },
    {
        eventId: "14",
        userId: "Yuki_Sato",
        name: "開発チームミーティング",
        start: new Date("2024-02-10T15:00:00"),
        end: new Date("2024-02-10T17:00:00")
    },
    {
        eventId: "15",
        userId: "Akira_Yamada",
        name: "プロジェクト進捗報告",
        start: new Date("2024-03-15T10:00:00"),
        end: new Date("2024-03-15T12:00:00")
    },
    {
        eventId: "16",
        userId: "Taro_Tanaka",
        name: "クライアントとの打ち合わせ",
        start: new Date("2024-04-12T13:00:00"),
        end: new Date("2024-04-12T14:30:00")
    },
    {
        eventId: "17",
        userId: "Hanako_Goto",
        name: "社内イベント",
        start: new Date("2024-05-30T10:00:00"),
        end: new Date("2024-05-30T17:00:00")
    },
    {
        eventId: "18",
        userId: "Kenji_Suzuki",
        name: "外部講師によるセミナー",
        start: new Date("2024-06-20T11:00:00"),
        end: new Date("2024-06-20T13:00:00")
    },
    {
        eventId: "19",
        userId: "Yuki_Sato",
        name: "夏季社員研修",
        start: new Date("2024-07-25T09:00:00"),
        end: new Date("2024-07-25T17:00:00")
    },
    {
        eventId: "20",
        userId: "Akira_Yamada",
        name: "全体会議",
        start: new Date("2024-08-30T10:00:00"),
        end: new Date("2024-08-30T12:00:00")
    },
    {
        eventId: "21",
        userId: "Taro_Tanaka",
        name: "秋のイベント",
        start: new Date("2024-09-29T18:00:00"),
        end: new Date("2024-09-29T20:00:00")
    },
    {
        eventId: "22",
        userId: "Hanako_Goto",
        name: "年末パーティー",
        start: new Date("2024-12-20T18:00:00"),
        end: new Date("2024-12-20T22:00:00")
    },
    {
        eventId: "23",
        userId: "Kenji_Suzuki",
        name: "誕生日パーティー",
        start: new Date("2024-11-15T19:00:00"),
        end: new Date("2024-11-15T21:00:00")
    },
    {
        eventId: "24",
        userId: "Yuki_Sato",
        name: "オフサイトミーティング",
        start: new Date("2024-10-12T09:00:00"),
        end: new Date("2024-10-12T17:00:00")
    },
    {
        eventId: "25",
        userId: "Akira_Yamada",
        name: "スプリングフェスティバル",
        start: new Date("2024-04-01T11:00:00"),
        end: new Date("2024-04-01T15:00:00")
    },
    {
        eventId: "26",
        userId: "Taro_Tanaka",
        name: "デモデイ",
        start: new Date("2024-05-10T10:00:00"),
        end: new Date("2024-05-10T14:00:00")
    },
    {
        eventId: "27",
        userId: "Hanako_Goto",
        name: "スポーツデー",
        start: new Date("2024-06-30T09:00:00"),
        end: new Date("2024-06-30T15:00:00")
    },
    {
        eventId: "28",
        userId: "Kenji_Suzuki",
        name: "ファミリーデー",
        start: new Date("2024-07-20T11:00:00"),
        end: new Date("2024-07-20T18:00:00")
    },
    {
        eventId: "29",
        userId: "Yuki_Sato",
        name: "職場見学",
        start: new Date("2024-08-25T10:00:00"),
        end: new Date("2024-08-25T12:00:00")
    },
    {
        eventId: "30",
        userId: "Akira_Yamada",
        name: "年末大掃除",
        start: new Date("2024-12-28T10:00:00"),
        end: new Date("2024-12-28T17:00:00")
    },
  
    // 2025年のイベント
    {
        eventId: "31",
        userId: "Taro_Tanaka",
        name: "新年会",
        start: new Date("2025-01-05T18:00:00"),
        end: new Date("2025-01-05T21:00:00")
    },
    {
        eventId: "32",
        userId: "Hanako_Goto",
        name: "年次総会",
        start: new Date("2025-03-15T10:00:00"),
        end: new Date("2025-03-15T12:00:00")
    },
  ];
  