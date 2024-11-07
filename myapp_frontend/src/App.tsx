import './App.css'
import { MonthEventList } from "./MonthEventList";
import { events } from "./events"
import { user } from './user';
function App() {

  return (
    <>
      <MonthEventList events={events} user={user} classNameList="h-[80dvh] bg-slate-200"/>
    </>
  )
}

export default App

