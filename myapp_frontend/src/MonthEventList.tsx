import { startOfMonth, endOfMonth, format } from "date-fns";
import { useState, useMemo } from "react";
import { EventType } from "./events";
import { LoginStatus } from "./user";
import { ScrollArea } from "../components/ui/scroll-area";
import {
  Card,
  CardContent,
  CardDescription,
  CardHeader,
  CardTitle,
} from "../components/ui/card";
import {
  Dialog,
  DialogContent,
  DialogDescription,
  DialogHeader,
  DialogTitle,
} from "../components/ui/dialog";
import { cn } from "../lib/utils";

type MonthEventListProps = {
  events: EventType[];
  user: LoginStatus[];
  classNameList?: string;
};

export const MonthEventList = ({ events, user, classNameList = '' }: MonthEventListProps) => {
  // 今年を取得
  const [year, setYear] = useState(new Date().getFullYear());

  // 選択した月のイベントを保存する状態変数
  const [selectedEvents, setSelectedEvents] = useState<EventType[]>([]);
  const [selectedUser, setSelectedUser] = useState<string>(user[0].id);

  // 選択されたイベントの状態とダイアログの開閉状態
  const [selectedEvent, setSelectedEvent] = useState<EventType | null>(null);
  const [isDialogOpen, setIsDialogOpen] = useState(false);

  // 12個の配列生成
  const eventsCount = useMemo(() => {
    return Array.from({ length: 12 }, (_, month) => {
      // その月の開始日と終了日を取得
      const monthStart = startOfMonth(new Date(year, month, 1)); 
      const monthEnd = endOfMonth(monthStart);

      // イベントリストをフィルタリングして、現在の月に含まれるイベントをカウント
      const count = events.filter(event => {
        return (
          event.start <= monthEnd &&
          event.end >= monthStart &&
          event.userId === selectedUser
        );
      }).length;

      return { month, count };
    });
  }, [year, events, selectedUser]);

  // 年を変更するための関数
  const changeYear = (delta: number) => {
    setYear(prevYear => prevYear + delta);
  };

  // 特定の月がクリックされた時にその月のイベントを取得する処理
  const handleMonthClick = (month: number) => {
    const monthStart = startOfMonth(new Date(year, month, 1));
    const monthEnd = endOfMonth(monthStart);
    const eventsInMonth = events.filter(event => {
      return (
        event.start <= monthEnd &&
        event.end >= monthStart &&
        event.userId === selectedUser
      );
    });
    setSelectedEvents(eventsInMonth);
  };

  // ユーザーの権限に基づいてヘッダーの色を決定する関数
  const getHeaderColor = (userId: string) => {
    const userInfo = user.find(u => u.id === userId);
    return userInfo?.admin === "ADMIN" ? "bg-blue-500" : "bg-green-500";
  };

  // イベントカードがクリックされたときの処理
  const handleEventClick = (event: EventType) => {
    setSelectedEvent(event);
    setIsDialogOpen(true);
  };

  return (
    <div className={`flex w-full ${classNameList}`}>
      {/* 左ペイン */}
      <div className="w-1/2 p-4 border-r h-full overflow-auto">
        <h2 className="text-lg font-bold mb-4">{year}年のイベント数</h2>
        
        {/* ユーザー選択用ドロップダウン */}
        <div className="mb-4">
          <label htmlFor="user-select" className="block text-sm font-medium text-gray-700">ユーザー選択</label>
          <select 
            id="user-select"
            value={selectedUser} 
            onChange={(e) => setSelectedUser(e.target.value)}
            className="mt-1 block w-full pl-3 pr-10 py-2 text-base border-gray-300 focus:outline-none focus:ring-indigo-500 focus:border-indigo-500 sm:text-sm rounded-md"
          >
            {user.map(u => (
              <option key={u.id} value={u.id}>{u.id} ({u.admin})</option>
            ))}
          </select>
        </div>

        {/* 前後の年を切り替えるボタン */}
        <div className="flex justify-between mb-4">
          <button
            onClick={() => changeYear(-1)}
            className="bg-blue-500 text-white py-1 px-4 rounded hover:bg-blue-600 transition"
            aria-label="前の年"
          >
            前の年
          </button>
          <button
            onClick={() => changeYear(1)}
            className="bg-blue-500 text-white py-1 px-4 rounded hover:bg-blue-600 transition"
            aria-label="次の年"
          >
            次の年
          </button>
        </div>

        {/* 各月のイベント数を表示 */}
        <div className="grid grid-cols-3 gap-4">
          {eventsCount.map(({ month, count }) => (
            <div
              key={month}
              className="text-center border p-2 rounded cursor-pointer hover:bg-gray-100 hover:shadow transition"
              onClick={() => handleMonthClick(month)} 
              aria-label={`${month + 1}月のイベントを表示`}
            >
              <div className="text-xl font-semibold">{month + 1}月</div>
              <div className="text-sm">{count} イベント</div>
            </div>
          ))}
        </div>
      </div>

      {/* 右ペイン */}
      <div className="w-1/2 p-4 h-full overflow-auto">
        <h2 className="text-lg font-bold mb-4">選択した月のイベント</h2>

        <ScrollArea className="h-[calc(100%-2rem)]">
          {selectedEvents.length === 0 ? (
            <p className="p-4">イベントが選択されていません。</p>
          ) : (
            <div className="space-y-4">
              {selectedEvents.map(event => (
                <Card 
                  key={event.eventId}
                  className="cursor-pointer hover:shadow-md transition-shadow"
                  onClick={() => handleEventClick(event)}
                >
                  <CardHeader>
                    <CardTitle>{event.name}</CardTitle>
                    <CardDescription>ID: {event.eventId}</CardDescription>
                  </CardHeader>
                  <CardContent>
                    <p><strong>開始:</strong> {format(event.start, 'yyyy/MM/dd HH:mm')}</p>
                    <p><strong>終了:</strong> {format(event.end, 'yyyy/MM/dd HH:mm')}</p>
                  </CardContent>
                </Card>
              ))}
            </div>
          )}
        </ScrollArea>
      </div>

      {/* ダイアログ（モーダル） */}
      {selectedEvent && (
        <Dialog open={isDialogOpen} onOpenChange={setIsDialogOpen}>
          <DialogContent>
            <DialogHeader className={cn("p-4 rounded-t", getHeaderColor(selectedEvent.userId))}>
              <DialogTitle className="text-white">
                {selectedEvent.name}
              </DialogTitle>
              <DialogDescription className="text-white opacity-90">
                開催者: {selectedEvent.userId}
              </DialogDescription>
            </DialogHeader>
            <div className="mt-4 p-4">
              <p><strong>開始:</strong> {format(selectedEvent.start, 'yyyy/MM/dd HH:mm')}</p>
              <p><strong>終了:</strong> {format(selectedEvent.end, 'yyyy/MM/dd HH:mm')}</p>
              {/* 他のイベント詳細を追加 */}
            </div>
          </DialogContent>
        </Dialog>
      )}
    </div>
  );
};