import React from "react"
import PropTypes from "prop-types"

import { BrowserRouter, Routes, Route } from 'react-router-dom'

import TopicsList from './TopicList'
import Topic from "./Topic"
import TopicNew from "./TopicNew"

class App extends React.Component {
  render() {
    return (
      <BrowserRouter>
        <Routes>
          <Route exact path='/' element={<TopicsList/>} />
          <Route path='/topic/new' element={<TopicNew/>} />
          <Route path='/topic/:id' element={<Topic/>} />
        </Routes>
      </BrowserRouter>
    );
  }
}

export default App
