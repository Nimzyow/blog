import React from "react";
import Toast from "react-bootstrap/Toast";
import Button from "react-bootstrap/Button";
import Layout from "../components/layout";

const ExampleToast = ({ children }: { children: React.ReactNode }) => {
  const [show, toggleShow] = React.useState(true);

  return (
    <>
      {!show && <Button onClick={() => toggleShow(true)}>Show Toast</Button>}
      <Toast show={show} onClose={() => toggleShow(false)}>
        <Toast.Header>
          <strong className="mr-auto">React-Bootstrap</strong>
        </Toast.Header>
        <Toast.Body>{children}</Toast.Body>
      </Toast>
    </>
  );
};

const About = () => {
  return (
    <Layout>
      <div>
        <h1 className="header text-white">Welcome To React-Bootstrap</h1>
        <ExampleToast>
          We now have Toasts on the about page
          <span role="img" aria-label="tada">
            🎉
          </span>
        </ExampleToast>
      </div>
    </Layout>
  );
};

export default About;
