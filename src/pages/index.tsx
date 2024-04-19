import * as React from "react";
import type { HeadFC, PageProps } from "gatsby";
import Toast from "react-bootstrap/Toast";
import Container from "react-bootstrap/Container";
import Button from "react-bootstrap/Button";
import "bootstrap/dist/css/bootstrap.min.css";
import NavBar from "../components/NavBar";
import FormComponent from "../components/Form";
import { Link } from "gatsby";
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

const IndexPage: React.FC<PageProps> = () => {
  return (
    <Layout>
      <div className="mb-5">
        <p className="text-white">
          Check out the <Link to="/about">about</Link> page!
        </p>
        <h1 className="header text-white">Welcome To React-Bootstrap</h1>
        <ExampleToast>
          We now have Toasts
          <span role="img" aria-label="tada">
            🎉
          </span>
        </ExampleToast>
      </div>
      <FormComponent />
    </Layout>
  );
};

export default IndexPage;

export const Head: HeadFC = () => <title>Home Page</title>;
