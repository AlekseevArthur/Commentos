import React from "react"
import PropTypes from "prop-types"
class TopicList extends React.Component {
  state = { topics: [], user: '' }

  componentDidMount = () => {
    this.updateTopics()
  }
  updateTopics = () => {
    fetch('topics.json')
      .then(res => res.json())
      .then(data => this.setState({ topics: data.data, admin: data.haveRights }))
  }
  render() {
    return (
      <div className='container'>
        {this.state.admin ? <a href='/topics/new'>Create new</a> : null}
        <hr />
        {
          this.state.topics
            ? this.state.topics.map((topic, key) =>
              <MiniTopic
                key={key}
                text={topic.text}
                name={topic.name}
                topic_id={topic.id}
                canDelete={this.state.admin}
                updateTopics={this.updateTopics}
              />)
            : <p>loading</p>
        }

      </div>
    );
  }
}

const MiniTopic = (props) => {

  const deleteTopic = () => {
    fetch(`topics/${props.topic_id}`, {
      method: 'DELETE',
      headers: {
        'Content-type': 'application/json'
      }
    })
      .then(() => props.updateTopics())
      .catch(console.log)
  }

  return (
    <div>
      <a href={`/topics/${props.topic_id}`}>{props.name}</a>
      {props.canDelete ? <button className="btn btn-danger btn-sm" onClick={deleteTopic}>X</button> : null}
      <p>{props.text}</p>
      <hr />
    </div>
  )
}


export default TopicList
