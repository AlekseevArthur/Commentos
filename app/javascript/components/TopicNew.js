import React from "react"
import PropTypes from "prop-types"

class TopicNew extends React.Component {
  constructor(props) {
    super(props)
    this.state = { name: '', text: '', isAdmin: false }

    this.handleChange = this.handleChange.bind(this);
    this.handleSubmit = this.handleSubmit.bind(this);
  }

  handleChange(e) {
    this.setState({ [e.target.name]: e.target.value })
  }

  handleSubmit(e) {
    e.preventDefault()
    fetch('/topics', {
      method: 'POST',
      headers: {
        'Content-type': 'application/json'
      },
      body: JSON.stringify(this.state)
    })
    .then(()=> {window.location.href = "/"})
    .catch(console.log)

  }

  render() {
    return (
      <form onSubmit={this.handleSubmit}>
        <div>
          Name:
          <input value={this.state.name} onChange={this.handleChange} type='text' name='name' />
        </div>
        <div>
          Describe:
          <textarea value={this.state.text} onChange={this.handleChange} name='text' />
        </div>
        <input type="submit" value='Submit' />
      </form>
    );
  }
}

export default  TopicNew
