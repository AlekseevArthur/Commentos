import React, { useState } from "react"

const Topic = (props) => {

  const openCommentForm = () => {
    setFlag(!commentFlag)
  }

  const [info, setInfo] = useState({ name: 'loading', text: '', loaded: false, user_id: null })
  const [commentFlag, setFlag] = useState(false)
  const [commentsList, setComments] = useState({ comments: [], loaded: false })
  if (!info.loaded) {
    fetch(`/topics/${props.topic_id}.json`)
      .then(res => res.json())
      .then(data => {
        setInfo({ ...data, loaded: true })
      })
  }

  const updateComments = (reload = false) => {
    if (!commentsList.loaded || reload) {
      fetch(`/topics/${props.topic_id}/comments.json`)
        .then(res => res.json())
        .then(data => {
          setComments({ comments: data, loaded: true })

        })
    }
  }
  updateComments()
  return <div className='container'>
    <h1>{info.name}</h1>
    <h3>{info.text}</h3>
    <button className="btn btn-info" onClick={openCommentForm}>Comment</button>
    {commentFlag ? <CommentForm
      updateComments={updateComments}
      foo={openCommentForm}
      topicId={props.topic_id}
      user_id={info.user_id}
    />
      : null}

    {commentsList.loaded ? <CommentsList
      updateComments={updateComments}
      comments={commentsList.comments} /> : null}
  </div>
}

const CommentForm = (props) => {

  function handleChange(e) {
    setValues({ ...formValues, text: e.target.value })
  }

  function handleSubmit(e) {
    e.preventDefault()
    fetch(`/topics/${props.topicId}/comments`, {
      method: 'POST',
      headers: {
        'Content-type': 'application/json'
      },
      body: JSON.stringify(formValues)
    })
      .then(() => {
        props.foo()
        props.updateComments(true)
      })
  }

  const [formValues, setValues] = useState({ text: '', user_id: props.user_id, topic_id: props.topicId })

  return <form onSubmit={handleSubmit}>
    <div className="mb-3">
      <label className="form-label">Leave your message</label>
      <textarea
        value={formValues.text}
        onChange={handleChange}
        className="form-control"
        name='text'
        rows="3">
      </textarea>
    </div>
    <input type="submit" value='Submit' />
  </form>
}

const CommentsList = (props) => {
  return <div className='container-sm'>
    <hr />
    {props.comments.map((comment, key) =>
      <Comment
        topic_id={comment.topic_id}
        key={key}
        text={comment.text}
        author={comment.author}
        canDelete={comment.canDelete}
        comment_id={comment.comment_id}
        updateComments={props.updateComments} />
    )}
  </div>
}


const Comment = (props) => {
  function deleteComment() {
    fetch(`/topics/${props.topic_id}/comments/${props.comment_id}`, {
      method: 'DELETE',
      headers: {
        'Content-type': 'application/json'
      }
    })
      .then(() => props.updateComments(true))
  }
  return <div>
    <div className="card">
      <div className="card-header">
        {props.canDelete ? <button className="btn btn-danger btn-sm" onClick={deleteComment}>x</button> : null}
      </div>
      <div className="card-body">
        <blockquote className="blockquote mb-0">
          <p>{props.text}</p>
          <footer className="blockquote-footer">{props.author}</footer>
        </blockquote>
      </div>
    </div>
    <hr />
  </div>
}

export default Topic
